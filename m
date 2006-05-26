From: "Garry T. Williams" <gtwilliams@gmail.com>
Subject: Sony Vaio FS640/W Failure to Wake From S3
Date: Thu, 25 May 2006 20:34:50 -0400
Message-ID: <200605252034.50903.gtwilliams@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.203]:34341 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965212AbWEZAey (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 May 2006 20:34:54 -0400
Received: by wx-out-0102.google.com with SMTP id s6so1401795wxc
        for <linux-acpi@vger.kernel.org>; Thu, 25 May 2006 17:34:53 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

My Fedora Core 5 (2.6.16-1.2122_FC5) system does not recover from
suspend to memory.  This used to just work under FC4.  Unfortunately,
I do not know what update caused the original failure.  I stopped
carrying the laptop back and forth to work several months ago, so I
didn't notice that S3 wasn't working since I didn't use it very often.

What can I do to get information on this failure?

I have nothing in my system log to indicate what the problem is.  The
power comes on, the disk light stays on for about 40 seconds then
turns off, and then everything just hangs.  Everything is just stalled
or frozen -- no network access, no messages in the log.  The only way
to recover is to power down and then power up again.

Some more info:

I suspend from an acpi lid switch handler.  It does this:

    /usr/bin/dbus-send --system --print-reply \
	--reply-timeout=2000 \
	--dest=org.freedesktop.NetworkManager \
	/org/freedesktop/NetworkManager \
	org.freedesktop.NetworkManager.sleep
    /sbin/hwclock --systohc
    echo mem >/sys/power/state
    /usr/bin/dbus-send --system \
	--dest=org.freedesktop.NetworkManager \
	/org/freedesktop/NetworkManager \
	org.freedesktop.NetworkManager.wake
    /sbin/hwclock --hctosys

The acpid log file shows the go-to-sleep part of the above (I have
some debugging messages in the lid handler script), but it does not
indicate that control returned after wake-up.  I wake by striking the
Ctrl key on the keyboard.

acpid log:

    [Thu May 25 20:12:29 2006] received event "button/lid LID0 00000080 00000001"
    [Thu May 25 20:12:29 2006] notifying client 2193[68:68]
    [Thu May 25 20:12:29 2006] executing action "/etc/acpi/actions/lid -d"
    [Thu May 25 20:12:29 2006] BEGIN HANDLER MESSAGES
    lid: entered
    lid: 20:12:29 sending dbus sleep message to nm
    [Thu May 25 20:15:28 2006] starting up

My system log shows this:

    NetworkManager: <information> Going to sleep.
    avahi-daemon[2166]: Interface eth1.IPv4 no longer relevant for mDNS.
    avahi-daemon[2166]: Leaving mDNS multicast group on interface eth1.IPv4 with address 192.168.0.51.
    avahi-daemon[2166]: Withdrawing address record for 192.168.0.51 on eth1.
    NetworkManagerDispatcher: ntpd is running, stop
    dhclient: DHCPRELEASE on eth1 to 192.168.0.1 port 67
    dhclient: send_packet: Network is unreachable
    dhclient: send_packet: please consult README file regarding broadcast address.
    named[2248]: D-BUS: dhclient for interface eth1 released lease - removing forwarders.
    ntpd[2674]: ntpd exiting on signal 15
    syslogd 1.4.1: restart.

-- 
Garry T. Williams --- +1 678 656-4579


