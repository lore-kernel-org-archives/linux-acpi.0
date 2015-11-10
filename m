From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 5/7] ACPI / x86: introduce acpi_os_readable() support
Date: Tue, 10 Nov 2015 16:22:10 +0800
Message-ID: <c54877289d7742727b2395147167590ed2f24d8a.1447143067.git.lv.zheng@intel.com>
References: <cover.1446790780.git.lv.zheng@intel.com> <cover.1447143067.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1447143067.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Chen Yu <yu.c.chen@intel.com>

This patch implements acpi_os_readable(). The function is used by ACPI
AML debugger to validate user specified pointers for the dumpable AML
operand objects.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 arch/x86/Kconfig                  |    1 +
 arch/x86/include/asm/acenv.h      |    1 +
 arch/x86/kernel/acpi/boot.c       |   14 ++++++++++++++
 drivers/acpi/Kconfig              |    3 +++
 drivers/acpi/osl.c                |   12 ++++++++++++
 include/acpi/platform/aclinux.h   |    1 -
 include/acpi/platform/aclinuxex.h |    5 -----
 7 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 96d058a..25585ee 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -19,6 +19,7 @@ config X86
 	def_bool y
 	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
+	select ACPI_MEMORY_ACCESS_CHECK_SUPPORT	if ACPI
 	select ANON_INODES
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_DISCARD_MEMBLOCK
diff --git a/arch/x86/include/asm/acenv.h b/arch/x86/include/asm/acenv.h
index 1b010a8..a2a2849 100644
--- a/arch/x86/include/asm/acenv.h
+++ b/arch/x86/include/asm/acenv.h
@@ -20,6 +20,7 @@
 
 int __acpi_acquire_global_lock(unsigned int *lock);
 int __acpi_release_global_lock(unsigned int *lock);
+bool __acpi_memory_readable(void *pointer, size_t length);
 
 #define ACPI_ACQUIRE_GLOBAL_LOCK(facs, Acq) \
 	((Acq) = __acpi_acquire_global_lock(&facs->global_lock))
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index e759076..3e03fde 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1699,6 +1699,20 @@ int __acpi_release_global_lock(unsigned int *lock)
 	return old & 0x1;
 }
 
+bool __acpi_memory_readable(void *pointer, size_t length)
+{
+	unsigned long start_pfn, end_pfn;
+
+	start_pfn = page_to_pfn(virt_to_page(pointer));
+	end_pfn = page_to_pfn(virt_to_page(pointer + length));
+	/*
+	 * Since the acpi address is allocated by kmalloc, we only
+	 * need to consider the direct-mapping virtual address,
+	 * rather than the kmap/vmalloc/ioremap address.
+	 */
+	return pfn_range_is_mapped(start_pfn, end_pfn) ? true : false;
+}
+
 void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
 {
 	e820_add_region(addr, size, E820_ACPI);
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 4de3517..e67b1b5 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -57,6 +57,9 @@ config ACPI_SYSTEM_POWER_STATES_SUPPORT
 config ACPI_CCA_REQUIRED
 	bool
 
+config ACPI_MEMORY_ACCESS_CHECK_SUPPORT
+	bool
+
 config ACPI_DEBUGGER
 	bool "In-kernel debugger"
 	select ACPI_DEBUG
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 2de8f66..bc3da95 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1387,6 +1387,18 @@ acpi_status acpi_os_get_line(char *buffer, u32 buffer_length, u32 *bytes_read)
 	return AE_OK;
 }
 
+#ifdef CONFIG_ACPI_MEMORY_ACCESS_CHECK_SUPPORT
+u8 acpi_os_readable(void *pointer, acpi_size length)
+{
+	return __acpi_memory_readable(pointer, length);
+}
+#else
+u8 acpi_os_readable(void *pointer, acpi_size length)
+{
+	return true;
+}
+#endif
+
 acpi_status acpi_os_wait_command_ready(void)
 {
 	int ret;
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index e21857d..b3c493e 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -148,7 +148,6 @@
 /*
  * OSL interfaces used by debugger/disassembler
  */
-#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_readable
 #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_writable
 #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_initialize_command_signals
 #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_terminate_command_signals
diff --git a/include/acpi/platform/aclinuxex.h b/include/acpi/platform/aclinuxex.h
index ceea026..94bead6 100644
--- a/include/acpi/platform/aclinuxex.h
+++ b/include/acpi/platform/aclinuxex.h
@@ -124,11 +124,6 @@ static inline acpi_thread_id acpi_os_get_thread_id(void)
 		lock ? AE_OK : AE_NO_MEMORY; \
 	})
 
-static inline u8 acpi_os_readable(void *pointer, acpi_size length)
-{
-	return TRUE;
-}
-
 static inline acpi_status acpi_os_initialize_command_signals(void)
 {
 	return AE_OK;
-- 
1.7.10
