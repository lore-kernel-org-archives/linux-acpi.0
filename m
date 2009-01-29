From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: state of some x86 acpi patches
Date: Wed, 28 Jan 2009 17:10:41 -0800
Message-ID: <49810211.9030808@kernel.org>
References: <4947FF4C.80706@goop.org> <20081216192534.GB843@elte.hu> <alpine.LFD.2.00.0812311821110.3854@localhost.localdomain> <495C677F.6080707@goop.org> <20090102153957.GA1180@elte.hu> <4980EE0C.4070308@goop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070809060608020601040306"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54606 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751508AbZA2BLa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Jan 2009 20:11:30 -0500
In-Reply-To: <4980EE0C.4070308@goop.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------070809060608020601040306
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jeremy Fitzhardinge wrote:
> Ingo Molnar wrote:
>> yes, that end result is the desired state of things. We did run with
>> this for several months and resolved all the cases that needed fixing,
>> but dropped them when the ACPI tree moved out from under us.
>>
>> Can resurrect it if Len feels OK about the concept. Len, you shouldnt
>> worry about conflicts - we can do it after the ACPI changes of this
>> merge window are upstream so there should be no conflict trouble at
>> all. How does that sound?
>>   
> 
> Doesn't look like these changes made it in this time.  Did they get
> overlooked, or did some other problem come up?  Or did you want me to
> dig them up?
> 
> Thanks,
>    J


please check attached that are updated to today tip/master with ingo's genapic patchset..

YH

--------------070809060608020601040306
Content-Type: text/x-patch;
 name="acpi_use_early_ioremap_1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi_use_early_ioremap_1.patch"

commit ac77f220e5b99e8d7bfeae21516b4ac8736c266c
Author: Jeremy Fitzhardinge <jeremy@goop.org>
Date:   Sun Sep 7 15:21:18 2008 -0700

    x86: use early_ioremap in __acpi_map_table
    
    __acpi_map_table() effectively reimplements early_ioremap().  Rather
    than have that duplication, just implement it in terms of
    early_ioremap().
    
    However, unlike early_ioremap(), __acpi_map_table() just maintains a
    single mapping which gets replaced each call, and has no corresponding
    unmap function.  Implement this by just removing the previous mapping
    each time its called.  Unfortunately, this will leave a stray mapping
    at the end.
    
    Signed-off-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
    Signed-off-by: Ingo Molnar <mingo@elte.hu>

---
 arch/x86/include/asm/acpi.h      |    3 ---
 arch/x86/include/asm/fixmap_32.h |    4 ----
 arch/x86/include/asm/fixmap_64.h |    4 ----
 arch/x86/kernel/acpi/boot.c      |   29 ++++++++---------------------
 4 files changed, 8 insertions(+), 32 deletions(-)

Index: linux-2.6/arch/x86/kernel/acpi/boot.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/acpi/boot.c
+++ linux-2.6/arch/x86/kernel/acpi/boot.c
@@ -108,8 +108,8 @@ enum acpi_irq_model_id acpi_irq_model =
  */
 char *__init __acpi_map_table(unsigned long phys, unsigned long size)
 {
-	unsigned long base, offset, mapped_size;
-	int idx;
+	static char *prev_map;
+	static unsigned long prev_size;
 
 	if (!phys || !size)
 		return NULL;
@@ -117,26 +117,13 @@ char *__init __acpi_map_table(unsigned l
 	if (phys+size <= (max_low_pfn_mapped << PAGE_SHIFT))
 		return __va(phys);
 
-	offset = phys & (PAGE_SIZE - 1);
-	mapped_size = PAGE_SIZE - offset;
-	clear_fixmap(FIX_ACPI_END);
-	set_fixmap(FIX_ACPI_END, phys);
-	base = fix_to_virt(FIX_ACPI_END);
-
-	/*
-	 * Most cases can be covered by the below.
-	 */
-	idx = FIX_ACPI_END;
-	while (mapped_size < size) {
-		if (--idx < FIX_ACPI_BEGIN)
-			return NULL;	/* cannot handle this */
-		phys += PAGE_SIZE;
-		clear_fixmap(idx);
-		set_fixmap(idx, phys);
-		mapped_size += PAGE_SIZE;
-	}
+	if (prev_map)
+		early_iounmap(prev_map, prev_size);
 
-	return ((unsigned char *)base + offset);
+	prev_size = size;
+	prev_map = early_ioremap(phys, size);
+
+	return prev_map;
 }
 
 #ifdef CONFIG_PCI_MMCONFIG
Index: linux-2.6/arch/x86/include/asm/acpi.h
===================================================================
--- linux-2.6.orig/arch/x86/include/asm/acpi.h
+++ linux-2.6/arch/x86/include/asm/acpi.h
@@ -102,9 +102,6 @@ static inline void disable_acpi(void)
 	acpi_noirq = 1;
 }
 
