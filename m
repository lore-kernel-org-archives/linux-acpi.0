From: "Bernard Normier" <bernard-jCTGDdqZGLzlLTHTg0CpQwC/G2K4zDHf@public.gmane.org>
Subject: ACPI on Intel SE7501WV2
Date: Sat, 9 Oct 2004 16:28:44 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <028c01c4ae3e$938440e0$6400a8c0@centrino>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The Intel SE7501WV2 is a dual Xeon server motherboard. Power management is 
not a concern ... but stability is. When I boot with 2.6.8-1.521smp (latest 
Fedora Core 2), or my own 2.6.9-rc3 smp kernel build, the log shows 2 
ACPI-related issues:

- with USB enabled in the BIOS, dmesg shows:

hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
irq 169: nobody cared! (screaming interrupt?)
irq 169: Please try booting with acpi=off and report a bug
 [<021074d6>] __report_bad_irq+0x3a/0x77
 [<02107572>] note_interrupt+0x43/0x66
 [<021078c4>] do_IRQ+0x19d/0x225
handlers:
[<0225a679>] (usb_hcd_irq+0x0/0x4b)
Disabling IRQ #169

If I disable USB support in the BIOS, this error goes away. That's ok for 
me, since I don't use the USB ports on these servers.

- I always get these warnings:

PCI: PCI BIOS revision 2.10 entry at 0xfdb75, last bus=4
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
    ACPI-0562: *** Warning: Type override - [DEB_] had invalid type 
(Integer) for Scope operator, changed to (Scope)
    ACPI-0562: *** Warning: Type override - [MLIB] had invalid type 
(Integer) for Scope operator, changed to (Scope)
    ACPI-0562: *** Warning: Type override - [DATA] had invalid type (String) 
for Scope operator, changed to (Scope)
    ACPI-0562: *** Warning: Type override - [SIO_] had invalid type (String) 
for Scope operator, changed to (Scope)
    ACPI-0562: *** Warning: Type override - [LEDP] had invalid type (String) 
for Scope operator, changed to (Scope)
    ACPI-0562: *** Warning: Type override - [GPEN] had invalid type (String) 
for Scope operator, changed to (Scope)
    ACPI-0562: *** Warning: Type override - [GPST] had invalid type (String) 
for Scope operator, changed to (Scope)
    ACPI-0562: *** Warning: Type override - [WUES] had invalid type (String) 
for Scope operator, changed to (Scope)
    ACPI-0562: *** Warning: Type override - [WUSE] had invalid type (String) 
for Scope operator, changed to (Scope)
    ACPI-0562: *** Warning: Type override - [SBID] had invalid type (String) 
for Scope operator, changed to (Scope)
    ACPI-0562: *** Warning: Type override - [SWCE] had invalid type (String) 
for Scope operator, changed to (Scope)
ACPI: Interpreter enabled

Interestingly, disassembling /proc/acpi/dsdt with iasl shows the same 
warnings/errors. This is the top of dsdt.dsl:
dswload-0697: *** Warning: Type override - [DEB_] had invalid type (Integer) 
for Scope operator, changed to (Scope)
 dswload-0697: *** Warning: Type override - [MLIB] had invalid type 
(Integer) for Scope operator, changed to (Scope)
 dswload-0697: *** Warning: Type override - [DATA] had invalid type (String) 
for Scope operator, changed to (Scope)
 dswload-0697: *** Warning: Type override - [SIO_] had invalid type (String) 
for Scope operator, changed to (Scope)
 dswload-0697: *** Warning: Type override - [LEDP] had invalid type (String) 
for Scope operator, changed to (Scope)
 dswload-0697: *** Warning: Type override - [GPEN] had invalid type (String) 
for Scope operator, changed to (Scope)
 dswload-0697: *** Warning: Type override - [GPST] had invalid type (String) 
for Scope operator, changed to (Scope)
 dswload-0697: *** Warning: Type override - [WUES] had invalid type (String) 
for Scope operator, changed to (Scope)
 dswload-0697: *** Warning: Type override - [WUSE] had invalid type (String) 
for Scope operator, changed to (Scope)
 dswload-0697: *** Warning: Type override - [SBID] had invalid type (String) 
for Scope operator, changed to (Scope)
 dswload-0697: *** Warning: Type override - [SWCE] had invalid type (String) 
for Scope operator, changed to (Scope)
/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20040715
 *
 * Disassembly of dsdt.txt, Sat Oct  9 10:16:55 2004
 */
DefinitionBlock ("DSDT.aml", "DSDT", 1, "INTEL", "SWV25", 256)
{
[...]

and if I try to compile this dsdt.dsl with iasl -ta, I get this error:

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20040715 [Oct  9 2004]
Copyright (C) 2000 - 2004 Intel Corporation
Supports ACPI Specification Revision 2.0c

dsdt.dsl     1:  dswl         Method (_REG, 2, NotSerialized)
Error    1037 -     ^ syntax error, unexpected PARSEOP_NAMESEG, expecting 
PARSEOP_DEFINITIONBLOCK

ASL Input:  dsdt.dsl - 2364 lines, 74375 bytes, 0 keywords
Compilation complete. 1 Errors, 0 Warnings, 0 Remarks, 0 Optimizations

Can I safely ignore all these warnings, since I don't use power management 
on these servers?

If you'd like more details (such as the full dmesg, dmidecode output) I'd be 
happy to send them.

Thanks,
Bernard












-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
