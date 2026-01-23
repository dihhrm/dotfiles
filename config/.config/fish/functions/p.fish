function p --description "Abrir (criar) sessão tmux para meus projetos em ~/Development"
  if not command -q tmux
    echo "Tmux not found"
    return 1

    set -l group ""
    SET -l query ""

    # use case
    # p         -> fzf em tudo
    # p vert    -> fzf em vert
    # p my      -> fzf em my-projects
    # p vert/dev-vertc -> fzf em vert/dev-vertc
    
    if test (count $argv) -ge 1

      switch $argv[1]
        case vert my personal
          set group $argv[1]
          if test (count $argv) -ge 2
            set query $argv[2]
          end
        case "*"
          set query $argv[1]
      end
    end

    set -l list (__list_projects $group)

    if test -z "$query"
      if not command -q fzf
        echo "Fzf not found"
        echo "Projetos disponiveis"
        printf "%s\n" $list | cut -f1
        return 1
      end

      set -l picked (printf "%s\n" $list | fzf --with-nth=1 --delimiter="\t" --prompt="Projeto -> ")
      test -n "$picked"; or return 0

      set -l label (string split "\t" -- $picked)[1]
      set -l root  (string split "\t" -- $picked)[2]
    else
      # resolve group/name ou "name"
      set -l match (printf "%s\n" $list | awk -v q="$query" -F'\t' '$1==q || $1~"/"q"$" {print $0}' | head -n 1)
      if test -z "$match"
        echo "Projeto não encontrado: $query"
        echo "Dica: use 'p' e escolha na lista"
        return 1
      end

      set -l label (string split "\t" -- $match)[1]
      set -l root  (string split "\t" -- $match)[2]
    end

    set -l session (string replace -a "/" "__" -- $label) # session name without /

    # create tmux session on the project root
    tmux has-session -t $session 2>/dev/null; or begin
      tmux new-session -d -s $session -c $root -n app

      # basic layout 
      tmux send-keys -t $session:1 "n" C-m # open nvim automatically
      tmux select-window -t $session:1
    end

    # entrar/trocar
    if set -q TMUX
      tmux switch-client -t $session
    else
      tmux attach -t $session
    end
  end
end
