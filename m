From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs-V2lp6ZUObelkZyP8+xg2CQ@public.gmane.org>
Subject: 2.4.23-pre4-acpi-20030916 on ASUS A7V 333 1014 Beta2
Date: Thu, 18 Sep 2003 20:58:18 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.OSF.4.51.0309182026530.456757@tao.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="20476355-1611458637-1063911498=:456757"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I
	got today to machine running 2.4.20 kernel and had to upgrade. It
	turneout there's ACPI problem in 2.4.22 with this machine ... Sep 18
	19:32:59 calomys kernel: ACPI-0202: *** Warning: Invalid tableSep 18
	19:32:59 calomys kernel: ACPI-0095: *** Error: Acpi_load_tables: Error
	getting required tables (DSDT/FADT/FACS): AE_BAD_SIGNATURE Sep 18
	19:32:59 calomys kernel: ACPI-0116: *** Error: Acpi_load_tables: Could
	not load tables: AE_BAD_SIGNATURE Sep 18 19:32:59 calomys kernel: ACPI:
	System description table load faile<€Linux version 2.4.23-pre4
	(root@calomys) (gcc version 3.3.1 20030626 (Debian prerelease)) #3 Thu
	Sep 18 20:05:55 CEST 2003 BIOS-provided physical RAM map: 127MB HIGHMEM
	available. 896MB LOWMEM available. ACPI: have wakeup address 0xc0001000
	On node 0 totalpages: 262140 zone(0): 4096 pages. zone(1): 225280
	pages. zone(2): 32764 pages. ACPI: RSDP (v000 ASUS ) @ 0x000f5c00 ACPI:
	RSDT (v001 ASUS A7V333 0x42302e31 MSFT 0x31313031) @ 0x3fffc000 ACPI:
	FADT (v001 ASUS A7V333 0x42302e31 MSFT 0x31313031) @ 0x3fffc0ae ACPI:
	TÀÿ? (v001 ASUS A7V333 0x42302e31 MSFT 0x31313031) @ 0x3fffsMœ-------^
	what are these 8bit chars? ACPI: DSDT (v001 ASUS A7V333 0x00001000 MSFT
	0x0100000b) @ 0x00000000 Kernel command line: auto
	BOOT_IMAGE=2423pre4acpi ro root=801 Found and enabled local APIC!
	Initializing CPU#0 Detected 1666.768 MHz processor. Console: colour
	VGA+ 80x25 Calibrating delay loop... 3322.67 BogoMIPS Memory:
	1033560k/1048560k available (1389k kernel code, 14612k reserved, 360k
	data, 292k init, 131056k highmem) Dentry cache hash table entries:
	131072 (order: 8, 1048576 bytes) Inode cache hash table entries: 65536
	(order: 7, 524288 bytes) Mount cache hash table entries: 512 (order: 0,
	4096 bytes) Buffer cache hash table [...] 
	Content analysis details:   (0.00 points, 5 required)
	USER_AGENT_PINE    (0.0 points)  Message-Id indicates a non-spam MUA (Pine)
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
X-BeenThere: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
X-Mailman-Version: 2.0.9-sf.net
Precedence: bulk
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Id: ACPI Development Discussion List <acpi-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
X-Original-Date: Thu, 18 Sep 2003 20:58:18 +0200 (CEST)
Xref: main.gmane.org gmane.linux.acpi.devel:4752

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime-oOUblnuQwHKola3qYQ6TW/IULO3mGbRi9nwVQlTi/Pw@public.gmane.org for more info.

--20476355-1611458637-1063911498=:456757
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by tao.natur.cuni.cz id h8IIwI1T003659

Hi,
  although I did not have reported any problems earlier, just accidentall=
y
I got today to machine running 2.4.20 kernel and had to upgrade. It turne=
d
out there's ACPI problem in 2.4.22 with this machine ...

  It used to show with ACPI:
Sep 18 19:32:59 calomys kernel:     ACPI-0202: *** Warning: Invalid table=
 signature T<C0><FF>? found
Sep 18 19:32:59 calomys kernel:     ACPI-0095: *** Error: Acpi_load_table=
s: Error getting required tables (DSDT/FADT/FACS): AE_BAD_SIGNATURE
Sep 18 19:32:59 calomys kernel:     ACPI-0116: *** Error: Acpi_load_table=
s: Could not load tables: AE_BAD_SIGNATURE
Sep 18 19:32:59 calomys kernel: ACPI: System description table load faile=
d


  Please note it is a desktop computer, no laptop.

  Here's what I have now when BIOS section Boot/Interrupt Mode is set to
PIC:

Linux version 2.4.23-pre4 (root@calomys) (gcc version 3.3.1 20030626 (Deb=
ian prerelease)) #3 Thu Sep 18 20:05:55 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fffc000 (usable)
 BIOS-e820: 000000003fffc000 - 000000003ffff000 (ACPI data)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 262140
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32764 pages.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f5c00
ACPI: RSDT (v001 ASUS   A7V333   0x42302e31 MSFT 0x31313031) @ 0x3fffc000
ACPI: FADT (v001 ASUS   A7V333   0x42302e31 MSFT 0x31313031) @ 0x3fffc0ae
ACPI: T=C0=FF? (v001 ASUS   A7V333   0x42302e31 MSFT 0x31313031) @ 0x3fff=
c02c

