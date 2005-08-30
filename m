From: Manuel J.Galan <mjgalan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ACER Aspire 5000
Date: Tue, 30 Aug 2005 14:36:52 +0000 (UTC)
Message-ID: <loom.20050830T163344-565@post.gmane.org>
References: <20050829180845.98096.qmail@web81605.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

Matt R Hall <mhall@...> writes:

> 
> I am having some problems with ACPI battery support on an ACER Aspire
> 5000. I am unable to read the battery state, which makes this laptop
> nearly useless. I suspect the DSDT code was missing a variable
> declaration or something and this was not caught by Microsoft's
> compiler, but I'm nowhere near expert with the DSDT programming
> language, so some help would be greatly appreciated.
> 
> Relevant ASCII information is included inline. The /proc/acpi/dsdt file
> is attached.
> 

try to patch your dsdt.dsl with the following
================================================
--- dstd.dsl.old        2005-08-30 15:26:55.000000000 +0100
+++ dstd.dsl    2005-08-30 15:26:35.000000000 +0100
@@ -2,7 +2,7 @@
  * Intel ACPI Component Architecture
  * AML Disassembler version 20050624
  *
- * Disassembly of dstd, Tue Aug 30 15:26:55 2005
+ * Disassembly of dstd, Tue Aug 30 15:12:42 2005
  */
 DefinitionBlock ("DSDT.aml", "DSDT", 1, "PTLTD ", "755", 100925440)
 {
@@ -144,7 +144,10 @@

     Scope (_PR)
     {
-        Processor (CPU0, 0x00, 0x00008010, 0x06) {}
+        Processor (CPU0, 0x00, 0x00008010, 0x06)
+       {
+               External (_PPC) // added. mjgalan
+       }
     }

     Scope (\_SB)
@@ -3007,8 +3010,8 @@
             Name (PBST, Package (0x04)
             {
                 0x00,
-                Z007,
-                Z007,
+                Z006,  // changed from Z007. mjgalan
+                Z006,  // changed from Z007. mjgalan
                 0x2710
             })
             Name (ERRC, 0x00)
@@ -3399,6 +3402,7 @@
         {
             \_SB.PHSR (0x03, 0x00)
         }
+       Return(Package(0x02){0x00, 0x00}) // added. mjgalan
     }

     Method (_PTS, 1, NotSerialized)
========================================================



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
