From: akpm-3NddpPZAyC0@public.gmane.org
Subject: acpi_register_gsi-change-acpi-based-8250-driver.patch added to -mm tree
Date: Thu, 28 Jul 2005 11:42:18 -0700
Message-ID: <200507281843.j6SIhFbL012115@shell0.pdx.osdl.net>
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
To: kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mm-commits-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


The patch titled

     acpi_register_gsi(): change acpi based 8250 driver

has been added to the -mm tree.  Its filename is

     acpi_register_gsi-change-acpi-based-8250-driver.patch

Patches currently in -mm which might be from kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org are

acpi_register_gsi-change-acpi_register_gsi-interface.patch
acpi_register_gsi-change-acpi-pci-code.patch
acpi_register_gsi-change-hpet-driver.patch
acpi_register_gsi-change-phpacpi-driver.patch
acpi_register_gsi-change-acpi-based-8250-driver.patch
acpi_register_gsi-change-ia64-iosapic-code.patch



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
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
