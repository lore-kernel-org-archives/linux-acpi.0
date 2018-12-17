From: Shunyong Yang <shunyong.yang@hxt-semitech.com>
Subject: [PATCH] ACPI / tables: table upgrade from built-in initrd
Date: Mon, 17 Dec 2018 10:19:44 +0800
Message-ID: <1545013184-2487-1-git-send-email-shunyong.yang@hxt-semitech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Shunyong Yang <shunyong.yang@hxt-semitech.com>, Joey Zheng <yu.zheng@hxt-semitech.com>
List-Id: linux-acpi@vger.kernel.org

In some scenario, we need to build initrd with kernel in a single image.
This can simplify system deployment process by downloading the whole system
once, such as in IC verification.

This patch adds support to upgrade ACPI tables from built-in initrd.

Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
---
 drivers/acpi/Kconfig   |  9 +++++++++
 drivers/acpi/tables.c  | 12 ++++++++++--
 include/linux/initrd.h |  3 +++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 7cea769c37df..30976496fe77 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -357,6 +357,15 @@ config ACPI_TABLE_UPGRADE
 	  initrd, therefore it's safe to say Y.
 	  See Documentation/acpi/initrd_table_override.txt for details
 
+config ACPI_TABLE_UPGRADE_VIA_BUILTIN_INITRD
+	bool "Upgrade ACPI tables from built-in initrd"
+	depends on ACPI_TABLE_UPGRADE
+	depends on INITRAMFS_SOURCE!="" && INITRAMFS_COMPRESSION=""
+	def_bool n
+	help
+	  This option provides functionality to upgrade arbitrary ACPI tables
+	  from built-in uncompressed initrd.
+
 config ACPI_DEBUG
 	bool "Debug Statements"
 	help
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 61203eebf3a1..88e3a34443da 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -473,14 +473,22 @@ static u8 __init acpi_table_checksum(u8 *buffer, u32 length)
 
 void __init acpi_table_upgrade(void)
 {
-	void *data = (void *)initrd_start;
-	size_t size = initrd_end - initrd_start;
+	void *data;
+	size_t size;
 	int sig, no, table_nr = 0, total_offset = 0;
 	long offset = 0;
 	struct acpi_table_header *table;
 	char cpio_path[32] = "kernel/firmware/acpi/";
 	struct cpio_data file;
 
+	if (IS_ENABLED(CONFIG_ACPI_TABLE_UPGRADE_VIA_BUILTIN_INITRD)) {
+		data = __initramfs_start;
+		size = __initramfs_size;
+	} else {
+		data = (void *)initrd_start;
+		size = initrd_end - initrd_start;
+	}
+
 	if (data == NULL || size == 0)
 		return;
 
diff --git a/include/linux/initrd.h b/include/linux/initrd.h
index 84b423044088..02d94aae54c7 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -22,3 +22,6 @@
 extern void free_initrd_mem(unsigned long, unsigned long);
 
 extern unsigned int real_root_dev;
+
+extern char __initramfs_start[];
+extern unsigned long __initramfs_size;
-- 
1.8.3.1
