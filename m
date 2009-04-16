From: Norbert Preining <preining@logic.at>
Subject: gnome-power-manager: adjusting brightness kills AltGr key behaviour
Date: Thu, 16 Apr 2009 13:56:41 +0200
Message-ID: <20090416115641.GA15237@gandalf.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:39530 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbZDPL6d (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Apr 2009 07:58:33 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Debian Bug Tracking System <submit@bugs.debian.org>
Cc: linux-acpi@vger.kernel.org

Package: gnome-power-manager
Version: 2.24.4-2
Severity: important

Dear all,

(going to Debian BTS and acpi mailing list)

I am having the following strange phenomenon:

When I log into the gnome session the AltGr key is working, thus on my
German kbd I get
   AltGr-q -> AT sign
   AltGr-8 -> open square bracket
   ...
As soon as I adjust the brightness with Fn-F5 or Fn-F6 the OSD with the
brightness level appears, the brightness is adjusted, but at the same
time the functionality of the AltGr key is lost. Pressing AltGr-q I get 
a q instead of the AT sign.

This is 100% repeatable, and happens only in Gnome. I tried the failsafe
terminal session and pressing the keys did not change anything, nor the
brightness, nor the AltGr behaviour.

So I guess that the culprit is one of those adjusting the brightness, and
not the hardware support for sending the kbd events.

Since a missing AltGr on a German kbd means there is no AT, no curly nor
square brackets, etc, that is very disturbing, and I need to restart X 
to get normal behaviour back.

Hard/Software:
- Sony Vaio VGN-Z11
- kernel 2.6.29 plus latest sony-acpi patches from Mattia/ACPI ML
- Debian/sid up2date

Hope that someone can help me there

All the best

Norbert

-- Package-specific info:
Distro version:       squeeze/sid
Kernel version:       2.6.29
g-p-m version:        2.24.4
HAL version:          0.5.12
System manufacturer:  missing
System version:       missing
System product:       missing
AC adapter present:   yes
Battery present:      yes
Laptop panel present: yes
CPU scaling present:  yes
Battery Information:
  battery.charge_level.current = 62650  (0xf4ba)  (int)
  battery.charge_level.design = 89260  (0x15cac)  (int)
  battery.charge_level.last_full = 89260  (0x15cac)  (int)
  battery.charge_level.percentage = 70  (0x46)  (int)
  battery.charge_level.rate = 17476  (0x4444)  (int)
  battery.is_rechargeable = true  (bool)
  battery.model = ''  (string)
  battery.present = true  (bool)
  battery.rechargeable.is_charging = true  (bool)
  battery.rechargeable.is_discharging = false  (bool)
  battery.remaining_time = 5481  (0x1569)  (int)
  battery.reporting.current = 62650  (0xf4ba)  (int)
  battery.reporting.design = 89260  (0x15cac)  (int)
  battery.reporting.last_full = 89260  (0x15cac)  (int)
  battery.reporting.rate = 17476  (0x4444)  (int)
  battery.reporting.technology = 'Li-ion'  (string)
  battery.reporting.unit = 'mWh'  (string)
  battery.serial = ''  (string)
  battery.technology = 'lithium-ion'  (string)
  battery.type = 'primary'  (string)
  battery.vendor = 'Sony Corporation'  (string)
  battery.voltage.current = 11761  (0x2df1)  (int)
  battery.voltage.design = 10800  (0x2a30)  (int)
  battery.voltage.unit = 'mV'  (string)
GNOME Power Manager Process Information:
HAL Process Information:
109       4155  0.0  0.1  36804  5500 ?        Ss   12:58   0:01 /usr/sbin/hald
root      4221  0.0  0.0  15668  1244 ?        S    12:58   0:00  \_ hald-runner
root      4263  0.0  0.0  28320  2064 ?        S    12:58   0:00      \_ hald-ad
root      4307  0.0  0.0  28320  2052 ?        S    12:58   0:00      \_ hald-ad
109       4310  0.0  0.0  32216  2036 ?        S    12:58   0:00      \_ hald-ad

-- System Information:
Debian Release: squeeze/sid
  APT prefers unstable
  APT policy: (500, 'unstable')
Architecture: amd64 (x86_64)

Kernel: Linux 2.6.29 (SMP w/2 CPU cores; PREEMPT)
Locale: LANG=en_US.UTF-8, LC_CTYPE=en_US.UTF-8 (charmap=UTF-8)
Shell: /bin/sh linked to /bin/bash

Versions of packages gnome-power-manager depends on:
ii  consolekit   0.3.0-2                     framework for defining and trackin
ii  dbus-x11     1.2.12-1                    simple interprocess messaging syst
ii  gconf2       2.26.0-1                    GNOME configuration database syste
ii  hal          0.5.12~git20090406.46dc48-1 Hardware Abstraction Layer
ii  libc6        2.9-7                       GNU C Library: Shared libraries
ii  libcairo2    1.8.6-2+b1                  The Cairo 2D vector graphics libra
ii  libdbus-1-3  1.2.12-1                    simple interprocess messaging syst
ii  libdbus-glib 0.80-3                      simple interprocess messaging syst
ii  libgconf2-4  2.26.0-1                    GNOME configuration database syste
ii  libglade2-0  1:2.6.4-1                   library to load .glade files at ru
ii  libglib2.0-0 2.20.1-1                    The GLib library of C routines
ii  libgnome-key 2.26.0-3                    GNOME keyring services library
ii  libgnome2-0  2.24.1-2                    The GNOME 2 library - runtime file
ii  libgnomeui-0 2.24.1-1                    The GNOME 2 libraries (User Interf
ii  libgstreamer 0.10.22-3                   Core GStreamer libraries and eleme
ii  libgtk2.0-0  2.14.7-5                    The GTK+ graphical user interface 
ii  libnotify1 [ 0.4.5-1                     sends desktop notifications to a n
ii  libpanel-app 2.24.3-1+b1                 library for GNOME Panel applets
ii  libpango1.0- 1.24.0-3+b1                 Layout and rendering of internatio
ii  libunique-1. 1.0.8-1                     Library for writing single instanc
ii  libx11-6     2:1.2.1-1                   X11 client-side library
ii  libxext6     2:1.0.4-1                   X11 miscellaneous extension librar
ii  libxrandr2   2:1.3.0-2                   X11 RandR extension library
ii  notification 0.4.0-1                     a daemon that displays passive pop

gnome-power-manager recommends no packages.

gnome-power-manager suggests no packages.

-- no debconf information
