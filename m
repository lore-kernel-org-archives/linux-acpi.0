From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Print error, debug and info messages even if ACPI_DEBUG is off
Date: Mon, 28 Feb 2005 01:18:03 +0100
Message-ID: <4222633B.4030704@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080900010507060308030105"
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------080900010507060308030105
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Shouldn't at least all error and warning messages be printed even if 
ACPI_DEBUG is off?

I collected all ACPI_DEBUG_PRINT (ACPI_DB_ERROR | ACPI_DB_WARN | 
ACPI_DB_INFO, ...) messages for discussion under:

ftp://ftp.suse.com/pub/people/trenn/acpi_messages/acpi_DEBUG_ERROR_messages
ftp://ftp.suse.com/pub/people/trenn/acpi_messages/acpi_DEBUG_WARNING_messages
ftp://ftp.suse.com/pub/people/trenn/acpi_messages/acpi_DEBUG_INFO_messages

The patch (2.6.11-rc5) attached provides another config, 
ACPI_DEBUG_LITE, that at least prints out ACPI_DB_ERROR | ACPI_DB_WARN 
messages.

It's probably cleaner to convert:

ACPI_DEBUG_PRINT (ACPI_DB_ERROR, ...)   -> ACPI_REPORT_ERROR (...)
ACPI_DEBUG_PRINT (ACPI_DB_WARNING, ...) -> ACPI_REPORT_WARNING (...)
ACPI_DEBUG_PRINT (ACPI_DB_INFO, ...)    -> ACPI_REPORT_INFO (...)

to show that messages, even if ACPI_DEBUG is disabled, without the need 
of another config variable.

Before I start on this one, I'd appreciate if someone of the Intel 
people could comment whether this will be accepted for mainline.

Thanks,

       Thomas



--------------080900010507060308030105
Content-Type: text/plain;
 name="acpi_errors_on"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi_errors_on"

Author: Thomas Renninger (mail-smMupaH/RwJM7kwft8N7nw@public.gmane.org)

Patch provides new ACPI_DEBUG_LITE config that prints
ACPI_DB_ERROR and ACPI_DB_WARNING messages even if
ACPI_DEBUG (which uses significantly amount of CPU since
latest kernel versions) is not set.


--- x/drivers/acpi/executer/exconvrt.c.orig	2005-02-24 17:39:47.000000000 +0100
+++ y/drivers/acpi/executer/exconvrt.c	2005-02-27 21:04:32.972577766 +0100
@@ -682,11 +682,9 @@
 
 
 	default:
-		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR,
-			"Unknown Target type ID 0x%X Op %s dest_type %s\n",
+		ACPI_REPORT_ERROR (("Unknown Target type ID 0x%X dest_type %s\n",
 			GET_CURRENT_ARG_TYPE (walk_state->op_info->runtime_args),
-			walk_state->op_info->name, acpi_ut_get_type_name (destination_type)));
-
+		        acpi_ut_get_type_name (destination_type)));
 		ACPI_REPORT_ERROR (("Bad Target Type (ARGI): %X\n",
 			GET_CURRENT_ARG_TYPE (walk_state->op_info->runtime_args)))
 		status = AE_AML_INTERNAL;
--- x/drivers/acpi/executer/exresop.c.orig	2005-02-24 17:40:40.000000000 +0100
+++ y/drivers/acpi/executer/exresop.c	2005-02-27 21:04:32.973577559 +0100
@@ -159,9 +159,10 @@
 
 		return_ACPI_STATUS (AE_AML_INTERNAL);
 	}
-
+#ifdef ACPI_DEBUG_OUTPUT
 	ACPI_DEBUG_PRINT ((ACPI_DB_EXEC, "Opcode %X [%s] required_operand_types=%8.8X \n",
 		opcode, op_info->name, arg_types));
