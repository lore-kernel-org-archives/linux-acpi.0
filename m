From: Mizu <michal-VaXaUECoPuY@public.gmane.org>
Subject: ACPI-20021122 status on ACER TM 630
Date: Tue, 3 Dec 2002 20:34:16 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021203193416.GA784@mizu.intrak.tuke.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi.

Basic INFO:

kernel:2.4.20-rc3.

#
##boot message:
#
Linux version 2.4.20-rc1 (root@mizu) (gcc version 2.95.4 20011002
(Debian prerelease)) #10 Sat Nov 30 13:26:48 CET 2002
 BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fef0000 (usable)
 BIOS-e820: 000000000fef0000 - 000000000feff000 (ACPI data)
 BIOS-e820: 000000000feff000 - 000000000ff00000 (ACPI NVS)
 BIOS-e820: 000000000ff00000 - 0000000010000000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
 254MB LOWMEM available.
 ACPI: have wakeup address 0xc0001000
 On node 0 totalpages: 65264
 zone(0): 4096 pages.
 zone(1): 61168 pages.
 zone(2): 0 pages.
 ACPI: RSDP (v000 PTLTD                      ) @ 0x000f6db0
 ACPI: RSDT (v001 PTLTD    RSDT   01540.00000) @ 0x0fefa663
 ACPI: FADT (v001 ALI    M1533    01540.00000) @ 0x0fefeeaf
 ACPI: BOOT (v001 PTLTD  $SBFTBL$ 01540.00000) @ 0x0fefef23
 ACPI: SSDT (v001 PTLTD  ACPIPST1 01540.00000) @ 0x0fefef4b
 ACPI: DSDT (v001    ALI    M1533 01540.00000) @ 0x00000000
 ACPI: BIOS passes blacklist
=2E..
 ACPI: Subsystem revision 20021111
 PCI: PCI BIOS revision 2.10 entry at 0xfd58e, last bus=3D3
 PCI: Using configuration type 1
 ACPI-0508: *** Info: GPE Block0 defined as GPE0 to GPE63
 ACPI: Interpreter enabled
 ACPI: Using PIC for interrupt routing
 ACPI: System [ACPI] (supports S0 S3 S4 S5)
 ACPI: PCI Root Bridge [PCI0] (00:00)
 PCI: Probing PCI hardware (bus 00)
 ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
 ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
 ACPI: PCI Interrupt Link [LNKB] (IRQs 11, disabled)
 ACPI: PCI Interrupt Link [LNKC] (IRQs 10, enabled at IRQ 11)
 ACPI: PCI Interrupt Link [LNKD] (IRQs 11, disabled)
 ACPI: PCI Interrupt Link [LNKE] (IRQs *11)
 ACPI: PCI Interrupt Link [LNKF] (IRQs 11, disabled)
 ACPI: PCI Interrupt Link [LNKG] (IRQs *11)
 ACPI: PCI Interrupt Link [LNKH] (IRQs 11, enabled at IRQ 10)
 ACPI: PCI Interrupt Link [LNKU] (IRQs *11)
 ACPI: Embedded Controller [EC] (gpe 34)
 schedule_task(): keventd has not started
 PCI: Probing PCI hardware
 ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
 ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
 ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 11
 PCI: No IRQ known for interrupt pin A of device 00:10.0<6>PCI: Using
 ACPI for IRQ routing
 PCI: if you experience problems, try using option 'pci=3Dnoacpi' or
 even 'acpi=3Doff'
   =20
#
#cat /proc/acpi/battery/BAT0/info
#
present:                 yes
design capacity:         3920 mAh
last full capacity:      3920 mAh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 30 mAh
design capacity low:     20 mAh
capacity granularity 1:  10 mAh
capacity granularity 2:  3470 mAh
model number:            Bat0
serial number:
battery type:            Lion
OEM info:                Acer

#cat /proc/acpi/battery/BAT0/state

present:                 yes
capacity state:          ok
charging state:          discharging
present rate:            unknown
remaining capacity:      2040 mAh
present voltage:         14800 mV

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
Everything seems to be OK, but....

Problems:


acpi -b:
	nothing
acpi -V:
     Thermal 1: ok, 46.0 degrees C
     Thermal 2: ok, 41.0 degrees C
     AC Adapter 1: off-line


But my GNOME2 applet Battery Charge Monitor 2.0.4. display correct info
about my battery and about charging.....i dont understand !
It is very strange ?!



I wanna suspend my computer. I dont know how. maybe echo 1 >/proc/acpi/slee=
p  ??
or i have to use swsupend project ?


Thanks for more information.


			Mizu


--=20
        -[ Mizu ]-
#-------------------------#
[-> E-mail:michal-VaXaUECoPuY@public.gmane.org   =20
[-> ICQ:97165392
[-> WWW: http://www.mizu.sk


--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE97Qc49kFXwDL4DRkRAt3ZAKCLAaPZedUVO+vhZwn438vuphqGTgCgspfq
SQuDOazCis5I5S0Gu8ZoMCU=
=kR99
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--


-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET 
comprehensive development tool, built to increase your 
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en
