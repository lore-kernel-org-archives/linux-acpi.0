From: "KOCHI, Takayoshi" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>
Subject: Re: [Discontig-devel] RE: Cleanup of NUMA support in ACPI
Date: Wed, 14 Aug 2002 17:21:19 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020815092003.JBWFC0A82650.6C9EC293@mvf.biglobe.ne.jp>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DD8B@orsmsx119.jf.intel.com> <20020815032846.DAESC0A82654.59A07363@mvf.biglobe.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020815032846.DAESC0A82654.59A07363-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, discontig-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Andy,

> > There are a bunch of other ACPI config options that should be split out like
> > this as well, so if you don't want to redo the patch, I'll just take it and
> > it can get fixed in a sweep with the others, later.
> 
> Erich has worked to clean up some portions and sent to LKML.
> I'll split ACPI part from the patch and send to you this afternoon.

Here's the patch.
This is generated against 2.5.30 kernel's driver.
For 2.4.18 + 20020725, I saw faiures against Config.in and Makefile...
perhaps it's easy to merge.


For discontig/numa developers:

If this is applied, both i386 and ia64 have to provide their own
functions in architecture-dependent numa support (only when CONFIG_NUMA and
CONFIG_ACPI_NUMA are both Y):

void __init acpi_numa_slit_init (struct acpi_table_slit *slit);
void __init acpi_numa_processor_affinity_init (struct acpi_table_processor_affinity *pa);
void __init acpi_numa_memory_affinity_init (struct acpi_table_memory_affinity *ma);
void __init acpi_numa_arch_fixup(void);

Also, acpi_numa_init() has to be called in very early stage of
initialization of architecture-dependent setup routine
so that you can use the SRAT/SLIT information for constructing
numa-related structures.

--- linux-2.5.30-orig/drivers/acpi/Config.in	Thu Aug  1 14:16:34 2002
+++ linux-2.5.30-numa/drivers/acpi/Config.in	Wed Aug 14 17:00:37 2002
@@ -31,6 +31,9 @@
       tristate     '  Fan'		CONFIG_ACPI_FAN
       tristate     '  Processor'	CONFIG_ACPI_PROCESSOR
       dep_tristate '  Thermal Zone' 	CONFIG_ACPI_THERMAL $CONFIG_ACPI_PROCESSOR
+      if [ "$CONFIG_NUMA" = "y" ]; then
+        bool       '  NUMA support'     CONFIG_ACPI_NUMA $CONFIG_NUMA
+      fi
       tristate     '  Toshiba Laptop Extras'	CONFIG_ACPI_TOSHIBA
       bool         '  Debug Statements'	CONFIG_ACPI_DEBUG
     fi
@@ -58,6 +61,7 @@
     define_bool CONFIG_ACPI_FAN		n
     define_bool CONFIG_ACPI_PROCESSOR	n
     define_bool CONFIG_ACPI_THERMAL	n
+    define_bool CONFIG_ACPI_NUMA	y
     endmenu
   fi
 
@@ -77,7 +81,10 @@
     tristate     '  Button'		CONFIG_ACPI_BUTTON
     tristate     '  Fan'		CONFIG_ACPI_FAN
     tristate     '  Processor'		CONFIG_ACPI_PROCESSOR
-    dep_tristate '  Thermal Zone' CONFIG_ACPI_THERMAL $CONFIG_ACPI_PROCESSOR
+    dep_tristate '  Thermal Zone'       CONFIG_ACPI_THERMAL $CONFIG_ACPI_PROCESSOR
+    if [ "$CONFIG_NUMA" = "y" ]; then
+      bool       '  NUMA support'       CONFIG_ACPI_NUMA $CONFIG_NUMA
+    fi
     bool         '  Debug Statements' 	CONFIG_ACPI_DEBUG
     endmenu
   fi
--- linux-2.5.30-orig/drivers/acpi/Makefile	Thu Aug  1 14:16:40 2002
+++ linux-2.5.30-numa/drivers/acpi/Makefile	Wed Aug 14 16:27:15 2002
@@ -43,6 +43,7 @@
 obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
 obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
 obj-$(CONFIG_ACPI_SYSTEM)	+= system.o
+obj-$(CONFIG_ACPI_NUMA)		+= numa.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
 
 include $(TOPDIR)/Rules.make
--- linux-2.5.30-orig/drivers/acpi/tables.c	Thu Aug  1 14:16:21 2002
+++ linux-2.5.30-numa/drivers/acpi/tables.c	Wed Aug 14 16:36:26 2002
@@ -224,11 +224,13 @@
 
 
 int __init
