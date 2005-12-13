From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Fixing my DSDT. Do I have to learn another language?
Date: Tue, 13 Dec 2005 20:02:07 +0100
Message-ID: <20051213190207.GA16715@poupinou.org>
References: <439BEFF1.1040607@netland.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <439BEFF1.1040607-aH2ABhMBJl7z+pZb47iToQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ron Arts <ron.arts-aH2ABhMBJl7z+pZb47iToQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Dec 11, 2005 at 10:22:57AM +0100, Ron Arts wrote:
> Hi,
> 
> I own a Uniwill 255II3, and occasionally my system thinks the battery is 
> almost empty
> (XP has the same problem on this laptop BTW).
> 
> Looking at the syslog I get about every minute:
> 
> Dec 11 09:51:05 raarts-ttec kernel:     ACPI-0412: *** Error: Handler for 
> [EmbeddedControl] returned AE_TIME
> Dec 11 09:51:05 raarts-ttec kernel:     ACPI-0508: *** Error: Method 
> execution failed [\_SB_.PCI0.BAT0._BST] (Node c145c9e0), AE_TIME
> 
> I found out about DSDT's, and determined that mine must contain errors, I 
> need
> to fix it, and boot my system with the fixed table.
> 
> I dumped my current DSDT, decompiled mine using iasl and looked at it.
> 
> This is where I am now. I have looked at the ACPI spec, and this spec is 
> 631 pages.
> Do I have to learn this language to fix the fact that my system occasionally
> thinks it has an empty battery?

I don't think so.

> Maybe someone can give me a hint on how to
> handle it? I made it available here: http://www.netland.nl/download/dsdt.dsl
> (temporary link).

The problem is here:

   2358                     Name (BFB0, Package (0x04)
   2359                     {
   2360                         0x00,
   2361                         0xFFFFFFFF,
   2362                         0x1034,
   2363                         0x2A30
   2364                     })
   2365                     Method (_BST, 0, NotSerialized)
   2366                     {
   2367                         Store ("BST Start", Debug)
   2368                         Store (\_SB.PCI0.SBRG.EC0.XST0, Index (BFB0, 0x00))
   2369                         Store (\_SB.PCI0.SBRG.EC0.XST2, Index (BFB0, 0x02))
   2370                         Store (\_SB.PCI0.SBRG.EC0.XST3, Index (BFB0, 0x03))
   2371                         Store ("BST End", Debug)
   2372                         Return (BFB0)
   2373                     }

and a timeout happens on one of those lines: 2368, 2369 or 2370.
The \_SB.PCI0.SBRG.EC0.XST0 (XST1...) are defined under an Embedded
Controller region.
The fault come therefore from the EC.  I don't know however if this
is due to a bug under Linux, or under the EC's firmware.  It may be
possible that a bios upgrade (including an upgrade to the EC firmware)
may fix this problem.  Another quick an dirty hack that you may want
to try is to increase the timeout things into

drivers/acpi/ec.c

for example, try to set 100 instead of 50 for ACPI_EC_DELAY
#define ACPI_EC_DELAY           50      /* Wait 50ms max. during EC ops */

and so on...

> Another question (sorry): I also own some Apple iBooks. When I close the 
> lid, they
> go into a state where the laptop only preserves its RAM image, and when I 
> open the lid
> the system is back within 3 seconds. An iBook can stay this way for a week, 
> before
> the battery wears out.
> 
> Can I get this to work on this Uniwill laptop with Intel Pentium M processor
> and 82852/82855 GM/GME/PM/GMV chipset?

In theory yes, but can't tell for sure..

> Will it last just as long as the 
> iBook?

Don't know.  But I don't think this will be the case.  Maybe one or two
days.

> I am disappointed by the fact that these Intel laptops continuously spin up
> their cooling fan, this is very annoying. People I talk to seem to take this
> for granted, but The iBooks I have used to far were totally quiet, and the
> fan almost never needed to kick in. So I am trying every trick in the book
> to let it run cooler.

It's not true.  I saw the fan of my iBook going on, erm, when I wrote a
driver to control that functionality...

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
