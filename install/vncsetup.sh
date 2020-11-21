#!/bin/bash

sudo apt install openbox tint2 tightvncserver ufw terminator firefox

# Setting password quick
vncserver

killall Xtightvnc

mkdir ~/.vnc

touch ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup

tee -a ~/.vnc/xstartup << END 
#!/bin/sh
# Fix to make GNOME work
export XKL_XMODMAP_DISABLE=1
xrdb $HOME/.Xresources
xsetroot -solid grey
autocutsel -fork
xterm -geometry 80x24+10+10 -ls -title "$VNCDESKTOP Desktop" &

exec lxappearance &
exec openbox &
exec /usr/bin/openbox &
exec tint2 &
END

sudo tee -a /etc/systemd/system/vncserver@:1.service << END
[Unit]
Description=Remote desktop service (VNC)
After=syslog.target network.target

[Service]
Type=forking
# Clean any existing files in /tmp/.X11-unix environment
ExecStartPre=/bin/sh -c '/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :'
ExecStart=/sbin/runuser -l ed -c "/usr/bin/vncserver %i -geometry 1920x1080 -depth 24"
PIDFile=/home/ed/.vnc/%H%i.pid
ExecStop=/bin/sh -c '/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :'

[Install]
WantedBy=multi-user.target
END

sudo systemctl daemon-reload

#Its gonna throw an error here and im not sure why
# It started however so who cares
sudo systemctl start vncserver@\:1.service
