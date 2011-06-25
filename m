From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/2] ACPI: Implement overriding of arbitrary ACPI tables via initrd
Date: Sat, 25 Jun 2011 22:13:16 +0200
Message-ID: <201106252213.17116.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48567 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751337Ab1FYUNk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 25 Jun 2011 16:13:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, hpa@zytor.com, x86@kernel.org

The patch should have no functional change as long as no ACPI
tables are glued to a current valid initrd.

1) Issues, help appreciated!
----------------------------

While the patch worked for me it has issues that need to be addressed:
  - crashkernel conflicts (compare with setup.c)
  - must initrd_start be page aligned? I expect parts of the override
    tables could get freed with the current implementation which must
    not happen
My idea is to relocate the ACPI tables like it's done in relocate_initrd()?

It would be great to get some comments whether this is an acceptable
solution for mainline integration.

2) What is this for
-------------------

Please keep in mind that this is a debug option.
While it can be enabled in any kernel, because there is no functional
change with common initrds, it provides a powerful feature to easily
debug and test ACPI BIOS table compatibility with the Linux kernel.

Currently it's only possible to override the DSDT by compiling it into
the kernel. This is a nightmare when trying to work on ACPI related bugs
and a lot bugs got stuck because of that.
Even for people with enough kernel knowledge, building a fully featured
kernel on a slow machine at home is very time consuming.

With this patch it's not only possible to override the DSDT table, but up
to 10 arbitrary ACPI tables (HPET, SSDT, APIC, SRAT, SLIT, BERT, ERST, ...)
can be passed.

This might even ease up testing for vendors/OEMs who could flush their BIOS
to test, but this is much easier and quicker.
For example one could prepare different initrds overriding NUMA tables with
different affinity settings. Set up a script, let the machine reboot and
run tests over night and one can get picture how much these settings influence
the Linux kernel and which one is best.

People can instrument the dynamic ACPI (ASL) code (for example with debug
statements showing up in syslog when the ACPI code is processed, etc.),
to better understand BIOS to OS interfaces and develop ACPI based drivers
quicker.

Intstrumenting ACPI code in SSDTs is now much easier. Before, one had to copy
all SSDTs into the DSDT to compile it into the kernel for testing
(because only DSDT could get overridden). That's what the acpi_no_auto_ssdt
boot param is for: the BIOS provided SSDTs are ignored and all have to get
copied into the DSDT, complicated and time consuming...

...

3) How does it work
-------------------

# Extract the machine's ACPI tables:
acpidump >acpidump
acpixtract -a acpidump
# Disassemble, modify and recompile them:
iasl -d *.dat
# For example add this statement into a _PRT (PCI Routing Table) function
# of the DSDT:
Store("Hello World", debug)
iasl -sa *.dsl
# glue them together with the initrd. ACPI tables go first, original initrd
# goes on top:
cat TBL1.dat >>instrumented_initrd
cat TBL2.dat >>instrumented_initrd
cat TBL3.dat >>instrumented_initrd
cat /boot/initrd >>instrumented_initrd
# reboot with increased acpi debug level, e.g. boot params:
acpi.debug_level=0x2 acpi.debug_layer=0xFFFFFFFF
# and check your syslog:
[    1.268089] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    1.272091] [ACPI Debug]  String [0x0B] "HELLO WORLD"

I haven't tried more than one table, but in theory it works.


Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: linux-acpi@vger.kernel.org
CC: lenb@kernel.org
CC: hpa@zytor.com
CC: x86@kernel.org

---
 arch/x86/kernel/setup.c |   12 +++++---
 drivers/acpi/Kconfig    |    7 ++++
 drivers/acpi/osl.c      |   68 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h    |    2 +
 include/linux/initrd.h  |    3 ++
 init/initramfs.c        |    6 ++++
 6 files changed, 94 insertions(+), 4 deletions(-)

Index: linux-3.0-rc3-master/arch/x86/kernel/setup.c
===================================================================
--- linux-3.0-rc3-master.orig/arch/x86/kernel/setup.c
+++ linux-3.0-rc3-master/arch/x86/kernel/setup.c
@@ -411,12 +411,16 @@ static void __init reserve_initrd(void)
 		 */
 		initrd_start = ramdisk_image + PAGE_OFFSET;
 		initrd_end = initrd_start + ramdisk_size;
-		return;
+	} else {
+		relocate_initrd();
+		memblock_x86_free_range(ramdisk_image, ramdisk_end);
 	}
 
-	relocate_initrd();
-
-	memblock_x86_free_range(ramdisk_image, ramdisk_end);
+#ifdef CONFIG_ACPI_INITRD_TABLE_OVERRIDE
+	acpi_initrd_offset = acpi_initrd_table_override(initrd_start);
+	printk (KERN_INFO "Found acpi tables of size: %d at 0x%lx "
+		"- 0x%lx\n", acpi_initrd_offset, initrd_start, initrd_end);
+#endif
 }
 #else
 static void __init reserve_initrd(void)
Index: linux-3.0-rc3-master/drivers/acpi/Kconfig
===================================================================
--- linux-3.0-rc3-master.orig/drivers/acpi/Kconfig
+++ linux-3.0-rc3-master/drivers/acpi/Kconfig
@@ -261,6 +261,13 @@ config ACPI_CUSTOM_DSDT
 	bool
 	default ACPI_CUSTOM_DSDT_FILE != ""
 
+config ACPI_INITRD_TABLE_OVERRIDE
+	bool
+	default y
+	help
+	  This option provides functionality to override arbitrary ACPI tables
+	  via initrd. See Documentation/acpi/initrd_table_override.txt for details
+
 config ACPI_BLACKLIST_YEAR
 	int "Disable ACPI for systems before Jan 1st this year" if X86_32
 	default 0
