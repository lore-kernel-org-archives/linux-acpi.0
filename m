From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] MADT printk cleanups
Date: Tue, 25 May 2004 09:50:30 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200405250950.30717.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Here's a fairly straightforward patch to go along with the switch to
printing GSIs in decimal instead of hex.  It
	- uses "gsi" rather than "global_irq"
	- prints GSIs as %u rather than 0x%x
	- places the "polarity trigger" stuff at the end consistently
	- reorders IOSAPIC info to be consistent with IOAPIC
	- changes a couple addresses from %p to 0x%08lx for consistency

No functional change.  This is against current BK of linux-2.5.

===== drivers/acpi/tables.c 1.23 vs edited =====
--- 1.23/drivers/acpi/tables.c	2004-05-12 21:30:55 -06:00
+++ edited/drivers/acpi/tables.c	2004-05-25 09:39:47 -06:00
@@ -131,7 +131,7 @@
 	{
 		struct acpi_table_ioapic *p =
 			(struct acpi_table_ioapic*) header;
-		printk(KERN_INFO PREFIX "IOAPIC (id[0x%02x] address[0x%08x] global_irq_base[0x%x])\n",
+		printk(KERN_INFO PREFIX "IOAPIC (id[0x%02x] address[0x%08x] gsi_base[%u])\n",
 			p->id, p->address, p->global_irq_base);
 	}
 		break;
@@ -140,7 +140,7 @@
 	{
 		struct acpi_table_int_src_ovr *p =
 			(struct acpi_table_int_src_ovr*) header;
-		printk(KERN_INFO PREFIX "INT_SRC_OVR (bus %d bus_irq %d global_irq %d %s %s)\n",
+		printk(KERN_INFO PREFIX "INT_SRC_OVR (bus %d bus_irq %d gsi %u %s %s)\n",
 			p->bus, p->bus_irq, p->global_irq,
 			mps_inti_flags_polarity[p->flags.polarity],
 			mps_inti_flags_trigger[p->flags.trigger]);
@@ -155,9 +155,10 @@
 	{
 		struct acpi_table_nmi_src *p =
 			(struct acpi_table_nmi_src*) header;
-		printk(KERN_INFO PREFIX "NMI_SRC (%s %s global_irq %d)\n",
+		printk(KERN_INFO PREFIX "NMI_SRC (gsi %u %s %s)\n",
+			p->global_irq,
 			mps_inti_flags_polarity[p->flags.polarity],
-			mps_inti_flags_trigger[p->flags.trigger], p->global_irq);
+			mps_inti_flags_trigger[p->flags.trigger]);
 	}
 		break;
 
@@ -165,10 +166,10 @@
 	{
 		struct acpi_table_lapic_nmi *p =
 			(struct acpi_table_lapic_nmi*) header;
-		printk(KERN_INFO PREFIX "LAPIC_NMI (acpi_id[0x%02x] %s %s lint[0x%x])\n",
-			p->acpi_id,
+		printk(KERN_INFO PREFIX "LAPIC_NMI (acpi_id[0x%02x] lint[0x%x] %s %s)\n",
+			p->acpi_id, p->lint,
 			mps_inti_flags_polarity[p->flags.polarity],
-			mps_inti_flags_trigger[p->flags.trigger], p->lint);
+			mps_inti_flags_trigger[p->flags.trigger]);
 	}
 		break;
 
@@ -176,8 +177,8 @@
 	{
 		struct acpi_table_lapic_addr_ovr *p =
 			(struct acpi_table_lapic_addr_ovr*) header;
-		printk(KERN_INFO PREFIX "LAPIC_ADDR_OVR (address[%p])\n",
-			(void *) (unsigned long) p->address);
+		printk(KERN_INFO PREFIX "LAPIC_ADDR_OVR (address[0x%08lx])\n",
+			(unsigned long) p->address);
 	}
 		break;
 
@@ -185,8 +186,9 @@
 	{
 		struct acpi_table_iosapic *p =
 			(struct acpi_table_iosapic*) header;
-		printk(KERN_INFO PREFIX "IOSAPIC (id[0x%x] global_irq_base[0x%x] address[%p])\n",
-			p->id, p->global_irq_base, (void *) (unsigned long) p->address);
+		printk(KERN_INFO PREFIX "IOSAPIC (id[0x%x] address[0x%08lx] gsi_base[%u])\n",
+			p->id, (unsigned long) p->address,
+			p->global_irq_base);
 	}
 		break;
 
@@ -203,10 +205,10 @@
 	{
 		struct acpi_table_plat_int_src *p =
 			(struct acpi_table_plat_int_src*) header;
-		printk(KERN_INFO PREFIX "PLAT_INT_SRC (%s %s type[0x%x] id[0x%04x] eid[0x%x] iosapic_vector[0x%x] global_irq[0x%x]\n",
+		printk(KERN_INFO PREFIX "PLAT_INT_SRC (type[0x%x] id[0x%04x] eid[0x%x] iosapic_vector[0x%x] gsi[%u] %s %s)\n",
+			p->type, p->id, p->eid, p->iosapic_vector, p->global_irq,
 			mps_inti_flags_polarity[p->flags.polarity],
-			mps_inti_flags_trigger[p->flags.trigger],
-			p->type, p->id, p->eid, p->iosapic_vector, p->global_irq);
+			mps_inti_flags_trigger[p->flags.trigger]);
 	}
 		break;
 


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
