From: Athlion <athlion@gmail.com>
Subject: Re: Kernel stops at "PM: Preparing system for mem sleep", never makes
 it to "Freezing user space processes ... "
Date: Sat, 11 Aug 2012 18:18:46 +0300
Message-ID: <CACfp432=M5XkqRXpKfzstvQo59tytHGoV1_r15DtV3ZhYvGwoA@mail.gmail.com>
References: <CACfp4335KJQ8Zjj0TJNj65Va9K-t_iEHLEGEi8QuWyQj5dVT0g@mail.gmail.com>
 <201208090033.52380.rjw@sisk.pl> <CACfp433snentBjXMaoLLnemD82-xRCZge9aCCRd1Ao=7yhG=RQ@mail.gmail.com>
 <201208091141.58586.rjw@sisk.pl> <CACfp431RNXmp_453ZU999bQzdBgiU20FEehvLH+DxnZbALAc3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56720 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656Ab2HKPTI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Aug 2012 11:19:08 -0400
In-Reply-To: <CACfp431RNXmp_453ZU999bQzdBgiU20FEehvLH+DxnZbALAc3A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

Ok, this thing happened again! Whatsmore, this happened on pm-suspend
while on [core].

The kernel output this:
Aug 11 17:59:16 localhost logger: LID closed
Aug 11 17:59:16 localhost kernel: [32512.391116] EXT4-fs (sda1):
re-mounted. Opts: discard,barrier=0,commit=0
Aug 11 17:59:17 localhost kernel: [32512.520905] wlan0:
deauthenticating from 00:13:33:a1:23:46 by local choice (reason=3)
Aug 11 17:59:17 localhost kernel: [32512.530786] cfg80211: Calling
CRDA to update world regulatory domain
Aug 11 17:59:17 localhost NetworkManager[794]: <info> (wlan0): now unmanaged
Aug 11 17:59:17 localhost NetworkManager[794]: <info> (wlan0): device
state change: activated -> unmanaged (reason 'removed') [100 10 36]
Aug 11 17:59:17 localhost NetworkManager[794]: <info> (wlan0):
deactivating device (reason 'removed') [36]
Aug 11 17:59:17 localhost dhcpcd[12635]: received SIGTERM, stopping
Aug 11 17:59:17 localhost dhcpcd[12635]: wlan0: removing interface
Aug 11 17:59:17 localhost dhcpcd[12635]: wlan0: del_route: No such device
Aug 11 17:59:17 localhost dhcpcd[12635]: del_address: No such device
Aug 11 17:59:17 localhost kernel: [32512.607181] ehci_hcd
0000:00:1d.0: remove, state 1
Aug 11 17:59:17 localhost kernel: [32512.607212] usb usb2: USB
disconnect, device number 1
Aug 11 17:59:17 localhost kernel: [32512.607214] usb 2-1: USB
disconnect, device number 2
Aug 11 17:59:17 localhost kernel: [32512.612488] ehci_hcd
0000:00:1d.0: USB bus 2 deregistered
Aug 11 17:59:17 localhost kernel: [32512.612528] ehci_hcd
0000:00:1a.0: remove, state 1
Aug 11 17:59:17 localhost kernel: [32512.612533] usb usb1: USB
disconnect, device number 1
Aug 11 17:59:17 localhost kernel: [32512.612534] usb 1-1: USB
disconnect, device number 2
Aug 11 17:59:17 localhost kernel: [32512.617226] ehci_hcd
0000:00:1a.0: USB bus 1 deregistered
Aug 11 17:59:17 localhost NetworkManager[794]: <info> (wlan0):
canceled DHCP transaction, DHCP client pid 12635
Aug 11 17:59:17 localhost NetworkManager[794]: <warn> (44) failed to
find interface name for index
Aug 11 17:59:17 localhost NetworkManager[794]:
nm_system_iface_flush_routes: assertion `iface != NULL' failed
Aug 11 17:59:17 localhost NetworkManager[794]: <warn> (44) failed to
find interface name for index
Aug 11 17:59:17 localhost NetworkManager[794]: <info> (wlan0): cleaning up...
Aug 11 17:59:17 localhost NetworkManager[794]: <warn> (44) failed to
find interface name for index
Aug 11 17:59:17 localhost NetworkManager[794]:
(nm-system.c:685):nm_system_iface_get_flags: runtime check failed:
(iface != NULL)
Aug 11 17:59:17 localhost NetworkManager[794]: <error>
[1344697157.261251] [nm-system.c:687] nm_system_iface_get_flags():
(unknown): failed to get interface link object
Aug 11 17:59:17 localhost dbus[406]: [system] Activating service
name='org.freedesktop.nm_dispatcher' (using servicehelper)
Aug 11 17:59:17 localhost NetworkManager[794]: <info> radio killswitch
/sys/devices/pci0000:00/0000:00:1c.1/0000:03:00.0/ieee80211/phy33/rfkill41
disappeared
Aug 11 17:59:17 localhost NetworkManager[794]: <warn> (pid 12635)
unhandled DHCP event for interface wlan0
Aug 11 17:59:17 localhost dbus[406]: [system] Successfully activated
service 'org.freedesktop.nm_dispatcher'
Aug 11 17:59:17 localhost kernel: [32512.842664] PM: Syncing
filesystems ... done.
Aug 11 17:59:17 localhost kernel: [32512.844894] PM: Preparing system
for mem sleep
Aug 11 17:59:17 localhost NetworkManager[794]: <warn> error requesting
auth for org.freedesktop.NetworkManager.wifi.share.protected: (3)
GDBus.Error:org.freedesktop.DBus.Error.NameHasNoOwner:
GDBus.Error:org.freedesktop.DBus.Error.NameHasNoOwner: Could not get
UID of name ':1.154': no such name
Aug 11 17:59:17 localhost NetworkManager[794]: <warn> error requesting
auth for org.freedesktop.NetworkManager.wifi.share.open: (3)
GDBus.Error:org.freedesktop.DBus.Error.NameHasNoOwner:
GDBus.Error:org.freedesktop.DBus.Error.NameHasNoOwner: Could not get
UID of name ':1.154': no such name
Aug 11 14:59:56 localhost rtkit-daemon[1885]: Successfully made thread
13922 of process 13922 (/usr/bin/pulseaudio) owned by '1000' high
priority at nice level -11.
Aug 11 14:59:56 localhost rtkit-daemon[1885]: Supervising 1 threads of
1 processes of 1 users.
Aug 11 17:59:56 localhost pulseaudio[13922]: [pulseaudio] pid.c: Stale
PID file, overwriting.
Aug 11 17:59:56 localhost dbus[406]: [system] Activating service
name='org.bluez' (using servicehelper)
Aug 11 17:59:56 localhost dbus[406]: [system] Activated service
'org.bluez' failed: Launch helper exited with unknown return code 1
Aug 11 17:59:56 localhost pulseaudio[13922]: [pulseaudio]
bluetooth-util.c: org.bluez.Manager.ListAdapters() failed:
org.freedesktop.DBus.Error.Spawn.ChildExited: Launch helper exited
with unknown return code 1
Aug 11 14:59:57 localhost rtkit-daemon[1885]: Successfully made thread
13987 of process 13987 (/usr/bin/pulseaudio) owned by '1000' high
priority at nice level -11.
Aug 11 14:59:57 localhost rtkit-daemon[1885]: Supervising 2 threads of
2 processes of 1 users.
Aug 11 17:59:57 localhost pulseaudio[13987]: [pulseaudio] pid.c:
Daemon already running.
Aug 11 18:01:01 localhost /USR/SBIN/CROND[14152]: (root) CMD
(run-parts /etc/cron.hourly)

and then nothing more. Whatsmore, X crashed and no more ACPI events
got registered.
I am really clueless regarding this and have nowhere to look. One hint
would be that after I killed and restarted my X server at 12 hours of
uptime, the problem re-surfaced at about 33 hours uptime, so it might
be something with X but I don't really know how this could affect the
kernel....
