From: Chris McDermott <lcm-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2.6] ia64 support for PCI link devices
Date: Mon, 5 Apr 2004 18:45:53 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040406014553.GV7695@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: bjorn.helgaas-VXdhtT5mjnY@public.gmane.org, davidm-sDzT885Ts8HQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


This patch enables correct enablement of interrupts described by
PCI link device entries in the DSDT.

The current ia64 implementation ignores link entries and therefore
prevents such interrupts from being configured correctly.

Comments?

thanks,
-- 
Chris McDermott


--- orig/arch/ia64/kernel/iosapic.c	2004-03-31 16:19:20.000000000 -0800
+++ new/arch/ia64/kernel/iosapic.c	2004-04-05 10:29:11.668281924 -0700
@@ -688,15 +688,23 @@ iosapic_parse_prt (void)
 	char pci_id[16];
 	struct hw_interrupt_type *irq_type = &irq_type_iosapic_level;
 	irq_desc_t *idesc;
+	int trigger = IOSAPIC_LEVEL;
+	int polarity = IOSAPIC_POL_LOW;
 
 	list_for_each(node, &acpi_prt.entries) {
 		entry = list_entry(node, struct acpi_prt_entry, node);
 
-		/* We're only interested in static (non-link) entries.  */
-		if (entry->link.handle)
-			continue;
+		/* Check for dynamic (PCI link) entry. */
+		if (entry->link.handle) {
+			gsi = acpi_pci_link_get_irq(entry->link.handle, entry->link.index, &trigger, &polarity);
+			if (!gsi)
+				continue;
 
-		gsi = entry->link.index;
+			if (trigger == IOSAPIC_EDGE)
+				irq_type = &irq_type_iosapic_edge;
+		} else {
+			gsi = entry->link.index;
+		}
 
 		vector = gsi_to_vector(gsi);
 		if (vector < 0) {
@@ -710,8 +718,12 @@ iosapic_parse_prt (void)
 				/* new GSI; allocate a vector for it */
 				vector = ia64_alloc_vector();
 
-			register_intr(gsi, vector, IOSAPIC_LOWEST_PRIORITY, IOSAPIC_POL_LOW,
-				      IOSAPIC_LEVEL);
+			if (entry->link.handle)
+				register_intr(gsi, vector, IOSAPIC_LOWEST_PRIORITY, polarity,
+					      trigger);
+			else
+				register_intr(gsi, vector, IOSAPIC_LOWEST_PRIORITY, IOSAPIC_POL_LOW,
+					      IOSAPIC_LEVEL);
 		}
 		entry->irq = vector;
 		snprintf(pci_id, sizeof(pci_id), "%02x:%02x:%02x[%c]",
@@ -723,8 +735,8 @@ iosapic_parse_prt (void)
 		 */
 		idesc = irq_descp(vector);
 		if (idesc->handler != irq_type)
-			register_intr(gsi, vector, IOSAPIC_LOWEST_PRIORITY, IOSAPIC_POL_LOW,
-				      IOSAPIC_LEVEL);
+			register_intr(gsi, vector, IOSAPIC_LOWEST_PRIORITY, polarity,
+				      trigger);
 
 	}
 }


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
