From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: [PATCH 3/5] processor: always demote to next lower state
Date: Thu, 23 Dec 2004 15:07:47 +0100
Message-ID: <20041223140747.GC7973@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Let C4 demote to C3, not directly to C2.

Signed-off-by: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
---

 drivers/acpi/processor_idle.c |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)

Index: linux-2.6.10-rc3+bk-acpi/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.10-rc3+bk-acpi.orig/drivers/acpi/processor_idle.c	2004-12-23 14:25:23.854099002 +0100
+++ linux-2.6.10-rc3+bk-acpi/drivers/acpi/processor_idle.c	2004-12-23 14:25:28.737417644 +0100
@@ -425,10 +425,7 @@
 				cx->demotion.threshold.bm = 0x0F;
 		}
 
-		/* from C3 we always demote to C2, even if there are multiple
-		 * states of type C3 available. */
-		if (cx->type < ACPI_STATE_C3)
-			lower = cx;
+		lower = cx;
 	}
 
 	/* promotion */


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
