From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: [PATCH] acpi-20030916-2.6.0-pre5.diff
Date: Thu, 18 Sep 2003 15:57:15 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030918155715.61a41697.akpm@osdl.org>
References: <20030823150219.21c951aa.akpm@osdl.org>
	<1063926206.2680.200.camel@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1063926206.2680.200.camel-Tk/TtsB/rErDOqzlkpFKJg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>
> This patch updates 2.6.0-test5 to the current ACPI in 2.4.22-pre5
> If nothing explodes, I'll be releasing it to Linus shortly via BK.

And it doesn't include this fix.




From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>

With the help of Chris Wright testing several failed patches, I've tracked
down another ACPI IRQ problem.  On many systems, the BIOS pre-allocates
IRQs for certain PCI devices, providing a list of alternate possibilities
as well.

On some systems, changing the IRQ to one of those alternate possibilities
works fine.  On others however, it really isn't a good idea.  As theres no
way to tell which systems are good and bad in advance, this patch simply
ensures that ACPI does not change an IRQ if the BIOS has pre-allocated it.



 25-akpm/drivers/acpi/pci_link.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff -puN drivers/acpi/pci_link.c~acpi-bios-preallocation-fix drivers/acpi/pci_link.c
--- 25/drivers/acpi/pci_link.c~acpi-bios-preallocation-fix	Tue Sep 16 16:17:11 2003
+++ 25-akpm/drivers/acpi/pci_link.c	Tue Sep 16 16:18:00 2003
@@ -509,15 +509,14 @@ static int acpi_pci_link_allocate(struct
 		irq = link->irq.active;
 	} else {
 		irq = link->irq.possible[0];
-	}
-
-	/*
-	 * Select the best IRQ.  This is done in reverse to promote
-	 * the use of IRQs 9, 10, 11, and >15.
-	 */
-	for (i=(link->irq.possible_count-1); i>0; i--) {
-		if (acpi_irq_penalty[irq] > acpi_irq_penalty[link->irq.possible[i]])
-			irq = link->irq.possible[i];
+		/*
+		 * Select the best IRQ.  This is done in reverse to promote
+		 * the use of IRQs 9, 10, 11, and >15.
+		 */
+		for (i=(link->irq.possible_count-1); i>0; i--) {
+			if (acpi_irq_penalty[irq] > acpi_irq_penalty[link->irq.possible[i]])
+				irq = link->irq.possible[i];
+		}
 	}
 
 	/* Attempt to enable the link device at this IRQ. */

_



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
