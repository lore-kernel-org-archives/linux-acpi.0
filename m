From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 03/12] acpi_register_gsi(): change hpet driver
Date: Sat, 30 Jul 2005 01:17:30 -0700
Message-ID: <200507300818.j6U8ITT8017300@shell0.pdx.osdl.net>
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
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: akpm-3NddpPZAyC0@public.gmane.org, kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


From: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>

This patch adds the error check of acpi_register_gsi() into hpet driver.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Cc: <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 drivers/char/hpet.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff -puN drivers/char/hpet.c~acpi_register_gsi-change-hpet-driver drivers/char/hpet.c
--- devel/drivers/char/hpet.c~acpi_register_gsi-change-hpet-driver	2005-07-28 11:42:13.000000000 -0700
+++ devel-akpm/drivers/char/hpet.c	2005-07-28 11:42:13.000000000 -0700
@@ -906,11 +906,15 @@ static acpi_status hpet_resources(struct
 		if (irqp->number_of_interrupts > 0) {
 			hdp->hd_nirqs = irqp->number_of_interrupts;
 
-			for (i = 0; i < hdp->hd_nirqs; i++)
-				hdp->hd_irq[i] =
+			for (i = 0; i < hdp->hd_nirqs; i++) {
+				int rc =
 				    acpi_register_gsi(irqp->interrupts[i],
 						      irqp->edge_level,
 						      irqp->active_high_low);
+				if (rc < 0)
+					return AE_ERROR;
+				hdp->hd_irq[i] = rc;
+			}
 		}
 	}
 
_


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
