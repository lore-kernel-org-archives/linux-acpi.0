From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 05/12] acpi_register_gsi(): change acpi based 8250 driver
Date: Sat, 30 Jul 2005 01:17:31 -0700
Message-ID: <200507300818.j6U8IVEu017306@shell0.pdx.osdl.net>
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

This patch adds the error check of acpi_register_gsi() into ACPI based 8250
serial driver.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Cc: <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 drivers/serial/8250_acpi.c |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff -puN drivers/serial/8250_acpi.c~acpi_register_gsi-change-acpi-based-8250-driver drivers/serial/8250_acpi.c
--- devel/drivers/serial/8250_acpi.c~acpi_register_gsi-change-acpi-based-8250-driver	2005-07-28 11:42:17.000000000 -0700
+++ devel-akpm/drivers/serial/8250_acpi.c	2005-07-28 11:42:17.000000000 -0700
@@ -47,18 +47,30 @@ static acpi_status acpi_serial_port(stru
 static acpi_status acpi_serial_ext_irq(struct uart_port *port,
 				       struct acpi_resource_ext_irq *ext_irq)
 {
-	if (ext_irq->number_of_interrupts > 0)
-		port->irq = acpi_register_gsi(ext_irq->interrupts[0],
+	int rc;
+
+	if (ext_irq->number_of_interrupts > 0) {
+		rc = acpi_register_gsi(ext_irq->interrupts[0],
 	                   ext_irq->edge_level, ext_irq->active_high_low);
+		if (rc < 0)
+			return AE_ERROR;
+		port->irq = rc;
+	}
 	return AE_OK;
 }
 
 static acpi_status acpi_serial_irq(struct uart_port *port,
 				   struct acpi_resource_irq *irq)
 {
-	if (irq->number_of_interrupts > 0)
-		port->irq = acpi_register_gsi(irq->interrupts[0],
+	int rc;
+
+	if (irq->number_of_interrupts > 0) {
+		rc = acpi_register_gsi(irq->interrupts[0],
 	                   irq->edge_level, irq->active_high_low);
+		if (rc < 0)
+			return AE_ERROR;
+		port->irq = rc;
+	}
 	return AE_OK;
 }
 
_


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
