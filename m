From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: 3.9.0 + CONFIG_X86_INTEL_PSTATE=y  -> ThinkPad T420 with i5 lost
 ACPI functionality
Date: Fri, 03 May 2013 18:55:37 +0200
Message-ID: <5183EC09.9080208@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

The following file doesn't exists at my Gentoo Linux
/sys/devices/system/cpu/cpufreq/ondemand/ignore_nice_load
in 3.9.0 if I activate CONFIG_X86_INTEL_PSTATE=3Dy=20

That means, that a command like

$> echo 1 > /sys/devices/system/cpu/cpufreq/ondemand/ignore_nice_load

in /etc/rc.local is now no longer working.
A high fan +  high temperature are the result, even if just the BOINC c=
lient
is run with low prio (nice 19) in the back ground.

Manually loading the missing module won't work too :

$> modprobe acpi_cpufreq
modprobe: ERROR: could not insert 'acpi_cpufreq': Device or resource bu=
sy

Is the behaviour a bug or a feature ?
In the later case: How can I achieve the previous behaviour back ?

This issue might affect the RH EL kernel too [1] where I observed a sim=
ilar behaviour.


[1] http://elrepo.org/bugs/view.php?id=3D379

--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