-------^ what are these 8bit chars?

ACPI: DSDT (v001   ASUS A7V333   0x00001000 MSFT 0x0100000b) @ 0x00000000
Kernel command line: auto BOOT_IMAGE=3D2423pre4acpi ro root=3D801
Found and enabled local APIC!
Initializing CPU#0
Detected 1666.768 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3322.67 BogoMIPS
Memory: 1033560k/1048560k available (1389k kernel code, 14612k reserved, =
360k data, 292k init, 131056k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(TM) XP 2000+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1666.7999 MHz.
..... host bus clock speed is 266.6878 MHz.
cpu: 0, clocks: 2666878, slice: 1333439
CPU0<T0:2666864,T1:1333424,D:1,S:1333439,C:2666878>
mtrr: v1.40 (20010327) Richard Gooch (rgooch-r1x6VkxMR+00zabcByZE4g@public.gmane.org)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030916
PCI: PCI BIOS revision 2.10 entry at 0xf17e0, last bus=3D1
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
PCI: Probing PCI hardware
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: No IRQ known for interrupt pin A of device 00:11.1

------------------------------------------------^
	this is also to be seen in BIOS APIC mode

ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even =
'acpi=3Doff'
PCI: Via IRQ fixup for 00:09.0, from 9 to 10
PCI: Via IRQ fixup for 00:11.3, from 9 to 10
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
Journalled Block Device driver loaded
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)



calomys:/# cat /proc/interrupts
           CPU0
  0:      46679          XT-PIC  timer
  1:          2          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:       3343          XT-PIC  eth0
  9:          0          XT-PIC  acpi
 11:      22524          XT-PIC  aic7xxx
 14:          4          XT-PIC  ide0
NMI:          0
LOC:      46641
ERR:          9
MIS:          0
calomys:/#


calomys:~# ls -laR /proc/acpi/
/proc/acpi/:
total 0
dr-xr-xr-x   10 root     root            0 Sep 18 20:35 .
dr-xr-xr-x   81 root     root            0 Sep 18  2003 ..
dr-xr-xr-x    2 root     root            0 Sep 18 20:35 ac_adapter
-rw-r--r--    1 root     root            0 Sep 18 20:35 alarm
dr-xr-xr-x    2 root     root            0 Sep 18 20:35 battery
dr-xr-xr-x    3 root     root            0 Sep 18 20:35 button
-r--------    1 root     root            0 Sep 18 20:35 dsdt
dr-xr-xr-x    2 root     root            0 Sep 18 20:35 embedded_controll=
er
-r--------    1 root     root            0 Sep 18 20:35 event
-r--------    1 root     root            0 Sep 18 20:35 fadt
dr-xr-xr-x    2 root     root            0 Sep 18 20:35 fan
-r--r--r--    1 root     root            0 Sep 18 20:35 info
dr-xr-xr-x    2 root     root            0 Sep 18 20:35 power_resource
dr-xr-xr-x    3 root     root            0 Sep 18 20:35 processor
-rw-r--r--    1 root     root            0 Sep 18 20:35 sleep
dr-xr-xr-x    2 root     root            0 Sep 18 20:35 thermal_zone

/proc/acpi/ac_adapter:
total 0
dr-xr-xr-x    2 root     root            0 Sep 18 20:35 .
dr-xr-xr-x   10 root     root            0 Sep 18 20:35 ..

/proc/acpi/battery:
total 0
dr-xr-xr-x    2 root     root            0 Sep 18 20:35 .
dr-xr-xr-x   10 root     root            0 Sep 18 20:35 ..

/proc/acpi/button:
total 0
dr-xr-xr-x    3 root     root            0 Sep 18 20:35 .
dr-xr-xr-x   10 root     root            0 Sep 18 20:35 ..
dr-xr-xr-x    3 root     root            0 Sep 18 20:35 power

/proc/acpi/button/power:
total 0
dr-xr-xr-x    3 root     root            0 Sep 18 20:35 .
dr-xr-xr-x    3 root     root            0 Sep 18 20:35 ..
dr-xr-xr-x    2 root     root            0 Sep 18 20:35 PWRF

/proc/acpi/button/power/PWRF:
total 0
dr-xr-xr-x    2 root     root            0 Sep 18 20:35 .
dr-xr-xr-x    3 root     root            0 Sep 18 20:35 ..
-r--r--r--    1 root     root            0 Sep 18 20:35 info

/proc/acpi/embedded_controller:
total 0
dr-xr-xr-x    2 root     root            0 Sep 18 20:35 .
dr-xr-xr-x   10 root     root            0 Sep 18 20:35 ..

/proc/acpi/fan:
total 0
dr-xr-xr-x    2 root     root            0 Sep 18 20:35 .
dr-xr-xr-x   10 root     root            0 Sep 18 20:35 ..

/proc/acpi/power_resource:
total 0
dr-xr-xr-x    2 root     root            0 Sep 18 20:35 .
dr-xr-xr-x   10 root     root            0 Sep 18 20:35 ..

