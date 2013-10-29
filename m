From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 18/20] ACPICA: Add support to allow host to redefine individual OSL prototypes.
Date: Tue, 29 Oct 2013 09:30:35 +0800
Message-ID: <ded8977aa40199c2f1e301e13f08eda5428f865e.1383009405.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:56740 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757384Ab3J2Baw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Oct 2013 21:30:52 -0400
In-Reply-To: <cover.1383009405.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

This change enables the host to redefine OSL prototypes found in the
acpiosxf.h file. This allows the host to implement OSL interfaces with
a macro or inlined function. Further, it allows the host to add any
additional required modifiers such as __iomem, __init, __exit, etc.,
as necessary on a per-interface basis. Enables maximum flexibility
for the OSL interfaces. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/acpiosxf.h         |  139 ++++++++++++++++++++++++++++++++++++++-
 include/acpi/platform/aclinux.h |    1 +
 2 files changed, 137 insertions(+), 3 deletions(-)

diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 7f95215..55165fc 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -77,54 +77,80 @@ struct acpi_signal_fatal_info {
 /*
  * OSL Initialization and shutdown primitives
  */
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_initialize
 acpi_status __init acpi_os_initialize(void);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_terminate
 acpi_status acpi_os_terminate(void);
+#endif
 
 /*
  * ACPI Table interfaces
  */
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_root_pointer
 acpi_physical_address acpi_os_get_root_pointer(void);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_predefined_override
 acpi_status
 acpi_os_predefined_override(const struct acpi_predefined_names *init_val,
 			    acpi_string * new_val);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_table_override
 acpi_status
 acpi_os_table_override(struct acpi_table_header *existing_table,
 		       struct acpi_table_header **new_table);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_physical_table_override
 acpi_status
 acpi_os_physical_table_override(struct acpi_table_header *existing_table,
 				acpi_physical_address * new_address,
 				u32 *new_table_length);
+#endif
 
 /*
  * Spinlock primitives
  */
-#ifndef acpi_os_create_lock
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_create_lock
 acpi_status acpi_os_create_lock(acpi_spinlock * out_handle);
 #endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_delete_lock
 void acpi_os_delete_lock(acpi_spinlock handle);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_acquire_lock
 acpi_cpu_flags acpi_os_acquire_lock(acpi_spinlock handle);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_release_lock
 void acpi_os_release_lock(acpi_spinlock handle, acpi_cpu_flags flags);
+#endif
 
 /*
  * Semaphore primitives
  */
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_create_semaphore
 acpi_status
 acpi_os_create_semaphore(u32 max_units,
 			 u32 initial_units, acpi_semaphore * out_handle);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_delete_semaphore
 acpi_status acpi_os_delete_semaphore(acpi_semaphore handle);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_wait_semaphore
 acpi_status
 acpi_os_wait_semaphore(acpi_semaphore handle, u32 units, u16 timeout);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_signal_semaphore
 acpi_status acpi_os_signal_semaphore(acpi_semaphore handle, u32 units);
+#endif
 
 /*
  * Mutex primitives. May be configured to use semaphores instead via
@@ -132,63 +158,98 @@ acpi_status acpi_os_signal_semaphore(acpi_semaphore handle, u32 units);
  */
 #if (ACPI_MUTEX_TYPE != ACPI_BINARY_SEMAPHORE)
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_create_mutex
 acpi_status acpi_os_create_mutex(acpi_mutex * out_handle);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_delete_mutex
 void acpi_os_delete_mutex(acpi_mutex handle);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_acquire_mutex
 acpi_status acpi_os_acquire_mutex(acpi_mutex handle, u16 timeout);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_release_mutex
 void acpi_os_release_mutex(acpi_mutex handle);
 #endif
 
+#endif
+
 /*
  * Memory allocation and mapping
  */
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_allocate
 void *acpi_os_allocate(acpi_size size);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_allocate_zeroed
 void *acpi_os_allocate_zeroed(acpi_size size);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_free
 void acpi_os_free(void *memory);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_map_memory
 void __iomem *acpi_os_map_memory(acpi_physical_address where,
 				acpi_size length);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_unmap_memory
 void acpi_os_unmap_memory(void __iomem * logical_address, acpi_size size);
+#endif
 void early_acpi_os_unmap_memory(void __iomem * virt, acpi_size size);
 
 #ifdef ACPI_FUTURE_USAGE
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_physical_address
 acpi_status
 acpi_os_get_physical_address(void *logical_address,
 			     acpi_physical_address * physical_address);
 #endif
+#endif
 
 /*
  * Memory/Object Cache
  */
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_create_cache
 acpi_status
 acpi_os_create_cache(char *cache_name,
 		     u16 object_size,
 		     u16 max_depth, acpi_cache_t ** return_cache);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_delete_cache
 acpi_status acpi_os_delete_cache(acpi_cache_t * cache);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_purge_cache
 acpi_status acpi_os_purge_cache(acpi_cache_t * cache);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_acquire_object
 void *acpi_os_acquire_object(acpi_cache_t * cache);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_release_object
 acpi_status acpi_os_release_object(acpi_cache_t * cache, void *object);
+#endif
 
 /*
  * Interrupt handlers
  */
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_install_interrupt_handler
 acpi_status
 acpi_os_install_interrupt_handler(u32 interrupt_number,
 				  acpi_osd_handler service_routine,
 				  void *context);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_remove_interrupt_handler
 acpi_status
 acpi_os_remove_interrupt_handler(u32 interrupt_number,
 				 acpi_osd_handler service_routine);
+#endif
 
 void acpi_os_gpe_count(u32 gpe_number);
 void acpi_os_fixed_event_count(u32 fixed_event_number);
@@ -196,86 +257,158 @@ void acpi_os_fixed_event_count(u32 fixed_event_number);
 /*
  * Threads and Scheduling
  */
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_thread_id
 acpi_thread_id acpi_os_get_thread_id(void);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_execute
 acpi_status
 acpi_os_execute(acpi_execute_type type,
 		acpi_osd_exec_callback function, void *context);
+#endif
 
 acpi_status
 acpi_os_hotplug_execute(acpi_osd_exec_callback function, void *context);
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_wait_events_complete
 void acpi_os_wait_events_complete(void);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_sleep
 void acpi_os_sleep(u64 milliseconds);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_stall
 void acpi_os_stall(u32 microseconds);
+#endif
 
 /*
  * Platform and hardware-independent I/O interfaces
  */
-acpi_status acpi_os_read_port(acpi_io_address address, u32 * value, u32 width);
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_read_port
+acpi_status acpi_os_read_port(acpi_io_address address, u32 *value, u32 width);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_write_port
 acpi_status acpi_os_write_port(acpi_io_address address, u32 value, u32 width);
+#endif
 
 /*
  * Platform and hardware-independent physical memory interfaces
  */
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_read_memory
 acpi_status
 acpi_os_read_memory(acpi_physical_address address, u64 *value, u32 width);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_write_memory
 acpi_status
 acpi_os_write_memory(acpi_physical_address address, u64 value, u32 width);
+#endif
 
 /*
  * Platform and hardware-independent PCI configuration space access
  * Note: Can't use "Register" as a parameter, changed to "Reg" --
  * certain compilers complain.
  */
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_read_pci_configuration
 acpi_status
 acpi_os_read_pci_configuration(struct acpi_pci_id *pci_id,
 			       u32 reg, u64 *value, u32 width);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_write_pci_configuration
 acpi_status
 acpi_os_write_pci_configuration(struct acpi_pci_id *pci_id,
 				u32 reg, u64 value, u32 width);
+#endif
 
 /*
  * Miscellaneous
  */
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_readable
+u8 acpi_os_readable(void *pointer, acpi_size length);
+#endif
+
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_writable
+u8 acpi_os_writable(void *pointer, acpi_size length);
+#endif
+
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_timer
 u64 acpi_os_get_timer(void);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_signal
 acpi_status acpi_os_signal(u32 function, void *info);
+#endif
 
 /*
  * Debug print routines
  */
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_printf
 void ACPI_INTERNAL_VAR_XFACE acpi_os_printf(const char *format, ...);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_vprintf
 void acpi_os_vprintf(const char *format, va_list args);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_redirect_output
 void acpi_os_redirect_output(void *destination);
+#endif
 
 #ifdef ACPI_FUTURE_USAGE
 /*
  * Debug input
  */
-u32 acpi_os_get_line(char *buffer);
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_line
+acpi_status acpi_os_get_line(char *buffer, u32 buffer_length, u32 *bytes_read);
+#endif
+#endif
+
+/*
+ * Obtain ACPI table(s)
+ */
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_table_by_name
+acpi_status
+acpi_os_get_table_by_name(char *signature,
+			  u32 instance,
+			  struct acpi_table_header **table,
+			  acpi_physical_address * address);
+#endif
+
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_table_by_index
+acpi_status
+acpi_os_get_table_by_index(u32 index,
+			   struct acpi_table_header **table,
+			   u32 *instance, acpi_physical_address * address);
+#endif
+
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_table_by_address
+acpi_status
+acpi_os_get_table_by_address(acpi_physical_address address,
+			     struct acpi_table_header **table);
 #endif
 
 /*
  * Directory manipulation
  */
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_open_directory
 void *acpi_os_open_directory(char *pathname,
 			     char *wildcard_spec, char requested_file_type);
+#endif
 
 /* requeste_file_type values */
 
 #define REQUEST_FILE_ONLY                   0
 #define REQUEST_DIR_ONLY                    1
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_next_filename
 char *acpi_os_get_next_filename(void *dir_handle);
+#endif
 
+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_close_directory
 void acpi_os_close_directory(void *dir_handle);
+#endif
 
 #endif				/* __ACPIOSXF_H__ */
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 0e6e73c..04e87a3 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -182,6 +182,7 @@ static inline void acpi_os_free(void *a)
 	}							\
 	lock ? AE_OK : AE_NO_MEMORY;				\
 })
+#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_create_lock
 
 #ifdef EXPORT_ACPI_INTERFACES
 #include <linux/export.h>
-- 
1.7.10

