From: Chris Howells <chrish-puGfsi27rH1aa/9Udqfwiw@public.gmane.org>
Subject: Not enough IRQs for multiple PCMCIA cards
Date: Sat, 10 May 2003 01:48:07 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200305100148.12713.chrish@gmx.co.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Description: clearsigned data
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I'm having huge problems trying to get enough IRQs for me to be able
to use a PCMCIA modem (D-Link 560) and a Wifi card (Netgear MA401)
simultaneously.

Basically, after PCI devices have been assigned IRQs there is only one
free IRQ which can be allocated to a PCMCIA card. If I disable some
stuff like the onboard serial and parallel ports, PCI devices get
assigned the IRQs that I have just disabled, which is of absolutely no
use.

=46or example, if I plug my modem in, it gets assigned IRQ 7. If I
remove it, and plug the Wifi card in, it gets assigned IRQ 7. If I put
both in simultaneously, the last one to be inserted does not get an
IRQ.

I have tried with ACPI enabled and with pci=3Dnoacpi.

Regrettably, my BIOS (Award Asus L3800C BIOS) does not give me any
control how IRQs are designed or PnP OS settings.

Currently, the IRQs look something like this:

chris@galadriel:~> cat /proc/interrupts
           CPU0
  0:     255219          XT-PIC  timer
  1:      11434          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:          6          XT-PIC  eth0, usb-uhci
  5:     163935          XT-PIC  usb-uhci, Ricoh Co Ltd RL5c476 II,
radeon@PCI:1:0:0
  7:      56829          XT-PIC  serial
  8:          2          XT-PIC  rtc
  9:         17          XT-PIC  acpi
 11:      29726          XT-PIC  Intel 82801CA-ICH3, Ricoh Co Ltd
RL5c476 II (#2)
 12:         75          XT-PIC  PS/2 Mouse
 14:      20172          XT-PIC  ide0
 15:         88          XT-PIC  ide1

(this is with the serial and parallel ports disabled in an attempt to
free some IRQs, which is something that I do not want to have set
permanently).

Thanks for any ideas
=2D --=20
Cheers, Chris Howells -- chris-NvB7AskkBIqIudiWw5vspbVCufUGDwFn@public.gmane.org, howells@kde.org
Web: http://chrishowells.co.uk, PGP ID: 33795A2C
KDE: http://www.koffice.org, http://printing.kde.org, http://usability.kde.=
org

=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQE+vExMF8Iu1zN5WiwRAteVAJ9K2mj+vnwWfX6RKZ/qM1IE+bUi0gCeI75e
cmFCA1Icv4qEZFCl0l2Gl8c=3D
=3Dy+hM
=2D----END PGP SIGNATURE-----


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
