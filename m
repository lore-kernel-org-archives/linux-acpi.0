From: Florian Lohoff <flo-BCn6idZOOBwdnm+yROfE0A@public.gmane.org>
Subject: [2.5.69] S3 does not come back / Sony Vaio C1MHP
Date: Tue, 27 May 2003 12:15:01 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030527101501.GB1247@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
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


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
S3 would be the reason to switch to 2.5 - bad that it does not work for
me ;)=20

Sony Vaio C1MHP=20
Transmeta TM5800

echo 3 >/proc/acpi/sleep

goes to sleep - The power led turns blinking red - good sign - after
pressing the powerbutton the machine powers up (Powerled turns green and
batterie led turns orange) but nothing happens. Backlight does not turn=20
on nor does the disk do anything. From looking at the screen in bright
light it does not write anything to it.

I need to disconnect the battery to get to a defined state again. The
power-button does nothing and even then the first power-on does
nothing - need to powercyle once after battery disconnect.


paradigm:~# lsmod
Module                  Size  Used by
snd_ali5451            12004  0=20
snd_ac97_codec         32900  1 snd_ali5451
snd_pcm                53568  1 snd_ali5451
snd_page_alloc          3876  1 snd_pcm
snd_timer              13152  1 snd_pcm
snd                    27904  4 snd_ali5451,snd_ac97_codec,snd_pcm,snd_timer
soundcore               3680  1 snd
usb_storage            19232  0=20
scsi_mod               73132  1 usb_storage
ohci_hcd               11680  0=20
usbcore                65332  4 usb_storage,ohci_hcd
ohci1394               22720  0=20
ieee1394               42376  1 ohci1394

paradigm:~# dmesg
Linux version 2.5.69 (root@paradigm) (gcc version 2.95.4 20011002 (Debian p=
rerelease)) #1 Tue May 27 11:40:21 CEST 2003
Video mode to be used for restore is f00
[...]
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f7bc0
ACPI: RSDT (v001 SONY   E0       08194.02068) @ 0x0eef86ed
ACPI: FADT (v002 SONY   E0       08194.02068) @ 0x0eefbe82
ACPI: SSDT (v001 PTLTD  ACPIPST1 08194.02068) @ 0x0eefbf06
ACPI: DSDT (v001   SONY E0       08194.02068) @ 0x00000000
ACPI: BIOS passes blacklist
Sony Vaio laptop detected.
[...]
ACPI: Subsystem revision 20030418
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:...............................................=
............................................................................
Table [DSDT] - 499 Objects with 48 Devices 122 Methods 13 Regions
Parsing all Control Methods:
Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions
ACPI Namespace successfully loaded at root c037535c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successf=
ul
evgpeblk-0740 [06] ev_create_gpe_block   : GPE Block: [_GPE] 8 registers at=
 0000000000008018 on interrupt 9
evgpeblk-0745 [06] ev_create_gpe_block   : GPE Block defined as GPE 0x00 to=
 GPE 0x3F
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L08 as GP=
E number 0x08
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L09 as GP=
E number 0x09
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L0B as GP=
E number 0x0B
evgpeblk-0262 [08] ev_save_method_info   : Registered GPE method _L0D as GP=
E number 0x0D
Executing all Device _STA and_INI methods:.....................[ACPI Debug]=
 String: LNK2_STA
=2E[ACPI Debug] String: LNK3_STA
=2E[ACPI Debug] String: LNK4_STA
=2E[ACPI Debug] String: LNK5_STA
=2E[ACPI Debug] String: LNK6_STA
=2E[ACPI Debug] String: LNK7_STA
=2E[ACPI Debug] String: LNK8_STA
=2E[ACPI Debug] String: LNKU_STA
=2E...................
48 Devices found containing: 48 _STA, 3 _INI methods
Completing Region/Field/Buffer/Package initialization:.....................=
...............................................
Initialized 7/13 Regions 0/0 Fields 32/32 Buffers 28/28 Packages (502 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 1)
ACPI: PCI Interrupt Link [LNK1] (IRQs *9)
[ACPI Debug] String: LNK2_STA
[ACPI Debug] String: LNK2_STA
[ACPI Debug] String: LNK2_STA
[ACPI Debug] String: LNK2_CRS
ACPI: PCI Interrupt Link [LNK2] (IRQs *9)
[ACPI Debug] String: LNK3_STA
[ACPI Debug] String: LNK3_STA
[ACPI Debug] String: LNK3_STA
[ACPI Debug] String: LNK3_CRS
ACPI: PCI Interrupt Link [LNK3] (IRQs *9)
[ACPI Debug] String: LNK4_STA
[ACPI Debug] String: LNK4_STA
[ACPI Debug] String: LNK4_STA
[ACPI Debug] String: LNK4_CRS
ACPI: PCI Interrupt Link [LNK4] (IRQs *9)
[ACPI Debug] String: LNK5_STA
[ACPI Debug] String: LNK5_STA
[ACPI Debug] String: LNK5_STA
[ACPI Debug] String: LNK5_CRS
ACPI: PCI Interrupt Link [LNK5] (IRQs *9)
[ACPI Debug] String: LNK6_STA
[ACPI Debug] String: LNK6_STA
[ACPI Debug] String: LNK6_STA
ACPI: PCI Interrupt Link [LNK6] (IRQs 9, disabled)
[ACPI Debug] String: LNK7_STA
[ACPI Debug] String: LNK7_STA
[ACPI Debug] String: LNK7_STA
[ACPI Debug] String: LNK7_CRS
ACPI: PCI Interrupt Link [LNK7] (IRQs *9)
[ACPI Debug] String: LNK8_STA
[ACPI Debug] String: LNK8_STA
[ACPI Debug] String: LNK8_STA
[ACPI Debug] String: LNK8_CRS
ACPI: PCI Interrupt Link [LNK8] (IRQs *9)
[ACPI Debug] String: LNKU_STA
[ACPI Debug] String: LNKU_STA
[ACPI Debug] String: LNKU_STA
[ACPI Debug] String: LNKU_CRS
ACPI: PCI Interrupt Link [LNKU] (IRQs *9)
ACPI: Power Resource [LRP0] (off)
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
[ACPI Debug] String: LNK6_SRS
[ACPI Debug] String: LNK6_STA
[ACPI Debug] String: LNK6_STA
[ACPI Debug] String: LNK6_CRS
ACPI: PCI Interrupt Link [LNK6] enabled at IRQ 9
 pci_irq-0295 [24] acpi_pci_irq_derive   : Unable to derive IRQ for device =
00:10.0
ACPI: No IRQ known for interrupt pin A of device 00:10.0 - using IRQ 255
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even 'a=
cpi=3Doff'
Initializing RT netlink socket
Enabling SEP on CPU 0
Journalled Block Device driver loaded
Initializing Cryptographic API
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PWRB]
ACPI: Fan [LRA0] (off)
ACPI: Processor [CPU0] (supports C1 C2 C3)
ACPI: Thermal Zone [ATF0] (52 C)
[...]
ACPI: (supports S0 S3 S4 S5)
Resume Machine: resuming from /dev/hda5
Resuming from device hda5
Resume Machine: This is normal swap space


--=20
Florian Lohoff                  flo-BCn6idZOOBwdnm+yROfE0A@public.gmane.org             +49-5201-669912
                        Heisenberg may have been here.

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+0zqlUaz2rXW+gJcRAmF7AJ9dLDPwH6iBnwEQkeXIyF3bMje/RwCaApS6
KfwdFVO8F+opoJkvYNa6AzU=
=eAyz
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
