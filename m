From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH 2/3] ACPI: table upgrade: move early_initrd_acpi_init() to header file
Date: Tue, 17 May 2016 15:06:02 +0300
Message-ID: <1463486765-31827-3-git-send-email-aleksey.makarov@linaro.org>
References: <1463486765-31827-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463486765-31827-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Jon Masters <jcm@redhat.com>, "Zheng, Lv" <lv.zheng@intel.com>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-Id: linux-acpi@vger.kernel.org

Move early_initrd_acpi_init() to header file so that
it can be used with architectures other than X86

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 arch/x86/kernel/setup.c | 7 -------
 drivers/acpi/tables.c   | 7 +++++--
 include/linux/acpi.h    | 4 ++--
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index c4e7b39..5ddbbfd 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -399,10 +399,6 @@ static void __init reserve_initrd(void)
 	memblock_free(ramdisk_image, ramdisk_end - ramdisk_image);
 }
 
-static void __init early_initrd_acpi_init(void)
-{
-	early_acpi_table_init((void *)initrd_start, initrd_end - initrd_start);
-}
 #else
 static void __init early_reserve_initrd(void)
 {
@@ -410,9 +406,6 @@ static void __init early_reserve_initrd(void)
 static void __init reserve_initrd(void)
 {
 }
-static void __init early_initrd_acpi_init(void)
-{
-}
 #endif /* CONFIG_BLK_DEV_INITRD */
 
 static void __init parse_setup_data(void)
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 449a649..82be84a 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -34,6 +34,7 @@
 #include <linux/bootmem.h>
 #include <linux/earlycpio.h>
 #include <linux/memblock.h>
+#include <linux/initrd.h>
 #include "internal.h"
 
 #ifdef CONFIG_ACPI_CUSTOM_DSDT
@@ -742,9 +743,11 @@ acpi_os_table_override(struct acpi_table_header *existing_table,
 	return AE_OK;
 }
 
-void __init early_acpi_table_init(void *data, size_t size)
+void __init early_initrd_acpi_init(void)
 {
-	acpi_table_initrd_init(data, size);
+#ifdef CONFIG_BLK_DEV_INITRD
+	acpi_table_initrd_init((void *)initrd_start, initrd_end - initrd_start);
+#endif
 }
 
 /*
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 288fac5..cb700c1 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -208,7 +208,7 @@ void acpi_boot_table_init (void);
 int acpi_mps_check (void);
 int acpi_numa_init (void);
 
-void early_acpi_table_init(void *data, size_t size);
+void early_initrd_acpi_init(void);
 int acpi_table_init (void);
 int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
 int __init acpi_parse_entries(char *id, unsigned long table_size,
@@ -588,7 +588,7 @@ static inline const char *acpi_dev_name(struct acpi_device *adev)
 	return NULL;
 }
 
-static inline void early_acpi_table_init(void *data, size_t size) { }
+static inline void early_initrd_acpi_init(void) { }
 static inline void acpi_early_init(void) { }
 static inline void acpi_subsystem_init(void) { }
 
-- 
2.8.2
