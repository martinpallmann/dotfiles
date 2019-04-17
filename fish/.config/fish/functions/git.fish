function git --wraps hub --description 'Alias for hub, which wraps git to provide extra functionality with GitHub.'
  if pwd | grep '/Users/mpallmann/Z' > /dev/null
    set -x GITHUB_TOKEN (security find-generic-password -a mpallmann -s github.bus.zalan.do.oauth -w)
    set -x GITHUB_HOST github.bus.zalan.do
  else
    set -x GITHUB_TOKEN (security find-generic-password -a martinpallmann -s github.com.oauth -w)
    set -x GITHUB_HOST github.com
  end
  hub $argv
  set -e GITHUB_HOST
end

