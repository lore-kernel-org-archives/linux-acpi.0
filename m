From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 11/13] ACPI: Enable build of AML interpreter debugger
Date: Thu, 15 Oct 2015 10:08:54 +0800
Message-ID: <68d66bbf4936538cbcfb8c39c1964cc17a034b39.1444874756.git.lv.zheng@intel.com>
References: <cover.1444874756.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1444874756.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch enables ACPICA debugger files using a configurable
CONFIG_ACPI_DEBUGGER configuration item. Those debugger related code that
was originally masked as ACPI_FUTURE_USAGE now gets unmasked.

Necessary OSL stubs are also added in this patch:
1. acpi_os_readable(): This should be arch specific in Linux, while this
    patch doesn't introduce real implementation and a complex mechanism to
    allow architecture specific acpi_os_readable() to be implemented to
    validate the address. It may be done by future commits.
2. acpi_os_get_line(): This is used to obtain debugger command input. This
    patch only introduces a simple KDB concept example in it and the
    example should be co-working with the code implemented in
    acpi_os_printf(). Since this KDB example won't be compiled unless
    ENABLE_DEBUGGER is defined and it seems Linux has already stopped to
    use ENABLE_DEBUGGER, thus do not expect it can work properly.

This patch also cleans up all other ACPI_FUTURE_USAGE surroundings
accordingly.
1. Since linkage error can be automatically detected, declaration in the
   headers needn't be surrounded by ACPI_FUTURE_USAGE.
   So only the following separate exported fuction bodies are masked by
   this macro (other exported fucntions may have already been masked at
   entire module level via drivers/acpi/acpica/Makefile):
     acpi_install_exception_handler()
     acpi_subsystem_status()
     acpi_get_system_info()
     acpi_get_statistics()
     acpi_install_initialization_handler()
2. Since strip can automatically zap the no-user functions, functions that
   are not marked with ACPI_EXPORT_SYMBOL() needn't get surrounded by
   ACPI_FUTURE_USAGE.
   So the following function which is not used by Linux kernel now won't
   get surrounded by this macro:
     acpi_ps_get_name()

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/Kconfig              |    9 +++++++++
 drivers/acpi/acpica/Makefile      |   16 ++++++++++++++++
 drivers/acpi/acpica/acinterp.h    |    2 --
 drivers/acpi/acpica/acnamesp.h    |    4 ----
 drivers/acpi/acpica/acparser.h    |    4 ----
 drivers/acpi/acpica/acutils.h     |    2 --
 drivers/acpi/acpica/evxface.c     |    2 +-
 drivers/acpi/acpica/nsdump.c      |    6 ------
 drivers/acpi/acpica/pstree.c      |    2 --
 drivers/acpi/acpica/psutils.c     |    2 --
 drivers/acpi/acpica/rsutils.c     |    2 --
 drivers/acpi/acpica/rsxface.c     |    4 ++--
 drivers/acpi/acpica/utxface.c     |    2 +-
 drivers/acpi/osl.c                |   11 +++--------
 include/acpi/acpixf.h             |   10 ----------
 include/acpi/platform/aclinux.h   |    7 +++++--
 include/acpi/platform/aclinuxex.h |    5 +++++
 17 files changed, 42 insertions(+), 48 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 5d1015c..706c2e9 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -57,6 +57,15 @@ config ACPI_SYSTEM_POWER_STATES_SUPPORT
 config ACPI_CCA_REQUIRED
 	bool
 
+config ACPI_DEBUGGER
+	bool "In-kernel debugger (EXPERIMENTAL)"
+	select ACPI_DEBUG
+	help
+	  Enable in-kernel debugging facilities: statistics, internal
+	  object dump, single step control method execution.
+	  This is still under development, currently enabling this only
+	  results in the compilation of the ACPICA debugger files.
+
 config ACPI_SLEEP
 	bool
 	depends on SUSPEND || HIBERNATION
diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index fedcc16..a57f019 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -178,7 +178,23 @@ acpi-y +=		\
 	utxferror.o	\
 	utxfmutex.o
 
+acpi-$(CONFIG_ACPI_DEBUGGER) +=	\
+	dbcmds.o		\
+	dbconvert.o		\
+	dbdisply.o		\
+	dbexec.o		\
+	dbhistry.o		\
+	dbinput.o		\
+	dbmethod.o		\
+	dbnames.o		\
+	dbobject.o		\
+	dbstats.o		\
+	dbutils.o		\
+	dbxface.o
+
 acpi-$(ACPI_FUTURE_USAGE) +=	\
+	dbfileio.o		\
+	dbtest.o		\
 	utcache.o		\
 	utfileio.o		\
 	utprint.o		\
