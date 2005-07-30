From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 04/12] acpi_register_gsi(): change phpacpi driver
Date: Sat, 30 Jul 2005 01:17:31 -0700
Message-ID: <200507300818.j6U8IUlt017303@shell0.pdx.osdl.net>
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

This patch adds the error check of acpi_register_gsi() into pnpacpi driver.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Cc: <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 drivers/pnp/pnpacpi/rsparser.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/pnp/pnpacpi/rsparser.c~acpi_register_gsi-change-phpacpi-driver drivers/pnp/pnpacpi/rsparser.c
--- devel/drivers/pnp/pnpacpi/rsparser.c~acpi_register_gsi-change-phpacpi-driver	2005-07-28 11:42:15.000000000 -0700
+++ devel-akpm/drivers/pnp/pnpacpi/rsparser.c	2005-07-28 11:42:15.000000000 -0700
@@ -81,7 +81,7 @@ pnpacpi_parse_allocated_irqresource(stru
 		i++;
 	if (i < PNP_MAX_IRQ) {
 		res->irq_resource[i].flags = IORESOURCE_IRQ;  //Also clears _UNSET flag
-		if (irq == -1) {
+		if (irq < 0) {
 			res->irq_resource[i].flags |= IORESOURCE_DISABLED;
 			return;
 		}
_


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
