
import subprocess
import sys
import re
import os
import setup_util

def start(args, logfile, errfile):
  setup_util.replace_text("sinatra/hello_world.rb", ":host => '.*'", ":host => '" + args.database_host + "'")
  setup_util.replace_text("sinatra/config/nginx.conf", "/path/to/app/current", args.troot)
  try:
    subprocess.check_call("cp Gemfile-ruby Gemfile", shell=True, cwd="sinatra", stderr=errfile, stdout=logfile)
    subprocess.check_call("cp Gemfile-ruby.lock Gemfile.lock", shell=True, cwd="sinatra", stderr=errfile, stdout=logfile)
    subprocess.check_call("sudo /usr/local/nginx/sbin/nginx -c $TROOT/config/nginx.conf", shell=True, stderr=errfile, stdout=logfile)
    subprocess.Popen("rvm ruby-2.0.0-p0 do bundle exec unicorn_rails -E production -c $TROOT/config/unicorn.rb", shell=True, cwd="sinatra", stderr=errfile, stdout=logfile)
    return 0
  except subprocess.CalledProcessError:
    return 1
def stop(logfile, errfile):
  subprocess.call("sudo /usr/local/nginx/sbin/nginx -c $TROOT/config/nginx.conf -s stop", shell=True, stderr=errfile, stdout=logfile)
  try:
    p = subprocess.Popen(['ps', 'aux'], stdout=subprocess.PIPE)
    out, err = p.communicate()
    for line in out.splitlines():
      if 'unicorn' in line and 'master' in line:
        pid = int(line.split(None, 2)[1])
        os.kill(pid, 15)
    subprocess.check_call("rm Gemfile", shell=True, cwd="sinatra", stderr=errfile, stdout=logfile)
    subprocess.check_call("rm Gemfile.lock", shell=True, cwd="sinatra", stderr=errfile, stdout=logfile)
    return 0
  except subprocess.CalledProcessError:
    return 1
