From: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>
Subject: Re: various problems with Acer TM654, suspend, ACAD, radeon
Date: Sun, 22 Aug 2004 12:35:42 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040822103542.GA17227@gamma.logic.tuwien.ac.at>
References: <20040820161911.GA24510@gamma.logic.tuwien.ac.at> <200408202147.51250.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200408202147.51250.stefandoesinger-RbZlAiThDcE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan =?iso-8859-15?Q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Stefan! Hi List!

Thanks for the hints, but it didn't work out:

On Fre, 20 Aug 2004, Stefan Dösinger wrote:
> > - Same with the AC Adapter, why does it send no event at all?

> Perhaps it's a problem with your DSDT. I had the same issue on my TM800, and 
> the patch I found on acpi.sf.net helped. Look for ACER - TravelMate 800 - 
> 3a15. I guess you'll have to edit your dsdt manually.

I did it and it didn't help: From my dmesg:
-----------------------------------------------------------------------
...
ACPI: RSDP (v000 ACER                                      ) @ 0x000f5e80
ACPI: RSDT (v001 ACER     RSDT   0x20020630  LTP 0x00000000) @ 0x1ff75a7b
ACPI: FADT (v001 ACER   IBIS     0x20020630 PTL  0x0000001e) @ 0x1ff7bf64
ACPI: BOOT (v001 ACER   IBIS     0x20020630  LTP 0x00000001) @ 0x1ff7bfd8
ACPI: DSDT (v001 ACER   IBIS     0x20020630 MSFT 0x0100000e) @ 0x00000000
Built 1 zonelists
....
ACPI: Looking for DSDT in initrd ... found (at offset 20)!
 found customized DSDT with 23575 bytes!
....
-----------------------------------------------------------------------

Where the custom DSDT was created by applying this fix:
-----------------------------------------------------------------------
--- dsdt.dsl	2004-08-21 14:52:10.000000000 +0200
+++ dsdt-fixed.dsl	2004-08-22 12:20:52.000000000 +0200
@@ -2,7 +2,7 @@
  * Intel ACPI Component Architecture
  * AML Disassembler version 20040715
  *
- * Disassembly of dsdt.dat, Sat Aug 21 14:52:10 2004
+ * Disassembly of dsdt.aml, Sat Aug 21 14:31:55 2004
  */
 DefinitionBlock ("DSDT.aml", "DSDT", 1, "ACER  ", "IBIS    ", 537003568)
 {
@@ -266,6 +266,7 @@
         }
 
         Store (0x00, \_SB.SLEE)
+	Return(Package(0x02){0x00, 0x00})
     }
 
     Scope (_GPE)
@@ -3486,7 +3487,7 @@
 
                                 If (And (0x02, BATF))
                                 {
-                                    Notify (\_SB.ACAD, 0x00)
+                                    Notify (\_SB.ACAD, 0x80)
                                 }
 
                                 Notify (\_SB.BAT1, 0x80)
-----------------------------------------------------------------------

The iasl still spews out two warnings, but I ignored them:
-----------------------------------------------------------------------
Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20040715 [Aug 21 2004]
Copyright (C) 2000 - 2004 Intel Corporation
Supports ACPI Specification Revision 2.0c

dsdt-fixed.dsl  4747:                         Method (_STA, 0, NotSerialized)
Warning  2019 -     Not all control paths return a value ^  (_STA)

dsdt-fixed.dsl  4747:                         Method (_STA, 0, NotSerialized)
Warning  2026 -      Reserved method must return a value ^  (_STA)

ASL Input:  dsdt-fixed.dsl - 5807 lines, 211377 bytes, 2765 keywords
AML Output: DSDT.aml - 23575 bytes 680 named objects 2085 executable opcodes

Compilation complete. 0 Errors, 2 Warnings, 0 Remarks, 801 Optimizations
-----------------------------------------------------------------------

But I still get only battery events when I plug in the ACAD or unplug
it.



> > - What can I try out to get S2D back again and S2R fully working?
> Try
> Option     "NoAccel"            "yes"
> in the device section in your XF86Config.

Umpf, well, yes, this works. But now even making a 
	ps -ax
makes the redrawing stumble. This cannot be the solution, the only one?!
Are there any other patches I could try?

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
Queasy but umbowed. The kind of feeling one gets when discovering a
plastic compartment in a fridge in which thing are growing.
			--- Douglas Adams, The Meaning of Liff


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
