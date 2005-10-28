From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 2/9] git-acpi build fix 2
Date: Fri, 28 Oct 2005 14:59:48 -0700
Message-ID: <200510282159.j9SLxUfx021607@shell0.pdx.osdl.net>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>

More missing type->id conversions

Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 drivers/pci/hotplug/shpchprm_acpi.c |    5 +++--
 drivers/serial/8250_acpi.c          |    6 +++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff -puN drivers/pci/hotplug/shpchprm_acpi.c~git-acpi-build-fix-2 drivers/pci/hotplug/shpchprm_acpi.c
--- 25/drivers/pci/hotplug/shpchprm_acpi.c~git-acpi-build-fix-2	Fri Oct 28 14:58:24 2005
+++ 25-akpm/drivers/pci/hotplug/shpchprm_acpi.c	Fri Oct 28 14:58:24 2005
@@ -649,7 +649,7 @@ static acpi_status acpi_parse_crs(
 
 	while (!done) {
 		dbg("acpi_shpchprm: PCI bus 0x%x Resource structure %x.\n", ab->bus, count++);
-		switch (resource->id) {
+		switch (resource->type) {
 		case ACPI_RSTYPE_IRQ:
 			dbg("Irq -------- Resource\n");
 			break; 
@@ -697,7 +697,8 @@ static acpi_status acpi_parse_crs(
 			dbg("Ext Irq -------- Resource\n");
 			break; 
 		default:
-			dbg("Invalid -------- resource type 0x%x\n", resource->id);
+			dbg("Invalid -------- resource type 0x%x\n",
+					resource->type);
 			break;
 		}
 
diff -puN drivers/serial/8250_acpi.c~git-acpi-build-fix-2 drivers/serial/8250_acpi.c
--- 25/drivers/serial/8250_acpi.c~git-acpi-build-fix-2	Fri Oct 28 14:58:24 2005
+++ 25-akpm/drivers/serial/8250_acpi.c	Fri Oct 28 14:58:24 2005
@@ -83,11 +83,11 @@ static acpi_status acpi_serial_resource(
 	status = acpi_resource_to_address64(res, &addr);
 	if (ACPI_SUCCESS(status))
 		return acpi_serial_mmio(port, &addr);
-	else if (res->id == ACPI_RSTYPE_IO)
+	else if (res->type == ACPI_RSTYPE_IO)
 		return acpi_serial_port(port, &res->data.io);
-	else if (res->id == ACPI_RSTYPE_EXT_IRQ)
+	else if (res->type == ACPI_RSTYPE_EXT_IRQ)
 		return acpi_serial_ext_irq(port, &res->data.extended_irq);
-	else if (res->id == ACPI_RSTYPE_IRQ)
+	else if (res->type == ACPI_RSTYPE_IRQ)
 		return acpi_serial_irq(port, &res->data.irq);
 	return AE_OK;
 }
_


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