-acpi_table_parse_madt (
+acpi_table_parse_madt_family (
 	enum acpi_table_id	id,
+	unsigned long		madt_size,
+	int			entry_id,
 	acpi_madt_entry_handler	handler)
 {
-	struct acpi_table_madt	*madt = NULL;
+	void			*madt = NULL;
 	acpi_table_entry_header	*entry = NULL;
 	unsigned long		count = 0;
 	unsigned long		madt_end = 0;
@@ -240,19 +242,21 @@
 	/* Locate the MADT (if exists). There should only be one. */
 
 	for (i = 0; i < sdt.count; i++) {
-		if (sdt.entry[i].id != ACPI_APIC)
+		if (sdt.entry[i].id != id)
 			continue;
-		madt = (struct acpi_table_madt *)
+		madt = (void *)
 			__acpi_map_table(sdt.entry[i].pa, sdt.entry[i].size);
 		if (!madt) {
-			printk(KERN_WARNING PREFIX "Unable to map MADT\n");
+			printk(KERN_WARNING PREFIX "Unable to map %s\n",
+			       acpi_table_signatures[id]);
 			return -ENODEV;
 		}
 		break;
 	}
 
 	if (!madt) {
-		printk(KERN_WARNING PREFIX "MADT not present\n");
+		printk(KERN_WARNING PREFIX "%s not present\n",
+		       acpi_table_signatures[id]);
 		return -ENODEV;
 	}
 
@@ -261,10 +265,10 @@
 	/* Parse all entries looking for a match. */
 
 	entry = (acpi_table_entry_header *)
-		((unsigned long) madt + sizeof(struct acpi_table_madt));
+		((unsigned long) madt + madt_size);
 
 	while (((unsigned long) entry) < madt_end) {
-		if (entry->type == id) {
+		if (entry->type == entry_id) {
 			count++;
 			handler(entry);
 		}
@@ -276,6 +280,16 @@
 }
 
 
+int __init
+acpi_table_parse_madt (
+	enum acpi_madt_entry_id	id,
+	acpi_madt_entry_handler	handler)
+{
+	return acpi_table_parse_madt_family(ACPI_APIC, sizeof(struct acpi_table_madt),
+					    id, handler);
+}
+
+
 int __init
 acpi_table_parse (
 	enum acpi_table_id	id,
--- linux-2.5.30-orig/drivers/acpi/numa.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.30-numa/drivers/acpi/numa.c	Wed Aug 14 17:02:02 2002
@@ -0,0 +1,187 @@
+/*
+ *  acpi_numa.c - ACPI NUMA support
+ *
+ *  Copyright (C) 2002 Takayoshi Kochi <t-kouchi-f7IHDacdhdx8UrSeD/g0lQ@public.gmane.org>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/acpi.h>
+
+#define PREFIX			"ACPI: "
+
+extern int __init acpi_table_parse_madt_family (enum acpi_table_id id, unsigned long madt_size, int entry_id, acpi_madt_entry_handler handler);
+
+void __init
+acpi_table_print_srat_entry (
+	acpi_table_entry_header	*header)
+{
+	if (!header)
+		return;
+
+	switch (header->type) {
+
+	case ACPI_SRAT_PROCESSOR_AFFINITY:
+	{
+		struct acpi_table_processor_affinity *p =
+			(struct acpi_table_processor_affinity*) header;
+		printk(KERN_INFO PREFIX "SRAT Processor (id[0x%02x] eid[0x%02x]) in proximity domain %d %s\n",
+		       p->apic_id, p->lsapic_eid, p->proximity_domain,
+		       p->flags.enabled?"enabled":"disabled");
+	}
+		break;
+
+	case ACPI_SRAT_MEMORY_AFFINITY:
+	{
+		struct acpi_table_memory_affinity *p =
+			(struct acpi_table_memory_affinity*) header;
+		printk(KERN_INFO PREFIX "SRAT Memory (0x%08x%08x length 0x%08x%08x type 0x%x) in proximity domain %d %s%s\n",
+		       p->base_addr_hi, p->base_addr_lo, p->length_hi, p->length_lo,
+		       p->memory_type, p->proximity_domain,
+		       p->flags.enabled ? "enabled" : "disabled",
+		       p->flags.hot_pluggable ? " hot-pluggable" : "");
+	}
+		break;
+
+	default:
+		printk(KERN_WARNING PREFIX "Found unsupported SRAT entry (type = 0x%x)\n",
+			header->type);
+		break;
+	}
+}
+
+
+static int __init
+acpi_parse_slit (unsigned long phys_addr, unsigned long size)
+{
+	struct acpi_table_slit	*slit;
+	u32			localities;
+
+	if (!phys_addr || !size)
+		return -EINVAL;
+
+	slit = (struct acpi_table_slit *) __va(phys_addr);
+
+	/* downcast just for %llu vs %lu for i386/ia64  */
+	localities = (u32) slit->localities;
+
+	printk(KERN_INFO PREFIX "SLIT localities %ux%u\n", localities, localities);
+
+	acpi_numa_slit_init(slit);
+
+	return 0;
+}
+
+
+static int __init
+acpi_parse_processor_affinity (acpi_table_entry_header *header)
+{
+	struct acpi_table_processor_affinity *processor_affinity = NULL;
+
+	processor_affinity = (struct acpi_table_processor_affinity*) header;
+	if (!processor_affinity)
+		return -EINVAL;
+
+	acpi_table_print_srat_entry(header);
+
+	/* let architecture-dependent part to do it */
+	acpi_numa_processor_affinity_init(processor_affinity);
+
+	return 0;
+}
+
+
+static int __init
+acpi_parse_memory_affinity (acpi_table_entry_header *header)
+{
+	struct acpi_table_memory_affinity *memory_affinity = NULL;
+
+	memory_affinity = (struct acpi_table_memory_affinity*) header;
+	if (!memory_affinity)
+		return -EINVAL;
+
+	acpi_table_print_srat_entry(header);
+
+	/* let architecture-dependent part to do it */
+	acpi_numa_memory_affinity_init(memory_affinity);
+
+	return 0;
+}
+
+
+static int __init
+acpi_parse_srat (unsigned long phys_addr, unsigned long size)
+{
+	struct acpi_table_srat	*srat = NULL;
+
+	if (!phys_addr || !size)
+		return -EINVAL;
+
+	srat = (struct acpi_table_srat *) __va(phys_addr);
+
+	printk(KERN_INFO PREFIX "SRAT revision %d\n", srat->table_revision);
+
+	return 0;
+}
+
+
+int __init
+acpi_table_parse_srat (
+	enum acpi_srat_entry_id	id,
+	acpi_madt_entry_handler	handler)
+{
+	return acpi_table_parse_madt_family(ACPI_SRAT, sizeof(struct acpi_table_srat),
+					    id, handler);
+}
+
+
+int __init
+acpi_numa_init()
+{
+	int			result;
+
+	/* SRAT: Static Resource Affinity Table */
+	result = acpi_table_parse(ACPI_SRAT, acpi_parse_srat);
+
+	if (result > 0) {
+		result = acpi_table_parse_srat(ACPI_SRAT_PROCESSOR_AFFINITY,
+					       acpi_parse_processor_affinity);
+		result = acpi_table_parse_srat(ACPI_SRAT_MEMORY_AFFINITY,
+					       acpi_parse_memory_affinity);
+	} else {
+		/* FIXME */
+		printk("Warning: acpi_table_parse(ACPI_SRAT) returned %d!\n",result);
+	}
+
+	/* SLIT: System Locality Information Table */
+	result = acpi_table_parse(ACPI_SLIT, acpi_parse_slit);
+	if (result < 1) {
+		/* FIXME */
+		printk("Warning: acpi_table_parse(ACPI_SLIT) returned %d!\n",result);
+	}
+
+	acpi_numa_arch_fixup();
+	return 0;
+}
--- linux-2.5.30-orig/include/linux/acpi.h	Thu Aug  1 14:16:01 2002
+++ linux-2.5.30-numa/include/linux/acpi.h	Wed Aug 14 16:05:05 2002
@@ -336,12 +336,21 @@
 char * __acpi_map_table (unsigned long phys_addr, unsigned long size);
 unsigned long acpi_find_rsdp (void);
 int acpi_boot_init (char *cmdline);
+int acpi_numa_init (void);
 
 int acpi_table_init (char *cmdline);
 int acpi_table_parse (enum acpi_table_id, acpi_table_handler);
-int acpi_table_parse_madt (enum acpi_table_id, acpi_madt_entry_handler);
+int acpi_table_parse_madt (enum acpi_madt_entry_id, acpi_madt_entry_handler);
+int acpi_table_parse_srat (enum acpi_srat_entry_id, acpi_madt_entry_handler);
 void acpi_table_print (struct acpi_table_header *, unsigned long);
 void acpi_table_print_madt_entry (acpi_table_entry_header *);
+void acpi_table_print_srat_entry (acpi_table_entry_header *);
+
+/* the following four functions are architecture-dependent */
+extern void __init acpi_numa_slit_init (struct acpi_table_slit *slit);
+extern void __init acpi_numa_processor_affinity_init (struct acpi_table_processor_affinity *pa);
+extern void __init acpi_numa_memory_affinity_init (struct acpi_table_memory_affinity *ma);
+extern void __init acpi_numa_arch_fixup(void);
 
 extern int acpi_mp_config;
 



Thanks,
-- 
KOCHI, Takayoshi <t-kouchi-f7IHDacdhdx8UrSeD/g0lQ@public.gmane.org/t-kouchi>



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
