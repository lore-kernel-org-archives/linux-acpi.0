From: Stefan Behnel <Stefan-vcFuay7eN/mzQB+pC5nmwQ@public.gmane.org>
Subject: Error calling uninitialized embedded controller during ACPI system
 init
Date: Sun, 26 Jan 2003 14:07:54 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E33DDAA.5030408@Behnel.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020907010406020209040100"
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

This is a multi-part message in MIME format.
--------------020907010406020209040100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

As I was playing around with my DSDT anyway, I took a closer look at
the two errors regarding battery and AC plug that were remaining in my
dmesg.

The funny thing is: the errors are reported when initializing "ACPI:
system" and they are related to the "embedded controller" (H_EC),
which is only initialized a little later down the road. I have
attached the relevant part of my dmesg.

Now, the DSDT methods that produce these errors (\_SB_.ADP1._STA and
\_SB_.BAT1._STA) actually access the embedded controller on the PCI
bus (\_SB.PCI0.LPCB.H_EC.ACEX) to see if the system is running on AC
(I guess). I attached my disassembled DSDT, too.

So I figured that I might have stumbled into a bug in the
Linux-ACPI-init procedure. (Well, anyway, I don't know if the spec
says anything about the devices that may (or may not) be called in the
_STA methods).

Do all _STA methods have to be called on system init? Wouldn't it be
(intuitively) better not to call BAT1._STA before battery init?

Would you know any clean way to get around this problem? I could try
to comment out the check in the _STA methods, but I don't know if
that's a good idea since I'm not very keen to break anything. What is
the _STA method there for anyway? Sounds like "sta-tus" or something,
but then, there are STAT methods, too...

Thanks,
Stefan Behnel


--------------020907010406020209040100
Content-Type: text/plain;
 name="dmesg.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.log"

ACPI: Subsystem revision 20030122
PCI: PCI BIOS revision 2.10 entry at 0xfd9cb, last bus=2
PCI: Using configuration type 1
   tbget-0273: *** Info: Table [DSDT] replaced by host OS
 tbxface-0098 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:..........................................................................................................................................................................
Table [DSDT] - 562 Objects with 50 Devices 170 Methods 17 Regions
Parsing all Control Methods:
Table [SSDT] - 0 Objects with 0 Devices 0 Methods 0 Regions
ACPI Namespace successfully loaded at root c0396dbc
evxfevnt-0073 [04] acpi_enable           : Transition to ACPI mode successful
   evgpe-0262: *** Info: GPE Block0 defined as GPE0 to GPE15
   evgpe-0262: *** Info: GPE Block1 defined as GPE16 to GPE31
Executing all Device _STA and_INI methods:..................................................
50 Devices found containing: 50 _STA, 2 _INI methods
Completing Region/Field/Buffer/Package initialization:.......................................................
Initialized 11/17 Regions 0/0 Fields 24/24 Buffers 20/20 Packages (565 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S3 S4 S5)
evregion-0235 [22] ev_address_space_dispa: no handler for region(c12ecca8) [embedded_control]
 exfldio-0216 [21] ex_access_region      : Region embedded_control(3) has no handler
 dswexec-0402 [14] ds_exec_end_op        : [LEqual]: Could not resolve operands, AE_NOT_EXIST
dswstate-0251 [16] ds_result_pop_from_bot: No result objects! State=cff67828
 dsutils-0494 [16] ds_create_operand     : Missing or null operand, AE_AML_NO_RETURN_VALUE
 psparse-1102: *** Error: Method execution failed [\_SB_.ADP1._STA] (Node c12f02a8), AE_AML_NO_RETURN_VALUE
evregion-0235 [22] ev_address_space_dispa: no handler for region(c12ecca8) [embedded_control]
 exfldio-0216 [21] ex_access_region      : Region embedded_control(3) has no handler
 dswexec-0402 [14] ds_exec_end_op        : [LEqual]: Could not resolve operands, AE_NOT_EXIST
dswstate-0251 [16] ds_result_pop_from_bot: No result objects! State=cff67828
 dsutils-0494 [16] ds_create_operand     : Missing or null operand, AE_AML_NO_RETURN_VALUE
 psparse-1102: *** Error: Method execution failed [\_SB_.BAT1._STA] (Node c12f0ca8), AE_AML_NO_RETURN_VALUE
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 10 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 10 11, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 10 11, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs 10 11, disabled)
ACPI: Embedded Controller [H_EC] (gpe 24)
ACPI: Power Resource [PFAN] (on)


--------------020907010406020209040100
Content-Type: application/x-gunzip;
 name="dsdt.dsl.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="dsdt.dsl.gz"

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
--------------020907010406020209040100--



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
