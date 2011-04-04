From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Subject: Probably wrong temparature for thermal zone on HP DL380 G7
 server
Date: Mon, 04 Apr 2011 16:29:12 +0200
Message-ID: <4D99F1D8020000A100005903@gwsmtp1.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rrzmta1.uni-regensburg.de ([194.94.155.51]:42682 "EHLO
	rrzmta1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754511Ab1DDOgJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Apr 2011 10:36:09 -0400
Received: from rrzmta1.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id BF6DBA4D
	for <linux-acpi@vger.kernel.org>; Mon,  4 Apr 2011 16:29:17 +0200 (CEST)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
	by rrzmta1.uni-regensburg.de (Postfix) with ESMTP id 8E4857B1
	for <linux-acpi@vger.kernel.org>; Mon,  4 Apr 2011 16:29:17 +0200 (CEST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

with SLES11 SP1 (current kernel), acpi reports:
linux:~ # acpi -cV
No support for device type: battery
     Thermal 1: ok, 8.0 degrees C
No support for device type: ac_adapter

I doubt that 8=C2=B0C as the ambient temperature is around 20=C2=B0C.

When comparing with the IPMI data I see this:
linux:~ # ipmitool sdr
UID Light        | 0 unspecified     | ok
Sys. Health LED  | 0 unspecified     | ok
Power Supply 1   | 60 Watts          | nc
Power Supply 2   | 65 Watts          | nc
Power Supplies   | 0 unspecified     | nc
=46an 1            | 33.32 unspecifi | nc
=46an 2            | 39.20 unspecifi | nc
=46an 3            | 39.20 unspecifi | nc
=46an 4            | 29.79 unspecifi | nc
=46an 5            | 25.09 unspecifi | nc
=46an 6            | 13.72 unspecifi | nc
=46ans             | 0 unspecified     | nc
Temp 1           | 21 degrees C      | ok
Temp 2           | 40 degrees C      | ok
Temp 3           | 40 degrees C      | ok
Temp 4           | 27 degrees C      | ok
Temp 5           | 27 degrees C      | ok
Temp 6           | 31 degrees C      | ok
Temp 7           | 31 degrees C      | ok
Temp 8           | 39 degrees C      | ok
Temp 9           | 34 degrees C      | ok
Temp 10          | 38 degrees C      | ok
Temp 11          | 32 degrees C      | ok
Temp 12          | 39 degrees C      | ok
Temp 13          | 27 degrees C      | ok
Temp 14          | 31 degrees C      | ok
Temp 15          | 29 degrees C      | ok
Temp 16          | 26 degrees C      | ok
Temp 17          | 28 degrees C      | ok
Temp 18          | disabled          | ns
Temp 19          | 23 degrees C      | ok
Temp 20          | 30 degrees C      | ok
Temp 21          | 26 degrees C      | ok
Temp 22          | 27 degrees C      | ok
Temp 23          | 34 degrees C      | ok
Temp 24          | 30 degrees C      | ok
Temp 25          | 31 degrees C      | ok
Temp 26          | 32 degrees C      | ok
Temp 27          | disabled          | ns
Temp 28          | 28 degrees C      | ok
Temp 29          | 35 degrees C      | ok
Temp 30          | 56 degrees C      | ok
Memory           | 0 error           | ok
Power Meter      | 182 Watts         | cr

Here's the PCI Hardware:
linux:~ # lspci
00:00.0 Host bridge: Intel Corporation 5520 I/O Hub to ESI Port (rev 13=
)
00:01.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express=
 Root
Port 1 (rev 13)
00:02.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express=
 Root
Port 2 (rev 13)
00:03.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express=
 Root
Port 3 (rev 13)
00:04.0 PCI bridge: Intel Corporation 5520/X58 I/O Hub PCI Express Root=
 Port 4
(rev 13)
00:05.0 PCI bridge: Intel Corporation 5520/X58 I/O Hub PCI Express Root=
 Port 5
(rev 13)
00:06.0 PCI bridge: Intel Corporation 5520/X58 I/O Hub PCI Express Root=
 Port 6
(rev 13)
00:07.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express=
 Root
Port 7 (rev 13)
00:08.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express=
 Root
Port 8 (rev 13)
00:09.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express=
 Root
Port 9 (rev 13)
00:0a.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express=
 Root
Port 10 (rev 13)
00:0d.0 Host bridge: Intel Corporation Device 343a (rev 13)
00:0d.1 Host bridge: Intel Corporation Device 343b (rev 13)
00:0d.2 Host bridge: Intel Corporation Device 343c (rev 13)
00:0d.3 Host bridge: Intel Corporation Device 343d (rev 13)
00:0d.4 Host bridge: Intel Corporation 5520/5500/X58 Physical Layer Por=
t 0
(rev 13)
00:0d.5 Host bridge: Intel Corporation 5520/5500 Physical Layer Port 1 =
(rev
13)
00:0d.6 Host bridge: Intel Corporation Device 341a (rev 13)
00:0e.0 Host bridge: Intel Corporation Device 341c (rev 13)
00:0e.1 Host bridge: Intel Corporation Device 341d (rev 13)
00:0e.2 Host bridge: Intel Corporation Device 341e (rev 13)
00:0e.3 Host bridge: Intel Corporation Device 341f (rev 13)
00:0e.4 Host bridge: Intel Corporation Device 3439 (rev 13)
00:14.0 PIC: Intel Corporation 5520/5500/X58 I/O Hub System Management
Registers (rev 13)
00:14.1 PIC: Intel Corporation 5520/5500/X58 I/O Hub GPIO and Scratch P=
ad
Registers (rev 13)
00:14.2 PIC: Intel Corporation 5520/5500/X58 I/O Hub Control Status and=
 RAS
Registers (rev 13)
00:1c.0 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Expres=
s Root
Port 1
00:1c.2 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Expres=
s Root
Port 3
00:1c.4 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Expres=
s Root
Port 5
00:1d.0 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UH=
CI
Controller #1
00:1d.1 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UH=
CI
Controller #2
00:1d.2 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UH=
CI
Controller #3
00:1d.3 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UH=
CI
Controller #6
00:1d.7 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB2 E=
HCI
Controller #1
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 90)
00:1f.0 ISA bridge: Intel Corporation 82801JIB (ICH10) LPC Interface
Controller
00:1f.2 IDE interface: Intel Corporation 82801JI (ICH10 Family) 4 port =
SATA
IDE Controller #1
01:03.0 VGA compatible controller: ATI Technologies Inc ES1000 (rev 02)
02:00.0 System peripheral: Hewlett-Packard Company iLO3 Slave instrumen=
tation
& System support (rev 04)
02:00.2 System peripheral: Hewlett-Packard Company iLO3 Management Proc=
essor
Support and Messaging (rev 04)
02:00.4 USB Controller: Hewlett-Packard Company Proliant iLO2/iLO3 virt=
ual USB
controller (rev 01)
03:00.0 Ethernet controller: Broadcom Corporation NetXtreme II BCM5709 =
Gigabit
Ethernet (rev 20)
03:00.1 Ethernet controller: Broadcom Corporation NetXtreme II BCM5709 =
Gigabit
Ethernet (rev 20)
04:00.0 Ethernet controller: Broadcom Corporation NetXtreme II BCM5709 =
Gigabit
Ethernet (rev 20)
04:00.1 Ethernet controller: Broadcom Corporation NetXtreme II BCM5709 =
Gigabit
Ethernet (rev 20)
05:00.0 RAID bus controller: Hewlett-Packard Company Smart Array G6
controllers (rev 01)
0b:00.0 Fibre Channel: Brocade Communications Systems, Inc. 415/815/41B=
/81B
4Gbps/8Gbps PCIe single port FC HBA (rev 01)
0b:00.1 Fibre Channel: Brocade Communications Systems, Inc. 415/815/41B=
/81B
4Gbps/8Gbps PCIe single port FC HBA (rev 01)
0e:00.0 Ethernet controller: Broadcom Corporation NetXtreme II BCM5709 =
Gigabit
Ethernet (rev 20)
0e:00.1 Ethernet controller: Broadcom Corporation NetXtreme II BCM5709 =
Gigabit
Ethernet (rev 20)
18:00.0 Fibre Channel: Brocade Communications Systems, Inc. 415/815/41B=
/81B
4Gbps/8Gbps PCIe single port FC HBA (rev 01)
18:00.1 Fibre Channel: Brocade Communications Systems, Inc. 415/815/41B=
/81B
4Gbps/8Gbps PCIe single port FC HBA (rev 01)

linux:~ # uname -a
Linux linux 2.6.32.29-0.3-default #1 SMP 2011-02-25 13:36:59 +0100 x86_=
64
x86_64 x86_64 GNU/Linux
linux:~ # cat /proc/version
Linux version 2.6.32.29-0.3-default (geeko@buildhost) (gcc version 4.3.=
4
[gcc-4_3-branch revision 152973] (SUSE Linux) ) #1 SMP 2011-02-25 13:36=
:59
+0100

Regards,
Ulrich
P.S. Not subscribed to this list
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