+#endif
 
 	/*
 	 * Normal exit is with (arg_types == 0) at end of argument list.
@@ -232,10 +233,9 @@
 					break;
 
 				default:
-					ACPI_DEBUG_PRINT ((ACPI_DB_ERROR,
+					ACPI_REPORT_ERROR ((
 						"Operand is a Reference, Unknown Reference Opcode %X [%s]\n",
-						obj_desc->reference.opcode,
-						(acpi_ps_get_opcode_info (obj_desc->reference.opcode))->name));
+						obj_desc->reference.opcode));
 
 					return_ACPI_STATUS (AE_AML_OPERAND_TYPE);
 				}
--- x/drivers/acpi/dispatcher/dswload.c.orig	2005-02-24 17:39:53.000000000 +0100
+++ y/drivers/acpi/dispatcher/dswload.c	2005-02-27 21:04:32.973577559 +0100
@@ -706,9 +706,10 @@
 	ACPI_FUNCTION_TRACE ("ds_load2_end_op");
 
 	op = walk_state->op;
+#ifdef ACPI_DEBUG_OUTPUT
 	ACPI_DEBUG_PRINT ((ACPI_DB_DISPATCH, "Opcode [%s] Op %p State %p\n",
 			walk_state->op_info->name, op, walk_state));
-
+#endif
 	/* Only interested in opcodes that have namespace objects */
 
 	if (!(walk_state->op_info->flags & AML_NSOBJECT)) {
--- x/drivers/acpi/events/evmisc.c.orig	2005-02-24 17:40:31.000000000 +0100
+++ y/drivers/acpi/events/evmisc.c	2005-02-27 21:04:32.974577353 +0100
@@ -132,6 +132,7 @@
 	 * For value 0x80 (Status Change) on the power button or sleep button,
 	 * initiate soft-off or sleep operation?
 	 */
+#ifdef ACPI_DEBUG_OUTPUT
 	ACPI_DEBUG_PRINT ((ACPI_DB_INFO,
 		"Dispatching Notify(%X) on node %p\n", notify_value, node));
 
@@ -143,7 +144,7 @@
 		ACPI_DEBUG_PRINT ((ACPI_DB_INFO, "Notify value: 0x%2.2X **Device Specific**\n",
 				notify_value));
 	}
-
+#endif
 	/* Get the notify object attached to the NS Node */
 
 	obj_desc = acpi_ns_get_attached_object (node);
--- x/drivers/acpi/namespace/nsalloc.c.orig	2005-02-24 17:40:30.000000000 +0100
+++ y/drivers/acpi/namespace/nsalloc.c	2005-02-27 21:04:32.974577353 +0100
@@ -409,9 +409,10 @@
 
 		ACPI_MEM_TRACKING (acpi_gbl_memory_lists[ACPI_MEM_LIST_NSNODE].total_freed++);
 
+#ifdef ACPI_DEBUG_OUTPUT
 		ACPI_DEBUG_PRINT ((ACPI_DB_ALLOCATIONS, "Object %p, Remaining %X\n",
 			child_node, acpi_gbl_current_node_count));
-
+#endif 
 		/*
 		 * Detach an object if there is one, then free the child node
 		 */
--- x/drivers/acpi/parser/psparse.c.orig	2005-02-24 17:39:55.000000000 +0100
+++ y/drivers/acpi/parser/psparse.c	2005-02-27 21:04:32.977576733 +0100
@@ -680,10 +680,12 @@
 			op->common.aml_offset = walk_state->aml_offset;
 
 			if (walk_state->op_info) {
+#ifdef ACPI_DEBUG_OUTPUT
 				ACPI_DEBUG_PRINT ((ACPI_DB_PARSE,
 					"Opcode %4.4X [%s] Op %p Aml %p aml_offset %5.5X\n",
 					 (u32) op->common.aml_opcode, walk_state->op_info->name,
 					 op, parser_state->aml, op->common.aml_offset));
+#endif
 			}
 		}
 
--- x/drivers/acpi/utilities/utmisc.c.orig	2005-02-24 17:39:54.000000000 +0100
+++ y/drivers/acpi/utilities/utmisc.c	2005-02-27 21:04:32.977576733 +0100
@@ -736,8 +736,8 @@
 		acpi_gbl_mutex_info[mutex_id].owner_id = this_thread_id;
 	}
 	else {
-		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "Thread %X could not acquire Mutex [%s] %s\n",
-				 this_thread_id, acpi_ut_get_mutex_name (mutex_id),
+		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "Thread %X could not acquire Mutex %s\n",
+				 this_thread_id,
 				 acpi_format_exception (status)));
 	}
 