Index: linux-3.0-rc3-master/drivers/acpi/osl.c
===================================================================
--- linux-3.0-rc3-master.orig/drivers/acpi/osl.c
+++ linux-3.0-rc3-master/drivers/acpi/osl.c
@@ -484,10 +484,52 @@ acpi_os_predefined_override(const struct
 	return AE_OK;
 }
 
+#ifdef CONFIG_ACPI_INITRD_TABLE_OVERRIDE
+#define ACPI_OVERRIDE_TABLES 10
+
+struct acpi_table_header * acpi_table_override[ACPI_OVERRIDE_TABLES];
+int __initdata acpi_initrd_offset;
+
+int __init acpi_initrd_table_override(unsigned long initrd_start_addr)
+{
+	int table_nr;
+	int offset = 0;
+
+	for (table_nr = 0; table_nr < ACPI_OVERRIDE_TABLES; table_nr++) {
+		struct acpi_table_header * table = (void*)initrd_start_addr + offset;
+		/* TBD: Better check for valid ACPI tables, couldn't find
+		   a suitable function in acpica, if it does not exist, one
+		   should be added there. All tables with a valid header and
+		   checksum should be allowed.
+		*/
+		int table_found = 0;
+		if (!strncmp(table->signature, "APIC", 4))
+		    table_found = 1;
+		if (!strncmp(table->signature, "HPET", 4))
+		    table_found = 1;
+		if (!strncmp(table->signature, "DSDT", 4))
+		    table_found = 1;
+		if (!table_found)
+			break;
+
+		acpi_table_override[table_nr] = table;
+		offset += table->length;
+		printk(KERN_INFO "%4.4s ACPI table found in initrd"
+		       " - size: %d", table->signature, table->length);
+	}
+	return offset;
+}
+
+#endif
+
 acpi_status
 acpi_os_table_override(struct acpi_table_header * existing_table,
 		       struct acpi_table_header ** new_table)
 {
+#ifdef CONFIG_ACPI_INITRD_TABLE_OVERRIDE
+	int table_nr = 0;
+#endif
+
 	if (!existing_table || !new_table)
 		return AE_BAD_PARAMETER;
 
@@ -497,6 +539,32 @@ acpi_os_table_override(struct acpi_table
 	if (strncmp(existing_table->signature, "DSDT", 4) == 0)
 		*new_table = (struct acpi_table_header *)AmlCode;
 #endif
+
+#ifdef CONFIG_ACPI_INITRD_TABLE_OVERRIDE
+	for (;table_nr < ACPI_OVERRIDE_TABLES; table_nr++) {
+		struct acpi_table_header *table = acpi_table_override[table_nr];
+
+		if (!table)
+			break;
+
+		printk (KERN_INFO "Comparing: %4.4s vs %4.4s\n",
+			existing_table->signature, table->signature);
+
+		if (strncmp(existing_table->signature, table->signature, 4))
+			continue;
+
+		/* For SSDTs only override if we have the same oem id */
+		if (!strncmp(table->signature, "SSDT", 4)) {
+			if (!strncmp(table->oem_table_id,
+				     existing_table->oem_table_id,
+				     ACPI_OEM_TABLE_ID_SIZE)) {
+				break;
+			}
+		}
+		*new_table = table;
+	}
+#endif
+
 	if (*new_table != NULL) {
 		printk(KERN_WARNING PREFIX "Override [%4.4s-%8.8s], "
 			   "this is unsafe: tainting kernel\n",
Index: linux-3.0-rc3-master/include/linux/acpi.h
===================================================================
--- linux-3.0-rc3-master.orig/include/linux/acpi.h
+++ linux-3.0-rc3-master/include/linux/acpi.h
@@ -76,6 +76,8 @@ typedef int (*acpi_table_handler) (struc
 
 typedef int (*acpi_table_entry_handler) (struct acpi_subtable_header *header, const unsigned long end);
 
+int __init acpi_initrd_table_override(unsigned long initrd_start_addr);
+
 char * __acpi_map_table (unsigned long phys_addr, unsigned long size);
 void __acpi_unmap_table(char *map, unsigned long size);
 int early_acpi_boot_init(void);
Index: linux-3.0-rc3-master/include/linux/initrd.h
===================================================================
--- linux-3.0-rc3-master.orig/include/linux/initrd.h
+++ linux-3.0-rc3-master/include/linux/initrd.h
@@ -16,5 +16,8 @@ extern int initrd_below_start_ok;
 /* free_initrd_mem always gets called with the next two as arguments.. */
 extern unsigned long initrd_start, initrd_end;
 extern void free_initrd_mem(unsigned long, unsigned long);
+#ifdef CONFIG_ACPI_INITRD_TABLE_OVERRIDE
+extern int acpi_initrd_offset;
+#endif
 
 extern unsigned int real_root_dev;
Index: linux-3.0-rc3-master/init/initramfs.c
===================================================================
--- linux-3.0-rc3-master.orig/init/initramfs.c
+++ linux-3.0-rc3-master/init/initramfs.c
@@ -574,6 +574,12 @@ static int __init populate_rootfs(void)
 	char *err = unpack_to_rootfs(__initramfs_start, __initramfs_size);
 	if (err)
 		panic(err);	/* Failed to decompress INTERNAL initramfs */
+
+#ifdef CONFIG_ACPI_INITRD_TABLE_OVERRIDE
+		/* We won't free the ACPI data in the initrd anymore */
+		initrd_start = initrd_start + acpi_initrd_offset;
+#endif
+
 	if (initrd_start) {
 #ifdef CONFIG_BLK_DEV_RAM
 		int fd;