-/* Fixmap pages to reserve for ACPI boot-time tables (see fixmap.h) */
-#define FIX_ACPI_PAGES 4
-
 extern int acpi_gsi_to_irq(u32 gsi, unsigned int *irq);
 
 static inline void acpi_noirq_set(void) { acpi_noirq = 1; }
Index: linux-2.6/arch/x86/include/asm/fixmap_32.h
===================================================================
--- linux-2.6.orig/arch/x86/include/asm/fixmap_32.h
+++ linux-2.6/arch/x86/include/asm/fixmap_32.h
@@ -95,10 +95,6 @@ enum fixed_addresses {
 			(__end_of_permanent_fixed_addresses & 255),
 	FIX_BTMAP_BEGIN = FIX_BTMAP_END + NR_FIX_BTMAPS*FIX_BTMAPS_SLOTS - 1,
 	FIX_WP_TEST,
-#ifdef CONFIG_ACPI
-	FIX_ACPI_BEGIN,
-	FIX_ACPI_END = FIX_ACPI_BEGIN + FIX_ACPI_PAGES - 1,
-#endif
 #ifdef CONFIG_PROVIDE_OHCI1394_DMA_INIT
 	FIX_OHCI1394_BASE,
 #endif
Index: linux-2.6/arch/x86/include/asm/fixmap_64.h
===================================================================
--- linux-2.6.orig/arch/x86/include/asm/fixmap_64.h
+++ linux-2.6/arch/x86/include/asm/fixmap_64.h
@@ -50,10 +50,6 @@ enum fixed_addresses {
 	FIX_PARAVIRT_BOOTMAP,
 #endif
 	__end_of_permanent_fixed_addresses,
-#ifdef CONFIG_ACPI
-	FIX_ACPI_BEGIN,
-	FIX_ACPI_END = FIX_ACPI_BEGIN + FIX_ACPI_PAGES - 1,
-#endif
 #ifdef CONFIG_PROVIDE_OHCI1394_DMA_INIT
 	FIX_OHCI1394_BASE,
 #endif

--------------070809060608020601040306
Content-Type: text/x-patch;
 name="acpi_use_early_ioremap_2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi_use_early_ioremap_2.patch"

commit c95f866ed97595a48b3dcbb6d265d5f1ae37866e
Author: Jeremy Fitzhardinge <jeremy@goop.org>
Date:   Sun Sep 7 15:21:19 2008 -0700

    x86: always explicitly map acpi memory
    
    Always map acpi tables, rather than assuming we can use the normal
    linear mapping to access the acpi tables.  This is necessary in a
    virtual environment where the linear mappings are to pseudo-physical
    memory, but the acpi tables exist at a real physical address.  It
    doesn't hurt to map in the normal non-virtual case, so just do it
    unconditionally.
    
    Signed-off-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
    Signed-off-by: Ingo Molnar <mingo@elte.hu>

---
 arch/x86/kernel/acpi/boot.c |    3 ---
 1 file changed, 3 deletions(-)

Index: linux-2.6/arch/x86/kernel/acpi/boot.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/acpi/boot.c
+++ linux-2.6/arch/x86/kernel/acpi/boot.c
@@ -114,9 +114,6 @@ char *__init __acpi_map_table(unsigned l
 	if (!phys || !size)
 		return NULL;
 
-	if (phys+size <= (max_low_pfn_mapped << PAGE_SHIFT))
-		return __va(phys);
-
 	if (prev_map)
 		early_iounmap(prev_map, prev_size);
 

--------------070809060608020601040306
Content-Type: text/x-patch;
 name="acpi_use_early_ioremap_3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi_use_early_ioremap_3.patch"

commit 5c48856148e7b02257a663f49128544814a07255
Author: Jeremy Fitzhardinge <jeremy@goop.org>
Date:   Thu Sep 11 14:33:16 2008 -0700

    acpi: remove final __acpi_map_table mapping before setting acpi_gbl_permanent_mmap
    
    On x86, __acpi_map_table uses early_ioremap() to create the mapping,
    replacing the previous mapping with a new one.  Once enough of the
    kernel is up an running it switches to using normal ioremap().  At
    that point, we need to clean up the final mapping to avoid a warning
    from the early_ioremap subsystem.
    
    This can be removed after all the instances in the ACPI code are fixed
    that rely on early-ioremap's implicit overmapping of previously
    mapped tables.
    
    Signed-off-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
    Cc: Andi Kleen <andi@firstfloor.org>
    Signed-off-by: Ingo Molnar <mingo@elte.hu>

---
 arch/x86/kernel/acpi/boot.c |    8 +++++---
 drivers/acpi/bus.c          |    6 ++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

Index: linux-2.6/arch/x86/kernel/acpi/boot.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/acpi/boot.c
+++ linux-2.6/arch/x86/kernel/acpi/boot.c
@@ -111,12 +111,14 @@ char *__init __acpi_map_table(unsigned l
 	static char *prev_map;
 	static unsigned long prev_size;
 
+	if (prev_map) {
+		early_iounmap(prev_map, prev_size);
+		prev_map = NULL;
+	}
+
 	if (!phys || !size)
 		return NULL;
 
-	if (prev_map)
-		early_iounmap(prev_map, prev_size);
-
 	prev_size = size;
 	prev_map = early_ioremap(phys, size);
 
Index: linux-2.6/drivers/acpi/bus.c
===================================================================
--- linux-2.6.orig/drivers/acpi/bus.c
+++ linux-2.6/drivers/acpi/bus.c
@@ -694,6 +694,12 @@ void __init acpi_early_init(void)
 	if (!acpi_strict)
 		acpi_gbl_enable_interpreter_slack = TRUE;
 
+	/*
+	 * Doing a zero-sized mapping will clear out the previous
+	 * __acpi_map_table() mapping, if any.
+	 */
+	__acpi_map_table(0, 0);
+
 	acpi_gbl_permanent_mmap = 1;
 
 	status = acpi_reallocate_root_table();

--------------070809060608020601040306
Content-Type: text/x-patch;
 name="acpi_use_early_ioremap_4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi_use_early_ioremap_4.patch"

commit 5560cb0d955aad89ea0001baa0da675dba97650b
Author: Yinghai Lu <yhlu.kernel@gmail.com>
Date:   Sun Sep 14 02:33:13 2008 -0700

    acpi/x86: introduce __apci_map_table, v4
    
    to prevent wrongly overwriting fixmap that still want to use.
    
    ACPI used to rely on low mappings being all linearly mapped and
    grew a habit: it never really unmapped certain kinds of tables
    after use.
    
    This can cause problems - for example the hypothetical case
    when some spurious access still references it.
    
    v2: remove prev_map and prev_size in __apci_map_table
    v3: let acpi_os_unmap_memory() call early_iounmap too, so remove extral calling to
    	early_acpi_os_unmap_memory
    v4: fix typo in one acpi_get_table_with_size calling
    
    Signed-off-by: Yinghai Lu <yhlu.kernel@gmail.com>
    Signed-off-by: Ingo Molnar <mingo@elte.hu>

---
 arch/ia64/kernel/acpi.c       |    4 ++++
 arch/x86/kernel/acpi/boot.c   |   17 +++++++----------
 drivers/acpi/acpica/tbxface.c |   17 ++++++++++++++---
 drivers/acpi/bus.c            |    6 ------
 drivers/acpi/osl.c            |   11 +++++++++--
 drivers/acpi/tables.c         |   20 ++++++++++++++------
 include/acpi/acpiosxf.h       |    1 +
 include/acpi/acpixf.h         |    4 ++++
 include/linux/acpi.h          |    1 +
 9 files changed, 54 insertions(+), 27 deletions(-)

Index: linux-2.6/arch/ia64/kernel/acpi.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/acpi.c
+++ linux-2.6/arch/ia64/kernel/acpi.c
@@ -199,6 +199,10 @@ char *__init __acpi_map_table(unsigned l
 	return __va(phys_addr);
 }
 
+char *__init __acpi_unmap_table(unsigned long virt_addr, unsigned long size)
+{
+}
+
 /* --------------------------------------------------------------------------
                             Boot-time Table Parsing
    -------------------------------------------------------------------------- */
Index: linux-2.6/arch/x86/kernel/acpi/boot.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/acpi/boot.c
+++ linux-2.6/arch/x86/kernel/acpi/boot.c
@@ -108,21 +108,18 @@ enum acpi_irq_model_id acpi_irq_model =
  */
 char *__init __acpi_map_table(unsigned long phys, unsigned long size)
 {
-	static char *prev_map;
-	static unsigned long prev_size;
-
-	if (prev_map) {
-		early_iounmap(prev_map, prev_size);
-		prev_map = NULL;
-	}
 
 	if (!phys || !size)
 		return NULL;
 
-	prev_size = size;
-	prev_map = early_ioremap(phys, size);
+	return early_ioremap(phys, size);
+}
+void __init __acpi_unmap_table(char *map, unsigned long size)
+{
+	if (!map || !size)
+		return;
 
-	return prev_map;
+	early_iounmap(map, size);
 }
 
 #ifdef CONFIG_PCI_MMCONFIG
Index: linux-2.6/drivers/acpi/bus.c
===================================================================
--- linux-2.6.orig/drivers/acpi/bus.c
+++ linux-2.6/drivers/acpi/bus.c
@@ -694,12 +694,6 @@ void __init acpi_early_init(void)
 	if (!acpi_strict)
 		acpi_gbl_enable_interpreter_slack = TRUE;
 
-	/*
-	 * Doing a zero-sized mapping will clear out the previous
-	 * __acpi_map_table() mapping, if any.
-	 */
-	__acpi_map_table(0, 0);
-
 	acpi_gbl_permanent_mmap = 1;
 
 	status = acpi_reallocate_root_table();
Index: linux-2.6/drivers/acpi/osl.c
===================================================================
--- linux-2.6.orig/drivers/acpi/osl.c
+++ linux-2.6/drivers/acpi/osl.c
@@ -274,12 +274,19 @@ EXPORT_SYMBOL_GPL(acpi_os_map_memory);
 
 void acpi_os_unmap_memory(void __iomem * virt, acpi_size size)
 {
-	if (acpi_gbl_permanent_mmap) {
+	if (acpi_gbl_permanent_mmap)
 		iounmap(virt);
-	}
+	else
+		__acpi_unmap_table(virt, size);
 }
 EXPORT_SYMBOL_GPL(acpi_os_unmap_memory);
 
+void early_acpi_os_unmap_memory(void __iomem * virt, acpi_size size)
+{
+	if (!acpi_gbl_permanent_mmap)
+		__acpi_unmap_table(virt, size);
+}
+
 #ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_os_get_physical_address(void *virt, acpi_physical_address * phys)
Index: linux-2.6/drivers/acpi/tables.c
===================================================================
--- linux-2.6.orig/drivers/acpi/tables.c
+++ linux-2.6/drivers/acpi/tables.c
@@ -181,14 +181,15 @@ acpi_table_parse_entries(char *id,
 	struct acpi_subtable_header *entry;
 	unsigned int count = 0;
 	unsigned long table_end;
+	acpi_size tbl_size;
 
 	if (!handler)
 		return -EINVAL;
 
 	if (strncmp(id, ACPI_SIG_MADT, 4) == 0)
-		acpi_get_table(id, acpi_apic_instance, &table_header);
+		acpi_get_table_with_size(id, acpi_apic_instance, &table_header, &tbl_size);
 	else
-		acpi_get_table(id, 0, &table_header);
+		acpi_get_table_with_size(id, 0, &table_header, &tbl_size);
 
 	if (!table_header) {
 		printk(KERN_WARNING PREFIX "%4.4s not present\n", id);
@@ -206,8 +207,10 @@ acpi_table_parse_entries(char *id,
 	       table_end) {
 		if (entry->type == entry_id
 		    && (!max_entries || count++ < max_entries))
-			if (handler(entry, table_end))
+			if (handler(entry, table_end)) {
+				early_acpi_os_unmap_memory((char *)table_header, tbl_size);
 				return -EINVAL;
+			}
 
 		entry = (struct acpi_subtable_header *)
 		    ((unsigned long)entry + entry->length);
@@ -217,6 +220,7 @@ acpi_table_parse_entries(char *id,
 		       "%i found\n", id, entry_id, count - max_entries, count);
 	}
 
+	early_acpi_os_unmap_memory((char *)table_header, tbl_size);
 	return count;
 }
 
@@ -241,17 +245,19 @@ acpi_table_parse_madt(enum acpi_madt_typ
 int __init acpi_table_parse(char *id, acpi_table_handler handler)
 {
 	struct acpi_table_header *table = NULL;
+	acpi_size tbl_size;
 
 	if (!handler)
 		return -EINVAL;
 
 	if (strncmp(id, ACPI_SIG_MADT, 4) == 0)
-		acpi_get_table(id, acpi_apic_instance, &table);
+		acpi_get_table_with_size(id, acpi_apic_instance, &table, &tbl_size);
 	else
-		acpi_get_table(id, 0, &table);
+		acpi_get_table_with_size(id, 0, &table, &tbl_size);
 
 	if (table) {
 		handler(table);
+		early_acpi_os_unmap_memory(table, tbl_size);
 		return 0;
 	} else
 		return 1;
@@ -265,8 +271,9 @@ int __init acpi_table_parse(char *id, ac
 static void __init check_multiple_madt(void)
 {
 	struct acpi_table_header *table = NULL;
+	acpi_size tbl_size;
 
-	acpi_get_table(ACPI_SIG_MADT, 2, &table);
+	acpi_get_table_with_size(ACPI_SIG_MADT, 2, &table, &tbl_size);
 	if (table) {
 		printk(KERN_WARNING PREFIX
 		       "BIOS bug: multiple APIC/MADT found,"
@@ -275,6 +282,7 @@ static void __init check_multiple_madt(v
 		       "If \"acpi_apic_instance=%d\" works better, "
 		       "notify linux-acpi@vger.kernel.org\n",
 		       acpi_apic_instance ? 0 : 2);
+		early_acpi_os_unmap_memory(table, tbl_size);
 
 	} else
 		acpi_apic_instance = 0;
Index: linux-2.6/drivers/acpi/acpica/tbxface.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/tbxface.c
+++ linux-2.6/drivers/acpi/acpica/tbxface.c
@@ -365,7 +365,7 @@ ACPI_EXPORT_SYMBOL(acpi_unload_table_id)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_get_table
+ * FUNCTION:    acpi_get_table_with_size
  *
  * PARAMETERS:  Signature           - ACPI signature of needed table
  *              Instance            - Which instance (for SSDTs)
@@ -377,8 +377,9 @@ ACPI_EXPORT_SYMBOL(acpi_unload_table_id)
  *
  *****************************************************************************/
 acpi_status
-acpi_get_table(char *signature,
-	       u32 instance, struct acpi_table_header **out_table)
+acpi_get_table_with_size(char *signature,
+	       u32 instance, struct acpi_table_header **out_table,
+	       acpi_size *tbl_size)
 {
        u32 i;
        u32 j;
@@ -408,6 +409,7 @@ acpi_get_table(char *signature,
 		    acpi_tb_verify_table(&acpi_gbl_root_table_list.tables[i]);
 		if (ACPI_SUCCESS(status)) {
 			*out_table = acpi_gbl_root_table_list.tables[i].pointer;
+			*tbl_size = acpi_gbl_root_table_list.tables[i].length;
 		}
 
 		if (!acpi_gbl_permanent_mmap) {
@@ -420,6 +422,15 @@ acpi_get_table(char *signature,
 	return (AE_NOT_FOUND);
 }
 
+acpi_status
+acpi_get_table(char *signature,
+	       u32 instance, struct acpi_table_header **out_table)
+{
+	acpi_size tbl_size;
+
+	return acpi_get_table_with_size(signature,
+		       instance, out_table, &tbl_size);
+}
 ACPI_EXPORT_SYMBOL(acpi_get_table)
 
 /*******************************************************************************
Index: linux-2.6/include/acpi/acpiosxf.h
===================================================================
--- linux-2.6.orig/include/acpi/acpiosxf.h
+++ linux-2.6/include/acpi/acpiosxf.h
@@ -144,6 +144,7 @@ void __iomem *acpi_os_map_memory(acpi_ph
 				acpi_size length);
 
 void acpi_os_unmap_memory(void __iomem * logical_address, acpi_size size);
+void early_acpi_os_unmap_memory(void __iomem * virt, acpi_size size);
 
 #ifdef ACPI_FUTURE_USAGE
 acpi_status
Index: linux-2.6/include/acpi/acpixf.h
===================================================================
--- linux-2.6.orig/include/acpi/acpixf.h
+++ linux-2.6/include/acpi/acpixf.h
@@ -130,6 +130,10 @@ acpi_get_table_header(acpi_string signat
 		      struct acpi_table_header *out_table_header);
 
 acpi_status
+acpi_get_table_with_size(acpi_string signature,
+	       u32 instance, struct acpi_table_header **out_table,
+	       acpi_size *tbl_size);
+acpi_status
 acpi_get_table(acpi_string signature,
 	       u32 instance, struct acpi_table_header **out_table);
 
Index: linux-2.6/include/linux/acpi.h
===================================================================
--- linux-2.6.orig/include/linux/acpi.h
+++ linux-2.6/include/linux/acpi.h
@@ -79,6 +79,7 @@ typedef int (*acpi_table_handler) (struc
 typedef int (*acpi_table_entry_handler) (struct acpi_subtable_header *header, const unsigned long end);
 
 char * __acpi_map_table (unsigned long phys_addr, unsigned long size);
+void __init __acpi_unmap_table(char *map, unsigned long size);
 int early_acpi_boot_init(void);
 int acpi_boot_init (void);
 int acpi_boot_table_init (void);

--------------070809060608020601040306
Content-Type: text/x-patch;
 name="revert_fix_es7000_compiling.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="revert_fix_es7000_compiling.patch"

---
 arch/x86/kernel/es7000_32.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Index: linux-2.6/arch/x86/kernel/es7000_32.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/es7000_32.c
+++ linux-2.6/arch/x86/kernel/es7000_32.c
@@ -287,24 +287,31 @@ int __init find_unisys_acpi_oem_table(un
 {
 	struct acpi_table_header *header = NULL;
 	int i = 0;
+	acpi_size tbl_size;
 
-	while (ACPI_SUCCESS(acpi_get_table("OEM1", i++, &header))) {
+	while (ACPI_SUCCESS(acpi_get_table_with_size("OEM1", i++, &header, &tbl_size))) {
 		if (!memcmp((char *) &header->oem_id, "UNISYS", 6)) {
 			struct oem_table *t = (struct oem_table *)header;
 
 			oem_addrX = t->OEMTableAddr;
 			oem_size = t->OEMTableSize;
+			early_acpi_os_unmap_memory(header, tbl_size);
 
 			*oem_addr = (unsigned long)__acpi_map_table(oem_addrX,
 								    oem_size);
 			return 0;
 		}
+		early_acpi_os_unmap_memory(header, tbl_size);
 	}
 	return -1;
 }
 
 void __init unmap_unisys_acpi_oem_table(unsigned long oem_addr)
 {
+	if (!oem_addr)
+		return;
+
+	__acpi_unmap_table((char *)oem_addr, oem_size);
 }
 #endif
 

--------------070809060608020601040306--
