From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [Update][PATCH v5 5/5] ACPI: Replace printk with pr_* in tables.c
Date: Thu, 20 Feb 2014 15:45:33 +0800
Message-ID: <1392882333-17146-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:35137 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703AbaBTHp6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Feb 2014 02:45:58 -0500
Received: by mail-pb0-f53.google.com with SMTP id md12so1552105pbc.12
        for <linux-acpi@vger.kernel.org>; Wed, 19 Feb 2014 23:45:58 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <Sudeep.Holla@arm.com>, Joe Perches <joe@perches.com>, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

This patch just do some clean up to replace printk with pr_*,
and introduces pr_fmt() to remove all PREFIXs in this file,
no functional change.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---

Hi Rafael,

I introduced pr_fmt() as Sudeep suggested, and remove all PREFIXs
in this file, hope this patch is ok to you.

Thanks
Hanjun
---
 drivers/acpi/tables.c |  128 +++++++++++++++++++++----------------------------
 1 file changed, 55 insertions(+), 73 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 5837f85..2178229 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -23,6 +23,8 @@
  *
  */
 
+#define pr_fmt(fmt) "ACPI: " fmt
+
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/smp.h>
@@ -33,8 +35,6 @@
 #include <linux/acpi.h>
 #include <linux/bootmem.h>
 
-#define PREFIX			"ACPI: "
-
 #define ACPI_MAX_TABLES		128
 
 static char *mps_inti_flags_polarity[] = { "dfl", "high", "res", "low" };
