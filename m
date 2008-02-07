From: Len Brown <lenb@kernel.org>
Subject: [PATCH 110/112] ACPI: update intrd DSDT override console messages
Date: Thu,  7 Feb 2008 04:35:12 -0500
Message-ID: <04d94886b47b5133915021dcfb1108a8576f6ea7.1202376825.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:48010 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757989AbYBGJhC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:37:02 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

also, address some checkpatch.pl violations

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |   33 ++++++++++++++++++---------------
 1 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 2b41bdd..2a400e0 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -326,49 +326,50 @@ struct acpi_table_header *acpi_find_dsdt_initrd(void)
 	struct kstat stat;
 	char *ramfs_dsdt_name = "/DSDT.aml";
 
-	printk(KERN_INFO PREFIX "Looking for DSDT in initramfs... ");
+	printk(KERN_INFO PREFIX "Checking initramfs for custom DSDT");
 
 	/*
 	 * Never do this at home, only the user-space is allowed to open a file.
-	 * The clean way would be to use the firmware loader. But this code must be run
-	 * before there is any userspace available. So we need a static/init firmware
-	 * infrastructure, which doesn't exist yet...
+	 * The clean way would be to use the firmware loader.
+	 * But this code must be run before there is any userspace available.
+	 * A static/init firmware infrastructure doesn't exist yet...
 	 */
-	if (vfs_stat(ramfs_dsdt_name, &stat) < 0) {
-		printk("not found.\n");
+	if (vfs_stat(ramfs_dsdt_name, &stat) < 0)
 		return ret;
-	}
 
 	len = stat.size;
 	/* check especially against empty files */
 	if (len <= 4) {
-		printk("error, file is too small: only %lu bytes.\n", len);
+		printk(KERN_ERR PREFIX "Failed: DSDT only %lu bytes.\n", len);
 		return ret;
 	}
 
 	firmware_file = filp_open(ramfs_dsdt_name, O_RDONLY, 0);
 	if (IS_ERR(firmware_file)) {
-		printk("error, could not open file %s.\n", ramfs_dsdt_name);
+		printk(KERN_ERR PREFIX "Failed to open %s.\n", ramfs_dsdt_name);
 		return ret;
 	}
 
-	dsdt_buffer = ACPI_ALLOCATE(len);
+	dsdt_buffer = kmalloc(len, GFP_ATOMIC);
 	if (!dsdt_buffer) {
-		printk("error when allocating %lu bytes of memory.\n", len);
+		printk(KERN_ERR PREFIX "Failed to allocate %lu bytes.\n", len);
 		goto err;
 	}
 
 	oldfs = get_fs();
 	set_fs(KERNEL_DS);
-	len2 = vfs_read(firmware_file, (char __user *)dsdt_buffer, len, &firmware_file->f_pos);
+	len2 = vfs_read(firmware_file, (char __user *)dsdt_buffer, len,
+		&firmware_file->f_pos);
 	set_fs(oldfs);
 	if (len2 < len) {
-		printk("error trying to read %lu bytes from %s.\n", len, ramfs_dsdt_name);
+		printk(KERN_ERR PREFIX "Failed to read %lu bytes from %s.\n",
+			len, ramfs_dsdt_name);
 		ACPI_FREE(dsdt_buffer);
 		goto err;
 	}
 
-	printk("successfully read %lu bytes from %s.\n", len, ramfs_dsdt_name);
+	printk(KERN_INFO PREFIX "Found %lu byte DSDT in %s.\n",
+			len, ramfs_dsdt_name);
 	ret = dsdt_buffer;
 err:
 	filp_close(firmware_file, NULL);
@@ -392,7 +393,9 @@ acpi_os_table_override(struct acpi_table_header * existing_table,
 #ifdef CONFIG_ACPI_CUSTOM_DSDT_INITRD
 	if ((strncmp(existing_table->signature, "DSDT", 4) == 0) &&
 	    !acpi_no_initrd_override) {
-		struct acpi_table_header *initrd_table = acpi_find_dsdt_initrd();
+		struct acpi_table_header *initrd_table;
+
+		initrd_table = acpi_find_dsdt_initrd();
 		if (initrd_table)
 			*new_table = initrd_table;
 	}
-- 
1.5.4.23.gef5b9

