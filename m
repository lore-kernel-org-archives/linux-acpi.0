From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Acer Extensa 4101 WLMI
Date: Tue, 8 Nov 2005 20:40:35 +0100
Message-ID: <20051108194035.GH24086@poupinou.org>
References: <20051108135734.GF24086@poupinou.org> <13777.1131468833@www73.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <13777.1131468833-SEy/yctNfLdmcu3hnIyYJQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dirk Partikel <dirk.partikel-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 08, 2005 at 05:53:53PM +0100, Dirk Partikel wrote:
> 
> 
> Dear Acpi4Linux Team
> The DSDT for the Acer Extensa 4100 WLMI from your website is not bootable
> with my Acer Extensa 4101 WLMI. The Acer-Support means, the Aspire 1690 and
> my Acer Extensa 4101 WLMI had the same Hardware.
> So I make a BIOS-Update to the latest available Version (3C29).
> Now I try the DSDT for the Acer Aspire 1691 from your Website, this was not
> succesfull, too.
> 
> I make a DSDT.dsl from /proc/acpi/dsdt. I get 14 errors after the intel
> compiler works. The most errors are 1061. I can t find a discription for
> error 1061 in the web. Can you check my DSDT.dsl and fix it???
> 
> If it possible, send me a little description, how to fix error 1061, i want
> to send it to ubuntuusers, there is a little how to about repair a broken
> DSDT, with some error codes, but without error 1061.
> 
> My kernel 2.6.14 boot with the option -noapic, i hope the dsdt.dsl depends
> not on any boot options.
> 
> My notebook: Acer Extensa 4101 WLMI, 1024 MB RAM DDR, Radeon X700
> 
> Sorry for the bad english, and perhaps for the big mistakes.
> I hope you can understand it.
> 
> Many thanks and best regards
> Dirk Partikel
> 

Please look thread at:
http://marc.theaimsgroup.com/?t=111771210400001&r=1&w=2
(for the error 1061)
and
http://marc.theaimsgroup.com/?l=acpi4linux&m=111159701930263&w=2
For (a first) report on the same problem with that laptop.

I think I privately send this patch to the OP of the latest thread since
I have that patch for your AML handy somewhere (I will try to not
forgot to CC to acpi-devel this time :) and I do have that:

ducrot@neptune:~/acpi_hack/acer_extensia_4101WMLI$ patch < ../acer_extensia_4/t
patching file dsdt.dsl
Hunk #2 succeeded at 1946 (offset 17 lines).
Hunk #4 succeeded at 6365 (offset 17 lines).
ducrot@neptune:~/acpi_hack/acer_extensia_4101WMLI$ iasl-20041203 dsdt.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20041203 [Jan 18
2005]
Copyright (C) 2000 - 2004 Intel Corporation
Supports ACPI Specification Revision 2.0c

ASL Input:  dsdt.dsl - 6945 lines, 244066 bytes, 3202 keywords
AML Output: DSDT.aml - 27317 bytes 674 named objects 2528 executable
opcodes

Compilation complete. 0 Errors, 0 Warnings, 0 Remarks, 1116 Optimizations


so it should be fine.


--- dsdt.dsl	2005/03/23 17:06:53	1.1
+++ dsdt.dsl	2005/03/23 18:03:04
@@ -6,6 +6,10 @@
  */
 DefinitionBlock ("DSDT.aml", "DSDT", 1, "INTEL ", "ALVISO  ", 100925440)
 {
+    External (\CFGD)
+    External (\PDC0)
+    External (\PDC1)
+
     OperationRegion (PRT0, SystemIO, 0x80, 0x04)
     Field (PRT0, DWordAcc, Lock, Preserve)
     {
@@ -1925,6 +1929,7 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, 
                                 Return (0x00)
                             }
                         }
+                        Return(0)
                     }
 
                     Method (USTA, 0, NotSerialized)
@@ -2556,6 +2561,7 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, 
                                 Store (0x00, \_SB.PCI0.RP03.Z002)
                                 Store (0x01, \_SB.PCI0.RP03.LDP3)
                             }
+                            Return(1)
                         }
 
                         Method (XEJ0, 1, NotSerialized)
@@ -6342,8 +6348,8 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, 
             Name (PBST, Package (0x04)
             {
                 0x00, 
-                Z00C, 
-                Z00C, 
+                0xffff, 
+                0xffff, 
                 0x2710
             })
             Name (ERRC, 0x00)
@@ -6599,8 +6605,8 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, 
             Name (PBST, Package (0x04)
             {
                 0x00, 
-                Z00C, 
-                Z00C, 
+                0xffff, 
+                0xffff, 
                 0x2710
             })
             Name (ERRC, 0x00)

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