@@ -55,10 +55,9 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		{
 			struct acpi_madt_local_apic *p =
 			    (struct acpi_madt_local_apic *)header;
-			printk(KERN_INFO PREFIX
-			       "LAPIC (acpi_id[0x%02x] lapic_id[0x%02x] %s)\n",
-			       p->processor_id, p->id,
-			       (p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
+			pr_info("LAPIC (acpi_id[0x%02x] lapic_id[0x%02x] %s)\n",
+				p->processor_id, p->id,
+				(p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
 		}
 		break;
 
@@ -66,11 +65,9 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		{
 			struct acpi_madt_local_x2apic *p =
 			    (struct acpi_madt_local_x2apic *)header;
-			printk(KERN_INFO PREFIX
-			       "X2APIC (apic_id[0x%02x] uid[0x%02x] %s)\n",
-			       p->local_apic_id, p->uid,
-			       (p->lapic_flags & ACPI_MADT_ENABLED) ?
-			       "enabled" : "disabled");
+			pr_info("X2APIC (apic_id[0x%02x] uid[0x%02x] %s)\n",
+				p->local_apic_id, p->uid,
+				(p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
 		}
 		break;
 
@@ -78,9 +75,8 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		{
 			struct acpi_madt_io_apic *p =
 			    (struct acpi_madt_io_apic *)header;
-			printk(KERN_INFO PREFIX
-			       "IOAPIC (id[0x%02x] address[0x%08x] gsi_base[%d])\n",
-			       p->id, p->address, p->global_irq_base);
+			pr_info("IOAPIC (id[0x%02x] address[0x%08x] gsi_base[%d])\n",
+				p->id, p->address, p->global_irq_base);
 		}
 		break;
 
@@ -88,18 +84,15 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		{
 			struct acpi_madt_interrupt_override *p =
 			    (struct acpi_madt_interrupt_override *)header;
-			printk(KERN_INFO PREFIX
-			       "INT_SRC_OVR (bus %d bus_irq %d global_irq %d %s %s)\n",
-			       p->bus, p->source_irq, p->global_irq,
-			       mps_inti_flags_polarity[p->inti_flags & ACPI_MADT_POLARITY_MASK],
-			       mps_inti_flags_trigger[(p->inti_flags & ACPI_MADT_TRIGGER_MASK) >> 2]);
+			pr_info("INT_SRC_OVR (bus %d bus_irq %d global_irq %d %s %s)\n",
+				p->bus, p->source_irq, p->global_irq,
+				mps_inti_flags_polarity[p->inti_flags & ACPI_MADT_POLARITY_MASK],
+				mps_inti_flags_trigger[(p->inti_flags & ACPI_MADT_TRIGGER_MASK) >> 2]);
 			if (p->inti_flags  &
 			    ~(ACPI_MADT_POLARITY_MASK | ACPI_MADT_TRIGGER_MASK))
-				printk(KERN_INFO PREFIX
-				       "INT_SRC_OVR unexpected reserved flags: 0x%x\n",
-				       p->inti_flags  &
+				pr_info("INT_SRC_OVR unexpected reserved flags: 0x%x\n",
+					p->inti_flags  &
 					~(ACPI_MADT_POLARITY_MASK | ACPI_MADT_TRIGGER_MASK));
-
 		}
 		break;
 
@@ -107,11 +100,10 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		{
 			struct acpi_madt_nmi_source *p =
 			    (struct acpi_madt_nmi_source *)header;
-			printk(KERN_INFO PREFIX
-			       "NMI_SRC (%s %s global_irq %d)\n",
-			       mps_inti_flags_polarity[p->inti_flags & ACPI_MADT_POLARITY_MASK],
-			       mps_inti_flags_trigger[(p->inti_flags & ACPI_MADT_TRIGGER_MASK) >> 2],
-			       p->global_irq);
+			pr_info("NMI_SRC (%s %s global_irq %d)\n",
+				mps_inti_flags_polarity[p->inti_flags & ACPI_MADT_POLARITY_MASK],
+				mps_inti_flags_trigger[(p->inti_flags & ACPI_MADT_TRIGGER_MASK) >> 2],
+				p->global_irq);
 		}
 		break;
 
@@ -119,12 +111,11 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		{
 			struct acpi_madt_local_apic_nmi *p =
 			    (struct acpi_madt_local_apic_nmi *)header;
-			printk(KERN_INFO PREFIX
-			       "LAPIC_NMI (acpi_id[0x%02x] %s %s lint[0x%x])\n",
-			       p->processor_id,
-			       mps_inti_flags_polarity[p->inti_flags & ACPI_MADT_POLARITY_MASK	],
-			       mps_inti_flags_trigger[(p->inti_flags & ACPI_MADT_TRIGGER_MASK) >> 2],
-			       p->lint);
+			pr_info("LAPIC_NMI (acpi_id[0x%02x] %s %s lint[0x%x])\n",
+				p->processor_id,
+				mps_inti_flags_polarity[p->inti_flags & ACPI_MADT_POLARITY_MASK	],
+				mps_inti_flags_trigger[(p->inti_flags & ACPI_MADT_TRIGGER_MASK) >> 2],
+				p->lint);
 		}
 		break;
 
@@ -137,12 +128,11 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 			polarity = p->inti_flags & ACPI_MADT_POLARITY_MASK;
 			trigger = (p->inti_flags & ACPI_MADT_TRIGGER_MASK) >> 2;
 
-			printk(KERN_INFO PREFIX
-			       "X2APIC_NMI (uid[0x%02x] %s %s lint[0x%x])\n",
-			       p->uid,
-			       mps_inti_flags_polarity[polarity],
-			       mps_inti_flags_trigger[trigger],
-			       p->lint);
+			pr_info("X2APIC_NMI (uid[0x%02x] %s %s lint[0x%x])\n",
+				p->uid,
+				mps_inti_flags_polarity[polarity],
+				mps_inti_flags_trigger[trigger],
+				p->lint);
 		}
 		break;
 
@@ -150,9 +140,8 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		{
 			struct acpi_madt_local_apic_override *p =
 			    (struct acpi_madt_local_apic_override *)header;
-			printk(KERN_INFO PREFIX
-			       "LAPIC_ADDR_OVR (address[%p])\n",
-			       (void *)(unsigned long)p->address);
+			pr_info("LAPIC_ADDR_OVR (address[%p])\n",
+				(void *)(unsigned long)p->address);
 		}
 		break;
 
@@ -160,10 +149,9 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		{
 			struct acpi_madt_io_sapic *p =
 			    (struct acpi_madt_io_sapic *)header;
-			printk(KERN_INFO PREFIX
-			       "IOSAPIC (id[0x%x] address[%p] gsi_base[%d])\n",
-			       p->id, (void *)(unsigned long)p->address,
-			       p->global_irq_base);
+			pr_info("IOSAPIC (id[0x%x] address[%p] gsi_base[%d])\n",
+				p->id, (void *)(unsigned long)p->address,
+				p->global_irq_base);
 		}
 		break;
 
@@ -171,10 +159,9 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		{
 			struct acpi_madt_local_sapic *p =
 			    (struct acpi_madt_local_sapic *)header;
-			printk(KERN_INFO PREFIX
-			       "LSAPIC (acpi_id[0x%02x] lsapic_id[0x%02x] lsapic_eid[0x%02x] %s)\n",
-			       p->processor_id, p->id, p->eid,
-			       (p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
+			pr_info("LSAPIC (acpi_id[0x%02x] lsapic_id[0x%02x] lsapic_eid[0x%02x] %s)\n",
+				p->processor_id, p->id, p->eid,
+				(p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
 		}
 		break;
 
@@ -182,19 +169,17 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		{
 			struct acpi_madt_interrupt_source *p =
 			    (struct acpi_madt_interrupt_source *)header;
-			printk(KERN_INFO PREFIX
-			       "PLAT_INT_SRC (%s %s type[0x%x] id[0x%04x] eid[0x%x] iosapic_vector[0x%x] global_irq[0x%x]\n",
-			       mps_inti_flags_polarity[p->inti_flags & ACPI_MADT_POLARITY_MASK],
-			       mps_inti_flags_trigger[(p->inti_flags & ACPI_MADT_TRIGGER_MASK) >> 2],
-			       p->type, p->id, p->eid, p->io_sapic_vector,
-			       p->global_irq);
+			pr_info("PLAT_INT_SRC (%s %s type[0x%x] id[0x%04x] eid[0x%x] iosapic_vector[0x%x] global_irq[0x%x]\n",
+				mps_inti_flags_polarity[p->inti_flags & ACPI_MADT_POLARITY_MASK],
+				mps_inti_flags_trigger[(p->inti_flags & ACPI_MADT_TRIGGER_MASK) >> 2],
+				p->type, p->id, p->eid, p->io_sapic_vector,
+				p->global_irq);
 		}
 		break;
 
 	default:
-		printk(KERN_WARNING PREFIX
-		       "Found unsupported MADT entry (type = 0x%x)\n",
-		       header->type);
+		pr_warn("Found unsupported MADT entry (type = 0x%x)\n",
+			header->type);
 		break;
 	}
 }
@@ -225,7 +210,7 @@ acpi_table_parse_entries(char *id,
 		acpi_get_table_with_size(id, 0, &table_header, &tbl_size);
 
 	if (!table_header) {
-		printk(KERN_WARNING PREFIX "%4.4s not present\n", id);
+		pr_warn("%4.4s not present\n", id);
 		return -ENODEV;
 	}
 
@@ -248,7 +233,7 @@ acpi_table_parse_entries(char *id,
 		 * infinite loop.
 		 */
 		if (entry->length == 0) {
-			pr_err(PREFIX "[%4.4s:0x%02x] Invalid zero length\n", id, entry_id);
+			pr_err("[%4.4s:0x%02x] Invalid zero length\n", id, entry_id);
 			goto err;
 		}
 
@@ -256,8 +241,8 @@ acpi_table_parse_entries(char *id,
 		    ((unsigned long)entry + entry->length);
 	}
 	if (max_entries && count > max_entries) {
-		printk(KERN_WARNING PREFIX "[%4.4s:0x%02x] ignored %i entries of "
-		       "%i found\n", id, entry_id, count - max_entries, count);
+		pr_warn("[%4.4s:0x%02x] ignored %i entries of %i found\n",
+			id, entry_id, count - max_entries, count);
 	}
 
 	early_acpi_os_unmap_memory((char *)table_header, tbl_size);
@@ -322,13 +307,11 @@ static void __init check_multiple_madt(void)
 
 	acpi_get_table_with_size(ACPI_SIG_MADT, 2, &table, &tbl_size);
 	if (table) {
-		printk(KERN_WARNING PREFIX
-		       "BIOS bug: multiple APIC/MADT found,"
-		       " using %d\n", acpi_apic_instance);
-		printk(KERN_WARNING PREFIX
-		       "If \"acpi_apic_instance=%d\" works better, "
-		       "notify linux-acpi@vger.kernel.org\n",
-		       acpi_apic_instance ? 0 : 2);
+		pr_warn("BIOS bug: multiple APIC/MADT found, using %d\n",
+			acpi_apic_instance);
+		pr_warn("If \"acpi_apic_instance=%d\" works better, "
+			"notify linux-acpi@vger.kernel.org\n",
+			acpi_apic_instance ? 0 : 2);
 		early_acpi_os_unmap_memory(table, tbl_size);
 
 	} else
@@ -365,8 +348,7 @@ static int __init acpi_parse_apic_instance(char *str)
 
 	acpi_apic_instance = simple_strtoul(str, NULL, 0);
 
-	printk(KERN_NOTICE PREFIX "Shall use APIC/MADT table %d\n",
-	       acpi_apic_instance);
+	pr_notice("Shall use APIC/MADT table %d\n", acpi_apic_instance);
 
 	return 0;
 }
-- 
1.7.9.5