diff --git a/drivers/acpi/acpica/acinterp.h b/drivers/acpi/acpica/acinterp.h
index e820ed8..e9e936e 100644
--- a/drivers/acpi/acpica/acinterp.h
+++ b/drivers/acpi/acpica/acinterp.h
@@ -397,12 +397,10 @@ void
 acpi_ex_dump_operands(union acpi_operand_object **operands,
 		      const char *opcode_name, u32 num_opcodes);
 
-#ifdef	ACPI_FUTURE_USAGE
 void
 acpi_ex_dump_object_descriptor(union acpi_operand_object *object, u32 flags);
 
 void acpi_ex_dump_namespace_node(struct acpi_namespace_node *node, u32 flags);
-#endif				/* ACPI_FUTURE_USAGE */
 
 /*
  * exnames - AML namestring support
diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index ea0d907..5d261c9 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -193,9 +193,7 @@ acpi_ns_convert_to_resource(union acpi_operand_object *original_object,
 /*
  * nsdump - Namespace dump/print utilities
  */
-#ifdef	ACPI_FUTURE_USAGE
 void acpi_ns_dump_tables(acpi_handle search_base, u32 max_depth);
-#endif				/* ACPI_FUTURE_USAGE */
 
 void acpi_ns_dump_entry(acpi_handle handle, u32 debug_level);
 
@@ -208,7 +206,6 @@ acpi_status
 acpi_ns_dump_one_object(acpi_handle obj_handle,
 			u32 level, void *context, void **return_value);
 
-#ifdef	ACPI_FUTURE_USAGE
 void
 acpi_ns_dump_objects(acpi_object_type type,
 		     u8 display_type,
@@ -220,7 +217,6 @@ acpi_ns_dump_object_paths(acpi_object_type type,
 			  u8 display_type,
 			  u32 max_depth,
 			  acpi_owner_id owner_id, acpi_handle start_handle);
-#endif				/* ACPI_FUTURE_USAGE */
 
 /*
  * nseval - Namespace evaluation functions
diff --git a/drivers/acpi/acpica/acparser.h b/drivers/acpi/acpica/acparser.h
index 6021ccf..8fc8c7c 100644
--- a/drivers/acpi/acpica/acparser.h
+++ b/drivers/acpi/acpica/acparser.h
@@ -194,10 +194,8 @@ union acpi_parse_object *acpi_ps_find(union acpi_parse_object *scope,
 
 union acpi_parse_object *acpi_ps_get_arg(union acpi_parse_object *op, u32 argn);
 
-#ifdef	ACPI_FUTURE_USAGE
 union acpi_parse_object *acpi_ps_get_depth_next(union acpi_parse_object *origin,
 						union acpi_parse_object *op);
-#endif				/* ACPI_FUTURE_USAGE */
 
 /*
  * pswalk - parse tree walk routines
@@ -235,9 +233,7 @@ void acpi_ps_free_op(union acpi_parse_object *op);
 
 u8 acpi_ps_is_leading_char(u32 c);
 
-#ifdef	ACPI_FUTURE_USAGE
 u32 acpi_ps_get_name(union acpi_parse_object *op);
-#endif				/* ACPI_FUTURE_USAGE */
 
 void acpi_ps_set_name(union acpi_parse_object *op, u32 name);
 
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index fb2aa50..8b8fef6 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -635,9 +635,7 @@ void
 acpi_ut_free_and_track(void *address,
 		       u32 component, const char *module, u32 line);
 
-#ifdef	ACPI_FUTURE_USAGE
 void acpi_ut_dump_allocation_info(void);
-#endif				/* ACPI_FUTURE_USAGE */
 
 void acpi_ut_dump_allocations(u32 component, const char *module);
 
diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index 81f2d9e..07d22bf 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -405,7 +405,7 @@ cleanup:
 }
 
 ACPI_EXPORT_SYMBOL(acpi_install_exception_handler)
-#endif				/*  ACPI_FUTURE_USAGE  */
+#endif
 
 #if (!ACPI_REDUCED_HARDWARE)
 /*******************************************************************************
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 0f1daba..37aa5c4 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -60,7 +60,6 @@ acpi_ns_dump_one_device(acpi_handle obj_handle,
 
 #if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DEBUGGER)
 
-#ifdef	ACPI_FUTURE_USAGE
 static acpi_status
 acpi_ns_dump_one_object_path(acpi_handle obj_handle,
 			     u32 level, void *context, void **return_value);
@@ -68,7 +67,6 @@ acpi_ns_dump_one_object_path(acpi_handle obj_handle,
 static acpi_status
 acpi_ns_get_max_depth(acpi_handle obj_handle,
 		      u32 level, void *context, void **return_value);
-#endif				/* ACPI_FUTURE_USAGE */
 
 /*******************************************************************************
  *
@@ -625,7 +623,6 @@ cleanup:
 	return (AE_OK);
 }
 
-#ifdef ACPI_FUTURE_USAGE
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ns_dump_objects
@@ -680,9 +677,7 @@ acpi_ns_dump_objects(acpi_object_type type,
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 }
-#endif				/* ACPI_FUTURE_USAGE */
 
