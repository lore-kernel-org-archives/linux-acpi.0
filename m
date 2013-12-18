From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 03/15] ACPICA: Linux: Add configurability for OSL APIs.
Date: Wed, 18 Dec 2013 17:06:08 +0800
Message-ID: <3166886ad901d20dcb161f385324586d2c83aea3.1387336613.git.lv.zheng@intel.com>
References: <cover.1387336613.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1387336613.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

OSPMs like Linux trend to include all header files but leave empty inline
stub variables for a feature that is not configured during build.
This patch configures ACPICA internal OSL prototypes out when ACPI is
disabled to facilitate Linux with such configurability.

Note that this patch is generated in the assumption that all ACPICA OSL
APIs should only be used by ACPICA itself.  While the real world is there
are some external ACPICA macros called ACPICA OSL APIs.  This patch
doesn't include protections around the OSL APIs that are used by such
ACPICA external macros.  Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/platform/aclinux.h |   63 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 68cda04..5e5de9c 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -108,6 +108,65 @@
 #define acpi_get_fadt_revision()    0
 #define acpi_test_fadt_flags(__flags) 0
 
+/* OSL prototypes for __KERNEL__, hiding their declarations */
+
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_initialize
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_terminate
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_root_pointer
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_predefined_override
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_table_override
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_physical_table_override
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_create_lock
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_delete_lock
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_acquire_lock
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_release_lock
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_create_semaphore
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_delete_semaphore
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_wait_semaphore
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_signal_semaphore
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_create_mutex
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_delete_mutex
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_acquire_mutex
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_release_mutex
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_allocate
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_allocate_zeroed
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_free
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_map_memory
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_unmap_memory
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_physical_address
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_create_cache
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_delete_cache
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_purge_cache
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_acquire_object
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_release_object
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_install_interrupt_handler
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_remove_interrupt_handler
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_thread_id
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_execute
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_wait_events_complete
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_sleep
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_stall
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_read_port
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_write_port
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_read_memory
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_write_memory
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_read_pci_configuration
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_write_pci_configuration
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_readable
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_writable
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_timer
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_signal
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_printf
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_vprintf
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_redirect_output
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_line
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_table_by_name
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_table_by_index
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_table_by_address
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_open_directory
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_next_filename
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_close_directory
+
 #endif				/* CONFIG_ACPI */
 
 #ifndef ACPI_DISASSEMBLER
@@ -164,6 +223,8 @@
 
 #ifdef __KERNEL__
 
+#ifdef CONFIG_ACPI
+
 /*
  * FIXME: Inclusion of actypes.h
  * Linux kernel need this before defining inline OSL interfaces as
@@ -296,6 +357,8 @@ void acpi_os_gpe_count(u32 gpe_number);
 
 void acpi_os_fixed_event_count(u32 fixed_event_number);
 
+#endif				/* CONFIG_ACPI */
+
 #endif				/* __KERNEL__ */
 
 #endif				/* __ACLINUX_H__ */
-- 
1.7.10.4
