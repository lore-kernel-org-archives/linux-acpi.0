From: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
Subject: [2.6 patch] drivers/pnp/pnpacpi/rsparser.c: fix an array overflow
Date: Sun, 27 Mar 2005 22:33:31 +0200
Message-ID: <20050327203331.GT4285@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Matthieu Castet <castet.matthieu-GANU6spQydw@public.gmane.org>, Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This patch fixes an array overflow found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>

--- linux-2.6.12-rc1-mm1-full/drivers/pnp/pnpacpi/rsparser.c.old	2005-03-23 02:58:31.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/pnp/pnpacpi/rsparser.c	2005-03-23 03:02:49.000000000 +0100
@@ -94,8 +94,8 @@
 pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table * res, int dma)
 {
 	int i = 0;
-	while (!(res->dma_resource[i].flags & IORESOURCE_UNSET) &&
-			i < PNP_MAX_DMA)
+	while (i < PNP_MAX_DMA &&
+			!(res->dma_resource[i].flags & IORESOURCE_UNSET))
 		i++;
 	if (i < PNP_MAX_DMA) {
 		res->dma_resource[i].flags = IORESOURCE_DMA;  // Also clears _UNSET flag



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
