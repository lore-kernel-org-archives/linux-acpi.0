From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: dsdt and more
Date: Mon, 28 Oct 2002 10:04:39 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19B8A8@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?=27S=E9rgio_Monteiro_Basto=27?= <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


The checksum in DSDT.bin is incorrect, and it looks like some bytes =
have
been zeroed out.  You've got a corrupted DSDT somehow.  That's why you =
have
the strange error when you try to compile the disassembled code.

The iASL disassembler wasn't validating the checksum, so you didn't get =
an
error message.  I've added the checksum validation for the next =
release.

Bob


-----Original Message-----
From: S=E9rgio Monteiro Basto [mailto:sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org]=20
Sent: Saturday, October 26, 2002 4:57 PM
To: acpi-devel
Subject: [ACPI] dsdt and more

I will report all strange things acpi related in my Compaq pressario
706EA.=20


./iasl -tc -i acpi_dsdt.dsl=20
give me this strange error, the others error have fixes.=20
acpi_dsdt.dsl   549:                     Zero=20
Error    1037 -                 parse error ^=20


if I override bios with this dsdt fixed deleting or not deleting this
Zeros, my BAT is not recognized.=20
without override I can read BATTERY information.=20

"Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions"=20


" acpi_processor-0897 [21] acpi_processor_get_per: Unsupported address
space [127] (control_register)=20
ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)"=20

with this new verion this mesg disappears ;), know I don't have
/proc/processor.=20

acpidmp > dmp.bin=20
acpidmp DSDT > DSDT.bin=20
acpidmp FACP > FACP.bin=20
acpidmp FACS > FACS.bin=20
acpidmp FADT > FADT.bin=20
acpidmp RSDP > RSDP.bin=20
acpidmp RSDT > RSDT.bin=20
acpidmp SSDT > SSDT.bin=20
cat /proc/acpi/fadt > fadt.bin=20

from dmesg:=20
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f6dd0=20
ACPI: RSDT (v001 PTLTD    RSDT   01540.00000) @ 0x0defb63b=20
ACPI: FADT (v001 COMPAQ  EAGLES  01540.00000) @ 0x0defeeb6=20
ACPI: SSDT (v001 PTLTD  POWERNOW 01540.00000) @ 0x0defef2a=20
ACPI: DSDT (v001 COMAPQ   EAGLES 01540.00000) @ 0x00000000=20
ACPI: Vendor "COMAPQ" System "  EAGLES" Revision 0x6040000 has a known
ACPI BIOS problem.=20
ACPI: Reason: SCI issues (C2 disabled). This is a recoverable error=20
ACPI: BIOS passes blacklist=20


and finally=20
Oct 21 03:42:57 darkstar kernel: [ACPI Debug] String: USB runtime event =

Oct 21 03:42:57 darkstar kernel: acpi_bus-0263 [15]
acpi_bus_get_device   : Error getting context for object [cde28ee8]=20
Oct 21 03:42:57 darkstar kernel: hub.c: USB new device connect on
bus1/1, assigned device number 3=20
Oct 21 03:42:57 darkstar kernel: usb.c: USB device 3 (vend/prod
0x5ab/0x200) is not claimed by any active driver.=20



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