@@ -783,8 +783,7 @@
 	 */
 	if (acpi_gbl_mutex_info[mutex_id].owner_id == ACPI_MUTEX_NOT_ACQUIRED) {
 		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR,
-				"Mutex [%s] is not acquired, cannot release\n",
-				acpi_ut_get_mutex_name (mutex_id)));
+				"Mutex is not acquired, cannot release\n"));
 
 		return (AE_NOT_ACQUIRED);
 	}
@@ -800,10 +799,11 @@
 			if (i == mutex_id) {
 				continue;
 			}
-
-			ACPI_DEBUG_PRINT ((ACPI_DB_ERROR,
+			ACPI_DEBUG_PRINT ((ACPI_DB_MUTEX,
 					"Invalid release order: owns [%s], releasing [%s]\n",
-					acpi_ut_get_mutex_name (i), acpi_ut_get_mutex_name (mutex_id)));
+					acpi_ut_get_mutex_name(i), acpi_ut_get_mutex_name (mutex_id)));
+
+			ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "Invalid Mutex release order\n"));
 
 			return (AE_RELEASE_DEADLOCK);
 		}
@@ -816,8 +816,8 @@
 	status = acpi_os_signal_semaphore (acpi_gbl_mutex_info[mutex_id].mutex, 1);
 
 	if (ACPI_FAILURE (status)) {
-		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "Thread %X could not release Mutex [%s] %s\n",
-				 this_thread_id, acpi_ut_get_mutex_name (mutex_id),
+		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "Thread %X could not release Mutex %s\n",
+				 this_thread_id, 
 				 acpi_format_exception (status)));
 	}
 	else {
@@ -1477,6 +1477,7 @@
 	acpi_os_printf ("%8s-%04d: *** Warning: ", module_name, line_number);
 }
 
+EXPORT_SYMBOL(acpi_ut_report_warning);
 
 /*******************************************************************************
  *
--- x/drivers/acpi/Kconfig.orig	2005-02-27 21:06:27.541917348 +0100
+++ y/drivers/acpi/Kconfig	2005-02-27 21:06:29.327548586 +0100
@@ -343,4 +343,14 @@
 	 	This is the ACPI generic container driver which supports
 		ACPI0004, PNP0A05 and PNP0A06 devices
 
+config ACPI_DEBUG_LITE
+        bool "Print ACPI errors and warnings"
+        depends on ACPI
+        default n
+        help
+          Full ACPI_DEBUG output slows down the system significantly,
+	  even if not enabled during runtime.
+	  This variable takes care that errors and warnings will still be printed,
+	  but higher debug levels can not be enabled any more during runtime.
+
 endmenu
--- x/include/acpi/acmacros.h.orig	2005-02-24 17:40:30.000000000 +0100
+++ y/include/acpi/acmacros.h	2005-02-27 21:04:32.976576940 +0100
@@ -604,7 +604,18 @@
 #define ACPI_DUMP_PATHNAME(a,b,c,d)
 #define ACPI_DUMP_RESOURCE_LIST(a)
 #define ACPI_DUMP_BUFFER(a,b)
+
+
+#ifdef ACPI_DEBUG_LITE
+/* compiler must optimize, no solution to only integrate
+   this in preprocessing directives found */
+#define ACPI_DEBUG_PRINT_SUB(L, LINE, DB_INFO, A...) (L == ACPI_LV_ERROR || L == ACPI_LV_WARN) ? \
+ (ACPI_REPORT_WARNING ((A))) : (0)
+#define ACPI_DEBUG_PRINT(pl)  ACPI_DEBUG_PRINT_SUB pl
+#else
 #define ACPI_DEBUG_PRINT(pl)
+#endif
+
 #define ACPI_DEBUG_PRINT_RAW(pl)
 #define ACPI_BREAK_MSG(a)
 
--- x/include/acpi/acutils.h.orig	2005-02-24 17:39:46.000000000 +0100
+++ y/include/acpi/acutils.h	2005-02-27 21:04:32.978576527 +0100
@@ -45,6 +45,8 @@
 #define _ACUTILS_H
 
 
+#include <linux/module.h>
+
 typedef
 acpi_status (*acpi_pkg_callback) (
 	u8                              object_type,

--------------080900010507060308030105--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
