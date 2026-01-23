function __list_projects --argument-names group
  set -l roots

  switch "$group"
    case vert
      set roots $DEV_VERT
    case my personal
      set roots $DEV_MY
    case "*"
      set roots $DEV_MY $DEV_VERT
  end

  for root in $roots
    test -d "$root"; or continue

    for dir in $root/*/ 
      set -l d (string trim -r -c / -- $dir)
      __is_code_project $d; or continue

      set -l name (basename $d)
      set -l grp (basename $root)

      # output format "group/name<TAB>/path/full"
      printf "%s/%s\t%s\n" $grp $name $d
    end
  end
end