-#ifdef	ACPI_FUTURE_USAGE
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ns_dump_one_object_path, acpi_ns_get_max_depth
@@ -810,7 +805,6 @@ acpi_ns_dump_object_paths(acpi_object_type type,
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 }
-#endif				/* ACPI_FUTURE_USAGE */
 
 /*******************************************************************************
  *
diff --git a/drivers/acpi/acpica/pstree.c b/drivers/acpi/acpica/pstree.c
index 89984f3..cf2f2fa 100644
--- a/drivers/acpi/acpica/pstree.c
+++ b/drivers/acpi/acpica/pstree.c
@@ -183,7 +183,6 @@ acpi_ps_append_arg(union acpi_parse_object *op, union acpi_parse_object *arg)
 	}
 }
 
-#ifdef ACPI_FUTURE_USAGE
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ps_get_depth_next
@@ -317,4 +316,3 @@ union acpi_parse_object *acpi_ps_get_child(union acpi_parse_object *op)
 	return (child);
 }
 #endif
-#endif				/*  ACPI_FUTURE_USAGE  */
diff --git a/drivers/acpi/acpica/psutils.c b/drivers/acpi/acpica/psutils.c
index 183cc1e..71d2877 100644
--- a/drivers/acpi/acpica/psutils.c
+++ b/drivers/acpi/acpica/psutils.c
@@ -205,7 +205,6 @@ u8 acpi_ps_is_leading_char(u32 c)
 /*
  * Get op's name (4-byte name segment) or 0 if unnamed
  */
-#ifdef ACPI_FUTURE_USAGE
 u32 acpi_ps_get_name(union acpi_parse_object * op)
 {
 
@@ -219,7 +218,6 @@ u32 acpi_ps_get_name(union acpi_parse_object * op)
 
 	return (op->named.name);
 }
-#endif				/*  ACPI_FUTURE_USAGE  */
 
 /*
  * Set op's name
diff --git a/drivers/acpi/acpica/rsutils.c b/drivers/acpi/acpica/rsutils.c
index 52b024d..9486992 100644
--- a/drivers/acpi/acpica/rsutils.c
+++ b/drivers/acpi/acpica/rsutils.c
@@ -564,7 +564,6 @@ acpi_rs_get_crs_method_data(struct acpi_namespace_node *node,
  *
  ******************************************************************************/
 
-#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_rs_get_prs_method_data(struct acpi_namespace_node *node,
 			    struct acpi_buffer *ret_buffer)
@@ -596,7 +595,6 @@ acpi_rs_get_prs_method_data(struct acpi_namespace_node *node,
 	acpi_ut_remove_reference(obj_desc);
 	return_ACPI_STATUS(status);
 }
-#endif				/*  ACPI_FUTURE_USAGE  */
 
 /*******************************************************************************
  *
diff --git a/drivers/acpi/acpica/rsxface.c b/drivers/acpi/acpica/rsxface.c
index de51f83..1e8cd57 100644
--- a/drivers/acpi/acpica/rsxface.c
+++ b/drivers/acpi/acpica/rsxface.c
@@ -220,7 +220,7 @@ acpi_get_current_resources(acpi_handle device_handle,
 }
 
 ACPI_EXPORT_SYMBOL(acpi_get_current_resources)
-#ifdef ACPI_FUTURE_USAGE
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_get_possible_resources
@@ -262,7 +262,7 @@ acpi_get_possible_resources(acpi_handle device_handle,
 }
 
 ACPI_EXPORT_SYMBOL(acpi_get_possible_resources)
-#endif				/*  ACPI_FUTURE_USAGE  */
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_set_current_resources
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index a6b0eb0..f9c8f9c 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -253,7 +253,7 @@ acpi_install_initialization_handler(acpi_init_handler handler, u32 function)
 }
 
 ACPI_EXPORT_SYMBOL(acpi_install_initialization_handler)
