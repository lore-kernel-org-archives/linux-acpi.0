From: Emilio =?iso-8859-1?q?Mej=EDa=20Fern=E1ndez=20de=20Velasco?= <emejia-EkmVulN54Sk=@public.gmane.org>(by way of Emilio Mejia Fernandez de Velasco <emejia-EkmVulN54Sk=@public.gmane.org>)
Subject: Re: differences between acpidump and =?iso-8859-1?q?disassembling=0Adsdt=20with?= iasl
Date: Sun, 18 Apr 2004 13:58:23 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200404181358.24472.emejia@ieee.org>
Reply-To: emejia-EkmVulN54Sk=@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA==@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg==@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

When I compile the kernel to work with ACPI I choose not to include local
APIC. Otherwise it doesn't work at all.
In the kernel configuration with ACPI I leave blank the option
"Processor type and features ->
		[ ]Local APIC support on uniprocessors"

I get the same results with nolapic as boot option. The computer can only w=
ork=20
for some minutes, and then it freezes.
This time I tried compiling with debug options in ACPI, but nothing relevan=
t=20
seems to be registered in /var/log/messages. Anyway here you can see the gr=
ep=20
ACPI of this file:
Apr 18 13:04:46 microstar kernel:  BIOS-e820: 0000000016ff0000 -=20
0000000016fffc00 (ACPI data)
Apr 18 13:04:46 microstar kernel:  BIOS-e820: 0000000016fffc00 -=20
0000000017000000 (ACPI NVS)
Apr 18 13:04:46 microstar kernel: ACPI: RSDP (v000=20
PTLTD                                     ) @ 0x000f7030
Apr 18 13:04:46 microstar kernel: ACPI: RSDT (v001 PTLTD    RSDT   0x060400=
00 =20
LTP 0x00000000) @ 0x16ffba62
Apr 18 13:04:46 microstar kernel: ACPI: FADT (v001 VT8603 TWISTER  0x060400=
00=20
PTL  0x000f4240) @ 0x16fffb64
Apr 18 13:04:46 microstar kernel: ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x060400=
00 =20
LTP 0x00000001) @ 0x16fffbd8
Apr 18 13:04:46 microstar kernel: ACPI: DSDT (v001  VIA   PTL_ACPI 0x060400=
00=20
MSFT 0x0100000b) @ 0x00000000
Apr 18 13:04:46 microstar kernel: ACPI: Looking for DSDT in initrd ... foun=
d=20
customized DSDT with 15240 bytes!
Apr 18 13:04:46 microstar kernel: ACPI: Subsystem revision 20040326
Apr 18 13:04:46 microstar kernel: ACPI: Using customized DSDT
Apr 18 13:04:46 microstar kernel:  tbxface-0117 [03] acpi_load_tables      =
:=20
ACPI Tables successfully acquired
Apr 18 13:04:46 microstar kernel: ACPI Namespace successfully loaded at roo=
t=20
c03b9ffc
Apr 18 13:04:46 microstar kernel: ACPI: IRQ9 SCI: Edge set to Level Trigger.
Apr 18 13:04:46 microstar kernel: evxfevnt-0093 [04] acpi_enable           =
:=20
Transition to ACPI mode successful
Apr 18 13:04:46 microstar kernel: ACPI: Interpreter enabled
Apr 18 13:04:46 microstar kernel: ACPI: Using PIC for interrupt routing
Apr 18 13:04:46 microstar kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Apr 18 13:04:46 microstar kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
Apr 18 13:04:46 microstar kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
Apr 18 13:04:46 microstar kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 5)
Apr 18 13:04:46 microstar kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs *5)
Apr 18 13:04:46 microstar kernel: ACPI: Power Resource [PFAN] (off)
Apr 18 13:04:46 microstar kernel: ACPI: PCI Interrupt Link [LNKA] enabled a=
t=20
IRQ 10
Apr 18 13:04:46 microstar kernel: ACPI: PCI Interrupt Link [LNKD] enabled a=
t=20
IRQ 5
Apr 18 13:04:46 microstar kernel: ACPI: PCI Interrupt Link [LNKC] enabled a=
t=20
IRQ 5
Apr 18 13:04:46 microstar kernel: ACPI: PCI Interrupt Link [LNKB] enabled a=
t=20
IRQ 10
Apr 18 13:04:46 microstar kernel: PCI: Using ACPI for IRQ routing
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x00, ""
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x08, "ACAD_P=
SR"
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x00, ""
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x0F, "ACAD_P=
SR=20
Return"
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x00, ""
Apr 18 13:04:46 microstar kernel: [ACPI Debug] Integer: 0x0000000000000001
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:04:46 microstar kernel: ACPI: AC Adapter [ACAD] (on-line)
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x00, ""
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x10,=20
"BAT0_BIF_RETURN:"
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x00, ""
Apr 18 13:04:46 microstar kernel: [ACPI Debug] Package: Size 0x0D Elements =
Ptr=20
=2D d6fecf48
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:04:46 microstar kernel: ACPI: Battery Slot [BAT0] (battery presen=
t)
Apr 18 13:04:46 microstar kernel: ACPI: Power Button (FF) [PWRF]
Apr 18 13:04:46 microstar kernel: ACPI: Lid Switch [LID]
Apr 18 13:04:46 microstar kernel: ACPI: Fan [FAN] (on)
Apr 18 13:04:46 microstar kernel: ACPI: Processor [CPU0] (supports C1 C2, 1=
6=20
throttling states)
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x00, ""
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x08, "THRM_T=
MP"
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x00, ""
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x08, "THRM_T=
MP"
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:04:46 microstar kernel: ACPI: Thermal Zone [THRM] (74 C)
Apr 18 13:04:46 microstar kernel: [ACPI Debug] Integer: 0x0000000000000001
Apr 18 13:04:46 microstar kernel: [ACPI Debug] Integer: 0x000000000000004A
Apr 18 13:04:46 microstar kernel: [ACPI Debug] Integer: 0x0000000000000032
Apr 18 13:04:46 microstar kernel: [ACPI Debug] Integer: 0x0000000000000001
Apr 18 13:04:46 microstar kernel: [ACPI Debug] Integer: 0x000000000000004A
Apr 18 13:04:46 microstar kernel: [ACPI Debug] Integer: 0x0000000000000044
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x00, ""
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x08, "THRM_T=
MP"
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x00, ""
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x08, "THRM_T=
MP"
Apr 18 13:04:46 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x00, ""
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x08, "BAT0_B=
ST"
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x00, ""
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x10,=20
"BAT0_BST_RETURN:"
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x00, ""
Apr 18 13:05:45 microstar kernel: [ACPI Debug] Package: Size 0x04 Elements =
Ptr=20
=2D d6f38ac8
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x00, ""
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x10,=20
"BAT0_BIF_RETURN:"
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x00, ""
Apr 18 13:05:45 microstar kernel: [ACPI Debug] Package: Size 0x0D Elements =
Ptr=20
=2D d6fecf48
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x00, ""
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x08, "THRM_T=
MP"
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x00, ""
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x08, "ACAD_P=
SR"
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x00, ""
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x0F, "ACAD_P=
SR=20
Return"
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x00, ""
Apr 18 13:05:45 microstar kernel: [ACPI Debug] Integer: 0x0000000000000001
Apr 18 13:05:45 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:10:25 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:10:25 microstar kernel: [ACPI Debug] String: Length 0x00, ""
Apr 18 13:10:25 microstar kernel: [ACPI Debug] String: Length 0x08, "THRM_T=
MP"
Apr 18 13:10:25 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:11:25 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
Apr 18 13:11:25 microstar kernel: [ACPI Debug] String: Length 0x00, ""
Apr 18 13:11:25 microstar kernel: [ACPI Debug] String: Length 0x08, "THRM_T=
MP"
Apr 18 13:11:25 microstar kernel: [ACPI Debug] String: Length 0x22,=20
"__________________________________"
=2E..
And these last 4 lines repeat for 10 times, and then the computer freezes. =
It=20
is completely blocked. It can only be rebooted with the power button. I hav=
e=20
also tried to reach it from ssh, but no luck with this either.
The remaining of the messages file belong to the next boot.
There is another thing: I can make it go frozen faster, I just need to unpl=
ug=20
and plug the AC adapter for a couple of times, and the I get the blocking=20
again. -This only happens with acpi, not with apm-
I feel like throwing the laptop through the window.



>On Sat, 2004-04-17 at 15:59, Emilio Mej=EDa Fern=E1ndez de Velasco wrote:
>> ACPI: IRQ9 SCI: Edge set to Level Trigger.
>
>when this happens, my empiric experience says that you should try ,
>disable APIC in kernel configuration
>or
>boot with nolapic option ( that disable apic )
>
>let me know the result of the test.
>
>thanks,
>--
>S=E9rgio M. B.

=2D------------------------------------------------------



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
