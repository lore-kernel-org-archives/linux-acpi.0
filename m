From: Cory Bell <cory.bell-Jdbf3xiKgS8@public.gmane.org>
Subject: Instant Reboot w/ACPI, 2.5.59, Dell Precision Workstation 340
Date: 24 Jan 2003 07:47:27 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1043423247.4412.34.camel@homer.oit.pdx.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fm49K2tziamd40WZhXqi"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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


--=-fm49K2tziamd40WZhXqi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I get the grub screen, press enter, then blank (don't see the "loading
kernel" stuff), then the Dell BIOS boot screen. I am using the latest
BIOS available from Dell (A06)

acpi=3Doff "solves" the problem. pci=3Dnoacpi has no effect. no modules,
everything is static (too many module problems in 2.5). Interestingly
enough, I have the same problem in 2.4 w/recent (>=3D June 2002 - when I
got the machine) ACPI from sf.net.

Any suggestions? As you can see below, I've tried stripping down to the
most basic ACPI config I can... If there's any way to retrieve the DSDT
or other tables without the ACPI driver loaded, I'm happy to try...

Thanks in advance!

dmesg excerpt:
Linux version 2.5.59 (user@host) (gcc version 3.2 20020903 (Red Hat Linux 8=
.0 3.2-7)) #1 Thu Jan 23 11:42:55 PST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff77000 (usable)
 BIOS-e820: 000000003ff77000 - 000000003ff79000 (ACPI NVS)
 BIOS-e820: 000000003ff79000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262007
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32631 pages, LIFO batch:7
Building zonelist for node : 0
Kernel command line: ro root=3DLABEL=3D/ acpi=3Doff
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2386.153 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4718.59 BogoMIPS
Memory: 1031380k/1048028k available (3376k kernel code, 15728k reserved, 12=
11k data, 140k init, 130524k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
Machine check exception polling timer started.
CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xfbe5e, last bus=3D2
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030109
ACPI: Disabled via command line (acpi=3Doff)
Linux Plug and Play Support v0.94 (c) Adam Belay
pnp: Enabling Plug and Play Card Services.
PnPBIOS: Found PnP BIOS installation structure at 0xc00fe2d0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xe2f4, dseg 0x40
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
SCSI subsystem driver Revision: 1.00
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Br
PCI: Using IRQ router PIIX [8086/2440] at 00:1f.0
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
IA-32 Microcode Update Driver: v1.11 <tigran-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
Enabling SEP on CPU 0
highmem bounce pool size: 64 pages

.config excerpt:
#
# Power management options (ACPI, APM)
#
CONFIG_PM=3Dy
CONFIG_SOFTWARE_SUSPEND=3Dy

#
# ACPI Support
#
CONFIG_ACPI=3Dy
CONFIG_ACPI_BOOT=3Dy
# CONFIG_ACPI_SLEEP is not set
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
# CONFIG_ACPI_BUTTON is not set
# CONFIG_ACPI_FAN is not set
# CONFIG_ACPI_PROCESSOR is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=3Dy
CONFIG_ACPI_INTERPRETER=3Dy
CONFIG_ACPI_EC=3Dy
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_PCI=3Dy
CONFIG_ACPI_SYSTEM=3Dy
# CONFIG_APM is not set
# CONFIG_CPU_FREQ is not set

--=-fm49K2tziamd40WZhXqi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA+MWAPfUmPgSsI5McRApVfAJ9bBWK8xEdaaicR8JLY+WXX1Q9bpgCfTIF5
aEcpMtKJoHZL3YRt2wL39LQ=
=et7z
-----END PGP SIGNATURE-----

--=-fm49K2tziamd40WZhXqi--



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
