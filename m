From: Emilio =?iso-8859-1?q?Mej=EDa=20Fern=E1ndez=20de=20Velasco?= <emejia-EkmVulN54Sk@public.gmane.org>
Subject: differences between acpidump and disassembling dsdt with iasl
Date: Sat, 17 Apr 2004 16:59:32 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200404171655.51162.emejia@ieee.org>
Reply-To: emejia-EkmVulN54Sk@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,
I'm having many problems to run acpi in my laptop. The last one came when I 
tried to fix the dsdt table. I found one error and fixed it. There were some 
arguments missing in DefinitionBlock, so I added them.
After fixing the dsdt and rebooting, I get different files from acpidump than 
rebuilding /proc/acpi/dsdt with iasl -d
In fact, this last method is the one that doesn't give errors after the 
fix-up. Yet acpidump doesn't seem to notice the fixing, because it still 
gives a file with the same arguments missing.
The problem is that I can't get my kernel working with acpi. It freezes after 
some time working. The keyboard doesn't respond and so I have to reboot. 
There is no message reported in /var/log/messages so I don't know where the 
blocking comes from. What I can see for example is that when I unplug the AC 
adapter a couple of times then I get it blocked automatically. Otherwise it 
gets blocked after some time anyway.
Now I have my system working with apm and it is stable, but it is not able to 
give an IRQ to the network card, and there are some other things that only 
work when I compile the kernel with acpi. Everything else is much better with 
the acpi kernel, except for the inconvenience that it breaks down after some 
minutes working.
Has anyone experienced similar problems? 
Is there any way to trace the errors and find where they come from?

This is the error when I try to compile the file returned by acpidump:
dsdt.asl    35: {_SB_.VIAX(0x8a)
Error    1037 - ^ parse error, unexpected '{', expecting PARSEOP_INTEGER

ASL Input:  dsdt.asl - 1914 lines, 71527 bytes, 0 keywords
Compilation complete. 1 Errors, 0 Warnings, 0 Remarks, 0 Optimizations

This is the part of the code to be modified:
DefinitionBlock (
"acpi_dsdt.aml",	//Output filename
"DSDT",	//Signature
{
Scope(_PR_) {
   ...
So I fixed it adding the rest of the arguments for DefinitionBlock, but after 
rebooting and including the new aml file I get the same error if I get the 
dsdt table from acpidump. On the other hand, if I get the dsdt decompiling 
the file /proc/acpi/dsdt with iasl, I get these lines:
DefinitionBlock ("DSDT.aml", "DSDT", 1, "VIA", "PTL_ACPI", 100925440)
{
    Scope (_PR)
...
As this file compiles back without errors, I included DSDT.aml in initrd 
instead of acpi_dsdt.aml. Anyway it keeps giving the same results afterwards

These are the lines of dmesg with grep acpi:
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f7030
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x16ffba62
ACPI: FADT (v001 VT8603 TWISTER  0x06040000 PTL  0x000f4240) @ 0x16fffb64
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x16fffbd8
ACPI: DSDT (v001  VIA   PTL_ACPI 0x06040000 MSFT 0x0100000b) @ 0x00000000
ACPI: Looking for DSDT in initrd ... found customized DSDT with 15240 bytes!
ACPI: Subsystem revision 20040326
ACPI: Using customized DSDT
    ACPI-0299: *** Info: Table [DSDT] replaced by host OS
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5)
ACPI: PCI Interrupt Link [LNKD] (IRQs *5)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PPB_._PRT]
ACPI: Power Resource [PFAN] (off)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)
ACPI: Thermal Zone [THRM] (74 C)


If someone could give some light on this it would help very much, because I 
feel a little bit frustrated after dedicating so much time without results. I 
have recompiled different versions of the kernel a thousand times in these 
weeks with many different options. Now I'm working with 2.6.5 and apm, but 
the tests with acpi are with 2.6.4 after the acpi patch and another patch to 
use a customized dsdt -there is no patch available for 2.6.5-
If you need more information please tell me, because I am desperate to find 
some helping hand.
Thank you

Emilio Mejia



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
