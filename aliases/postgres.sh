if [[ -d "$HOME/.linuxbrew" ]]; then
  alias pg_start="pg_ctl start -D $HOME/.linuxbrew/var/postgres -l logfile"
  alias pg_stop="pg_ctl stop -D $HOME/.linuxbrew/var/postgres"
elif [[ -d "/home/linuxbrew/.linuxbrew" ]]; then
  alias pg_start="pg_ctl start -D /home/linuxbrew/.linuxbrew/var/postgres -l logfile"
  alias pg_stop="pg_ctl stop -D /home/linuxbrew/.linuxbrew/var/postgres"
fi
