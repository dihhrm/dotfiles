function __is_code_project --argument-names dir
  test -d "$dir"; or return 1

  test -d "$dir/.git"; and return 0
  test -f "$dir/package.json"; and return 0
  test -f "$dir/requirements.txt"; and return 0
  test -f "$dir/go.mod"; and return 0

  return 1
end