/proc/acpi/processor:
total 0
dr-xr-xr-x    3 root     root            0 Sep 18 20:35 .
dr-xr-xr-x   10 root     root            0 Sep 18 20:35 ..
dr-xr-xr-x    2 root     root            0 Sep 18 20:35 CPU0

/proc/acpi/processor/CPU0:
total 0
dr-xr-xr-x    2 root     root            0 Sep 18 20:35 .
dr-xr-xr-x    3 root     root            0 Sep 18 20:35 ..
-r--r--r--    1 root     root            0 Sep 18 20:35 info
-rw-r--r--    1 root     root            0 Sep 18 20:35 limit
-rw-r--r--    1 root     root            0 Sep 18 20:35 performance
-r--r--r--    1 root     root            0 Sep 18 20:35 power
-rw-r--r--    1 root     root            0 Sep 18 20:35 throttling

/proc/acpi/thermal_zone:
total 0
dr-xr-xr-x    2 root     root            0 Sep 18 20:35 .
dr-xr-xr-x   10 root     root            0 Sep 18 20:35 ..
calomys:~#
calomys:~# cat /proc/acpi/processor/CPU0/throttling
<not supported>
calomys:~# cat /proc/acpi/processor/CPU0/performance
<not supported>
calomys:~# cat /proc/acpi/processor/CPU0/info
processor id:            0
acpi id:                 0
bus mastering control:   no
power management:        no
throttling control:      no
performance management:  no
limit interface:         no
calomys:~# cat /proc/acpi/processor/CPU0/limit
<not supported>
calomys:~# cat /proc/acpi/processor/CPU0/power
active state:            C1
default state:           C1
bus master activity:     00000000
states:
   *C1:                  promotion[--] demotion[--] latency[000] usage[00=
000000]
    C2:                  <not supported>
    C3:                  <not supported>
calomys:~#



If BIOS has set Boot/Interrupt Mode to APIC, I get ... see attached file
a7v333.diff for easy comaprison of both modes. Also, lspci output when
machine in this APIC mode is attached. Interrupts are below:

calomys:~# cat /proc/interrupts
           CPU0
  0:      14317    IO-APIC-edge  timer
  1:          2    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  9:          0   IO-APIC-level  acpi
 14:          5    IO-APIC-edge  ide0
 16:        952   IO-APIC-level  eth0
 18:      22137   IO-APIC-level  aic7xxx
NMI:          0
LOC:      14269
ERR:          0
MIS:          0
calomys:~#



I hope this tells you if everything looks like expected on my machine in =
terms of ACPI.

Thanks for developing/supporting ACPI!
--=20
Martin Mokrejs <mmokrejs-V2lp6ZUObelkZyP8+xg2CQ@public.gmane.org>, <m.mokrejs@gsf.de>
PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany
tel.: +49-89-3187 3683 , fax:=A0+49-89-3187 3585
--20476355-1611458637-1063911498=:456757
Content-Type: TEXT/PLAIN; charset=iso-8859-2; name="a7v333.diff"
Content-ID: <Pine.OSF.4.51.0309182058180.456757-xveqDVFKMsx2wEp5G055aaVXKuFTiq87@public.gmane.org>
Content-Description: 
Content-Disposition: attachment; filename="a7v333.diff"
Content-Transfer-Encoding: BASE64

