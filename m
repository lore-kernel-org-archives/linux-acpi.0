From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: [BK PATCH] ACPI updates
Date: 25 May 2003 05:42:04 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1053837724.4322.35.camel@darkstar.portugal>
References: <F760B14C9561B941B89469F59BA3A847E96ED1@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-B0KBBEvH8VPk9vGjC0Aw"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E96ED1-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-B0KBBEvH8VPk9vGjC0Aw
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,=20

Firsts tests seem ok!
I send in attach what I think that was relevant of /var/log/dmesg=20

I found 2 new things=20

1- Table [SSDT](id F003) - 3 Objects with 0 Devices 0 Methods 0 Regions.
I don't remember, apci trying parse SSDT table.

2- Initialized 15/15 Regions 1/1 Fields 20/20 Buffers 23/23 Packages (444 n=
odes)
for time first time or just in last patches, acpi initialize all in all pos=
sible.

This messages appears, more or less, since July of 2002=20
But I would like try understand what this message means:=20
 acpi_processor-0897 [17] acpi_processor_get_per: Unsupported address space=
 [127] (control_register)

Thanks

On Sat, 2003-05-24 at 01:15, Grover, Andrew wrote:
> Hi,
>=20
...
--=20
S=E9rgioMB
email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org

Who gives me one shell, give me everything.

--=-B0KBBEvH8VPk9vGjC0Aw
Content-Disposition: attachment; filename=dmesg
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=dmesg; charset=ISO-8859-1

Linux version 2.4.21-rc3 (root-4/PLUo9XfK/yXfm4dIG/yWZHpeb/A1Y/@public.gmane.org) (gcc version 2.96 2000073=
1 (Red Hat Linux 7.3 2.96-113)) #2 Sun May 25 04:56:31 WEST 2003
224MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f6dd0
ACPI: RSDT (v001 PTLTD    RSDT   01540.00000) @ 0x0defb63b
ACPI: FADT (v001 COMPAQ  EAGLES  01540.00000) @ 0x0defeeb6
ACPI: SSDT (v001 PTLTD  POWERNOW 01540.00000) @ 0x0defef2a
ACPI: DSDT (v001 COMAPQ   EAGLES 01540.00000) @ 0x00000000
ACPI: Vendor "COMAPQ" System "  EAGLES" Revision 0x6040000 has a known ACPI=
 BIOS problem.
ACPI: Reason: SCI issues (C2 disabled). This is a recoverable error
ACPI: BIOS passes blacklist
Detected 996.570 MHz processor.
Memory: 224248k/229376k available (1357k kernel code, 4672k reserved, 383k =
data, 240k init, 0k highmem)
CPU: AMD mobile AMD Athlon(tm) 4 Processor stepping 02
ACPI: Subsystem revision 20030522
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquire=
d
Parsing all Control Methods:...............................................=
..............................................................
Table [DSDT](id F005) - 433 Objects with 44 Devices 109 Methods 15 Regions
Parsing all Control Methods:
Table [SSDT](id F003) - 3 Objects with 0 Devices 0 Methods 0 Regions
ACPI Namespace successfully loaded at root c03003dc
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successf=
ul
evgpeblk-0735 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 00=
00000000008020 on int 10
evgpeblk-0260 [08] ev_save_method_info   : Registered GPE method _L0B as GP=
E number 0x0B
evgpeblk-0260 [08] ev_save_method_info   : Registered GPE method _L0E as GP=
E number 0x0E
evgpeblk-0260 [08] ev_save_method_info   : Registered GPE method _L09 as GP=
E number 0x09
evgpeblk-0260 [08] ev_save_method_info   : Registered GPE method _L05 as GP=
E number 0x05
Completing Region/Field/Buffer/Package initialization:.....................=
......................................
Initialized 15/15 Regions 1/1 Fields 20/20 Buffers 23/23 Packages (444 node=
s)
Executing all Device _STA and_INI methods:.....[ACPI Debug] String: -------=
--------------------- AC _STA
..[ACPI Debug] String: --------- VIA SOFTWARE SMI PMIO 2Fh ------------
......................................
45 Devices found containing: 45 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
[ACPI Debug] String: ---------------------------- AC _STA
[ACPI Debug] String: ---------------------------- AC _STA
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Disabling VIA memory write queue (PCI ID 0305, rev 80): [55] 3c & 1f -> 1c
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *4)
ACPI: PCI Interrupt Link [LNKB] (IRQs *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs *5)
ACPI: PCI Interrupt Link [LNKD] (IRQs *9)
ACPI: Embedded Controller [EC] (gpe 6)
PCI: Probing PCI hardware
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even 'a=
cpi=3Doff'
Applying VIA southbridge workaround.
[ACPI Debug] String: ---------------------------- AC _PSR
[ACPI Debug] String: ---------------------------- AC _FLPA
[ACPI Debug] String: ---------------------------- AC on line
ACPI: AC Adapter [AC] (on-line)
[ACPI Debug] String: --------- VIA SOFTWARE SMI PMIO 2Fh ------------
[ACPI Debug] String: ---------------- NABT < 6=20
[ACPI Debug] String: ---------------- Li Battery=20
[ACPI Debug] String: --------------------- DC >=3D 3000=20
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
acpi_processor-0897 [17] acpi_processor_get_per: Unsupported address space =
[127] (control_register)
ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)
[ACPI Debug] String: ---------------------------- AC _STA

--=-B0KBBEvH8VPk9vGjC0Aw--



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
