From: Pedro Venda <pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Subject: "Unlink after no-IRQ?" problem: unable to use USB printer
Date: Thu, 27 Jan 2005 18:27:49 +0000
Message-ID: <41F932A5.7000306@arrakis.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: linux-usb-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi everyone,

I'm trying to share an USB printer for my home network. The main and only=
 server
is an old dual pIII with an ASUS CUR-DLS, which fortunately features USB =
ports
but which unfortunately don't seem to work.

modprobing usblp hangs forever without crashing the machine. the error me=
ssage
suggests fiddling with ACPI but the same happens if I disable ACPI comple=
tely,
so I supposed this could be an USB problem. Nevertheless, this goes also =
to the
acpi-devel mailing list.

kernel is 2.6.10-grsec.

is my hardware broken? I know it's old, but it's supposed to support the =
ohci
driver, so... it can't be THAT old as far as USB is concerned...

any help/tips would be very appreciated.

my lspci follows and then some kernel messages:
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
gw linux # lspci
0000:00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
0000:00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
0000:00:02.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100=
] (rev 08)
0000:00:05.0 Ethernet controller: Digital Equipment Corporation DECchip 2=
1142/43
(rev 41)
0000:00:07.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev=
 65)
0000:00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 4f)
0000:00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
0000:00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (r=
ev 04)
0000:01:02.0 RAID bus controller: Triones Technologies, Inc. HPT372A (rev=
 01)
0000:01:04.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
0000:01:05.0 SCSI storage controller: LSI Logic / Symbios Logic 53c896 (r=
ev 07)
0000:01:05.1 SCSI storage controller: LSI Logic / Symbios Logic 53c896 (r=
ev 07)
gw linux #
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++




here's a snip of the kernel messages with usb-debug enabled (I've pointed=
 the
error message. it's at the bottom):
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
usbcore: registered new driver usbfs
usbcore: registered new driver hub
grsec: mount none to /proc/bus/usb by /bin/mount[mount:5427] uid/euid:0/0=
 gid/eg
id:0/0, parent /sbin/rc[rc:28494] uid/euid:0/0 gid/egid:0/0
grsec: time set by /sbin/hwclock[hwclock:3270] uid/euid:0/0 gid/egid:0/0,=
 parent
~ /sbin/rc[rc:12909] uid/euid:0/0 gid/egid:0/0
piix4_smbus 0000:00:0f.0: Found 0000:00:0f.0 device
piix4_smbus 0000:00:0f.0: Unusual config register value
piix4_smbus 0000:00:0f.0: Try using fix_hstcfg=3D1 if you experience prob=
lems
piix4_smbus 0000:00:0f.0: Illegal Interrupt configuration (or code out of=
 date)!
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:0f.2: ServerWorks OSB4/CSB5 OHCI USB Controller
ohci_hcd 0000:00:0f.2: irq 30, pci mem 0xfb000000
ohci_hcd 0000:00:0f.2: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:0f.2: resetting from state 'reset', control =3D 0x0
ohci_hcd 0000:00:0f.2: OHCI controller state
ohci_hcd 0000:00:0f.2: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:0f.2: control 0x083 HCFS=3Doperational CBSR=3D3
ohci_hcd 0000:00:0f.2: cmdstatus 0x00000 SOC=3D0
ohci_hcd 0000:00:0f.2: intrstatus 0x00000044 RHSC SF
ohci_hcd 0000:00:0f.2: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:0f.2: hcca frame #0003
ohci_hcd 0000:00:0f.2: roothub.a 01000204 POTPGT=3D1 NPS NDP=3D4
ohci_hcd 0000:00:0f.2: roothub.b 00000000 PPCM=3D0000 DR=3D0000
ohci_hcd 0000:00:0f.2: roothub.status 00008000 DRWE
ohci_hcd 0000:00:0f.2: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:0f.2: roothub.portstatus [1] 0x00010101 CSC PPS CCS
ohci_hcd 0000:00:0f.2: roothub.portstatus [2] 0x00000100 PPS
ohci_hcd 0000:00:0f.2: roothub.portstatus [3] 0x00000100 PPS
usb usb1: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb1: default language 0x0409
usb usb1: Product: ServerWorks OSB4/CSB5 OHCI USB Controller
usb usb1: Manufacturer: Linux 2.6.10-grsec-5 ohci_hcd
usb usb1: SerialNumber: 0000:00:0f.2
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
ohci_hcd 0000:00:0f.2: created debug files
hub 1-0:1.0: state 5 ports 4 chg ffff evt ffff
hub 1-0:1.0: port 1, status 0100, change 0000, 12 Mb/s
ohci_hcd 0000:00:0f.2: GetStatus roothub.portstatus [1] =3D 0x00010101 CS=
C PPS CCS
hub 1-0:1.0: port 2, status 0101, change 0001, 12 Mb/s
hub 1-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x101
ohci_hcd 0000:00:0f.2: GetStatus roothub.portstatus [1] =3D 0x00100103 PR=
SC PPS PE
S CCS
usb 1-2: new full speed USB device using ohci_hcd and address 2

=3D=3D> ohci_hcd 0000:00:0f.2: Unlink after no-IRQ?  Different ACPI or AP=
IC settings
may help.

Disabled Privacy Extensions on device c03d1f40(lo)
grsec: time set by /usr/bin/ntpdate[ntpdate:26203] uid/euid:0/0 gid/egid:=
0/0, pa
rent /sbin/rc[rc:4882] uid/euid:0/0 gid/egid:0/0
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++

regards,
pedro venda.
- --

Pedro Jo=E3o Lopes Venda
email: pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org
http://arrakis.dhis.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB+TKleRy7HWZxjWERAnDJAKCPsquNmX/Zum5912NsJoXInsodlgCg3UzT
FDBbN6D8DP6Gs+8/6P7IjSI=3D
=3DPwxw
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