LS0tIFBJQyAyMDAzLTA5LTE4IDIwOjI1OjUxLjAwMDAwMDAwMCArMDIwMA0K
KysrIEFQSUMgICAgICAgIDIwMDMtMDktMTggMjA6NDY6NTEuMDAwMDAwMDAw
ICswMjAwDQpAQCAtMTgsMTYgKzE4LDI2IEBADQogem9uZSgyKTogMzI3NjQg
cGFnZXMuDQogQUNQSTogUlNEUCAodjAwMCBBU1VTICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICApIEAgMHgwMDBmNWMwMA0KIEFDUEk6
IFJTRFQgKHYwMDEgQVNVUyAgIEE3VjMzMyAgIDB4NDIzMDJlMzEgTVNGVCAw
eDMxMzEzMDMxKSBAIDB4M2ZmZmMwMDANCi1BQ1BJOiBGQURUICh2MDAxIEFT
VVMgICBBN1YzMzMgICAweDQyMzAyZTMxIE1TRlQgMHgzMTMxMzAzMSkgQCAw
eDNmZmZjMGFlDQotQUNQSTogVMD/PyAodjAwMSBBU1VTICAgQTdWMzMzICAg
MHg0MjMwMmUzMSBNU0ZUIDB4MzEzMTMwMzEpIEAgMHgzZmZmYzAyYw0KK0FD
UEk6IEZBRFQgKHYwMDEgQVNVUyAgIEE3VjMzMyAgIDB4NDIzMDJlMzEgTVNG
VCAweDMxMzEzMDMxKSBAIDB4M2ZmZmMwYjINCitBQ1BJOiBCT09UICh2MDAx
IEFTVVMgICBBN1YzMzMgICAweDQyMzAyZTMxIE1TRlQgMHgzMTMxMzAzMSkg
QCAweDNmZmZjMDMwDQorQUNQSTogTUFEVCAodjAwMSBBU1VTICAgQTdWMzMz
ICAgMHg0MjMwMmUzMSBNU0ZUIDB4MzEzMTMwMzEpIEAgMHgzZmZmYzA1OA0K
IEFDUEk6IERTRFQgKHYwMDEgICBBU1VTIEE3VjMzMyAgIDB4MDAwMDEwMDAg
TVNGVCAweDAxMDAwMDBiKSBAIDB4MDAwMDAwMDANCitBQ1BJOiBMb2NhbCBB
UElDIGFkZHJlc3MgMHhmZWUwMDAwMA0KK0FDUEk6IExBUElDIChhY3BpX2lk
WzB4MDBdIGxhcGljX2lkWzB4MDBdIGVuYWJsZWQpDQorUHJvY2Vzc29yICMw
IFBlbnRpdW0odG0pIFBybyBBUElDIHZlcnNpb24gMTYNCitBQ1BJOiBMQVBJ
Q19OTUkgKGFjcGlfaWRbMHgwMF0gcG9sYXJpdHlbMHgxXSB0cmlnZ2VyWzB4
MV0gbGludFsweDFdKQ0KK0FDUEk6IElPQVBJQyAoaWRbMHgwMl0gYWRkcmVz
c1sweGZlYzAwMDAwXSBnbG9iYWxfaXJxX2Jhc2VbMHgwXSkNCitJT0FQSUNb
MF06IEFzc2lnbmVkIGFwaWNfaWQgMg0KK0lPQVBJQ1swXTogYXBpY19pZCAy
LCB2ZXJzaW9uIDIsIGFkZHJlc3MgMHhmZWMwMDAwMCwgSVJRIDAtMjMNCitB
Q1BJOiBJTlRfU1JDX09WUiAoYnVzWzBdIGlycVsweDBdIGdsb2JhbF9pcnFb
MHgyXSBwb2xhcml0eVsweDBdIHRyaWdnZXJbMHgxXSkNCitBQ1BJOiBJTlRf
U1JDX09WUiAoYnVzWzBdIGlycVsweDldIGdsb2JhbF9pcnFbMHg5XSBwb2xh
cml0eVsweDNdIHRyaWdnZXJbMHgzXSkNCitVc2luZyBBQ1BJIChNQURUKSBm
b3IgU01QIGNvbmZpZ3VyYXRpb24gaW5mb3JtYXRpb24NCiBLZXJuZWwgY29t
bWFuZCBsaW5lOiBhdXRvIEJPT1RfSU1BR0U9MjQyM3ByZTRhY3BpIHJvIHJv
b3Q9ODAxDQotRm91bmQgYW5kIGVuYWJsZWQgbG9jYWwgQVBJQyENCiBJbml0
aWFsaXppbmcgQ1BVIzANCiBEZXRlY3RlZCAxNjY2Ljc2OCBNSHogcHJvY2Vz
c29yLg0KIENvbnNvbGU6IGNvbG91ciBWR0ErIDgweDI1DQogQ2FsaWJyYXRp
bmcgZGVsYXkgbG9vcC4uLiAzMzIyLjY3IEJvZ29NSVBTDQotTWVtb3J5OiAx
MDMzNTYway8xMDQ4NTYwayBhdmFpbGFibGUgKDEzODlrIGtlcm5lbCBjb2Rl
LCAxNDYxMmsgcmVzZXJ2ZWQsIDM2MGsgZGF0YSwgMjkyayBpbml0LCAxMzEw
NTZrIGhpZ2htZW0pDQorTWVtb3J5OiAxMDMzNTU2ay8xMDQ4NTYwayBhdmFp
bGFibGUgKDEzODlrIGtlcm5lbCBjb2RlLCAxNDYxNmsgcmVzZXJ2ZWQsIDM2
MGsgZGF0YSwgMjkyayBpbml0LCAxMzEwNTZrIGhpZ2htZW0pDQogRGVudHJ5
IGNhY2hlIGhhc2ggdGFibGUgZW50cmllczogMTMxMDcyIChvcmRlcjogOCwg
MTA0ODU3NiBieXRlcykNCiBJbm9kZSBjYWNoZSBoYXNoIHRhYmxlIGVudHJp
ZXM6IDY1NTM2IChvcmRlcjogNywgNTI0Mjg4IGJ5dGVzKQ0KIE1vdW50IGNh
Y2hlIGhhc2ggdGFibGUgZW50cmllczogNTEyIChvcmRlcjogMCwgNDA5NiBi
eXRlcykNCkBAIC00NywxOSArNTcsODAgQEANCiBlbmFibGVkIEV4dElOVCBv
biBDUFUjMA0KIEVTUiB2YWx1ZSBiZWZvcmUgZW5hYmxpbmcgdmVjdG9yOiAw
MDAwMDAwMA0KIEVTUiB2YWx1ZSBhZnRlciBlbmFibGluZyB2ZWN0b3I6IDAw
MDAwMDAwDQorRU5BQkxJTkcgSU8tQVBJQyBJUlFzDQoraW5pdCBJT19BUElD
IElSUXMNCisgSU8tQVBJQyAoYXBpY2lkLXBpbikgMi0wLCAyLTE2LCAyLTE3
LCAyLTE4LCAyLTE5LCAyLTIwLCAyLTIxLCAyLTIyLCAyLTIzIG5vdCBjb25u
ZWN0ZWQuDQorLi5USU1FUjogdmVjdG9yPTB4MzEgcGluMT0yIHBpbjI9MA0K
K251bWJlciBvZiBNUCBJUlEgc291cmNlczogMTYuDQorbnVtYmVyIG9mIElP
LUFQSUMgIzIgcmVnaXN0ZXJzOiAyNC4NCit0ZXN0aW5nIHRoZSBJTyBBUElD
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4NCisNCitJTyBBUElDICMyLi4uLi4u
DQorLi4uLiByZWdpc3RlciAjMDA6IDAyMDAwMDAwDQorLi4uLi4uLiAgICA6
IHBoeXNpY2FsIEFQSUMgaWQ6IDAyDQorLi4uLi4uLiAgICA6IERlbGl2ZXJ5
IFR5cGU6IDANCisuLi4uLi4uICAgIDogTFRTICAgICAgICAgIDogMA0KKy4u
Li4gcmVnaXN0ZXIgIzAxOiAwMDE3ODAwMg0KKy4uLi4uLi4gICAgIDogbWF4
IHJlZGlyZWN0aW9uIGVudHJpZXM6IDAwMTcNCisuLi4uLi4uICAgICA6IFBS
USBpbXBsZW1lbnRlZDogMQ0KKy4uLi4uLi4gICAgIDogSU8gQVBJQyB2ZXJz
aW9uOiAwMDAyDQorLi4uLiBJUlEgcmVkaXJlY3Rpb24gdGFibGU6DQorIE5S
IExvZyBQaHkgTWFzayBUcmlnIElSUiBQb2wgU3RhdCBEZXN0IERlbGkgVmVj
dDogICANCisgMDAgMDAwIDAwICAxICAgIDAgICAgMCAgIDAgICAwICAgIDAg
ICAgMCAgICAwMA0KKyAwMSAwMDEgMDEgIDAgICAgMCAgICAwICAgMCAgIDAg
ICAgMSAgICAxICAgIDM5DQorIDAyIDAwMSAwMSAgMCAgICAwICAgIDAgICAw
ICAgMCAgICAxICAgIDEgICAgMzENCisgMDMgMDAxIDAxICAwICAgIDAgICAg
MCAgIDAgICAwICAgIDEgICAgMSAgICA0MQ0KKyAwNCAwMDEgMDEgIDAgICAg
MCAgICAwICAgMCAgIDAgICAgMSAgICAxICAgIDQ5DQorIDA1IDAwMSAwMSAg
MCAgICAwICAgIDAgICAwICAgMCAgICAxICAgIDEgICAgNTENCisgMDYgMDAx
IDAxICAwICAgIDAgICAgMCAgIDAgICAwICAgIDEgICAgMSAgICA1OQ0KKyAw
NyAwMDEgMDEgIDAgICAgMCAgICAwICAgMCAgIDAgICAgMSAgICAxICAgIDYx
DQorIDA4IDAwMSAwMSAgMCAgICAwICAgIDAgICAwICAgMCAgICAxICAgIDEg
ICAgNjkNCisgMDkgMDAxIDAxICAxICAgIDEgICAgMCAgIDEgICAwICAgIDEg
ICAgMSAgICA3MQ0KKyAwYSAwMDEgMDEgIDAgICAgMCAgICAwICAgMCAgIDAg
ICAgMSAgICAxICAgIDc5DQorIDBiIDAwMSAwMSAgMCAgICAwICAgIDAgICAw
ICAgMCAgICAxICAgIDEgICAgODENCisgMGMgMDAxIDAxICAwICAgIDAgICAg
MCAgIDAgICAwICAgIDEgICAgMSAgICA4OQ0KKyAwZCAwMDEgMDEgIDAgICAg
MCAgICAwICAgMCAgIDAgICAgMSAgICAxICAgIDkxDQorIDBlIDAwMSAwMSAg
MCAgICAwICAgIDAgICAwICAgMCAgICAxICAgIDEgICAgOTkNCisgMGYgMDAx
IDAxICAwICAgIDAgICAgMCAgIDAgICAwICAgIDEgICAgMSAgICBBMQ0KKyAx
MCAwMDAgMDAgIDEgICAgMCAgICAwICAgMCAgIDAgICAgMCAgICAwICAgIDAw
DQorIDExIDAwMCAwMCAgMSAgICAwICAgIDAgICAwICAgMCAgICAwICAgIDAg
ICAgMDANCisgMTIgMDAwIDAwICAxICAgIDAgICAgMCAgIDAgICAwICAgIDAg
ICAgMCAgICAwMA0KKyAxMyAwMDAgMDAgIDEgICAgMCAgICAwICAgMCAgIDAg
ICAgMCAgICAwICAgIDAwDQorIDE0IDAwMCAwMCAgMSAgICAwICAgIDAgICAw
ICAgMCAgICAwICAgIDAgICAgMDANCisgMTUgMDAwIDAwICAxICAgIDAgICAg
MCAgIDAgICAwICAgIDAgICAgMCAgICAwMA0KKyAxNiAwMDAgMDAgIDEgICAg
MCAgICAwICAgMCAgIDAgICAgMCAgICAwICAgIDAwDQorIDE3IDAwMCAwMCAg
MSAgICAwICAgIDAgICAwICAgMCAgICAwICAgIDAgICAgMDANCitJUlEgdG8g
cGluIG1hcHBpbmdzOg0KK0lSUTAgLT4gMDoyDQorSVJRMSAtPiAwOjENCitJ
UlEzIC0+IDA6Mw0KK0lSUTQgLT4gMDo0DQorSVJRNSAtPiAwOjUNCitJUlE2
IC0+IDA6Ng0KK0lSUTcgLT4gMDo3DQorSVJROCAtPiAwOjgNCitJUlE5IC0+
IDA6OQ0KK0lSUTEwIC0+IDA6MTANCitJUlExMSAtPiAwOjExDQorSVJRMTIg
LT4gMDoxMg0KK0lSUTEzIC0+IDA6MTMNCitJUlExNCAtPiAwOjE0DQorSVJR
MTUgLT4gMDoxNQ0KKy4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLiBkb25lLg0KIFVzaW5nIGxvY2FsIEFQSUMgdGltZXIgaW50ZXJydXB0
cy4NCiBjYWxpYnJhdGluZyBBUElDIHRpbWVyIC4uLg0KLS4uLi4uIENQVSBj
bG9jayBzcGVlZCBpcyAxNjY2Ljc5OTkgTUh6Lg0KLS4uLi4uIGhvc3QgYnVz
IGNsb2NrIHNwZWVkIGlzIDI2Ni42ODc4IE1Iei4NCi1jcHU6IDAsIGNsb2Nr
czogMjY2Njg3OCwgc2xpY2U6IDEzMzM0MzkNCi1DUFUwPFQwOjI2NjY4NjQs
VDE6MTMzMzQyNCxEOjEsUzoxMzMzNDM5LEM6MjY2Njg3OD4NCisuLi4uLiBD
UFUgY2xvY2sgc3BlZWQgaXMgMTY2Ni44MTU5IE1Iei4NCisuLi4uLiBob3N0
IGJ1cyBjbG9jayBzcGVlZCBpcyAyNjYuNjkwNSBNSHouDQorY3B1OiAwLCBj
bG9ja3M6IDI2NjY5MDUsIHNsaWNlOiAxMzMzNDUyDQorQ1BVMDxUMDoyNjY2
ODk2LFQxOjEzMzM0NDAsRDo0LFM6MTMzMzQ1MixDOjI2NjY5MDU+DQogbXRy
cjogdjEuNDAgKDIwMDEwMzI3KSBSaWNoYXJkIEdvb2NoIChyZ29vY2hAYXRu
Zi5jc2lyby5hdSkNCiBtdHJyOiBkZXRlY3RlZCBtdHJyIHR5cGU6IEludGVs
DQogQUNQSTogU3Vic3lzdGVtIHJldmlzaW9uIDIwMDMwOTE2DQogUENJOiBQ
Q0kgQklPUyByZXZpc2lvbiAyLjEwIGVudHJ5IGF0IDB4ZjE3ZTAsIGxhc3Qg
YnVzPTENCiBQQ0k6IFVzaW5nIGNvbmZpZ3VyYXRpb24gdHlwZSAxDQorSU9B
UElDWzBdOiBTZXQgUENJIHJvdXRpbmcgZW50cnkgKDItOSAtPiAweDcxIC0+
IElSUSA5IE1vZGU6MSBBY3RpdmU6MSkNCiBBQ1BJOiBJbnRlcnByZXRlciBl
bmFibGVkDQotQUNQSTogVXNpbmcgUElDIGZvciBpbnRlcnJ1cHQgcm91dGlu
Zw0KK0FDUEk6IFVzaW5nIElPQVBJQyBmb3IgaW50ZXJydXB0IHJvdXRpbmcN
CiBBQ1BJOiBTeXN0ZW0gW0FDUEldIChzdXBwb3J0cyBTMCBTMSBTNCBTNSkN
CiBBQ1BJOiBQQ0kgSW50ZXJydXB0IExpbmsgW0xOS0FdIChJUlFzIDMgNCAq
NSA2IDcgMTAgMTEgMTIgMTQgMTUpDQogQUNQSTogUENJIEludGVycnVwdCBM
aW5rIFtMTktCXSAoSVJRcyAqMyA0IDUgNiA3IDEwIDExIDEyIDE0IDE1KQ0K
QEAgLTcxLDE2ICsxNDIsNDggQEANCiBBQ1BJOiBQQ0kgSW50ZXJydXB0IFJv
dXRpbmcgVGFibGUgW1xfU0JfLlBDSTAuX1BSVF0NCiBBQ1BJOiBQQ0kgSW50
ZXJydXB0IFJvdXRpbmcgVGFibGUgW1xfU0JfLlBDSTAuUENJMS5fUFJUXQ0K
IFBDSTogUHJvYmluZyBQQ0kgaGFyZHdhcmUNCi1BQ1BJOiBQQ0kgSW50ZXJy
dXB0IExpbmsgW0xOS0JdIGVuYWJsZWQgYXQgSVJRIDExDQotQUNQSTogUENJ
IEludGVycnVwdCBMaW5rIFtMTktEXSBlbmFibGVkIGF0IElSUSAxMA0KLUFD
UEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbTE5LQV0gZW5hYmxlZCBhdCBJUlEg
NQ0KLUFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbTE5LQ10gZW5hYmxlZCBh
dCBJUlEgMTENCitJT0FQSUNbMF06IFNldCBQQ0kgcm91dGluZyBlbnRyeSAo
Mi0xNyAtPiAweGE5IC0+IElSUSAxNyBNb2RlOjEgQWN0aXZlOjEpDQorMDA6
MDA6MDVbQV0gLT4gMi0xNyAtPiBJUlEgMTcNCitJT0FQSUNbMF06IFNldCBQ
Q0kgcm91dGluZyBlbnRyeSAoMi0xOCAtPiAweGIxIC0+IElSUSAxOCBNb2Rl
OjEgQWN0aXZlOjEpDQorMDA6MDA6MDVbQl0gLT4gMi0xOCAtPiBJUlEgMTgN
CitJT0FQSUNbMF06IFNldCBQQ0kgcm91dGluZyBlbnRyeSAoMi0xOSAtPiAw
eGI5IC0+IElSUSAxOSBNb2RlOjEgQWN0aXZlOjEpDQorMDA6MDA6MDZbQV0g
LT4gMi0xOSAtPiBJUlEgMTkNCitQaW4gMi0xNyBhbHJlYWR5IHByb2dyYW1t
ZWQNCitQaW4gMi0xOSBhbHJlYWR5IHByb2dyYW1tZWQNCitJT0FQSUNbMF06
IFNldCBQQ0kgcm91dGluZyBlbnRyeSAoMi0xNiAtPiAweGMxIC0+IElSUSAx
NiBNb2RlOjEgQWN0aXZlOjEpDQorMDA6MDA6MGNbQl0gLT4gMi0xNiAtPiBJ
UlEgMTYNCitQaW4gMi0xNyBhbHJlYWR5IHByb2dyYW1tZWQNCitQaW4gMi0x
OCBhbHJlYWR5IHByb2dyYW1tZWQNCitQaW4gMi0xNiBhbHJlYWR5IHByb2dy
YW1tZWQNCitQaW4gMi0xNyBhbHJlYWR5IHByb2dyYW1tZWQNCitQaW4gMi0x
OCBhbHJlYWR5IHByb2dyYW1tZWQNCitQaW4gMi0xOSBhbHJlYWR5IHByb2dy
YW1tZWQNCitQaW4gMi0xNyBhbHJlYWR5IHByb2dyYW1tZWQNCitQaW4gMi0x
OCBhbHJlYWR5IHByb2dyYW1tZWQNCitQaW4gMi0xOSBhbHJlYWR5IHByb2dy
YW1tZWQNCitQaW4gMi0xNiBhbHJlYWR5IHByb2dyYW1tZWQNCitQaW4gMi0x
OCBhbHJlYWR5IHByb2dyYW1tZWQNCitQaW4gMi0xOSBhbHJlYWR5IHByb2dy
YW1tZWQNCitQaW4gMi0xNiBhbHJlYWR5IHByb2dyYW1tZWQNCitQaW4gMi0x
NyBhbHJlYWR5IHByb2dyYW1tZWQNCitQaW4gMi0xOSBhbHJlYWR5IHByb2dy
YW1tZWQNCitQaW4gMi0xNiBhbHJlYWR5IHByb2dyYW1tZWQNCitQaW4gMi0x
NyBhbHJlYWR5IHByb2dyYW1tZWQNCitQaW4gMi0xOCBhbHJlYWR5IHByb2dy
YW1tZWQNCitJT0FQSUNbMF06IFNldCBQQ0kgcm91dGluZyBlbnRyeSAoMi0y
MSAtPiAweGM5IC0+IElSUSAyMSBNb2RlOjEgQWN0aXZlOjEpDQorMDA6MDA6
MTFbRF0gLT4gMi0yMSAtPiBJUlEgMjENCitQaW4gMi0xOSBhbHJlYWR5IHBy
b2dyYW1tZWQNCitQaW4gMi0xNiBhbHJlYWR5IHByb2dyYW1tZWQNCitQaW4g
Mi0xNyBhbHJlYWR5IHByb2dyYW1tZWQNCitQaW4gMi0xNiBhbHJlYWR5IHBy
b2dyYW1tZWQNCitQaW4gMi0xNyBhbHJlYWR5IHByb2dyYW1tZWQNCiBQQ0k6
IE5vIElSUSBrbm93biBmb3IgaW50ZXJydXB0IHBpbiBBIG9mIGRldmljZSAw
MDoxMS4xDQotQUNQSTogUENJIEludGVycnVwdCBMaW5rIFtMTktFXSBlbmFi
bGVkIGF0IElSUSAxMA0KIFBDSTogVXNpbmcgQUNQSSBmb3IgSVJRIHJvdXRp
bmcNCiBQQ0k6IGlmIHlvdSBleHBlcmllbmNlIHByb2JsZW1zLCB0cnkgdXNp
bmcgb3B0aW9uICdwY2k9bm9hY3BpJyBvciBldmVuICdhY3BpPW9mZicNCi1Q
Q0k6IFZpYSBJUlEgZml4dXAgZm9yIDAwOjA5LjAsIGZyb20gOSB0byAxMA0K
LVBDSTogVmlhIElSUSBmaXh1cCBmb3IgMDA6MTEuMywgZnJvbSA5IHRvIDEw
DQorUENJOiBWaWEgSVJRIGZpeHVwIGZvciAwMDowOS4wLCBmcm9tIDkgdG8g
Mw0KK1BDSTogVmlhIElSUSBmaXh1cCBmb3IgMDA6MDkuMSwgZnJvbSA1IHRv
IDANCitQQ0k6IFZpYSBJUlEgZml4dXAgZm9yIDAwOjExLjIsIGZyb20gOSB0
byA1DQorUENJOiBWaWEgSVJRIGZpeHVwIGZvciAwMDoxMS4zLCBmcm9tIDkg
dG8gNQ0KIGlzYXBucDogU2Nhbm5pbmcgZm9yIFBuUCBjYXJkcy4uLg0KIGlz
YXBucDogTm8gUGx1ZyAmIFBsYXkgZGV2aWNlIGZvdW5kDQogTGludXggTkVU
NC4wIGZvciBMaW51eCAyLjQNCkBAIC05OSw3ICsyMDIsNyBAQA0KIEZEQyAw
IGlzIGEgcG9zdC0xOTkxIDgyMDc3DQogZWVwcm8xMDAuYzp2MS4wOWotdCA5
LzI5Lzk5IERvbmFsZCBCZWNrZXIgaHR0cDovL3d3dy5zY3lsZC5jb20vbmV0
d29yay9lZXBybzEwMC5odG1sDQogZWVwcm8xMDAuYzogJFJldmlzaW9uOiAx
LjM2ICQgMjAwMC8xMS8xNyBNb2RpZmllZCBieSBBbmRyZXkgVi4gU2F2b2No
a2luIDxzYXdAc2F3LnN3LmNvbS5zZz4gYW5kIG90aGVycw0KLWV0aDA6IElu
dGVsIENvcnAuIDgyNTU3LzgvOSBbRXRoZXJuZXQgUHJvIDEwMF0sIDAwOjAy
OkIzOkI4OjNCOjBBLCBJUlEgNS4NCitldGgwOiBJbnRlbCBDb3JwLiA4MjU1
Ny84LzkgW0V0aGVybmV0IFBybyAxMDBdLCAwMDowMjpCMzpCODozQjowQSwg
SVJRIDE2Lg0KICAgQm9hcmQgYXNzZW1ibHkgNzUxNzY3LTAwNCwgUGh5c2lj
YWwgY29ubmVjdG9ycyBwcmVzZW50OiBSSjQ1DQogICBQcmltYXJ5IGludGVy
ZmFjZSBjaGlwIGk4MjU1NSBQSFkgIzEuDQogICAgIFNlY29uZGFyeSBpbnRl
cmZhY2UgY2hpcCBpODI1NTUuDQpAQCAtMTU1LDggKzI1OCw3IEBADQoga2pv
dXJuYWxkIHN0YXJ0aW5nLiAgQ29tbWl0IGludGVydmFsIDUgc2Vjb25kcw0K
IEVYVDMgRlMgMi40LTAuOS4xOSwgMTkgQXVndXN0IDIwMDIgb24gc2QoOCw2
KSwgaW50ZXJuYWwgam91cm5hbA0KIEVYVDMtZnM6IG1vdW50ZWQgZmlsZXN5
c3RlbSB3aXRoIG9yZGVyZWQgZGF0YSBtb2RlLg0KLXNwdXJpb3VzIDgyNTlB
IGludGVycnVwdDogSVJRNy4NCiB0dHlTMTogTFNSIHNhZmV0eSBjaGVjayBl
bmdhZ2VkIQ0KIHR0eVMxOiBMU1Igc2FmZXR5IGNoZWNrIGVuZ2FnZWQhDQog
dHR5UzE6IExTUiBzYWZldHkgY2hlY2sgZW5nYWdlZCENCi1TdGFydGluZyBB
RlMgY2FjaGUgc2Nhbi4uLmZvdW5kIDY1NTUgbm9uLWVtcHR5IGNhY2hlIGZp
bGVzICg2JSkuDQorU3RhcnRpbmcgQUZTIGNhY2hlIHNjYW4uLi5mb3VuZCA2
NTU2IG5vbi1lbXB0eSBjYWNoZSBmaWxlcyAoNiUpLg0KDQo=

--20476355-1611458637-1063911498=:456757--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
