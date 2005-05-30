From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: question of appropriateness
Date: Mon, 30 May 2005 19:25:36 +0200
Message-ID: <20050530172536.GI32472@poupinou.org>
References: <1117244104.21648.1.camel@localhost.localdomain> <20050528101450.GA19354@fingerbrecher> <1117397912.24721.5.camel@localhost.localdomain> <20050530130147.GH32472@poupinou.org> <1117471738.398.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1117471738.398.18.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: James Sparenberg <james-q+VOwRQyn90NJZHkBl2fuw@public.gmane.org>
Cc: ACPI <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, May 30, 2005 at 09:48:58AM -0700, James Sparenberg wrote:
>    First thanks for the offer of help and yes I'm starting to did into
> the spec.  Shorter read than the LSB though not by much *grin*
> 
> I sent the outputs asked for via a direct mail as you asked.

Got it.

> But I
> didn't want to post those links into a forum than gets publicly
> archived.  If anyone else wants the data I'll be glad to let them see it
> as well.  
> 
> The reason for starting this endevor is a set of acpi related error
> messages that fill up my logs (at the rate of about 1 every 2 seconds) 
> 
>     ACPI-0352: *** Error: Looking up [Z007] in namespace, AE_NOT_FOUND
> search_node cbec2e20 start_node cbec2e20 return_node 00000000
>     ACPI-1138: *** Error: Method execution failed [\_SB_.BAT1._BST]
> (Node cbec2d20), AE_NOT_FOUND

Again that one? Grrr.

> I've noticed 2 rather interesting things ...
> 
> 1.  Windows is only slightly better on power management with this DSDT
> than Linux.  
> 2.  This DSDT does have the "Windows Only" settings in it.  Surprisingly
> it doesn't have an entry for WindowsXP.   (I've a feeling somebody cut
> and pasted an older DSDT.)
> 
> I did file a bug so to speak with Acer a prompt "Thank you for the
> information we are looking into the matter type letter", but somehow it
> did have a feel about it that it did raise and eyebrow so maybe they can
> help sometime in the next 6 months to a year.  *grin*

>From your acpi dump, the dsdt compile without the first error, so I was
pretty right to think that your iasl is broken somehow.

In order to get rid off the _PPC things, I checked that the _PPC thing
was in a SSDT via something like this:

../pmtools/acpidmp/acpixtract SSDT < acpidmp.out > ssdt

Then:
iasl -d ssdt
in order to decompile it to ASL.

So you should not worry about those \_PR.CPU0._PPC (for example) by
defining an external one (see diff below).

Lastly, for the Z007 horror, replace them with Zero or Ones (or any
other integer values).

But I'm wondering what iasl are you using?  It seems totally broken
to me.


--- dsdt.dsl	2005/05/30 17:20:33	1.1
+++ dsdt.dsl	2005/05/30 17:22:51
@@ -6,6 +6,7 @@
  */
 DefinitionBlock ("DSDT.aml", "DSDT", 1, "PTLTD ", "755", 100925440)
 {
+
     OperationRegion (P80G, SystemIO, 0x80, 0x01)
     Field (P80G, ByteAcc, NoLock, Preserve)
     {
@@ -146,6 +147,7 @@
     {
         Processor (CPU0, 0x00, 0x00008010, 0x06) {}
     }
+    External (\_PR.CPU0._PPC)
 
     Scope (\_SB)
     {
@@ -3007,8 +3009,8 @@
             Name (PBST, Package (0x04)
             {
                 0x00, 
-                Z007, 
-                Z007, 
+                Ones, 
+                Ones, 
                 0x2710
             })
             Name (ERRC, 0x00)

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
