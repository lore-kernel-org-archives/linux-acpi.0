From: Dieter Jurzitza <dieter.jurzitza@t-online.de>
Subject: Blacklisted system / blacklisting bad
Date: Sun, 3 Sep 2006 11:34:32 +0200
Message-ID: <200609031134.33024.dieter.jurzitza@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout06.sul.t-online.com ([194.25.134.19]:11201 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751201AbWICKhB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Sep 2006 06:37:01 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>

Dear listmembers,
I recently got a HP VISUALIZE NT workstation, using 2x 1GHz PIII proces=
sors=20
(no racing car, but that's not the point). After installation ACPI was =
always=20
disabled, the on board USB interface did not work (kernel 2.6.11.4 (SuS=
E=20
linux 9.3)

I tested using acpi=3Dforce on the commandline and that solved two prob=
lems:

1.) shutdown -h now switches the machine off (should be expected :-):-)=
 )
2.) much more important: the onboard USB interface works now.

After patching dmi_scan.c and removing the blacklist-entry I get the fo=
llowing=20
message at boot time:

<4>PCI: Probing PCI hardware (bus 00)
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
<4> =A0 =A0ACPI-0234: *** Warning: Wrong _BBN value, please reboot and =
using=20
option 'pci=3Dnoacpi'
<6>ACPI: PCI _CRS 2 overrides _BBN 0
<6>ACPI: PCI Root Bridge [PCI1] (00:02)
<4>PCI: Probing PCI hardware (bus 02)

If I du so (pci=3Dnoacpi at boottime) the on board USB interface gets s=
tuck=20
again and refuses to work.

So, blacklisting seems to be malicious for this machine and this kernel=
 (I=20
know that for many of you 2.6.11 might be outdated, but that's not the=20
point). Even pci=3Dnoacpi is bad.

If either pci=3Dnoacpi or acpi=3Dht is given, I get the following messa=
ge=20
in /var/log/messages:

Sep  2 13:04:06 linux kernel: ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host=
=20
Controller (OHCI) Driver (PCI)
Sep  2 13:04:06 linux kernel: PCI->APIC IRQ transform: 0000:00:0f.2[A] =
-> IRQ=20
0
Sep  2 13:04:06 linux kernel: ohci_hcd 0000:00:0f.2: Found HC with no I=
RQ. =20
Check BIOS/PCI 0000:00:0f.2 setup!

I assume this is why the onboard USB-controller is disfunctional as soo=
n as I=20
do what is recommended, i. e. keep the blacklisting / boot with pci=3Dn=
oirq.

Therefore I suggest patching dmi_scan.c and remove the entry for HP VIS=
UALIZE.=20
With a freshly built kernel without the blacklisting the machine has ha=
ppily=20
been building kernels for hours now without a single problem.

If there is anything I should test on top of this to verify whatever sh=
ould be=20
verified, please let me know! Any hints are highly appreciated.

To whom this might concern,
take care


Dieter Jurzitza
--=20
-----------------------------------------------------------

                               |
                                \
                 /\_/\           |
                | ~x~ |/-----\   /
                 \   /-       \_/
  ^^__   _        /  _  ____   /
 <=B0=B0__ \- \_/     |  |/    |  |
  ||  ||         _| _|    _| _|

if you really want to see the pictures above - use some font
with constant spacing like courier! :-)
-----------------------------------------------------------

--=20
VGER BF report: U 0.508633
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