-#endif				/*  ACPI_FUTURE_USAGE  */
+#endif
 
 /*****************************************************************************
  *
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 739a4a6..3272915 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -66,8 +66,6 @@ struct acpi_os_dpc {
 /* stuff for debugger support */
 int acpi_in_debugger;
 EXPORT_SYMBOL(acpi_in_debugger);
-
-extern char line_buf[80];
 #endif				/*ENABLE_DEBUGGER */
 
 static int (*__acpi_os_prepare_sleep)(u8 sleep_state, u32 pm1a_ctrl,
@@ -1345,15 +1343,13 @@ acpi_status acpi_os_signal_semaphore(acpi_handle handle, u32 units)
 	return AE_OK;
 }
 
-#ifdef ACPI_FUTURE_USAGE
-u32 acpi_os_get_line(char *buffer)
+acpi_status acpi_os_get_line(char *buffer, u32 buffer_length, u32 *bytes_read)
 {
-
 #ifdef ENABLE_DEBUGGER
 	if (acpi_in_debugger) {
 		u32 chars;
 
-		kdb_read(buffer, sizeof(line_buf));
+		kdb_read(buffer, buffer_length);
 
 		/* remove the CR kdb includes */
 		chars = strlen(buffer) - 1;
@@ -1361,9 +1357,8 @@ u32 acpi_os_get_line(char *buffer)
 	}
 #endif
 
-	return 0;
+	return AE_OK;
 }
-#endif				/*  ACPI_FUTURE_USAGE  */
 
 acpi_status acpi_os_signal(u32 function, void *info)
 {
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index c33eeab..89a4018 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -393,15 +393,11 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status __init acpi_terminate(void))
  */
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable(void))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_disable(void))
-#ifdef ACPI_FUTURE_USAGE
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status acpi_subsystem_status(void))
-#endif
 
-#ifdef ACPI_FUTURE_USAGE
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			    acpi_get_system_info(struct acpi_buffer
 						 *ret_buffer))
-#endif
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			     acpi_get_statistics(struct acpi_statistics *stats))
 ACPI_EXTERNAL_RETURN_PTR(const char
@@ -625,11 +621,9 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 							       space_id,
 							       acpi_adr_space_handler
 							       handler))
-#ifdef ACPI_FUTURE_USAGE
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			     acpi_install_exception_handler
 			     (acpi_exception_handler handler))
-#endif
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			     acpi_install_interface_handler
 			     (acpi_interface_handler handler))
@@ -750,12 +744,10 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			     acpi_get_current_resources(acpi_handle device,
 							struct acpi_buffer
 							*ret_buffer))
-#ifdef ACPI_FUTURE_USAGE
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			     acpi_get_possible_resources(acpi_handle device,
 							 struct acpi_buffer
 							 *ret_buffer))
-#endif
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			     acpi_get_event_resources(acpi_handle device_handle,
 						      struct acpi_buffer
@@ -844,7 +836,6 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 /*
  * ACPI Timer interfaces
  */
-#ifdef ACPI_FUTURE_USAGE
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_get_timer_resolution(u32 *resolution))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_get_timer(u32 *ticks))
@@ -853,7 +844,6 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_get_timer_duration(u32 start_ticks,
 							u32 end_ticks,
 							u32 *time_elapsed))
-#endif				/* ACPI_FUTURE_USAGE */
 
 /*
  * Error/Warning output
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 74ba46c..323e5da 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -63,12 +63,16 @@
 
 #define ACPI_USE_SYSTEM_INTTYPES
 
-/* Compile for reduced hardware mode only with this kernel config */
+/* Kernel specific ACPICA configuration */
 
 #ifdef CONFIG_ACPI_REDUCED_HARDWARE_ONLY
 #define ACPI_REDUCED_HARDWARE 1
 #endif
 
+#ifdef CONFIG_ACPI_DEBUGGER
+#define ACPI_DEBUGGER
+#endif
+
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/ctype.h>
@@ -151,7 +155,6 @@
  * OSL interfaces used by utilities
  */
 #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_redirect_output
-#define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_line
 #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_table_by_name
 #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_table_by_index
 #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_get_table_by_address
diff --git a/include/acpi/platform/aclinuxex.h b/include/acpi/platform/aclinuxex.h
index acedc3f..fd6d70f 100644
--- a/include/acpi/platform/aclinuxex.h
+++ b/include/acpi/platform/aclinuxex.h
@@ -124,6 +124,11 @@ static inline acpi_thread_id acpi_os_get_thread_id(void)
 		lock ? AE_OK : AE_NO_MEMORY; \
 	})
 
+static inline u8 acpi_os_readable(void *pointer, acpi_size length)
+{
+	return TRUE;
+}
+
 /*
  * OSL interfaces added by Linux
  */
-- 
1.7.10
