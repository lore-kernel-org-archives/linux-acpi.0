From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 1/9] git-acpi: pciehprm_acpi fix
Date: Fri, 28 Oct 2005 14:59:48 -0700
Message-ID: <200510282159.j9SLxURr021604@shell0.pdx.osdl.net>
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

drivers/pci/hotplug/pciehprm_acpi.c: In function `acpi_parse_crs':              drivers/pci/hotplug/pciehprm_acpi.c:668: error: structure has no member named `id'
drivers/pci/hotplug/pciehprm_acpi.c:716: error: structure has no member named `id'

Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 drivers/pci/hotplug/pciehprm_acpi.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -puN drivers/pci/hotplug/pciehprm_acpi.c~git-acpi-pciehprm_acpi-fix drivers/pci/hotplug/pciehprm_acpi.c
--- 25/drivers/pci/hotplug/pciehprm_acpi.c~git-acpi-pciehprm_acpi-fix	Fri Oct 28 14:58:23 2005
+++ 25-akpm/drivers/pci/hotplug/pciehprm_acpi.c	Fri Oct 28 14:58:23 2005
@@ -665,7 +665,7 @@ static acpi_status acpi_parse_crs(
 
 	while (!done) {
 		dbg("acpi_pciehprm: PCI bus 0x%x Resource structure %x.\n", ab->bus, count++);
-		switch (resource->id) {
+		switch (resource->type) {
 		case ACPI_RSTYPE_IRQ:
 			dbg("Irq -------- Resource\n");
 			break; 
@@ -713,7 +713,8 @@ static acpi_status acpi_parse_crs(
 			dbg("Ext Irq -------- Resource\n");
 			break; 
 		default:
-			dbg("Invalid -------- resource type 0x%x\n", resource->id);
+			dbg("Invalid -------- resource type 0x%x\n",
+					resource->type);
 			break;
 		}
 
_


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
