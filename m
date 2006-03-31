From: Denis Kostousov <sandello@permonline.ru>
Subject: ACadapter on Asus P5GD2-X
Date: Fri, 31 Mar 2006 10:49:27 +0600
Message-ID: <442CB4D7.7060400@permonline.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail1.permonline.ru ([212.120.160.133]:35232 "EHLO
	mail1.permonline.ru") by vger.kernel.org with ESMTP
	id S1750747AbWCaEtb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Mar 2006 23:49:31 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have some problem with my PC: the kernel don't turn power off
I detect that kernel don't recognize ACadapter and some other ACPI devices:

$ find /proc/acpi -type f
/proc/acpi/button/power/PWRB/info
/proc/acpi/button/power/PWRF/info
/proc/acpi/wakeup
/proc/acpi/alarm
/proc/acpi/sleep
/proc/acpi/processor/CPU1/power
/proc/acpi/processor/CPU1/limit
/proc/acpi/processor/CPU1/throttling
/proc/acpi/processor/CPU1/info
/proc/acpi/event
/proc/acpi/fadt
/proc/acpi/dsdt
/proc/acpi/info

$ find /proc/acpi -type d
/proc/acpi
/proc/acpi/video
/proc/acpi/button
/proc/acpi/button/power
/proc/acpi/button/power/PWRB
/proc/acpi/button/power/PWRF
/proc/acpi/battery
/proc/acpi/ac_adapter
/proc/acpi/thermal_zone
/proc/acpi/processor
/proc/acpi/processor/CPU1
/proc/acpi/fan
/proc/acpi/power_resource
/proc/acpi/embedded_controller

# acpitool -e
Kernel version : 2.6.15-1.1833_F20050902 - ACPI version : 20050902
- -----------------------------------------------------------
Battery status : <not available>

AC adapter : <not available>
Fan : <not available>

CPU type : Intel(R) Pentium(R) 4 CPU 3.00GHz
CPU speed : 3011.062 MHz
Bogomips : 6028.53
Processor ID : 0
Bus mastering control : no
Power management : no
Throttling control : yes
Limit interface : yes
Active C-state : C1
C-states (incl. C0) : 2
Usage of state C1 : 0 (nan %)
T-state count : 8
Active T-state : T0

Thermal info : <not available>

Device Sleep state Status
- ---------------------------------------
1. P0P1 4 disabled
2. P0P3 4 disabled
3. P0P4 4 disabled
4. P0P5 4 disabled
5. P0P6 4 disabled
6. P0P7 4 disabled
7. PS2K 4 disabled
8. PS2M 4 disabled
9. UAR1 4 disabled
10. USB1 4 disabled
11. USB2 4 disabled
12. USB3 4 disabled
13. USB4 4 disabled
14. EUSB 4 disabled
15. MC97 4 disabled

I'm using: FC4 with last updates. Hardware: Asus P5GD2-X motheboard

- --
Denis Kostousov
email: sandelloTHEDOGpermonline.ru
jabber: sandelloATjabber.org
fingerprint: FE3D 60AF E08D 2D2A 6A8B  C891 70BB 0665 F047 ADAE
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFELLTXcLsGZfBHra4RAozDAKDkYDylvbqJKO/xzGC0g6I+2jSlYwCg+VWS
DxeDEBZsNmokFkKa8L1Z3Pc=
=7ssh
-----END PGP SIGNATURE-----
