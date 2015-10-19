From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 08/14] ACPICA: Linuxize: Export debugger files to Linux
Date: Mon, 19 Oct 2015 10:25:20 +0800
Message-ID: <c14cbb09e56c15a2ad97a39d85c31fae172ed1b9.1445221165.git.lv.zheng@intel.com>
References: <8c1016ca8a570ba7c7a1c9f0f88d73cd83cea490> <cover.1445221164.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1445221164.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit bc2d3daa4bd429611451f28800def9fea55e63de

This patch exports debugger files to Linux.

Link: https://github.com/acpica/acpica/commit/bc2d3daa
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/dbcmds.c    | 1187 ++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/dbconvert.c |  484 +++++++++++++++
 drivers/acpi/acpica/dbdisply.c  | 1108 ++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/dbexec.c    |  753 +++++++++++++++++++++++
 drivers/acpi/acpica/dbfileio.c  |  256 ++++++++
 drivers/acpi/acpica/dbhistry.c  |  239 ++++++++
 drivers/acpi/acpica/dbinput.c   | 1274 +++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/dbmethod.c  |  369 ++++++++++++
 drivers/acpi/acpica/dbnames.c   |  947 +++++++++++++++++++++++++++++
 drivers/acpi/acpica/dbobject.c  |  533 ++++++++++++++++
 drivers/acpi/acpica/dbstats.c   |  546 +++++++++++++++++
 drivers/acpi/acpica/dbtest.c    | 1057 ++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/dbutils.c   |  457 ++++++++++++++
 drivers/acpi/acpica/dbxface.c   |  467 ++++++++++++++
 14 files changed, 9677 insertions(+)
 create mode 100644 drivers/acpi/acpica/dbcmds.c
 create mode 100644 drivers/acpi/acpica/dbconvert.c
 create mode 100644 drivers/acpi/acpica/dbdisply.c
 create mode 100644 drivers/acpi/acpica/dbexec.c
 create mode 100644 drivers/acpi/acpica/dbfileio.c
 create mode 100644 drivers/acpi/acpica/dbhistry.c
 create mode 100644 drivers/acpi/acpica/dbinput.c
 create mode 100644 drivers/acpi/acpica/dbmethod.c
 create mode 100644 drivers/acpi/acpica/dbnames.c
 create mode 100644 drivers/acpi/acpica/dbobject.c
 create mode 100644 drivers/acpi/acpica/dbstats.c
 create mode 100644 drivers/acpi/acpica/dbtest.c
 create mode 100644 drivers/acpi/acpica/dbutils.c
 create mode 100644 drivers/acpi/acpica/dbxface.c

diff --git a/drivers/acpi/acpica/dbcmds.c b/drivers/acpi/acpica/dbcmds.c
new file mode 100644
index 0000000..30414b3
--- /dev/null
+++ b/drivers/acpi/acpica/dbcmds.c
@@ -0,0 +1,1187 @@
+/*******************************************************************************
+ *
+ * Module Name: dbcmds - Miscellaneous debug commands and output routines
+ *
+ ******************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2015, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include <acpi/acpi.h>
+#include "accommon.h"
+#include "acevents.h"
+#include "acdebug.h"
+#include "acnamesp.h"
+#include "acresrc.h"
+#include "actables.h"
+
+#define _COMPONENT          ACPI_CA_DEBUGGER
+ACPI_MODULE_NAME("dbcmds")
+
+/* Local prototypes */
+static void
+acpi_dm_compare_aml_resources(u8 *aml1_buffer,
+			      acpi_rsdesc_size aml1_buffer_length,
+			      u8 *aml2_buffer,
+			      acpi_rsdesc_size aml2_buffer_length);
+
+static acpi_status
+acpi_dm_test_resource_conversion(struct acpi_namespace_node *node, char *name);
+
+static acpi_status
+acpi_db_resource_callback(struct acpi_resource *resource, void *context);
+
+static acpi_status
+acpi_db_device_resources(acpi_handle obj_handle,
+			 u32 nesting_level, void *context, void **return_value);
+
+static void acpi_db_do_one_sleep_state(u8 sleep_state);
+
+static char *acpi_db_trace_method_name = NULL;
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_convert_to_node
+ *
+ * PARAMETERS:  in_string           - String to convert
+ *
+ * RETURN:      Pointer to a NS node
+ *
+ * DESCRIPTION: Convert a string to a valid NS pointer. Handles numeric or
+ *              alphanumeric strings.
+ *
+ ******************************************************************************/
+
+struct acpi_namespace_node *acpi_db_convert_to_node(char *in_string)
+{
+	struct acpi_namespace_node *node;
+	acpi_size address;
+
+	if ((*in_string >= 0x30) && (*in_string <= 0x39)) {
+
+		/* Numeric argument, convert */
+
+		address = strtoul(in_string, NULL, 16);
+		node = ACPI_TO_POINTER(address);
+		if (!acpi_os_readable(node, sizeof(struct acpi_namespace_node))) {
+			acpi_os_printf("Address %p is invalid", node);
+			return (NULL);
+		}
+
+		/* Make sure pointer is valid NS node */
+
+		if (ACPI_GET_DESCRIPTOR_TYPE(node) != ACPI_DESC_TYPE_NAMED) {
+			acpi_os_printf
+			    ("Address %p is not a valid namespace node [%s]\n",
+			     node, acpi_ut_get_descriptor_name(node));
+			return (NULL);
+		}
+	} else {
+		/*
+		 * Alpha argument: The parameter is a name string that must be
+		 * resolved to a Namespace object.
+		 */
+		node = acpi_db_local_ns_lookup(in_string);
+		if (!node) {
+			acpi_os_printf
+			    ("Could not find [%s] in namespace, defaulting to root node\n",
+			     in_string);
+			node = acpi_gbl_root_node;
+		}
+	}
+
+	return (node);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_sleep
+ *
+ * PARAMETERS:  object_arg          - Desired sleep state (0-5). NULL means
+ *                                    invoke all possible sleep states.
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Simulate sleep/wake sequences
+ *
+ ******************************************************************************/
+
+acpi_status acpi_db_sleep(char *object_arg)
+{
+	u8 sleep_state;
+	u32 i;
+
+	ACPI_FUNCTION_TRACE(acpi_db_sleep);
+
+	/* Null input (no arguments) means to invoke all sleep states */
+
+	if (!object_arg) {
+		acpi_os_printf("Invoking all possible sleep states, 0-%d\n",
+			       ACPI_S_STATES_MAX);
+
+		for (i = 0; i <= ACPI_S_STATES_MAX; i++) {
+			acpi_db_do_one_sleep_state((u8)i);
+		}
+
+		return_ACPI_STATUS(AE_OK);
+	}
+
+	/* Convert argument to binary and invoke the sleep state */
+
+	sleep_state = (u8)strtoul(object_arg, NULL, 0);
+	acpi_db_do_one_sleep_state(sleep_state);
+	return_ACPI_STATUS(AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_do_one_sleep_state
+ *
+ * PARAMETERS:  sleep_state         - Desired sleep state (0-5)
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Simulate a sleep/wake sequence
+ *
+ ******************************************************************************/
+
+static void acpi_db_do_one_sleep_state(u8 sleep_state)
+{
+	acpi_status status;
+	u8 sleep_type_a;
+	u8 sleep_type_b;
+
+	/* Validate parameter */
+
+	if (sleep_state > ACPI_S_STATES_MAX) {
+		acpi_os_printf("Sleep state %d out of range (%d max)\n",
+			       sleep_state, ACPI_S_STATES_MAX);
+		return;
+	}
+
+	acpi_os_printf("\n---- Invoking sleep state S%d (%s):\n",
+		       sleep_state, acpi_gbl_sleep_state_names[sleep_state]);
+
+	/* Get the values for the sleep type registers (for display only) */
+
+	status =
+	    acpi_get_sleep_type_data(sleep_state, &sleep_type_a, &sleep_type_b);
+	if (ACPI_FAILURE(status)) {
+		acpi_os_printf("Could not evaluate [%s] method, %s\n",
+			       acpi_gbl_sleep_state_names[sleep_state],
+			       acpi_format_exception(status));
+		return;
+	}
+
+	acpi_os_printf
+	    ("Register values for sleep state S%d: Sleep-A: %.2X, Sleep-B: %.2X\n",
+	     sleep_state, sleep_type_a, sleep_type_b);
+
+	/* Invoke the various sleep/wake interfaces */
+
+	acpi_os_printf("**** Sleep: Prepare to sleep (S%d) ****\n",
+		       sleep_state);
+	status = acpi_enter_sleep_state_prep(sleep_state);
+	if (ACPI_FAILURE(status)) {
+		goto error_exit;
+	}
+
+	acpi_os_printf("**** Sleep: Going to sleep (S%d) ****\n", sleep_state);
+	status = acpi_enter_sleep_state(sleep_state);
+	if (ACPI_FAILURE(status)) {
+		goto error_exit;
+	}
+
+	acpi_os_printf("**** Wake: Prepare to return from sleep (S%d) ****\n",
+		       sleep_state);
+	status = acpi_leave_sleep_state_prep(sleep_state);
+	if (ACPI_FAILURE(status)) {
+		goto error_exit;
+	}
+
+	acpi_os_printf("**** Wake: Return from sleep (S%d) ****\n",
+		       sleep_state);
+	status = acpi_leave_sleep_state(sleep_state);
+	if (ACPI_FAILURE(status)) {
+		goto error_exit;
+	}
+
+	return;
+
+error_exit:
+	ACPI_EXCEPTION((AE_INFO, status, "During invocation of sleep state S%d",
+			sleep_state));
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_display_locks
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Display information about internal mutexes.
+ *
+ ******************************************************************************/
+
+void acpi_db_display_locks(void)
+{
+	u32 i;
+
+	for (i = 0; i < ACPI_MAX_MUTEX; i++) {
+		acpi_os_printf("%26s : %s\n", acpi_ut_get_mutex_name(i),
+			       acpi_gbl_mutex_info[i].thread_id ==
+			       ACPI_MUTEX_NOT_ACQUIRED ? "Locked" : "Unlocked");
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_display_table_info
+ *
+ * PARAMETERS:  table_arg           - Name of table to be displayed
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Display information about loaded tables. Current
+ *              implementation displays all loaded tables.
+ *
+ ******************************************************************************/
+
+void acpi_db_display_table_info(char *table_arg)
+{
+	u32 i;
+	struct acpi_table_desc *table_desc;
+	acpi_status status;
+
+	/* Header */
+
+	acpi_os_printf("Idx ID  Status Type                    "
+		       "TableHeader (Sig, Address, Length, Misc)\n");
+
+	/* Walk the entire root table list */
+
+	for (i = 0; i < acpi_gbl_root_table_list.current_table_count; i++) {
+		table_desc = &acpi_gbl_root_table_list.tables[i];
+
+		/* Index and Table ID */
+
+		acpi_os_printf("%3u %.2u ", i, table_desc->owner_id);
+
+		/* Decode the table flags */
+
+		if (!(table_desc->flags & ACPI_TABLE_IS_LOADED)) {
+			acpi_os_printf("NotLoaded ");
+		} else {
+			acpi_os_printf(" Loaded ");
+		}
+
+		switch (table_desc->flags & ACPI_TABLE_ORIGIN_MASK) {
+		case ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL:
+
+			acpi_os_printf("External/virtual ");
+			break;
+
+		case ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL:
+
+			acpi_os_printf("Internal/physical ");
+			break;
+
+		case ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL:
+
+			acpi_os_printf("Internal/virtual ");
+			break;
+
+		default:
+
+			acpi_os_printf("INVALID TYPE    ");
+			break;
+		}
+
+		/* Make sure that the table is mapped */
+
+		status = acpi_tb_validate_table(table_desc);
+		if (ACPI_FAILURE(status)) {
+			return;
+		}
+
+		/* Dump the table header */
+
+		if (table_desc->pointer) {
+			acpi_tb_print_table_header(table_desc->address,
+						   table_desc->pointer);
+		} else {
+			/* If the pointer is null, the table has been unloaded */
+
+			ACPI_INFO((AE_INFO, "%4.4s - Table has been unloaded",
+				   table_desc->signature.ascii));
+		}
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_unload_acpi_table
+ *
+ * PARAMETERS:  object_name         - Namespace pathname for an object that
+ *                                    is owned by the table to be unloaded
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Unload an ACPI table, via any namespace node that is owned
+ *              by the table.
+ *
+ ******************************************************************************/
+
+void acpi_db_unload_acpi_table(char *object_name)
+{
+	struct acpi_namespace_node *node;
+	acpi_status status;
+
+	/* Translate name to an Named object */
+
+	node = acpi_db_convert_to_node(object_name);
+	if (!node) {
+		return;
+	}
+
+	status = acpi_unload_parent_table(ACPI_CAST_PTR(acpi_handle, node));
+	if (ACPI_SUCCESS(status)) {
+		acpi_os_printf("Parent of [%s] (%p) unloaded and uninstalled\n",
+			       object_name, node);
+	} else {
+		acpi_os_printf("%s, while unloading parent table of [%s]\n",
+			       acpi_format_exception(status), object_name);
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_send_notify
+ *
+ * PARAMETERS:  name                - Name of ACPI object where to send notify
+ *              value               - Value of the notify to send.
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Send an ACPI notification. The value specified is sent to the
+ *              named object as an ACPI notify.
+ *
+ ******************************************************************************/
+
+void acpi_db_send_notify(char *name, u32 value)
+{
+	struct acpi_namespace_node *node;
+	acpi_status status;
+
+	/* Translate name to an Named object */
+
+	node = acpi_db_convert_to_node(name);
+	if (!node) {
+		return;
+	}
+
+	/* Dispatch the notify if legal */
+
+	if (acpi_ev_is_notify_object(node)) {
+		status = acpi_ev_queue_notify_request(node, value);
+		if (ACPI_FAILURE(status)) {
+			acpi_os_printf("Could not queue notify\n");
+		}
+	} else {
+		acpi_os_printf("Named object [%4.4s] Type %s, "
+			       "must be Device/Thermal/Processor type\n",
+			       acpi_ut_get_node_name(node),
+			       acpi_ut_get_type_name(node->type));
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_display_interfaces
+ *
+ * PARAMETERS:  action_arg          - Null, "install", or "remove"
+ *              interface_name_arg  - Name for install/remove options
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Display or modify the global _OSI interface list
+ *
+ ******************************************************************************/
+
+void acpi_db_display_interfaces(char *action_arg, char *interface_name_arg)
+{
+	struct acpi_interface_info *next_interface;
+	char *sub_string;
+	acpi_status status;
+
+	/* If no arguments, just display current interface list */
+
+	if (!action_arg) {
+		(void)acpi_os_acquire_mutex(acpi_gbl_osi_mutex,
+					    ACPI_WAIT_FOREVER);
+
+		next_interface = acpi_gbl_supported_interfaces;
+		while (next_interface) {
+			if (!(next_interface->flags & ACPI_OSI_INVALID)) {
+				acpi_os_printf("%s\n", next_interface->name);
+			}
+
+			next_interface = next_interface->next;
+		}
+
+		acpi_os_release_mutex(acpi_gbl_osi_mutex);
+		return;
+	}
+
+	/* If action_arg exists, so must interface_name_arg */
+
+	if (!interface_name_arg) {
+		acpi_os_printf("Missing Interface Name argument\n");
+		return;
+	}
+
+	/* Uppercase the action for match below */
+
+	acpi_ut_strupr(action_arg);
+
+	/* install - install an interface */
+
+	sub_string = strstr("INSTALL", action_arg);
+	if (sub_string) {
+		status = acpi_install_interface(interface_name_arg);
+		if (ACPI_FAILURE(status)) {
+			acpi_os_printf("%s, while installing \"%s\"\n",
+				       acpi_format_exception(status),
+				       interface_name_arg);
+		}
+		return;
+	}
+
+	/* remove - remove an interface */
+
+	sub_string = strstr("REMOVE", action_arg);
+	if (sub_string) {
+		status = acpi_remove_interface(interface_name_arg);
+		if (ACPI_FAILURE(status)) {
+			acpi_os_printf("%s, while removing \"%s\"\n",
+				       acpi_format_exception(status),
+				       interface_name_arg);
+		}
+		return;
+	}
+
+	/* Invalid action_arg */
+
+	acpi_os_printf("Invalid action argument: %s\n", action_arg);
+	return;
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_display_template
+ *
+ * PARAMETERS:  buffer_arg          - Buffer name or address
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Dump a buffer that contains a resource template
+ *
+ ******************************************************************************/
+
+void acpi_db_display_template(char *buffer_arg)
+{
+	struct acpi_namespace_node *node;
+	acpi_status status;
+	struct acpi_buffer return_buffer;
+
+	/* Translate buffer_arg to an Named object */
+
+	node = acpi_db_convert_to_node(buffer_arg);
+	if (!node || (node == acpi_gbl_root_node)) {
+		acpi_os_printf("Invalid argument: %s\n", buffer_arg);
+		return;
+	}
+
+	/* We must have a buffer object */
+
+	if (node->type != ACPI_TYPE_BUFFER) {
+		acpi_os_printf
+		    ("Not a Buffer object, cannot be a template: %s\n",
+		     buffer_arg);
+		return;
+	}
+
+	return_buffer.length = ACPI_DEBUG_BUFFER_SIZE;
+	return_buffer.pointer = acpi_gbl_db_buffer;
+
+	/* Attempt to convert the raw buffer to a resource list */
+
+	status = acpi_rs_create_resource_list(node->object, &return_buffer);
+
+	acpi_db_set_output_destination(ACPI_DB_REDIRECTABLE_OUTPUT);
+	acpi_dbg_level |= ACPI_LV_RESOURCES;
+
+	if (ACPI_FAILURE(status)) {
+		acpi_os_printf
+		    ("Could not convert Buffer to a resource list: %s, %s\n",
+		     buffer_arg, acpi_format_exception(status));
+		goto dump_buffer;
+	}
+
+	/* Now we can dump the resource list */
+
+	acpi_rs_dump_resource_list(ACPI_CAST_PTR(struct acpi_resource,
+						 return_buffer.pointer));
+
+dump_buffer:
+	acpi_os_printf("\nRaw data buffer:\n");
+	acpi_ut_debug_dump_buffer((u8 *)node->object->buffer.pointer,
+				  node->object->buffer.length,
+				  DB_BYTE_DISPLAY, ACPI_UINT32_MAX);
+
+	acpi_db_set_output_destination(ACPI_DB_CONSOLE_OUTPUT);
+	return;
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_dm_compare_aml_resources
+ *
+ * PARAMETERS:  aml1_buffer         - Contains first resource list
+ *              aml1_buffer_length  - Length of first resource list
+ *              aml2_buffer         - Contains second resource list
+ *              aml2_buffer_length  - Length of second resource list
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Compare two AML resource lists, descriptor by descriptor (in
+ *              order to isolate a miscompare to an individual resource)
+ *
+ ******************************************************************************/
+
+static void
+acpi_dm_compare_aml_resources(u8 *aml1_buffer,
+			      acpi_rsdesc_size aml1_buffer_length,
+			      u8 *aml2_buffer,
+			      acpi_rsdesc_size aml2_buffer_length)
+{
+	u8 *aml1;
+	u8 *aml2;
+	u8 *aml1_end;
+	u8 *aml2_end;
+	acpi_rsdesc_size aml1_length;
+	acpi_rsdesc_size aml2_length;
+	acpi_rsdesc_size offset = 0;
+	u8 resource_type;
+	u32 count = 0;
+	u32 i;
+
+	/* Compare overall buffer sizes (may be different due to size rounding) */
+
+	if (aml1_buffer_length != aml2_buffer_length) {
+		acpi_os_printf("**** Buffer length mismatch in converted "
+			       "AML: Original %X, New %X ****\n",
+			       aml1_buffer_length, aml2_buffer_length);
+	}
+
+	aml1 = aml1_buffer;
+	aml2 = aml2_buffer;
+	aml1_end = aml1_buffer + aml1_buffer_length;
+	aml2_end = aml2_buffer + aml2_buffer_length;
+
+	/* Walk the descriptor lists, comparing each descriptor */
+
+	while ((aml1 < aml1_end) && (aml2 < aml2_end)) {
+
+		/* Get the lengths of each descriptor */
+
+		aml1_length = acpi_ut_get_descriptor_length(aml1);
+		aml2_length = acpi_ut_get_descriptor_length(aml2);
+		resource_type = acpi_ut_get_resource_type(aml1);
+
+		/* Check for descriptor length match */
+
+		if (aml1_length != aml2_length) {
+			acpi_os_printf
+			    ("**** Length mismatch in descriptor [%.2X] type %2.2X, "
+			     "Offset %8.8X Len1 %X, Len2 %X ****\n", count,
+			     resource_type, offset, aml1_length, aml2_length);
+		}
+
+		/* Check for descriptor byte match */
+
+		else if (memcmp(aml1, aml2, aml1_length)) {
+			acpi_os_printf
+			    ("**** Data mismatch in descriptor [%.2X] type %2.2X, "
+			     "Offset %8.8X ****\n", count, resource_type,
+			     offset);
+
+			for (i = 0; i < aml1_length; i++) {
+				if (aml1[i] != aml2[i]) {
+					acpi_os_printf
+					    ("Mismatch at byte offset %.2X: is %2.2X, "
+					     "should be %2.2X\n", i, aml2[i],
+					     aml1[i]);
+				}
+			}
+		}
+
+		/* Exit on end_tag descriptor */
+
+		if (resource_type == ACPI_RESOURCE_NAME_END_TAG) {
+			return;
+		}
+
+		/* Point to next descriptor in each buffer */
+
+		count++;
+		offset += aml1_length;
+		aml1 += aml1_length;
+		aml2 += aml2_length;
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_dm_test_resource_conversion
+ *
+ * PARAMETERS:  node                - Parent device node
+ *              name                - resource method name (_CRS)
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Compare the original AML with a conversion of the AML to
+ *              internal resource list, then back to AML.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_dm_test_resource_conversion(struct acpi_namespace_node *node, char *name)
+{
+	acpi_status status;
+	struct acpi_buffer return_buffer;
+	struct acpi_buffer resource_buffer;
+	struct acpi_buffer new_aml;
+	union acpi_object *original_aml;
+
+	acpi_os_printf("Resource Conversion Comparison:\n");
+
+	new_aml.length = ACPI_ALLOCATE_LOCAL_BUFFER;
+	return_buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
+	resource_buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
+
+	/* Get the original _CRS AML resource template */
+
+	status = acpi_evaluate_object(node, name, NULL, &return_buffer);
+	if (ACPI_FAILURE(status)) {
+		acpi_os_printf("Could not obtain %s: %s\n",
+			       name, acpi_format_exception(status));
+		return (status);
+	}
+
+	/* Get the AML resource template, converted to internal resource structs */
+
+	status = acpi_get_current_resources(node, &resource_buffer);
+	if (ACPI_FAILURE(status)) {
+		acpi_os_printf("AcpiGetCurrentResources failed: %s\n",
+			       acpi_format_exception(status));
+		goto exit1;
+	}
+
+	/* Convert internal resource list to external AML resource template */
+
+	status = acpi_rs_create_aml_resources(&resource_buffer, &new_aml);
+	if (ACPI_FAILURE(status)) {
+		acpi_os_printf("AcpiRsCreateAmlResources failed: %s\n",
+			       acpi_format_exception(status));
+		goto exit2;
+	}
+
+	/* Compare original AML to the newly created AML resource list */
+
+	original_aml = return_buffer.pointer;
+
+	acpi_dm_compare_aml_resources(original_aml->buffer.pointer,
+				      (acpi_rsdesc_size) original_aml->buffer.
+				      length, new_aml.pointer,
+				      (acpi_rsdesc_size) new_aml.length);
+
+	/* Cleanup and exit */
+
+	ACPI_FREE(new_aml.pointer);
+exit2:
+	ACPI_FREE(resource_buffer.pointer);
+exit1:
+	ACPI_FREE(return_buffer.pointer);
+	return (status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_resource_callback
+ *
+ * PARAMETERS:  acpi_walk_resource_callback
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Simple callback to exercise acpi_walk_resources and
+ *              acpi_walk_resource_buffer.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_db_resource_callback(struct acpi_resource *resource, void *context)
+{
+
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_device_resources
+ *
+ * PARAMETERS:  acpi_walk_callback
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Display the _PRT/_CRS/_PRS resources for a device object.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_db_device_resources(acpi_handle obj_handle,
+			 u32 nesting_level, void *context, void **return_value)
+{
+	struct acpi_namespace_node *node;
+	struct acpi_namespace_node *prt_node = NULL;
+	struct acpi_namespace_node *crs_node = NULL;
+	struct acpi_namespace_node *prs_node = NULL;
+	struct acpi_namespace_node *aei_node = NULL;
+	char *parent_path;
+	struct acpi_buffer return_buffer;
+	acpi_status status;
+
+	node = ACPI_CAST_PTR(struct acpi_namespace_node, obj_handle);
+	parent_path = acpi_ns_get_external_pathname(node);
+	if (!parent_path) {
+		return (AE_NO_MEMORY);
+	}
+
+	/* Get handles to the resource methods for this device */
+
+	(void)acpi_get_handle(node, METHOD_NAME__PRT,
+			      ACPI_CAST_PTR(acpi_handle, &prt_node));
+	(void)acpi_get_handle(node, METHOD_NAME__CRS,
+			      ACPI_CAST_PTR(acpi_handle, &crs_node));
+	(void)acpi_get_handle(node, METHOD_NAME__PRS,
+			      ACPI_CAST_PTR(acpi_handle, &prs_node));
+	(void)acpi_get_handle(node, METHOD_NAME__AEI,
+			      ACPI_CAST_PTR(acpi_handle, &aei_node));
+
+	if (!prt_node && !crs_node && !prs_node && !aei_node) {
+		goto cleanup;	/* Nothing to do */
+	}
+
+	acpi_os_printf("\nDevice: %s\n", parent_path);
+
+	/* Prepare for a return object of arbitrary size */
+
+	return_buffer.pointer = acpi_gbl_db_buffer;
+	return_buffer.length = ACPI_DEBUG_BUFFER_SIZE;
+
+	/* _PRT */
+
+	if (prt_node) {
+		acpi_os_printf("Evaluating _PRT\n");
+
+		status =
+		    acpi_evaluate_object(prt_node, NULL, NULL, &return_buffer);
+		if (ACPI_FAILURE(status)) {
+			acpi_os_printf("Could not evaluate _PRT: %s\n",
+				       acpi_format_exception(status));
+			goto get_crs;
+		}
+
+		return_buffer.pointer = acpi_gbl_db_buffer;
+		return_buffer.length = ACPI_DEBUG_BUFFER_SIZE;
+
+		status = acpi_get_irq_routing_table(node, &return_buffer);
+		if (ACPI_FAILURE(status)) {
+			acpi_os_printf("GetIrqRoutingTable failed: %s\n",
+				       acpi_format_exception(status));
+			goto get_crs;
+		}
+
+		acpi_rs_dump_irq_list(ACPI_CAST_PTR(u8, acpi_gbl_db_buffer));
+	}
+
+	/* _CRS */
+
+get_crs:
+	if (crs_node) {
+		acpi_os_printf("Evaluating _CRS\n");
+
+		return_buffer.pointer = acpi_gbl_db_buffer;
+		return_buffer.length = ACPI_DEBUG_BUFFER_SIZE;
+
+		status =
+		    acpi_evaluate_object(crs_node, NULL, NULL, &return_buffer);
+		if (ACPI_FAILURE(status)) {
+			acpi_os_printf("Could not evaluate _CRS: %s\n",
+				       acpi_format_exception(status));
+			goto get_prs;
+		}
+
+		/* This code exercises the acpi_walk_resources interface */
+
+		status = acpi_walk_resources(node, METHOD_NAME__CRS,
+					     acpi_db_resource_callback, NULL);
+		if (ACPI_FAILURE(status)) {
+			acpi_os_printf("AcpiWalkResources failed: %s\n",
+				       acpi_format_exception(status));
+			goto get_prs;
+		}
+
+		/* Get the _CRS resource list (test ALLOCATE buffer) */
+
+		return_buffer.pointer = NULL;
+		return_buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
+
+		status = acpi_get_current_resources(node, &return_buffer);
+		if (ACPI_FAILURE(status)) {
+			acpi_os_printf("AcpiGetCurrentResources failed: %s\n",
+				       acpi_format_exception(status));
+			goto get_prs;
+		}
+
+		/* This code exercises the acpi_walk_resource_buffer interface */
+
+		status = acpi_walk_resource_buffer(&return_buffer,
+						   acpi_db_resource_callback,
+						   NULL);
+		if (ACPI_FAILURE(status)) {
+			acpi_os_printf("AcpiWalkResourceBuffer failed: %s\n",
+				       acpi_format_exception(status));
+			goto end_crs;
+		}
+
+		/* Dump the _CRS resource list */
+
+		acpi_rs_dump_resource_list(ACPI_CAST_PTR(struct acpi_resource,
+							 return_buffer.
+							 pointer));
+
+		/*
+		 * Perform comparison of original AML to newly created AML. This
+		 * tests both the AML->Resource conversion and the Resource->AML
+		 * conversion.
+		 */
+		(void)acpi_dm_test_resource_conversion(node, METHOD_NAME__CRS);
+
+		/* Execute _SRS with the resource list */
+
+		acpi_os_printf("Evaluating _SRS\n");
+
+		status = acpi_set_current_resources(node, &return_buffer);
+		if (ACPI_FAILURE(status)) {
+			acpi_os_printf("AcpiSetCurrentResources failed: %s\n",
+				       acpi_format_exception(status));
+			goto end_crs;
+		}
+
+end_crs:
+		ACPI_FREE(return_buffer.pointer);
+	}
+
+	/* _PRS */
+
+get_prs:
+	if (prs_node) {
+		acpi_os_printf("Evaluating _PRS\n");
+
+		return_buffer.pointer = acpi_gbl_db_buffer;
+		return_buffer.length = ACPI_DEBUG_BUFFER_SIZE;
+
+		status =
+		    acpi_evaluate_object(prs_node, NULL, NULL, &return_buffer);
+		if (ACPI_FAILURE(status)) {
+			acpi_os_printf("Could not evaluate _PRS: %s\n",
+				       acpi_format_exception(status));
+			goto get_aei;
+		}
+
+		return_buffer.pointer = acpi_gbl_db_buffer;
+		return_buffer.length = ACPI_DEBUG_BUFFER_SIZE;
+
+		status = acpi_get_possible_resources(node, &return_buffer);
+		if (ACPI_FAILURE(status)) {
+			acpi_os_printf("AcpiGetPossibleResources failed: %s\n",
+				       acpi_format_exception(status));
+			goto get_aei;
+		}
+
+		acpi_rs_dump_resource_list(ACPI_CAST_PTR
+					   (struct acpi_resource,
+					    acpi_gbl_db_buffer));
+	}
+
+	/* _AEI */
+
+get_aei:
+	if (aei_node) {
+		acpi_os_printf("Evaluating _AEI\n");
+
+		return_buffer.pointer = acpi_gbl_db_buffer;
+		return_buffer.length = ACPI_DEBUG_BUFFER_SIZE;
+
+		status =
+		    acpi_evaluate_object(aei_node, NULL, NULL, &return_buffer);
+		if (ACPI_FAILURE(status)) {
+			acpi_os_printf("Could not evaluate _AEI: %s\n",
+				       acpi_format_exception(status));
+			goto cleanup;
+		}
+
+		return_buffer.pointer = acpi_gbl_db_buffer;
+		return_buffer.length = ACPI_DEBUG_BUFFER_SIZE;
+
+		status = acpi_get_event_resources(node, &return_buffer);
+		if (ACPI_FAILURE(status)) {
+			acpi_os_printf("AcpiGetEventResources failed: %s\n",
+				       acpi_format_exception(status));
+			goto cleanup;
+		}
+
+		acpi_rs_dump_resource_list(ACPI_CAST_PTR
+					   (struct acpi_resource,
+					    acpi_gbl_db_buffer));
+	}
+
+cleanup:
+	ACPI_FREE(parent_path);
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_display_resources
+ *
+ * PARAMETERS:  object_arg          - String object name or object pointer.
+ *                                    NULL or "*" means "display resources for
+ *                                    all devices"
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Display the resource objects associated with a device.
+ *
+ ******************************************************************************/
+
+void acpi_db_display_resources(char *object_arg)
+{
+	struct acpi_namespace_node *node;
+
+	acpi_db_set_output_destination(ACPI_DB_REDIRECTABLE_OUTPUT);
+	acpi_dbg_level |= ACPI_LV_RESOURCES;
+
+	/* Asterisk means "display resources for all devices" */
+
+	if (!object_arg || (!strcmp(object_arg, "*"))) {
+		(void)acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+					  ACPI_UINT32_MAX,
+					  acpi_db_device_resources, NULL, NULL,
+					  NULL);
+	} else {
+		/* Convert string to object pointer */
+
+		node = acpi_db_convert_to_node(object_arg);
+		if (node) {
+			if (node->type != ACPI_TYPE_DEVICE) {
+				acpi_os_printf
+				    ("%4.4s: Name is not a device object (%s)\n",
+				     node->name.ascii,
+				     acpi_ut_get_type_name(node->type));
+			} else {
+				(void)acpi_db_device_resources(node, 0, NULL,
+							       NULL);
+			}
+		}
+	}
+
+	acpi_db_set_output_destination(ACPI_DB_CONSOLE_OUTPUT);
+}
+
+#if (!ACPI_REDUCED_HARDWARE)
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_generate_gpe
+ *
+ * PARAMETERS:  gpe_arg             - Raw GPE number, ascii string
+ *              block_arg           - GPE block number, ascii string
+ *                                    0 or 1 for FADT GPE blocks
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Simulate firing of a GPE
+ *
+ ******************************************************************************/
+
+void acpi_db_generate_gpe(char *gpe_arg, char *block_arg)
+{
+	u32 block_number = 0;
+	u32 gpe_number;
+	struct acpi_gpe_event_info *gpe_event_info;
+
+	gpe_number = strtoul(gpe_arg, NULL, 0);
+
+	/*
+	 * If no block arg, or block arg == 0 or 1, use the FADT-defined
+	 * GPE blocks.
+	 */
+	if (block_arg) {
+		block_number = strtoul(block_arg, NULL, 0);
+		if (block_number == 1) {
+			block_number = 0;
+		}
+	}
+
+	gpe_event_info =
+	    acpi_ev_get_gpe_event_info(ACPI_TO_POINTER(block_number),
+				       gpe_number);
+	if (!gpe_event_info) {
+		acpi_os_printf("Invalid GPE\n");
+		return;
+	}
+
+	(void)acpi_ev_gpe_dispatch(NULL, gpe_event_info, gpe_number);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_generate_sci
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Simulate an SCI -- just call the SCI dispatch.
+ *
+ ******************************************************************************/
+
+void acpi_db_generate_sci(void)
+{
+	acpi_ev_sci_dispatch();
+}
+
+#endif				/* !ACPI_REDUCED_HARDWARE */
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_trace
+ *
+ * PARAMETERS:  enable_arg          - ENABLE/AML to enable tracer
+ *                                    DISABLE to disable tracer
+ *              method_arg          - Method to trace
+ *              once_arg            - Whether trace once
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Control method tracing facility
+ *
+ ******************************************************************************/
+
+void acpi_db_trace(char *enable_arg, char *method_arg, char *once_arg)
+{
+	u32 debug_level = 0;
+	u32 debug_layer = 0;
+	u32 flags = 0;
+
+	if (enable_arg) {
+		acpi_ut_strupr(enable_arg);
+	}
+
+	if (once_arg) {
+		acpi_ut_strupr(once_arg);
+	}
+
+	if (method_arg) {
+		if (acpi_db_trace_method_name) {
+			ACPI_FREE(acpi_db_trace_method_name);
+			acpi_db_trace_method_name = NULL;
+		}
+
+		acpi_db_trace_method_name =
+		    ACPI_ALLOCATE(strlen(method_arg) + 1);
+		if (!acpi_db_trace_method_name) {
+			acpi_os_printf("Failed to allocate method name (%s)\n",
+				       method_arg);
+			return;
+		}
+
+		strcpy(acpi_db_trace_method_name, method_arg);
+	}
+
+	if (!strcmp(enable_arg, "ENABLE") ||
+	    !strcmp(enable_arg, "METHOD") || !strcmp(enable_arg, "OPCODE")) {
+		if (!strcmp(enable_arg, "ENABLE")) {
+
+			/* Inherit current console settings */
+
+			debug_level = acpi_gbl_db_console_debug_level;
+			debug_layer = acpi_dbg_layer;
+		} else {
+			/* Restrict console output to trace points only */
+
+			debug_level = ACPI_LV_TRACE_POINT;
+			debug_layer = ACPI_EXECUTER;
+		}
+
+		flags = ACPI_TRACE_ENABLED;
+
+		if (!strcmp(enable_arg, "OPCODE")) {
+			flags |= ACPI_TRACE_OPCODE;
+		}
+
+		if (once_arg && !strcmp(once_arg, "ONCE")) {
+			flags |= ACPI_TRACE_ONESHOT;
+		}
+	}
+
+	(void)acpi_debug_trace(acpi_db_trace_method_name,
+			       debug_level, debug_layer, flags);
+}
diff --git a/drivers/acpi/acpica/dbconvert.c b/drivers/acpi/acpica/dbconvert.c
new file mode 100644
index 0000000..a71632c
--- /dev/null
+++ b/drivers/acpi/acpica/dbconvert.c
@@ -0,0 +1,484 @@
+/*******************************************************************************
+ *
+ * Module Name: dbconvert - debugger miscellaneous conversion routines
+ *
+ ******************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2015, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include <acpi/acpi.h>
+#include "accommon.h"
+#include "acdebug.h"
+
+#define _COMPONENT          ACPI_CA_DEBUGGER
+ACPI_MODULE_NAME("dbconvert")
+
+#define DB_DEFAULT_PKG_ELEMENTS     33
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_hex_char_to_value
+ *
+ * PARAMETERS:  hex_char            - Ascii Hex digit, 0-9|a-f|A-F
+ *              return_value        - Where the converted value is returned
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Convert a single hex character to a 4-bit number (0-16).
+ *
+ ******************************************************************************/
+acpi_status acpi_db_hex_char_to_value(int hex_char, u8 *return_value)
+{
+	u8 value;
+
+	/* Digit must be ascii [0-9a-fA-F] */
+
+	if (!isxdigit(hex_char)) {
+		return (AE_BAD_HEX_CONSTANT);
+	}
+
+	if (hex_char <= 0x39) {
+		value = (u8)(hex_char - 0x30);
+	} else {
+		value = (u8)(toupper(hex_char) - 0x37);
+	}
+
+	*return_value = value;
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_hex_byte_to_binary
+ *
+ * PARAMETERS:  hex_byte            - Double hex digit (0x00 - 0xFF) in format:
+ *                                    hi_byte then lo_byte.
+ *              return_value        - Where the converted value is returned
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Convert two hex characters to an 8 bit number (0 - 255).
+ *
+ ******************************************************************************/
+
+static acpi_status acpi_db_hex_byte_to_binary(char *hex_byte, u8 *return_value)
+{
+	u8 local0;
+	u8 local1;
+	acpi_status status;
+
+	/* High byte */
+
+	status = acpi_db_hex_char_to_value(hex_byte[0], &local0);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	/* Low byte */
+
+	status = acpi_db_hex_char_to_value(hex_byte[1], &local1);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	*return_value = (u8)((local0 << 4) | local1);
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_convert_to_buffer
+ *
+ * PARAMETERS:  string              - Input string to be converted
+ *              object              - Where the buffer object is returned
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Convert a string to a buffer object. String is treated a list
+ *              of buffer elements, each separated by a space or comma.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_db_convert_to_buffer(char *string, union acpi_object *object)
+{
+	u32 i;
+	u32 j;
+	u32 length;
+	u8 *buffer;
+	acpi_status status;
+
+	/* Generate the final buffer length */
+
+	for (i = 0, length = 0; string[i];) {
+		i += 2;
+		length++;
+
+		while (string[i] && ((string[i] == ',') || (string[i] == ' '))) {
+			i++;
+		}
+	}
+
+	buffer = ACPI_ALLOCATE(length);
+	if (!buffer) {
+		return (AE_NO_MEMORY);
+	}
+
+	/* Convert the command line bytes to the buffer */
+
+	for (i = 0, j = 0; string[i];) {
+		status = acpi_db_hex_byte_to_binary(&string[i], &buffer[j]);
+		if (ACPI_FAILURE(status)) {
+			ACPI_FREE(buffer);
+			return (status);
+		}
+
+		j++;
+		i += 2;
+		while (string[i] && ((string[i] == ',') || (string[i] == ' '))) {
+			i++;
+		}
+	}
+
+	object->type = ACPI_TYPE_BUFFER;
+	object->buffer.pointer = buffer;
+	object->buffer.length = length;
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_convert_to_package
+ *
+ * PARAMETERS:  string              - Input string to be converted
+ *              object              - Where the package object is returned
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Convert a string to a package object. Handles nested packages
+ *              via recursion with acpi_db_convert_to_object.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_db_convert_to_package(char *string, union acpi_object * object)
+{
+	char *this;
+	char *next;
+	u32 i;
+	acpi_object_type type;
+	union acpi_object *elements;
+	acpi_status status;
+
+	elements =
+	    ACPI_ALLOCATE_ZEROED(DB_DEFAULT_PKG_ELEMENTS *
+				 sizeof(union acpi_object));
+
+	this = string;
+	for (i = 0; i < (DB_DEFAULT_PKG_ELEMENTS - 1); i++) {
+		this = acpi_db_get_next_token(this, &next, &type);
+		if (!this) {
+			break;
+		}
+
+		/* Recursive call to convert each package element */
+
+		status = acpi_db_convert_to_object(type, this, &elements[i]);
+		if (ACPI_FAILURE(status)) {
+			acpi_db_delete_objects(i + 1, elements);
+			ACPI_FREE(elements);
+			return (status);
+		}
+
+		this = next;
+	}
+
+	object->type = ACPI_TYPE_PACKAGE;
+	object->package.count = i;
+	object->package.elements = elements;
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_convert_to_object
+ *
+ * PARAMETERS:  type                - Object type as determined by parser
+ *              string              - Input string to be converted
+ *              object              - Where the new object is returned
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Convert a typed and tokenized string to an union acpi_object. Typing:
+ *              1) String objects were surrounded by quotes.
+ *              2) Buffer objects were surrounded by parentheses.
+ *              3) Package objects were surrounded by brackets "[]".
+ *              4) All standalone tokens are treated as integers.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_db_convert_to_object(acpi_object_type type,
+			  char *string, union acpi_object * object)
+{
+	acpi_status status = AE_OK;
+
+	switch (type) {
+	case ACPI_TYPE_STRING:
+
+		object->type = ACPI_TYPE_STRING;
+		object->string.pointer = string;
+		object->string.length = (u32)strlen(string);
+		break;
+
+	case ACPI_TYPE_BUFFER:
+
+		status = acpi_db_convert_to_buffer(string, object);
+		break;
+
+	case ACPI_TYPE_PACKAGE:
+
+		status = acpi_db_convert_to_package(string, object);
+		break;
+
+	default:
+
+		object->type = ACPI_TYPE_INTEGER;
+		status = acpi_ut_strtoul64(string, 16, &object->integer.value);
+		break;
+	}
+
+	return (status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_encode_pld_buffer
+ *
+ * PARAMETERS:  pld_info            - _PLD buffer struct (Using local struct)
+ *
+ * RETURN:      Encode _PLD buffer suitable for return value from _PLD
+ *
+ * DESCRIPTION: Bit-packs a _PLD buffer struct. Used to test the _PLD macros
+ *
+ ******************************************************************************/
+
+u8 *acpi_db_encode_pld_buffer(struct acpi_pld_info *pld_info)
+{
+	u32 *buffer;
+	u32 dword;
+
+	buffer = ACPI_ALLOCATE_ZEROED(ACPI_PLD_BUFFER_SIZE);
+	if (!buffer) {
+		return (NULL);
+	}
+
+	/* First 32 bits */
+
+	dword = 0;
+	ACPI_PLD_SET_REVISION(&dword, pld_info->revision);
+	ACPI_PLD_SET_IGNORE_COLOR(&dword, pld_info->ignore_color);
+	ACPI_PLD_SET_RED(&dword, pld_info->red);
+	ACPI_PLD_SET_GREEN(&dword, pld_info->green);
+	ACPI_PLD_SET_BLUE(&dword, pld_info->blue);
+	ACPI_MOVE_32_TO_32(&buffer[0], &dword);
+
+	/* Second 32 bits */
+
+	dword = 0;
+	ACPI_PLD_SET_WIDTH(&dword, pld_info->width);
+	ACPI_PLD_SET_HEIGHT(&dword, pld_info->height);
+	ACPI_MOVE_32_TO_32(&buffer[1], &dword);
+
+	/* Third 32 bits */
+
+	dword = 0;
+	ACPI_PLD_SET_USER_VISIBLE(&dword, pld_info->user_visible);
+	ACPI_PLD_SET_DOCK(&dword, pld_info->dock);
+	ACPI_PLD_SET_LID(&dword, pld_info->lid);
+	ACPI_PLD_SET_PANEL(&dword, pld_info->panel);
+	ACPI_PLD_SET_VERTICAL(&dword, pld_info->vertical_position);
+	ACPI_PLD_SET_HORIZONTAL(&dword, pld_info->horizontal_position);
+	ACPI_PLD_SET_SHAPE(&dword, pld_info->shape);
+	ACPI_PLD_SET_ORIENTATION(&dword, pld_info->group_orientation);
+	ACPI_PLD_SET_TOKEN(&dword, pld_info->group_token);
+	ACPI_PLD_SET_POSITION(&dword, pld_info->group_position);
+	ACPI_PLD_SET_BAY(&dword, pld_info->bay);
+	ACPI_MOVE_32_TO_32(&buffer[2], &dword);
+
+	/* Fourth 32 bits */
+
+	dword = 0;
+	ACPI_PLD_SET_EJECTABLE(&dword, pld_info->ejectable);
+	ACPI_PLD_SET_OSPM_EJECT(&dword, pld_info->ospm_eject_required);
+	ACPI_PLD_SET_CABINET(&dword, pld_info->cabinet_number);
+	ACPI_PLD_SET_CARD_CAGE(&dword, pld_info->card_cage_number);
+	ACPI_PLD_SET_REFERENCE(&dword, pld_info->reference);
+	ACPI_PLD_SET_ROTATION(&dword, pld_info->rotation);
+	ACPI_PLD_SET_ORDER(&dword, pld_info->order);
+	ACPI_MOVE_32_TO_32(&buffer[3], &dword);
+
+	if (pld_info->revision >= 2) {
+
+		/* Fifth 32 bits */
+
+		dword = 0;
+		ACPI_PLD_SET_VERT_OFFSET(&dword, pld_info->vertical_offset);
+		ACPI_PLD_SET_HORIZ_OFFSET(&dword, pld_info->horizontal_offset);
+		ACPI_MOVE_32_TO_32(&buffer[4], &dword);
+	}
+
+	return (ACPI_CAST_PTR(u8, buffer));
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_dump_pld_buffer
+ *
+ * PARAMETERS:  obj_desc            - Object returned from _PLD method
+ *
+ * RETURN:      None.
+ *
+ * DESCRIPTION: Dumps formatted contents of a _PLD return buffer.
+ *
+ ******************************************************************************/
+
+#define ACPI_PLD_OUTPUT     "%20s : %-6X\n"
+
+void acpi_db_dump_pld_buffer(union acpi_object *obj_desc)
+{
+	union acpi_object *buffer_desc;
+	struct acpi_pld_info *pld_info;
+	u8 *new_buffer;
+	acpi_status status;
+
+	/* Object must be of type Package with at least one Buffer element */
+
+	if (obj_desc->type != ACPI_TYPE_PACKAGE) {
+		return;
+	}
+
+	buffer_desc = &obj_desc->package.elements[0];
+	if (buffer_desc->type != ACPI_TYPE_BUFFER) {
+		return;
+	}
+
+	/* Convert _PLD buffer to local _PLD struct */
+
+	status = acpi_decode_pld_buffer(buffer_desc->buffer.pointer,
+					buffer_desc->buffer.length, &pld_info);
+	if (ACPI_FAILURE(status)) {
+		return;
+	}
+
+	/* Encode local _PLD struct back to a _PLD buffer */
+
+	new_buffer = acpi_db_encode_pld_buffer(pld_info);
+	if (!new_buffer) {
+		return;
+	}
+
+	/* The two bit-packed buffers should match */
+
+	if (memcmp(new_buffer, buffer_desc->buffer.pointer,
+		   buffer_desc->buffer.length)) {
+		acpi_os_printf
+		    ("Converted _PLD buffer does not compare. New:\n");
+
+		acpi_ut_dump_buffer(new_buffer,
+				    buffer_desc->buffer.length, DB_BYTE_DISPLAY,
+				    0);
+	}
+
+	/* First 32-bit dword */
+
+	acpi_os_printf(ACPI_PLD_OUTPUT, "PLD_Revision", pld_info->revision);
+	acpi_os_printf(ACPI_PLD_OUTPUT, "PLD_IgnoreColor",
+		       pld_info->ignore_color);
+	acpi_os_printf(ACPI_PLD_OUTPUT, "PLD_Red", pld_info->red);
+	acpi_os_printf(ACPI_PLD_OUTPUT, "PLD_Green", pld_info->green);
+	acpi_os_printf(ACPI_PLD_OUTPUT, "PLD_Blue", pld_info->blue);
+
+	/* Second 32-bit dword */
+
+	acpi_os_printf(ACPI_PLD_OUTPUT, "PLD_Width", pld_info->width);
+	acpi_os_printf(ACPI_PLD_OUTPUT, "PLD_Height", pld_info->height);
+
+	/* Third 32-bit dword */
+
+	acpi_os_printf(ACPI_PLD_OUTPUT, "PLD_UserVisible",
+		       pld_info->user_visible);
+	acpi_os_printf(ACPI_PLD_OUTPUT, "PLD_Dock", pld_info->dock);
+	acpi_os_printf(ACPI_PLD_OUTPUT, "PLD_Lid", pld_info->lid);
+	acpi_os_printf(ACPI_PLD_OUTPUT, "PLD_Panel", pld_info->panel);
+	acpi_os_printf(ACPI_PLD_OUTPUT, "PLD_VerticalPosition",
+		       pld_info->vertical_position);
+	acpi_os_printf(ACPI_PLD_OUTPUT, "PLD_HorizontalPosition",
+		       pld_info->horizontal_position);
+	acpi_os_printf(ACPI_PLD_OUTPUT, "PLD_Shape", pld_info->shape);
+	acpi_os_printf(ACPI_PLD_OUTPUT, "PLD_GroupOrientation",
+		       pld_info->group_orientation);
+	acpi_os_printf(ACPI_PLD_OUTPUT, "PLD_GroupToken",
+		       pld_info->group_token);
+	acpi_os_printf(ACPI_PLD_OUTPUT, "PLD_GroupPosition",
+		       pld_info->group_position);
+	acpi_os_printf(ACPI_PLD_OUTPUT, "PLD_Bay", pld_info->bay);
+
+	/* Fourth 32-bit dword */
+
+	acpi_os_printf(ACPI_PLD_OUTPUT, "PLD_Ejectable", pld_info->ejectable);
+	acpi_os_printf(ACPI_PLD_OUTPUT, "PLD_EjectRequired",
+		       pld_info->ospm_eject_required);
+	acpi_os_printf(ACPI_PLD_OUTPUT, "PLD_CabinetNumber",
+		       pld_info->cabinet_number);
+	acpi_os_printf(ACPI_PLD_OUTPUT, "PLD_CardCageNumber",
+		       pld_info->card_cage_number);
+	acpi_os_printf(ACPI_PLD_OUTPUT, "PLD_Reference", pld_info->reference);
+	acpi_os_printf(ACPI_PLD_OUTPUT, "PLD_Rotation", pld_info->rotation);
+	acpi_os_printf(ACPI_PLD_OUTPUT, "PLD_Order", pld_info->order);
+
+	/* Fifth 32-bit dword */
+
+	if (buffer_desc->buffer.length > 16) {
+		acpi_os_printf(ACPI_PLD_OUTPUT, "PLD_VerticalOffset",
+			       pld_info->vertical_offset);
+		acpi_os_printf(ACPI_PLD_OUTPUT, "PLD_HorizontalOffset",
+			       pld_info->horizontal_offset);
+	}
+
+	ACPI_FREE(pld_info);
+	ACPI_FREE(new_buffer);
+}
diff --git a/drivers/acpi/acpica/dbdisply.c b/drivers/acpi/acpica/dbdisply.c
new file mode 100644
index 0000000..672977e
--- /dev/null
+++ b/drivers/acpi/acpica/dbdisply.c
@@ -0,0 +1,1108 @@
+/*******************************************************************************
+ *
+ * Module Name: dbdisply - debug display commands
+ *
+ ******************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2015, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include <acpi/acpi.h>
+#include "accommon.h"
+#include "amlcode.h"
+#include "acdispat.h"
+#include "acnamesp.h"
+#include "acparser.h"
+#include "acinterp.h"
+#include "acdebug.h"
+
+#define _COMPONENT          ACPI_CA_DEBUGGER
+ACPI_MODULE_NAME("dbdisply")
+
+/* Local prototypes */
+static void acpi_db_dump_parser_descriptor(union acpi_parse_object *op);
+
+static void *acpi_db_get_pointer(void *target);
+
+static acpi_status
+acpi_db_display_non_root_handlers(acpi_handle obj_handle,
+				  u32 nesting_level,
+				  void *context, void **return_value);
+
+/*
+ * System handler information.
+ * Used for Handlers command, in acpi_db_display_handlers.
+ */
+#define ACPI_PREDEFINED_PREFIX          "%25s (%.2X) : "
+#define ACPI_HANDLER_NAME_STRING               "%30s : "
+#define ACPI_HANDLER_PRESENT_STRING                    "%-9s (%p)\n"
+#define ACPI_HANDLER_PRESENT_STRING2                   "%-9s (%p)"
+#define ACPI_HANDLER_NOT_PRESENT_STRING                "%-9s\n"
+
+/* All predefined Address Space IDs */
+
+static acpi_adr_space_type acpi_gbl_space_id_list[] = {
+	ACPI_ADR_SPACE_SYSTEM_MEMORY,
+	ACPI_ADR_SPACE_SYSTEM_IO,
+	ACPI_ADR_SPACE_PCI_CONFIG,
+	ACPI_ADR_SPACE_EC,
+	ACPI_ADR_SPACE_SMBUS,
+	ACPI_ADR_SPACE_CMOS,
+	ACPI_ADR_SPACE_PCI_BAR_TARGET,
+	ACPI_ADR_SPACE_IPMI,
+	ACPI_ADR_SPACE_GPIO,
+	ACPI_ADR_SPACE_GSBUS,
+	ACPI_ADR_SPACE_DATA_TABLE,
+	ACPI_ADR_SPACE_FIXED_HARDWARE
+};
+
+/* Global handler information */
+
+typedef struct acpi_handler_info {
+	void *handler;
+	char *name;
+
+} acpi_handler_info;
+
+static struct acpi_handler_info acpi_gbl_handler_list[] = {
+	{&acpi_gbl_global_notify[0].handler, "System Notifications"},
+	{&acpi_gbl_global_notify[1].handler, "Device Notifications"},
+	{&acpi_gbl_table_handler, "ACPI Table Events"},
+	{&acpi_gbl_exception_handler, "Control Method Exceptions"},
+	{&acpi_gbl_interface_handler, "OSI Invocations"}
+};
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_get_pointer
+ *
+ * PARAMETERS:  target          - Pointer to string to be converted
+ *
+ * RETURN:      Converted pointer
+ *
+ * DESCRIPTION: Convert an ascii pointer value to a real value
+ *
+ ******************************************************************************/
+
+static void *acpi_db_get_pointer(void *target)
+{
+	void *obj_ptr;
+	acpi_size address;
+
+	address = strtoul(target, NULL, 16);
+	obj_ptr = ACPI_TO_POINTER(address);
+	return (obj_ptr);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_dump_parser_descriptor
+ *
+ * PARAMETERS:  op              - A parser Op descriptor
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Display a formatted parser object
+ *
+ ******************************************************************************/
+
+static void acpi_db_dump_parser_descriptor(union acpi_parse_object *op)
+{
+	const struct acpi_opcode_info *info;
+
+	info = acpi_ps_get_opcode_info(op->common.aml_opcode);
+
+	acpi_os_printf("Parser Op Descriptor:\n");
+	acpi_os_printf("%20.20s : %4.4X\n", "Opcode", op->common.aml_opcode);
+
+	ACPI_DEBUG_ONLY_MEMBERS(acpi_os_printf("%20.20s : %s\n", "Opcode Name",
+					       info->name));
+
+	acpi_os_printf("%20.20s : %p\n", "Value/ArgList", op->common.value.arg);
+	acpi_os_printf("%20.20s : %p\n", "Parent", op->common.parent);
+	acpi_os_printf("%20.20s : %p\n", "NextOp", op->common.next);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_decode_and_display_object
+ *
+ * PARAMETERS:  target          - String with object to be displayed. Names
+ *                                and hex pointers are supported.
+ *              output_type     - Byte, Word, Dword, or Qword (B|W|D|Q)
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Display a formatted ACPI object
+ *
+ ******************************************************************************/
+
+void acpi_db_decode_and_display_object(char *target, char *output_type)
+{
+	void *obj_ptr;
+	struct acpi_namespace_node *node;
+	union acpi_operand_object *obj_desc;
+	u32 display = DB_BYTE_DISPLAY;
+	char buffer[80];
+	struct acpi_buffer ret_buf;
+	acpi_status status;
+	u32 size;
+
+	if (!target) {
+		return;
+	}
+
+	/* Decode the output type */
+
+	if (output_type) {
+		acpi_ut_strupr(output_type);
+		if (output_type[0] == 'W') {
+			display = DB_WORD_DISPLAY;
+		} else if (output_type[0] == 'D') {
+			display = DB_DWORD_DISPLAY;
+		} else if (output_type[0] == 'Q') {
+			display = DB_QWORD_DISPLAY;
+		}
+	}
+
+	ret_buf.length = sizeof(buffer);
+	ret_buf.pointer = buffer;
+
+	/* Differentiate between a number and a name */
+
+	if ((target[0] >= 0x30) && (target[0] <= 0x39)) {
+		obj_ptr = acpi_db_get_pointer(target);
+		if (!acpi_os_readable(obj_ptr, 16)) {
+			acpi_os_printf
+			    ("Address %p is invalid in this address space\n",
+			     obj_ptr);
+			return;
+		}
+
+		/* Decode the object type */
+
+		switch (ACPI_GET_DESCRIPTOR_TYPE(obj_ptr)) {
+		case ACPI_DESC_TYPE_NAMED:
+
+			/* This is a namespace Node */
+
+			if (!acpi_os_readable
+			    (obj_ptr, sizeof(struct acpi_namespace_node))) {
+				acpi_os_printf
+				    ("Cannot read entire Named object at address %p\n",
+				     obj_ptr);
+				return;
+			}
+
+			node = obj_ptr;
+			goto dump_node;
+
+		case ACPI_DESC_TYPE_OPERAND:
+
+			/* This is a ACPI OPERAND OBJECT */
+
+			if (!acpi_os_readable
+			    (obj_ptr, sizeof(union acpi_operand_object))) {
+				acpi_os_printf
+				    ("Cannot read entire ACPI object at address %p\n",
+				     obj_ptr);
+				return;
+			}
+
+			acpi_ut_debug_dump_buffer(obj_ptr,
+						  sizeof(union
+							 acpi_operand_object),
+						  display, ACPI_UINT32_MAX);
+			acpi_ex_dump_object_descriptor(obj_ptr, 1);
+			break;
+
+		case ACPI_DESC_TYPE_PARSER:
+
+			/* This is a Parser Op object */
+
+			if (!acpi_os_readable
+			    (obj_ptr, sizeof(union acpi_parse_object))) {
+				acpi_os_printf
+				    ("Cannot read entire Parser object at address %p\n",
+				     obj_ptr);
+				return;
+			}
+
+			acpi_ut_debug_dump_buffer(obj_ptr,
+						  sizeof(union
+							 acpi_parse_object),
+						  display, ACPI_UINT32_MAX);
+			acpi_db_dump_parser_descriptor((union acpi_parse_object
+							*)obj_ptr);
+			break;
+
+		default:
+
+			/* Is not a recognizeable object */
+
+			acpi_os_printf
+			    ("Not a known ACPI internal object, descriptor type %2.2X\n",
+			     ACPI_GET_DESCRIPTOR_TYPE(obj_ptr));
+
+			size = 16;
+			if (acpi_os_readable(obj_ptr, 64)) {
+				size = 64;
+			}
+
+			/* Just dump some memory */
+
+			acpi_ut_debug_dump_buffer(obj_ptr, size, display,
+						  ACPI_UINT32_MAX);
+			break;
+		}
+
+		return;
+	}
+
+	/* The parameter is a name string that must be resolved to a Named obj */
+
+	node = acpi_db_local_ns_lookup(target);
+	if (!node) {
+		return;
+	}
+
+dump_node:
+	/* Now dump the NS node */
+
+	status = acpi_get_name(node, ACPI_FULL_PATHNAME_NO_TRAILING, &ret_buf);
+	if (ACPI_FAILURE(status)) {
+		acpi_os_printf("Could not convert name to pathname\n");
+	}
+
+	else {
+		acpi_os_printf("Object (%p) Pathname: %s\n",
+			       node, (char *)ret_buf.pointer);
+	}
+
+	if (!acpi_os_readable(node, sizeof(struct acpi_namespace_node))) {
+		acpi_os_printf("Invalid Named object at address %p\n", node);
+		return;
+	}
+
+	acpi_ut_debug_dump_buffer((void *)node,
+				  sizeof(struct acpi_namespace_node), display,
+				  ACPI_UINT32_MAX);
+	acpi_ex_dump_namespace_node(node, 1);
+
+	obj_desc = acpi_ns_get_attached_object(node);
+	if (obj_desc) {
+		acpi_os_printf("\nAttached Object (%p):\n", obj_desc);
+		if (!acpi_os_readable
+		    (obj_desc, sizeof(union acpi_operand_object))) {
+			acpi_os_printf
+			    ("Invalid internal ACPI Object at address %p\n",
+			     obj_desc);
+			return;
+		}
+
+		acpi_ut_debug_dump_buffer((void *)obj_desc,
+					  sizeof(union acpi_operand_object),
+					  display, ACPI_UINT32_MAX);
+		acpi_ex_dump_object_descriptor(obj_desc, 1);
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_display_method_info
+ *
+ * PARAMETERS:  start_op        - Root of the control method parse tree
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Display information about the current method
+ *
+ ******************************************************************************/
+
+void acpi_db_display_method_info(union acpi_parse_object *start_op)
+{
+	struct acpi_walk_state *walk_state;
+	union acpi_operand_object *obj_desc;
+	struct acpi_namespace_node *node;
+	union acpi_parse_object *root_op;
+	union acpi_parse_object *op;
+	const struct acpi_opcode_info *op_info;
+	u32 num_ops = 0;
+	u32 num_operands = 0;
+	u32 num_operators = 0;
+	u32 num_remaining_ops = 0;
+	u32 num_remaining_operands = 0;
+	u32 num_remaining_operators = 0;
+	u8 count_remaining = FALSE;
+
+	walk_state = acpi_ds_get_current_walk_state(acpi_gbl_current_walk_list);
+	if (!walk_state) {
+		acpi_os_printf("There is no method currently executing\n");
+		return;
+	}
+
+	obj_desc = walk_state->method_desc;
+	node = walk_state->method_node;
+
+	acpi_os_printf("Currently executing control method is [%4.4s]\n",
+		       acpi_ut_get_node_name(node));
+	acpi_os_printf("%X Arguments, SyncLevel = %X\n",
+		       (u32)obj_desc->method.param_count,
+		       (u32)obj_desc->method.sync_level);
+
+	root_op = start_op;
+	while (root_op->common.parent) {
+		root_op = root_op->common.parent;
+	}
+
+	op = root_op;
+
+	while (op) {
+		if (op == start_op) {
+			count_remaining = TRUE;
+		}
+
+		num_ops++;
+		if (count_remaining) {
+			num_remaining_ops++;
+		}
+
+		/* Decode the opcode */
+
+		op_info = acpi_ps_get_opcode_info(op->common.aml_opcode);
+		switch (op_info->class) {
+		case AML_CLASS_ARGUMENT:
+
+			if (count_remaining) {
+				num_remaining_operands++;
+			}
+
+			num_operands++;
+			break;
+
+		case AML_CLASS_UNKNOWN:
+
+			/* Bad opcode or ASCII character */
+
+			continue;
+
+		default:
+
+			if (count_remaining) {
+				num_remaining_operators++;
+			}
+
+			num_operators++;
+			break;
+		}
+
+		op = acpi_ps_get_depth_next(start_op, op);
+	}
+
+	acpi_os_printf
+	    ("Method contains:       %X AML Opcodes - %X Operators, %X Operands\n",
+	     num_ops, num_operators, num_operands);
+
+	acpi_os_printf
+	    ("Remaining to execute:  %X AML Opcodes - %X Operators, %X Operands\n",
+	     num_remaining_ops, num_remaining_operators,
+	     num_remaining_operands);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_display_locals
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Display all locals for the currently running control method
+ *
+ ******************************************************************************/
+
+void acpi_db_display_locals(void)
+{
+	struct acpi_walk_state *walk_state;
+
+	walk_state = acpi_ds_get_current_walk_state(acpi_gbl_current_walk_list);
+	if (!walk_state) {
+		acpi_os_printf("There is no method currently executing\n");
+		return;
+	}
+
+	acpi_db_decode_locals(walk_state);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_display_arguments
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Display all arguments for the currently running control method
+ *
+ ******************************************************************************/
+
+void acpi_db_display_arguments(void)
+{
+	struct acpi_walk_state *walk_state;
+
+	walk_state = acpi_ds_get_current_walk_state(acpi_gbl_current_walk_list);
+	if (!walk_state) {
+		acpi_os_printf("There is no method currently executing\n");
+		return;
+	}
+
+	acpi_db_decode_arguments(walk_state);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_display_results
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Display current contents of a method result stack
+ *
+ ******************************************************************************/
+
+void acpi_db_display_results(void)
+{
+	u32 i;
+	struct acpi_walk_state *walk_state;
+	union acpi_operand_object *obj_desc;
+	u32 result_count = 0;
+	struct acpi_namespace_node *node;
+	union acpi_generic_state *frame;
+	u32 index;		/* Index onto current frame */
+
+	walk_state = acpi_ds_get_current_walk_state(acpi_gbl_current_walk_list);
+	if (!walk_state) {
+		acpi_os_printf("There is no method currently executing\n");
+		return;
+	}
+
+	obj_desc = walk_state->method_desc;
+	node = walk_state->method_node;
+
+	if (walk_state->results) {
+		result_count = walk_state->result_count;
+	}
+
+	acpi_os_printf("Method [%4.4s] has %X stacked result objects\n",
+		       acpi_ut_get_node_name(node), result_count);
+
+	/* From the top element of result stack */
+
+	frame = walk_state->results;
+	index = (result_count - 1) % ACPI_RESULTS_FRAME_OBJ_NUM;
+
+	for (i = 0; i < result_count; i++) {
+		obj_desc = frame->results.obj_desc[index];
+		acpi_os_printf("Result%u: ", i);
+		acpi_db_display_internal_object(obj_desc, walk_state);
+
+		if (index == 0) {
+			frame = frame->results.next;
+			index = ACPI_RESULTS_FRAME_OBJ_NUM;
+		}
+
+		index--;
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_display_calling_tree
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Display current calling tree of nested control methods
+ *
+ ******************************************************************************/
+
+void acpi_db_display_calling_tree(void)
+{
+	struct acpi_walk_state *walk_state;
+	struct acpi_namespace_node *node;
+
+	walk_state = acpi_ds_get_current_walk_state(acpi_gbl_current_walk_list);
+	if (!walk_state) {
+		acpi_os_printf("There is no method currently executing\n");
+		return;
+	}
+
+	node = walk_state->method_node;
+	acpi_os_printf("Current Control Method Call Tree\n");
+
+	while (walk_state) {
+		node = walk_state->method_node;
+		acpi_os_printf("  [%4.4s]\n", acpi_ut_get_node_name(node));
+
+		walk_state = walk_state->next;
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_display_object_type
+ *
+ * PARAMETERS:  name            - User entered NS node handle or name
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Display type of an arbitrary NS node
+ *
+ ******************************************************************************/
+
+void acpi_db_display_object_type(char *name)
+{
+	struct acpi_namespace_node *node;
+	struct acpi_device_info *info;
+	acpi_status status;
+	u32 i;
+
+	node = acpi_db_convert_to_node(name);
+	if (!node) {
+		return;
+	}
+
+	status = acpi_get_object_info(ACPI_CAST_PTR(acpi_handle, node), &info);
+	if (ACPI_FAILURE(status)) {
+		acpi_os_printf("Could not get object info, %s\n",
+			       acpi_format_exception(status));
+		return;
+	}
+
+	if (info->valid & ACPI_VALID_ADR) {
+		acpi_os_printf("ADR: %8.8X%8.8X, STA: %8.8X, Flags: %X\n",
+			       ACPI_FORMAT_UINT64(info->address),
+			       info->current_status, info->flags);
+	}
+	if (info->valid & ACPI_VALID_SXDS) {
+		acpi_os_printf("S1D-%2.2X S2D-%2.2X S3D-%2.2X S4D-%2.2X\n",
+			       info->highest_dstates[0],
+			       info->highest_dstates[1],
+			       info->highest_dstates[2],
+			       info->highest_dstates[3]);
+	}
+	if (info->valid & ACPI_VALID_SXWS) {
+		acpi_os_printf
+		    ("S0W-%2.2X S1W-%2.2X S2W-%2.2X S3W-%2.2X S4W-%2.2X\n",
+		     info->lowest_dstates[0], info->lowest_dstates[1],
+		     info->lowest_dstates[2], info->lowest_dstates[3],
+		     info->lowest_dstates[4]);
+	}
+
+	if (info->valid & ACPI_VALID_HID) {
+		acpi_os_printf("HID: %s\n", info->hardware_id.string);
+	}
+
+	if (info->valid & ACPI_VALID_UID) {
+		acpi_os_printf("UID: %s\n", info->unique_id.string);
+	}
+
+	if (info->valid & ACPI_VALID_SUB) {
+		acpi_os_printf("SUB: %s\n", info->subsystem_id.string);
+	}
+
+	if (info->valid & ACPI_VALID_CID) {
+		for (i = 0; i < info->compatible_id_list.count; i++) {
+			acpi_os_printf("CID %u: %s\n", i,
+				       info->compatible_id_list.ids[i].string);
+		}
+	}
+
+	ACPI_FREE(info);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_display_result_object
+ *
+ * PARAMETERS:  obj_desc        - Object to be displayed
+ *              walk_state      - Current walk state
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Display the result of an AML opcode
+ *
+ * Note: Curently only displays the result object if we are single stepping.
+ * However, this output may be useful in other contexts and could be enabled
+ * to do so if needed.
+ *
+ ******************************************************************************/
+
+void
+acpi_db_display_result_object(union acpi_operand_object *obj_desc,
+			      struct acpi_walk_state *walk_state)
+{
+
+	/* Only display if single stepping */
+
+	if (!acpi_gbl_cm_single_step) {
+		return;
+	}
+
+	acpi_os_printf("ResultObj: ");
+	acpi_db_display_internal_object(obj_desc, walk_state);
+	acpi_os_printf("\n");
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_display_argument_object
+ *
+ * PARAMETERS:  obj_desc        - Object to be displayed
+ *              walk_state      - Current walk state
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Display the result of an AML opcode
+ *
+ ******************************************************************************/
+
+void
+acpi_db_display_argument_object(union acpi_operand_object *obj_desc,
+				struct acpi_walk_state *walk_state)
+{
+
+	if (!acpi_gbl_cm_single_step) {
+		return;
+	}
+
+	acpi_os_printf("ArgObj:  ");
+	acpi_db_display_internal_object(obj_desc, walk_state);
+}
+
+#if (!ACPI_REDUCED_HARDWARE)
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_display_gpes
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Display the current GPE structures
+ *
+ ******************************************************************************/
+
+void acpi_db_display_gpes(void)
+{
+	struct acpi_gpe_block_info *gpe_block;
+	struct acpi_gpe_xrupt_info *gpe_xrupt_info;
+	struct acpi_gpe_event_info *gpe_event_info;
+	struct acpi_gpe_register_info *gpe_register_info;
+	char *gpe_type;
+	struct acpi_gpe_notify_info *notify;
+	u32 gpe_index;
+	u32 block = 0;
+	u32 i;
+	u32 j;
+	u32 count;
+	char buffer[80];
+	struct acpi_buffer ret_buf;
+	acpi_status status;
+
+	ret_buf.length = sizeof(buffer);
+	ret_buf.pointer = buffer;
+
+	block = 0;
+
+	/* Walk the GPE lists */
+
+	gpe_xrupt_info = acpi_gbl_gpe_xrupt_list_head;
+	while (gpe_xrupt_info) {
+		gpe_block = gpe_xrupt_info->gpe_block_list_head;
+		while (gpe_block) {
+			status = acpi_get_name(gpe_block->node,
+					       ACPI_FULL_PATHNAME_NO_TRAILING,
+					       &ret_buf);
+			if (ACPI_FAILURE(status)) {
+				acpi_os_printf
+				    ("Could not convert name to pathname\n");
+			}
+
+			if (gpe_block->node == acpi_gbl_fadt_gpe_device) {
+				gpe_type = "FADT-defined GPE block";
+			} else {
+				gpe_type = "GPE Block Device";
+			}
+
+			acpi_os_printf
+			    ("\nBlock %u - Info %p  DeviceNode %p [%s] - %s\n",
+			     block, gpe_block, gpe_block->node, buffer,
+			     gpe_type);
+
+			acpi_os_printf("    Registers:    %u (%u GPEs)\n",
+				       gpe_block->register_count,
+				       gpe_block->gpe_count);
+
+			acpi_os_printf
+			    ("    GPE range:    0x%X to 0x%X on interrupt %u\n",
+			     gpe_block->block_base_number,
+			     gpe_block->block_base_number +
+			     (gpe_block->gpe_count - 1),
+			     gpe_xrupt_info->interrupt_number);
+
+			acpi_os_printf
+			    ("    RegisterInfo: %p  Status %8.8X%8.8X Enable %8.8X%8.8X\n",
+			     gpe_block->register_info,
+			     ACPI_FORMAT_UINT64(gpe_block->register_info->
+						status_address.address),
+			     ACPI_FORMAT_UINT64(gpe_block->register_info->
+						enable_address.address));
+
+			acpi_os_printf("  EventInfo:    %p\n",
+				       gpe_block->event_info);
+
+			/* Examine each GPE Register within the block */
+
+			for (i = 0; i < gpe_block->register_count; i++) {
+				gpe_register_info =
+				    &gpe_block->register_info[i];
+
+				acpi_os_printf("    Reg %u: (GPE %.2X-%.2X)  "
+					       "RunEnable %2.2X WakeEnable %2.2X"
+					       " Status %8.8X%8.8X Enable %8.8X%8.8X\n",
+					       i,
+					       gpe_register_info->
+					       base_gpe_number,
+					       gpe_register_info->
+					       base_gpe_number +
+					       (ACPI_GPE_REGISTER_WIDTH - 1),
+					       gpe_register_info->
+					       enable_for_run,
+					       gpe_register_info->
+					       enable_for_wake,
+					       ACPI_FORMAT_UINT64
+					       (gpe_register_info->
+						status_address.address),
+					       ACPI_FORMAT_UINT64
+					       (gpe_register_info->
+						enable_address.address));
+
+				/* Now look at the individual GPEs in this byte register */
+
+				for (j = 0; j < ACPI_GPE_REGISTER_WIDTH; j++) {
+					gpe_index =
+					    (i * ACPI_GPE_REGISTER_WIDTH) + j;
+					gpe_event_info =
+					    &gpe_block->event_info[gpe_index];
+
+					if (ACPI_GPE_DISPATCH_TYPE
+					    (gpe_event_info->flags) ==
+					    ACPI_GPE_DISPATCH_NONE) {
+
+						/* This GPE is not used (no method or handler), ignore it */
+
+						continue;
+					}
+
+					acpi_os_printf
+					    ("        GPE %.2X: %p  RunRefs %2.2X Flags %2.2X (",
+					     gpe_block->block_base_number +
+					     gpe_index, gpe_event_info,
+					     gpe_event_info->runtime_count,
+					     gpe_event_info->flags);
+
+					/* Decode the flags byte */
+
+					if (gpe_event_info->
+					    flags & ACPI_GPE_LEVEL_TRIGGERED) {
+						acpi_os_printf("Level, ");
+					} else {
+						acpi_os_printf("Edge, ");
+					}
+
+					if (gpe_event_info->
+					    flags & ACPI_GPE_CAN_WAKE) {
+						acpi_os_printf("CanWake, ");
+					} else {
+						acpi_os_printf("RunOnly, ");
+					}
+
+					switch (ACPI_GPE_DISPATCH_TYPE
+						(gpe_event_info->flags)) {
+					case ACPI_GPE_DISPATCH_NONE:
+
+						acpi_os_printf("NotUsed");
+						break;
+
+					case ACPI_GPE_DISPATCH_METHOD:
+
+						acpi_os_printf("Method");
+						break;
+
+					case ACPI_GPE_DISPATCH_HANDLER:
+
+						acpi_os_printf("Handler");
+						break;
+
+					case ACPI_GPE_DISPATCH_NOTIFY:
+
+						count = 0;
+						notify =
+						    gpe_event_info->dispatch.
+						    notify_list;
+						while (notify) {
+							count++;
+							notify = notify->next;
+						}
+
+						acpi_os_printf
+						    ("Implicit Notify on %u devices",
+						     count);
+						break;
+
+					case ACPI_GPE_DISPATCH_RAW_HANDLER:
+
+						acpi_os_printf("RawHandler");
+						break;
+
+					default:
+
+						acpi_os_printf("UNKNOWN: %X",
+							       ACPI_GPE_DISPATCH_TYPE
+							       (gpe_event_info->
+								flags));
+						break;
+					}
+
+					acpi_os_printf(")\n");
+				}
+			}
+
+			block++;
+			gpe_block = gpe_block->next;
+		}
+
+		gpe_xrupt_info = gpe_xrupt_info->next;
+	}
+}
+#endif				/* !ACPI_REDUCED_HARDWARE */
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_display_handlers
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Display the currently installed global handlers
+ *
+ ******************************************************************************/
+
+void acpi_db_display_handlers(void)
+{
+	union acpi_operand_object *obj_desc;
+	union acpi_operand_object *handler_obj;
+	acpi_adr_space_type space_id;
+	u32 i;
+
+	/* Operation region handlers */
+
+	acpi_os_printf("\nOperation Region Handlers at the namespace root:\n");
+
+	obj_desc = acpi_ns_get_attached_object(acpi_gbl_root_node);
+	if (obj_desc) {
+		for (i = 0; i < ACPI_ARRAY_LENGTH(acpi_gbl_space_id_list); i++) {
+			space_id = acpi_gbl_space_id_list[i];
+			handler_obj = obj_desc->device.handler;
+
+			acpi_os_printf(ACPI_PREDEFINED_PREFIX,
+				       acpi_ut_get_region_name((u8)space_id),
+				       space_id);
+
+			while (handler_obj) {
+				if (acpi_gbl_space_id_list[i] ==
+				    handler_obj->address_space.space_id) {
+					acpi_os_printf
+					    (ACPI_HANDLER_PRESENT_STRING,
+					     (handler_obj->address_space.
+					      handler_flags &
+					      ACPI_ADDR_HANDLER_DEFAULT_INSTALLED)
+					     ? "Default" : "User",
+					     handler_obj->address_space.
+					     handler);
+
+					goto found_handler;
+				}
+
+				handler_obj = handler_obj->address_space.next;
+			}
+
+			/* There is no handler for this space_id */
+
+			acpi_os_printf("None\n");
+
+found_handler:		;
+		}
+
+		/* Find all handlers for user-defined space_IDs */
+
+		handler_obj = obj_desc->device.handler;
+		while (handler_obj) {
+			if (handler_obj->address_space.space_id >=
+			    ACPI_USER_REGION_BEGIN) {
+				acpi_os_printf(ACPI_PREDEFINED_PREFIX,
+					       "User-defined ID",
+					       handler_obj->address_space.
+					       space_id);
+				acpi_os_printf(ACPI_HANDLER_PRESENT_STRING,
+					       (handler_obj->address_space.
+						handler_flags &
+						ACPI_ADDR_HANDLER_DEFAULT_INSTALLED)
+					       ? "Default" : "User",
+					       handler_obj->address_space.
+					       handler);
+			}
+
+			handler_obj = handler_obj->address_space.next;
+		}
+	}
+#if (!ACPI_REDUCED_HARDWARE)
+
+	/* Fixed event handlers */
+
+	acpi_os_printf("\nFixed Event Handlers:\n");
+
+	for (i = 0; i < ACPI_NUM_FIXED_EVENTS; i++) {
+		acpi_os_printf(ACPI_PREDEFINED_PREFIX,
+			       acpi_ut_get_event_name(i), i);
+		if (acpi_gbl_fixed_event_handlers[i].handler) {
+			acpi_os_printf(ACPI_HANDLER_PRESENT_STRING, "User",
+				       acpi_gbl_fixed_event_handlers[i].
+				       handler);
+		} else {
+			acpi_os_printf(ACPI_HANDLER_NOT_PRESENT_STRING, "None");
+		}
+	}
+
+#endif				/* !ACPI_REDUCED_HARDWARE */
+
+	/* Miscellaneous global handlers */
+
+	acpi_os_printf("\nMiscellaneous Global Handlers:\n");
+
+	for (i = 0; i < ACPI_ARRAY_LENGTH(acpi_gbl_handler_list); i++) {
+		acpi_os_printf(ACPI_HANDLER_NAME_STRING,
+			       acpi_gbl_handler_list[i].name);
+
+		if (acpi_gbl_handler_list[i].handler) {
+			acpi_os_printf(ACPI_HANDLER_PRESENT_STRING, "User",
+				       acpi_gbl_handler_list[i].handler);
+		} else {
+			acpi_os_printf(ACPI_HANDLER_NOT_PRESENT_STRING, "None");
+		}
+	}
+
+	/* Other handlers that are installed throughout the namespace */
+
+	acpi_os_printf("\nOperation Region Handlers for specific devices:\n");
+
+	(void)acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+				  ACPI_UINT32_MAX,
+				  acpi_db_display_non_root_handlers, NULL, NULL,
+				  NULL);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_display_non_root_handlers
+ *
+ * PARAMETERS:  acpi_walk_callback
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Display information about all handlers installed for a
+ *              device object.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_db_display_non_root_handlers(acpi_handle obj_handle,
+				  u32 nesting_level,
+				  void *context, void **return_value)
+{
+	struct acpi_namespace_node *node =
+	    ACPI_CAST_PTR(struct acpi_namespace_node, obj_handle);
+	union acpi_operand_object *obj_desc;
+	union acpi_operand_object *handler_obj;
+	char *pathname;
+
+	obj_desc = acpi_ns_get_attached_object(node);
+	if (!obj_desc) {
+		return (AE_OK);
+	}
+
+	pathname = acpi_ns_get_external_pathname(node);
+	if (!pathname) {
+		return (AE_OK);
+	}
+
+	/* Display all handlers associated with this device */
+
+	handler_obj = obj_desc->device.handler;
+	while (handler_obj) {
+		acpi_os_printf(ACPI_PREDEFINED_PREFIX,
+			       acpi_ut_get_region_name((u8)handler_obj->
+						       address_space.space_id),
+			       handler_obj->address_space.space_id);
+
+		acpi_os_printf(ACPI_HANDLER_PRESENT_STRING2,
+			       (handler_obj->address_space.handler_flags &
+				ACPI_ADDR_HANDLER_DEFAULT_INSTALLED) ? "Default"
+			       : "User", handler_obj->address_space.handler);
+
+		acpi_os_printf(" Device Name: %s (%p)\n", pathname, node);
+
+		handler_obj = handler_obj->address_space.next;
+	}
+
+	ACPI_FREE(pathname);
+	return (AE_OK);
+}
diff --git a/drivers/acpi/acpica/dbexec.c b/drivers/acpi/acpica/dbexec.c
new file mode 100644
index 0000000..8eef298
--- /dev/null
+++ b/drivers/acpi/acpica/dbexec.c
@@ -0,0 +1,753 @@
+/*******************************************************************************
+ *
+ * Module Name: dbexec - debugger control method execution
+ *
+ ******************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2015, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include <acpi/acpi.h>
+#include "accommon.h"
+#include "acdebug.h"
+#include "acnamesp.h"
+
+#define _COMPONENT          ACPI_CA_DEBUGGER
+ACPI_MODULE_NAME("dbexec")
+
+static struct acpi_db_method_info acpi_gbl_db_method_info;
+
+/* Local prototypes */
+
+static acpi_status
+acpi_db_execute_method(struct acpi_db_method_info *info,
+		       struct acpi_buffer *return_obj);
+
+static acpi_status acpi_db_execute_setup(struct acpi_db_method_info *info);
+
+static u32 acpi_db_get_outstanding_allocations(void);
+
+static void ACPI_SYSTEM_XFACE acpi_db_method_thread(void *context);
+
+static acpi_status
+acpi_db_execution_walk(acpi_handle obj_handle,
+		       u32 nesting_level, void *context, void **return_value);
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_delete_objects
+ *
+ * PARAMETERS:  count               - Count of objects in the list
+ *              objects             - Array of ACPI_OBJECTs to be deleted
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Delete a list of ACPI_OBJECTS. Handles packages and nested
+ *              packages via recursion.
+ *
+ ******************************************************************************/
+
+void acpi_db_delete_objects(u32 count, union acpi_object *objects)
+{
+	u32 i;
+
+	for (i = 0; i < count; i++) {
+		switch (objects[i].type) {
+		case ACPI_TYPE_BUFFER:
+
+			ACPI_FREE(objects[i].buffer.pointer);
+			break;
+
+		case ACPI_TYPE_PACKAGE:
+
+			/* Recursive call to delete package elements */
+
+			acpi_db_delete_objects(objects[i].package.count,
+					       objects[i].package.elements);
+
+			/* Free the elements array */
+
+			ACPI_FREE(objects[i].package.elements);
+			break;
+
+		default:
+
+			break;
+		}
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_execute_method
+ *
+ * PARAMETERS:  info            - Valid info segment
+ *              return_obj      - Where to put return object
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Execute a control method.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_db_execute_method(struct acpi_db_method_info *info,
+		       struct acpi_buffer *return_obj)
+{
+	acpi_status status;
+	struct acpi_object_list param_objects;
+	union acpi_object params[ACPI_DEBUGGER_MAX_ARGS + 1];
+	u32 i;
+
+	ACPI_FUNCTION_TRACE(db_execute_method);
+
+	if (acpi_gbl_db_output_to_file && !acpi_dbg_level) {
+		acpi_os_printf("Warning: debug output is not enabled!\n");
+	}
+
+	param_objects.count = 0;
+	param_objects.pointer = NULL;
+
+	/* Pass through any command-line arguments */
+
+	if (info->args && info->args[0]) {
+
+		/* Get arguments passed on the command line */
+
+		for (i = 0; (info->args[i] && *(info->args[i])); i++) {
+
+			/* Convert input string (token) to an actual union acpi_object */
+
+			status = acpi_db_convert_to_object(info->types[i],
+							   info->args[i],
+							   &params[i]);
+			if (ACPI_FAILURE(status)) {
+				ACPI_EXCEPTION((AE_INFO, status,
+						"While parsing method arguments"));
+				goto cleanup;
+			}
+		}
+
+		param_objects.count = i;
+		param_objects.pointer = params;
+	}
+
+	/* Prepare for a return object of arbitrary size */
+
+	return_obj->pointer = acpi_gbl_db_buffer;
+	return_obj->length = ACPI_DEBUG_BUFFER_SIZE;
+
+	/* Do the actual method execution */
+
+	acpi_gbl_method_executing = TRUE;
+	status = acpi_evaluate_object(NULL, info->pathname,
+				      &param_objects, return_obj);
+
+	acpi_gbl_cm_single_step = FALSE;
+	acpi_gbl_method_executing = FALSE;
+
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status,
+				"while executing %s from debugger",
+				info->pathname));
+
+		if (status == AE_BUFFER_OVERFLOW) {
+			ACPI_ERROR((AE_INFO,
+				    "Possible overflow of internal debugger "
+				    "buffer (size 0x%X needed 0x%X)",
+				    ACPI_DEBUG_BUFFER_SIZE,
+				    (u32)return_obj->length));
+		}
+	}
+
+cleanup:
+	acpi_db_delete_objects(param_objects.count, params);
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_execute_setup
+ *
+ * PARAMETERS:  info            - Valid method info
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Setup info segment prior to method execution
+ *
+ ******************************************************************************/
+
+static acpi_status acpi_db_execute_setup(struct acpi_db_method_info *info)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_NAME(db_execute_setup);
+
+	/* Catenate the current scope to the supplied name */
+
+	info->pathname[0] = 0;
+	if ((info->name[0] != '\\') && (info->name[0] != '/')) {
+		if (acpi_ut_safe_strcat(info->pathname, sizeof(info->pathname),
+					acpi_gbl_db_scope_buf)) {
+			status = AE_BUFFER_OVERFLOW;
+			goto error_exit;
+		}
+	}
+
+	if (acpi_ut_safe_strcat(info->pathname, sizeof(info->pathname),
+				info->name)) {
+		status = AE_BUFFER_OVERFLOW;
+		goto error_exit;
+	}
+
+	acpi_db_prep_namestring(info->pathname);
+
+	acpi_db_set_output_destination(ACPI_DB_DUPLICATE_OUTPUT);
+	acpi_os_printf("Evaluating %s\n", info->pathname);
+
+	if (info->flags & EX_SINGLE_STEP) {
+		acpi_gbl_cm_single_step = TRUE;
+		acpi_db_set_output_destination(ACPI_DB_CONSOLE_OUTPUT);
+	}
+
+	else {
+		/* No single step, allow redirection to a file */
+
+		acpi_db_set_output_destination(ACPI_DB_REDIRECTABLE_OUTPUT);
+	}
+
+	return (AE_OK);
+
+error_exit:
+
+	ACPI_EXCEPTION((AE_INFO, status, "During setup for method execution"));
+	return (status);
+}
+
+#ifdef ACPI_DBG_TRACK_ALLOCATIONS
+u32 acpi_db_get_cache_info(struct acpi_memory_list *cache)
+{
+
+	return (cache->total_allocated - cache->total_freed -
+		cache->current_depth);
+}
+#endif
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_get_outstanding_allocations
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Current global allocation count minus cache entries
+ *
+ * DESCRIPTION: Determine the current number of "outstanding" allocations --
+ *              those allocations that have not been freed and also are not
+ *              in one of the various object caches.
+ *
+ ******************************************************************************/
+
+static u32 acpi_db_get_outstanding_allocations(void)
+{
+	u32 outstanding = 0;
+
+#ifdef ACPI_DBG_TRACK_ALLOCATIONS
+
+	outstanding += acpi_db_get_cache_info(acpi_gbl_state_cache);
+	outstanding += acpi_db_get_cache_info(acpi_gbl_ps_node_cache);
+	outstanding += acpi_db_get_cache_info(acpi_gbl_ps_node_ext_cache);
+	outstanding += acpi_db_get_cache_info(acpi_gbl_operand_cache);
+#endif
+
+	return (outstanding);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_execution_walk
+ *
+ * PARAMETERS:  WALK_CALLBACK
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Execute a control method. Name is relative to the current
+ *              scope.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_db_execution_walk(acpi_handle obj_handle,
+		       u32 nesting_level, void *context, void **return_value)
+{
+	union acpi_operand_object *obj_desc;
+	struct acpi_namespace_node *node =
+	    (struct acpi_namespace_node *)obj_handle;
+	struct acpi_buffer return_obj;
+	acpi_status status;
+
+	obj_desc = acpi_ns_get_attached_object(node);
+	if (obj_desc->method.param_count) {
+		return (AE_OK);
+	}
+
+	return_obj.pointer = NULL;
+	return_obj.length = ACPI_ALLOCATE_BUFFER;
+
+	acpi_ns_print_node_pathname(node, "Evaluating");
+
+	/* Do the actual method execution */
+
+	acpi_os_printf("\n");
+	acpi_gbl_method_executing = TRUE;
+
+	status = acpi_evaluate_object(node, NULL, NULL, &return_obj);
+
+	acpi_os_printf("Evaluation of [%4.4s] returned %s\n",
+		       acpi_ut_get_node_name(node),
+		       acpi_format_exception(status));
+
+	acpi_gbl_method_executing = FALSE;
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_execute
+ *
+ * PARAMETERS:  name                - Name of method to execute
+ *              args                - Parameters to the method
+ *              Types               -
+ *              flags               - single step/no single step
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Execute a control method. Name is relative to the current
+ *              scope.
+ *
+ ******************************************************************************/
+
+void
+acpi_db_execute(char *name, char **args, acpi_object_type * types, u32 flags)
+{
+	acpi_status status;
+	struct acpi_buffer return_obj;
+	char *name_string;
+
+#ifdef ACPI_DEBUG_OUTPUT
+	u32 previous_allocations;
+	u32 allocations;
+
+	/* Memory allocation tracking */
+
+	previous_allocations = acpi_db_get_outstanding_allocations();
+#endif
+
+	if (*name == '*') {
+		(void)acpi_walk_namespace(ACPI_TYPE_METHOD, ACPI_ROOT_OBJECT,
+					  ACPI_UINT32_MAX,
+					  acpi_db_execution_walk, NULL, NULL,
+					  NULL);
+		return;
+	} else {
+		name_string = ACPI_ALLOCATE(strlen(name) + 1);
+		if (!name_string) {
+			return;
+		}
+
+		memset(&acpi_gbl_db_method_info, 0,
+		       sizeof(struct acpi_db_method_info));
+
+		strcpy(name_string, name);
+		acpi_ut_strupr(name_string);
+		acpi_gbl_db_method_info.name = name_string;
+		acpi_gbl_db_method_info.args = args;
+		acpi_gbl_db_method_info.types = types;
+		acpi_gbl_db_method_info.flags = flags;
+
+		return_obj.pointer = NULL;
+		return_obj.length = ACPI_ALLOCATE_BUFFER;
+
+		status = acpi_db_execute_setup(&acpi_gbl_db_method_info);
+		if (ACPI_FAILURE(status)) {
+			ACPI_FREE(name_string);
+			return;
+		}
+
+		/* Get the NS node, determines existence also */
+
+		status = acpi_get_handle(NULL, acpi_gbl_db_method_info.pathname,
+					 &acpi_gbl_db_method_info.method);
+		if (ACPI_SUCCESS(status)) {
+			status =
+			    acpi_db_execute_method(&acpi_gbl_db_method_info,
+						   &return_obj);
+		}
+		ACPI_FREE(name_string);
+	}
+
+	/*
+	 * Allow any handlers in separate threads to complete.
+	 * (Such as Notify handlers invoked from AML executed above).
+	 */
+	acpi_os_sleep((u64)10);
+
+#ifdef ACPI_DEBUG_OUTPUT
+
+	/* Memory allocation tracking */
+
+	allocations =
+	    acpi_db_get_outstanding_allocations() - previous_allocations;
+
+	acpi_db_set_output_destination(ACPI_DB_DUPLICATE_OUTPUT);
+
+	if (allocations > 0) {
+		acpi_os_printf
+		    ("0x%X Outstanding allocations after evaluation of %s\n",
+		     allocations, acpi_gbl_db_method_info.pathname);
+	}
+#endif
+
+	if (ACPI_FAILURE(status)) {
+		acpi_os_printf("Evaluation of %s failed with status %s\n",
+			       acpi_gbl_db_method_info.pathname,
+			       acpi_format_exception(status));
+	} else {
+		/* Display a return object, if any */
+
+		if (return_obj.length) {
+			acpi_os_printf("Evaluation of %s returned object %p, "
+				       "external buffer length %X\n",
+				       acpi_gbl_db_method_info.pathname,
+				       return_obj.pointer,
+				       (u32)return_obj.length);
+
+			acpi_db_dump_external_object(return_obj.pointer, 1);
+
+			/* Dump a _PLD buffer if present */
+
+			if (ACPI_COMPARE_NAME
+			    ((ACPI_CAST_PTR
+			      (struct acpi_namespace_node,
+			       acpi_gbl_db_method_info.method)->name.ascii),
+			     METHOD_NAME__PLD)) {
+				acpi_db_dump_pld_buffer(return_obj.pointer);
+			}
+		} else {
+			acpi_os_printf
+			    ("No object was returned from evaluation of %s\n",
+			     acpi_gbl_db_method_info.pathname);
+		}
+	}
+
+	acpi_db_set_output_destination(ACPI_DB_CONSOLE_OUTPUT);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_method_thread
+ *
+ * PARAMETERS:  context             - Execution info segment
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Debugger execute thread. Waits for a command line, then
+ *              simply dispatches it.
+ *
+ ******************************************************************************/
+
+static void ACPI_SYSTEM_XFACE acpi_db_method_thread(void *context)
+{
+	acpi_status status;
+	struct acpi_db_method_info *info = context;
+	struct acpi_db_method_info local_info;
+	u32 i;
+	u8 allow;
+	struct acpi_buffer return_obj;
+
+	/*
+	 * acpi_gbl_db_method_info.Arguments will be passed as method arguments.
+	 * Prevent acpi_gbl_db_method_info from being modified by multiple threads
+	 * concurrently.
+	 *
+	 * Note: The arguments we are passing are used by the ASL test suite
+	 * (aslts). Do not change them without updating the tests.
+	 */
+	(void)acpi_os_wait_semaphore(info->info_gate, 1, ACPI_WAIT_FOREVER);
+
+	if (info->init_args) {
+		acpi_db_uint32_to_hex_string(info->num_created,
+					     info->index_of_thread_str);
+		acpi_db_uint32_to_hex_string((u32)acpi_os_get_thread_id(),
+					     info->id_of_thread_str);
+	}
+
+	if (info->threads && (info->num_created < info->num_threads)) {
+		info->threads[info->num_created++] = acpi_os_get_thread_id();
+	}
+
+	local_info = *info;
+	local_info.args = local_info.arguments;
+	local_info.arguments[0] = local_info.num_threads_str;
+	local_info.arguments[1] = local_info.id_of_thread_str;
+	local_info.arguments[2] = local_info.index_of_thread_str;
+	local_info.arguments[3] = NULL;
+
+	local_info.types = local_info.arg_types;
+
+	(void)acpi_os_signal_semaphore(info->info_gate, 1);
+
+	for (i = 0; i < info->num_loops; i++) {
+		status = acpi_db_execute_method(&local_info, &return_obj);
+		if (ACPI_FAILURE(status)) {
+			acpi_os_printf
+			    ("%s During evaluation of %s at iteration %X\n",
+			     acpi_format_exception(status), info->pathname, i);
+			if (status == AE_ABORT_METHOD) {
+				break;
+			}
+		}
+#if 0
+		if ((i % 100) == 0) {
+			acpi_os_printf("%u loops, Thread 0x%x\n",
+				       i, acpi_os_get_thread_id());
+		}
+
+		if (return_obj.length) {
+			acpi_os_printf
+			    ("Evaluation of %s returned object %p Buflen %X\n",
+			     info->pathname, return_obj.pointer,
+			     (u32)return_obj.length);
+			acpi_db_dump_external_object(return_obj.pointer, 1);
+		}
+#endif
+	}
+
+	/* Signal our completion */
+
+	allow = 0;
+	(void)acpi_os_wait_semaphore(info->thread_complete_gate,
+				     1, ACPI_WAIT_FOREVER);
+	info->num_completed++;
+
+	if (info->num_completed == info->num_threads) {
+
+		/* Do signal for main thread once only */
+		allow = 1;
+	}
+
+	(void)acpi_os_signal_semaphore(info->thread_complete_gate, 1);
+
+	if (allow) {
+		status = acpi_os_signal_semaphore(info->main_thread_gate, 1);
+		if (ACPI_FAILURE(status)) {
+			acpi_os_printf
+			    ("Could not signal debugger thread sync semaphore, %s\n",
+			     acpi_format_exception(status));
+		}
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_create_execution_threads
+ *
+ * PARAMETERS:  num_threads_arg         - Number of threads to create
+ *              num_loops_arg           - Loop count for the thread(s)
+ *              method_name_arg         - Control method to execute
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Create threads to execute method(s)
+ *
+ ******************************************************************************/
+
+void
+acpi_db_create_execution_threads(char *num_threads_arg,
+				 char *num_loops_arg, char *method_name_arg)
+{
+	acpi_status status;
+	u32 num_threads;
+	u32 num_loops;
+	u32 i;
+	u32 size;
+	acpi_mutex main_thread_gate;
+	acpi_mutex thread_complete_gate;
+	acpi_mutex info_gate;
+
+	/* Get the arguments */
+
+	num_threads = strtoul(num_threads_arg, NULL, 0);
+	num_loops = strtoul(num_loops_arg, NULL, 0);
+
+	if (!num_threads || !num_loops) {
+		acpi_os_printf("Bad argument: Threads %X, Loops %X\n",
+			       num_threads, num_loops);
+		return;
+	}
+
+	/*
+	 * Create the semaphore for synchronization of
+	 * the created threads with the main thread.
+	 */
+	status = acpi_os_create_semaphore(1, 0, &main_thread_gate);
+	if (ACPI_FAILURE(status)) {
+		acpi_os_printf("Could not create semaphore for "
+			       "synchronization with the main thread, %s\n",
+			       acpi_format_exception(status));
+		return;
+	}
+
+	/*
+	 * Create the semaphore for synchronization
+	 * between the created threads.
+	 */
+	status = acpi_os_create_semaphore(1, 1, &thread_complete_gate);
+	if (ACPI_FAILURE(status)) {
+		acpi_os_printf("Could not create semaphore for "
+			       "synchronization between the created threads, %s\n",
+			       acpi_format_exception(status));
+
+		(void)acpi_os_delete_semaphore(main_thread_gate);
+		return;
+	}
+
+	status = acpi_os_create_semaphore(1, 1, &info_gate);
+	if (ACPI_FAILURE(status)) {
+		acpi_os_printf("Could not create semaphore for "
+			       "synchronization of AcpiGbl_DbMethodInfo, %s\n",
+			       acpi_format_exception(status));
+
+		(void)acpi_os_delete_semaphore(thread_complete_gate);
+		(void)acpi_os_delete_semaphore(main_thread_gate);
+		return;
+	}
+
+	memset(&acpi_gbl_db_method_info, 0, sizeof(struct acpi_db_method_info));
+
+	/* Array to store IDs of threads */
+
+	acpi_gbl_db_method_info.num_threads = num_threads;
+	size = sizeof(acpi_thread_id) * acpi_gbl_db_method_info.num_threads;
+
+	acpi_gbl_db_method_info.threads = acpi_os_allocate(size);
+	if (acpi_gbl_db_method_info.threads == NULL) {
+		acpi_os_printf("No memory for thread IDs array\n");
+		(void)acpi_os_delete_semaphore(main_thread_gate);
+		(void)acpi_os_delete_semaphore(thread_complete_gate);
+		(void)acpi_os_delete_semaphore(info_gate);
+		return;
+	}
+	memset(acpi_gbl_db_method_info.threads, 0, size);
+
+	/* Setup the context to be passed to each thread */
+
+	acpi_gbl_db_method_info.name = method_name_arg;
+	acpi_gbl_db_method_info.flags = 0;
+	acpi_gbl_db_method_info.num_loops = num_loops;
+	acpi_gbl_db_method_info.main_thread_gate = main_thread_gate;
+	acpi_gbl_db_method_info.thread_complete_gate = thread_complete_gate;
+	acpi_gbl_db_method_info.info_gate = info_gate;
+
+	/* Init arguments to be passed to method */
+
+	acpi_gbl_db_method_info.init_args = 1;
+	acpi_gbl_db_method_info.args = acpi_gbl_db_method_info.arguments;
+	acpi_gbl_db_method_info.arguments[0] =
+	    acpi_gbl_db_method_info.num_threads_str;
+	acpi_gbl_db_method_info.arguments[1] =
+	    acpi_gbl_db_method_info.id_of_thread_str;
+	acpi_gbl_db_method_info.arguments[2] =
+	    acpi_gbl_db_method_info.index_of_thread_str;
+	acpi_gbl_db_method_info.arguments[3] = NULL;
+
+	acpi_gbl_db_method_info.types = acpi_gbl_db_method_info.arg_types;
+	acpi_gbl_db_method_info.arg_types[0] = ACPI_TYPE_INTEGER;
+	acpi_gbl_db_method_info.arg_types[1] = ACPI_TYPE_INTEGER;
+	acpi_gbl_db_method_info.arg_types[2] = ACPI_TYPE_INTEGER;
+
+	acpi_db_uint32_to_hex_string(num_threads,
+				     acpi_gbl_db_method_info.num_threads_str);
+
+	status = acpi_db_execute_setup(&acpi_gbl_db_method_info);
+	if (ACPI_FAILURE(status)) {
+		goto cleanup_and_exit;
+	}
+
+	/* Get the NS node, determines existence also */
+
+	status = acpi_get_handle(NULL, acpi_gbl_db_method_info.pathname,
+				 &acpi_gbl_db_method_info.method);
+	if (ACPI_FAILURE(status)) {
+		acpi_os_printf("%s Could not get handle for %s\n",
+			       acpi_format_exception(status),
+			       acpi_gbl_db_method_info.pathname);
+		goto cleanup_and_exit;
+	}
+
+	/* Create the threads */
+
+	acpi_os_printf("Creating %X threads to execute %X times each\n",
+		       num_threads, num_loops);
+
+	for (i = 0; i < (num_threads); i++) {
+		status =
+		    acpi_os_execute(OSL_DEBUGGER_THREAD, acpi_db_method_thread,
+				    &acpi_gbl_db_method_info);
+		if (ACPI_FAILURE(status)) {
+			break;
+		}
+	}
+
+	/* Wait for all threads to complete */
+
+	(void)acpi_os_wait_semaphore(main_thread_gate, 1, ACPI_WAIT_FOREVER);
+
+	acpi_db_set_output_destination(ACPI_DB_DUPLICATE_OUTPUT);
+	acpi_os_printf("All threads (%X) have completed\n", num_threads);
+	acpi_db_set_output_destination(ACPI_DB_CONSOLE_OUTPUT);
+
+cleanup_and_exit:
+
+	/* Cleanup and exit */
+
+	(void)acpi_os_delete_semaphore(main_thread_gate);
+	(void)acpi_os_delete_semaphore(thread_complete_gate);
+	(void)acpi_os_delete_semaphore(info_gate);
+
+	acpi_os_free(acpi_gbl_db_method_info.threads);
+	acpi_gbl_db_method_info.threads = NULL;
+}
diff --git a/drivers/acpi/acpica/dbfileio.c b/drivers/acpi/acpica/dbfileio.c
new file mode 100644
index 0000000..d0e6b20
--- /dev/null
+++ b/drivers/acpi/acpica/dbfileio.c
@@ -0,0 +1,256 @@
+/*******************************************************************************
+ *
+ * Module Name: dbfileio - Debugger file I/O commands. These can't usually
+ *              be used when running the debugger in Ring 0 (Kernel mode)
+ *
+ ******************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2015, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include <acpi/acpi.h>
+#include "accommon.h"
+#include "acdebug.h"
+#include "actables.h"
+
+#define _COMPONENT          ACPI_CA_DEBUGGER
+ACPI_MODULE_NAME("dbfileio")
+
+#ifdef ACPI_DEBUGGER
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_close_debug_file
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: If open, close the current debug output file
+ *
+ ******************************************************************************/
+void acpi_db_close_debug_file(void)
+{
+
+#ifdef ACPI_APPLICATION
+
+	if (acpi_gbl_debug_file) {
+		fclose(acpi_gbl_debug_file);
+		acpi_gbl_debug_file = NULL;
+		acpi_gbl_db_output_to_file = FALSE;
+		acpi_os_printf("Debug output file %s closed\n",
+			       acpi_gbl_db_debug_filename);
+	}
+#endif
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_open_debug_file
+ *
+ * PARAMETERS:  name                - Filename to open
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Open a file where debug output will be directed.
+ *
+ ******************************************************************************/
+
+void acpi_db_open_debug_file(char *name)
+{
+
+#ifdef ACPI_APPLICATION
+
+	acpi_db_close_debug_file();
+	acpi_gbl_debug_file = fopen(name, "w+");
+	if (!acpi_gbl_debug_file) {
+		acpi_os_printf("Could not open debug file %s\n", name);
+		return;
+	}
+
+	acpi_os_printf("Debug output file %s opened\n", name);
+	strncpy(acpi_gbl_db_debug_filename, name,
+		sizeof(acpi_gbl_db_debug_filename));
+	acpi_gbl_db_output_to_file = TRUE;
+
+#endif
+}
+#endif
+
+#ifdef ACPI_APPLICATION
+#include "acapps.h"
+
+/*******************************************************************************
+ *
+ * FUNCTION:    ae_local_load_table
+ *
+ * PARAMETERS:  table           - pointer to a buffer containing the entire
+ *                                table to be loaded
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: This function is called to load a table from the caller's
+ *              buffer. The buffer must contain an entire ACPI Table including
+ *              a valid header. The header fields will be verified, and if it
+ *              is determined that the table is invalid, the call will fail.
+ *
+ ******************************************************************************/
+
+static acpi_status ae_local_load_table(struct acpi_table_header *table)
+{
+	acpi_status status = AE_OK;
+
+	ACPI_FUNCTION_TRACE(ae_local_load_table);
+
+#if 0
+/*    struct acpi_table_desc          table_info; */
+
+	if (!table) {
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+	}
+
+	table_info.pointer = table;
+	status = acpi_tb_recognize_table(&table_info, ACPI_TABLE_ALL);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/* Install the new table into the local data structures */
+
+	status = acpi_tb_init_table_descriptor(&table_info);
+	if (ACPI_FAILURE(status)) {
+		if (status == AE_ALREADY_EXISTS) {
+
+			/* Table already exists, no error */
+
+			status = AE_OK;
+		}
+
+		/* Free table allocated by acpi_tb_get_table */
+
+		acpi_tb_delete_single_table(&table_info);
+		return_ACPI_STATUS(status);
+	}
+#if (!defined (ACPI_NO_METHOD_EXECUTION) && !defined (ACPI_CONSTANT_EVAL_ONLY))
+
+	status =
+	    acpi_ns_load_table(table_info.installed_desc, acpi_gbl_root_node);
+	if (ACPI_FAILURE(status)) {
+
+		/* Uninstall table and free the buffer */
+
+		acpi_tb_delete_tables_by_type(ACPI_TABLE_ID_DSDT);
+		return_ACPI_STATUS(status);
+	}
+#endif
+#endif
+
+	return_ACPI_STATUS(status);
+}
+#endif
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_get_table_from_file
+ *
+ * PARAMETERS:  filename        - File where table is located
+ *              return_table    - Where a pointer to the table is returned
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Load an ACPI table from a file
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_db_get_table_from_file(char *filename,
+			    struct acpi_table_header **return_table,
+			    u8 must_be_aml_file)
+{
+#ifdef ACPI_APPLICATION
+	acpi_status status;
+	struct acpi_table_header *table;
+	u8 is_aml_table = TRUE;
+
+	status = acpi_ut_read_table_from_file(filename, &table);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	if (must_be_aml_file) {
+		is_aml_table = acpi_ut_is_aml_table(table);
+		if (!is_aml_table) {
+			ACPI_EXCEPTION((AE_INFO, AE_OK,
+					"Input for -e is not an AML table: "
+					"\"%4.4s\" (must be DSDT/SSDT)",
+					table->signature));
+			return (AE_TYPE);
+		}
+	}
+
+	if (is_aml_table) {
+
+		/* Attempt to recognize and install the table */
+
+		status = ae_local_load_table(table);
+		if (ACPI_FAILURE(status)) {
+			if (status == AE_ALREADY_EXISTS) {
+				acpi_os_printf
+				    ("Table %4.4s is already installed\n",
+				     table->signature);
+			} else {
+				acpi_os_printf("Could not install table, %s\n",
+					       acpi_format_exception(status));
+			}
+
+			return (status);
+		}
+
+		acpi_tb_print_table_header(0, table);
+
+		fprintf(stderr,
+			"Acpi table [%4.4s] successfully installed and loaded\n",
+			table->signature);
+	}
+
+	acpi_gbl_acpi_hardware_present = FALSE;
+	if (return_table) {
+		*return_table = table;
+	}
+
+#endif				/* ACPI_APPLICATION */
+	return (AE_OK);
+}
diff --git a/drivers/acpi/acpica/dbhistry.c b/drivers/acpi/acpica/dbhistry.c
new file mode 100644
index 0000000..9c66a9e
--- /dev/null
+++ b/drivers/acpi/acpica/dbhistry.c
@@ -0,0 +1,239 @@
+/******************************************************************************
+ *
+ * Module Name: dbhistry - debugger HISTORY command
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2015, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include <acpi/acpi.h>
+#include "accommon.h"
+#include "acdebug.h"
+
+#define _COMPONENT          ACPI_CA_DEBUGGER
+ACPI_MODULE_NAME("dbhistry")
+
+#define HI_NO_HISTORY       0
+#define HI_RECORD_HISTORY   1
+#define HISTORY_SIZE        40
+typedef struct history_info {
+	char *command;
+	u32 cmd_num;
+
+} HISTORY_INFO;
+
+static HISTORY_INFO acpi_gbl_history_buffer[HISTORY_SIZE];
+static u16 acpi_gbl_lo_history = 0;
+static u16 acpi_gbl_num_history = 0;
+static u16 acpi_gbl_next_history_index = 0;
+u32 acpi_gbl_next_cmd_num = 1;
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_add_to_history
+ *
+ * PARAMETERS:  command_line    - Command to add
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Add a command line to the history buffer.
+ *
+ ******************************************************************************/
+
+void acpi_db_add_to_history(char *command_line)
+{
+	u16 cmd_len;
+	u16 buffer_len;
+
+	/* Put command into the next available slot */
+
+	cmd_len = (u16)strlen(command_line);
+	if (!cmd_len) {
+		return;
+	}
+
+	if (acpi_gbl_history_buffer[acpi_gbl_next_history_index].command !=
+	    NULL) {
+		buffer_len =
+		    (u16)
+		    strlen(acpi_gbl_history_buffer[acpi_gbl_next_history_index].
+			   command);
+
+		if (cmd_len > buffer_len) {
+			acpi_os_free(acpi_gbl_history_buffer
+				     [acpi_gbl_next_history_index].command);
+			acpi_gbl_history_buffer[acpi_gbl_next_history_index].
+			    command = acpi_os_allocate(cmd_len + 1);
+		}
+	} else {
+		acpi_gbl_history_buffer[acpi_gbl_next_history_index].command =
+		    acpi_os_allocate(cmd_len + 1);
+	}
+
+	strcpy(acpi_gbl_history_buffer[acpi_gbl_next_history_index].command,
+	       command_line);
+
+	acpi_gbl_history_buffer[acpi_gbl_next_history_index].cmd_num =
+	    acpi_gbl_next_cmd_num;
+
+	/* Adjust indexes */
+
+	if ((acpi_gbl_num_history == HISTORY_SIZE) &&
+	    (acpi_gbl_next_history_index == acpi_gbl_lo_history)) {
+		acpi_gbl_lo_history++;
+		if (acpi_gbl_lo_history >= HISTORY_SIZE) {
+			acpi_gbl_lo_history = 0;
+		}
+	}
+
+	acpi_gbl_next_history_index++;
+	if (acpi_gbl_next_history_index >= HISTORY_SIZE) {
+		acpi_gbl_next_history_index = 0;
+	}
+
+	acpi_gbl_next_cmd_num++;
+	if (acpi_gbl_num_history < HISTORY_SIZE) {
+		acpi_gbl_num_history++;
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_display_history
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Display the contents of the history buffer
+ *
+ ******************************************************************************/
+
+void acpi_db_display_history(void)
+{
+	u32 i;
+	u16 history_index;
+
+	history_index = acpi_gbl_lo_history;
+
+	/* Dump entire history buffer */
+
+	for (i = 0; i < acpi_gbl_num_history; i++) {
+		if (acpi_gbl_history_buffer[history_index].command) {
+			acpi_os_printf("%3ld %s\n",
+				       acpi_gbl_history_buffer[history_index].
+				       cmd_num,
+				       acpi_gbl_history_buffer[history_index].
+				       command);
+		}
+
+		history_index++;
+		if (history_index >= HISTORY_SIZE) {
+			history_index = 0;
+		}
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_get_from_history
+ *
+ * PARAMETERS:  command_num_arg         - String containing the number of the
+ *                                        command to be retrieved
+ *
+ * RETURN:      Pointer to the retrieved command. Null on error.
+ *
+ * DESCRIPTION: Get a command from the history buffer
+ *
+ ******************************************************************************/
+
+char *acpi_db_get_from_history(char *command_num_arg)
+{
+	u32 cmd_num;
+
+	if (command_num_arg == NULL) {
+		cmd_num = acpi_gbl_next_cmd_num - 1;
+	}
+
+	else {
+		cmd_num = strtoul(command_num_arg, NULL, 0);
+	}
+
+	return (acpi_db_get_history_by_index(cmd_num));
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_get_history_by_index
+ *
+ * PARAMETERS:  cmd_num             - Index of the desired history entry.
+ *                                    Values are 0...(acpi_gbl_next_cmd_num - 1)
+ *
+ * RETURN:      Pointer to the retrieved command. Null on error.
+ *
+ * DESCRIPTION: Get a command from the history buffer
+ *
+ ******************************************************************************/
+
+char *acpi_db_get_history_by_index(u32 cmd_num)
+{
+	u32 i;
+	u16 history_index;
+
+	/* Search history buffer */
+
+	history_index = acpi_gbl_lo_history;
+	for (i = 0; i < acpi_gbl_num_history; i++) {
+		if (acpi_gbl_history_buffer[history_index].cmd_num == cmd_num) {
+
+			/* Found the command, return it */
+
+			return (acpi_gbl_history_buffer[history_index].command);
+		}
+
+		/* History buffer is circular */
+
+		history_index++;
+		if (history_index >= HISTORY_SIZE) {
+			history_index = 0;
+		}
+	}
+
+	acpi_os_printf("Invalid history number: %u\n", history_index);
+	return (NULL);
+}
diff --git a/drivers/acpi/acpica/dbinput.c b/drivers/acpi/acpica/dbinput.c
new file mode 100644
index 0000000..7f1b6ec
--- /dev/null
+++ b/drivers/acpi/acpica/dbinput.c
@@ -0,0 +1,1274 @@
+/*******************************************************************************
+ *
+ * Module Name: dbinput - user front-end to the AML debugger
+ *
+ ******************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2015, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include <acpi/acpi.h>
+#include "accommon.h"
+#include "acdebug.h"
+
+#define _COMPONENT          ACPI_CA_DEBUGGER
+ACPI_MODULE_NAME("dbinput")
+
+/* Local prototypes */
+static u32 acpi_db_get_line(char *input_buffer);
+
+static u32 acpi_db_match_command(char *user_command);
+
+static void acpi_db_single_thread(void);
+
+static void acpi_db_display_command_info(char *command, u8 display_all);
+
+static void acpi_db_display_help(char *command);
+
+static u8
+acpi_db_match_command_help(char *command,
+			   const struct acpi_db_command_help *help);
+
+/*
+ * Top-level debugger commands.
+ *
+ * This list of commands must match the string table below it
+ */
+enum acpi_ex_debugger_commands {
+	CMD_NOT_FOUND = 0,
+	CMD_NULL,
+	CMD_ALLOCATIONS,
+	CMD_ARGS,
+	CMD_ARGUMENTS,
+	CMD_BREAKPOINT,
+	CMD_BUSINFO,
+	CMD_CALL,
+	CMD_DEBUG,
+	CMD_DISASSEMBLE,
+	CMD_DISASM,
+	CMD_DUMP,
+	CMD_EVALUATE,
+	CMD_EXECUTE,
+	CMD_EXIT,
+	CMD_FIND,
+	CMD_GO,
+	CMD_HANDLERS,
+	CMD_HELP,
+	CMD_HELP2,
+	CMD_HISTORY,
+	CMD_HISTORY_EXE,
+	CMD_HISTORY_LAST,
+	CMD_INFORMATION,
+	CMD_INTEGRITY,
+	CMD_INTO,
+	CMD_LEVEL,
+	CMD_LIST,
+	CMD_LOCALS,
+	CMD_LOCKS,
+	CMD_METHODS,
+	CMD_NAMESPACE,
+	CMD_NOTIFY,
+	CMD_OBJECTS,
+	CMD_OSI,
+	CMD_OWNER,
+	CMD_PATHS,
+	CMD_PREDEFINED,
+	CMD_PREFIX,
+	CMD_QUIT,
+	CMD_REFERENCES,
+	CMD_RESOURCES,
+	CMD_RESULTS,
+	CMD_SET,
+	CMD_STATS,
+	CMD_STOP,
+	CMD_TABLES,
+	CMD_TEMPLATE,
+	CMD_TRACE,
+	CMD_TREE,
+	CMD_TYPE,
+#ifdef ACPI_APPLICATION
+	CMD_ENABLEACPI,
+	CMD_EVENT,
+	CMD_GPE,
+	CMD_GPES,
+	CMD_SCI,
+	CMD_SLEEP,
+
+	CMD_CLOSE,
+	CMD_LOAD,
+	CMD_OPEN,
+	CMD_UNLOAD,
+
+	CMD_TERMINATE,
+	CMD_THREADS,
+
+	CMD_TEST,
+#endif
+};
+
+#define CMD_FIRST_VALID     2
+
+/* Second parameter is the required argument count */
+
+static const struct acpi_db_command_info acpi_gbl_db_commands[] = {
+	{"<NOT FOUND>", 0},
+	{"<NULL>", 0},
+	{"ALLOCATIONS", 0},
+	{"ARGS", 0},
+	{"ARGUMENTS", 0},
+	{"BREAKPOINT", 1},
+	{"BUSINFO", 0},
+	{"CALL", 0},
+	{"DEBUG", 1},
+	{"DISASSEMBLE", 1},
+	{"DISASM", 1},
+	{"DUMP", 1},
+	{"EVALUATE", 1},
+	{"EXECUTE", 1},
+	{"EXIT", 0},
+	{"FIND", 1},
+	{"GO", 0},
+	{"HANDLERS", 0},
+	{"HELP", 0},
+	{"?", 0},
+	{"HISTORY", 0},
+	{"!", 1},
+	{"!!", 0},
+	{"INFORMATION", 0},
+	{"INTEGRITY", 0},
+	{"INTO", 0},
+	{"LEVEL", 0},
+	{"LIST", 0},
+	{"LOCALS", 0},
+	{"LOCKS", 0},
+	{"METHODS", 0},
+	{"NAMESPACE", 0},
+	{"NOTIFY", 2},
+	{"OBJECTS", 0},
+	{"OSI", 0},
+	{"OWNER", 1},
+	{"PATHS", 0},
+	{"PREDEFINED", 0},
+	{"PREFIX", 0},
+	{"QUIT", 0},
+	{"REFERENCES", 1},
+	{"RESOURCES", 0},
+	{"RESULTS", 0},
+	{"SET", 3},
+	{"STATS", 1},
+	{"STOP", 0},
+	{"TABLES", 0},
+	{"TEMPLATE", 1},
+	{"TRACE", 1},
+	{"TREE", 0},
+	{"TYPE", 1},
+#ifdef ACPI_APPLICATION
+	{"ENABLEACPI", 0},
+	{"EVENT", 1},
+	{"GPE", 1},
+	{"GPES", 0},
+	{"SCI", 0},
+	{"SLEEP", 0},
+
+	{"CLOSE", 0},
+	{"LOAD", 1},
+	{"OPEN", 1},
+	{"UNLOAD", 1},
+
+	{"TERMINATE", 0},
+	{"THREADS", 3},
+
+	{"TEST", 1},
+#endif
+	{NULL, 0}
+};
+
+/*
+ * Help for all debugger commands. First argument is the number of lines
+ * of help to output for the command.
+ */
+static const struct acpi_db_command_help acpi_gbl_db_command_help[] = {
+	{0, "\nGeneral-Purpose Commands:", "\n"},
+	{1, "  Allocations", "Display list of current memory allocations\n"},
+	{2, "  Dump <Address>|<Namepath>", "\n"},
+	{0, "       [Byte|Word|Dword|Qword]",
+	 "Display ACPI objects or memory\n"},
+	{1, "  Handlers", "Info about global handlers\n"},
+	{1, "  Help [Command]", "This help screen or individual command\n"},
+	{1, "  History", "Display command history buffer\n"},
+	{1, "  Level <DebugLevel>] [console]",
+	 "Get/Set debug level for file or console\n"},
+	{1, "  Locks", "Current status of internal mutexes\n"},
+	{1, "  Osi [Install|Remove <name>]",
+	 "Display or modify global _OSI list\n"},
+	{1, "  Quit or Exit", "Exit this command\n"},
+	{8, "  Stats <SubCommand>",
+	 "Display namespace and memory statistics\n"},
+	{1, "     Allocations", "Display list of current memory allocations\n"},
+	{1, "     Memory", "Dump internal memory lists\n"},
+	{1, "     Misc", "Namespace search and mutex stats\n"},
+	{1, "     Objects", "Summary of namespace objects\n"},
+	{1, "     Sizes", "Sizes for each of the internal objects\n"},
+	{1, "     Stack", "Display CPU stack usage\n"},
+	{1, "     Tables", "Info about current ACPI table(s)\n"},
+	{1, "  Tables", "Display info about loaded ACPI tables\n"},
+	{1, "  ! <CommandNumber>", "Execute command from history buffer\n"},
+	{1, "  !!", "Execute last command again\n"},
+
+	{0, "\nNamespace Access Commands:", "\n"},
+	{1, "  Businfo", "Display system bus info\n"},
+	{1, "  Disassemble <Method>", "Disassemble a control method\n"},
+	{1, "  Find <AcpiName> (? is wildcard)",
+	 "Find ACPI name(s) with wildcards\n"},
+	{1, "  Integrity", "Validate namespace integrity\n"},
+	{1, "  Methods", "Display list of loaded control methods\n"},
+	{1, "  Namespace [Object] [Depth]",
+	 "Display loaded namespace tree/subtree\n"},
+	{1, "  Notify <Object> <Value>", "Send a notification on Object\n"},
+	{1, "  Objects [ObjectType]",
+	 "Display summary of all objects or just given type\n"},
+	{1, "  Owner <OwnerId> [Depth]",
+	 "Display loaded namespace by object owner\n"},
+	{1, "  Paths", "Display full pathnames of namespace objects\n"},
+	{1, "  Predefined", "Check all predefined names\n"},
+	{1, "  Prefix [<Namepath>]", "Set or Get current execution prefix\n"},
+	{1, "  References <Addr>", "Find all references to object at addr\n"},
+	{1, "  Resources [DeviceName]",
+	 "Display Device resources (no arg = all devices)\n"},
+	{1, "  Set N <NamedObject> <Value>", "Set value for named integer\n"},
+	{1, "  Template <Object>", "Format/dump a Buffer/ResourceTemplate\n"},
+	{1, "  Type <Object>", "Display object type\n"},
+
+	{0, "\nControl Method Execution Commands:", "\n"},
+	{1, "  Arguments (or Args)", "Display method arguments\n"},
+	{1, "  Breakpoint <AmlOffset>", "Set an AML execution breakpoint\n"},
+	{1, "  Call", "Run to next control method invocation\n"},
+	{1, "  Debug <Namepath> [Arguments]", "Single Step a control method\n"},
+	{6, "  Evaluate", "Synonym for Execute\n"},
+	{5, "  Execute <Namepath> [Arguments]", "Execute control method\n"},
+	{1, "     Hex Integer", "Integer method argument\n"},
+	{1, "     \"Ascii String\"", "String method argument\n"},
+	{1, "     (Hex Byte List)", "Buffer method argument\n"},
+	{1, "     [Package Element List]", "Package method argument\n"},
+	{1, "  Go", "Allow method to run to completion\n"},
+	{1, "  Information", "Display info about the current method\n"},
+	{1, "  Into", "Step into (not over) a method call\n"},
+	{1, "  List [# of Aml Opcodes]", "Display method ASL statements\n"},
+	{1, "  Locals", "Display method local variables\n"},
+	{1, "  Results", "Display method result stack\n"},
+	{1, "  Set <A|L> <#> <Value>", "Set method data (Arguments/Locals)\n"},
+	{1, "  Stop", "Terminate control method\n"},
+	{5, "  Trace <State> [<Namepath>] [Once]",
+	 "Trace control method execution\n"},
+	{1, "     Enable", "Enable all messages\n"},
+	{1, "     Disable", "Disable tracing\n"},
+	{1, "     Method", "Enable method execution messages\n"},
+	{1, "     Opcode", "Enable opcode execution messages\n"},
+	{1, "  Tree", "Display control method calling tree\n"},
+	{1, "  <Enter>", "Single step next AML opcode (over calls)\n"},
+
+#ifdef ACPI_APPLICATION
+	{0, "\nHardware Simulation Commands:", "\n"},
+	{1, "  EnableAcpi", "Enable ACPI (hardware) mode\n"},
+	{1, "  Event <F|G> <Value>", "Generate AcpiEvent (Fixed/GPE)\n"},
+	{1, "  Gpe <GpeNum> [GpeBlockDevice]", "Simulate a GPE\n"},
+	{1, "  Gpes", "Display info on all GPE devices\n"},
+	{1, "  Sci", "Generate an SCI\n"},
+	{1, "  Sleep [SleepState]", "Simulate sleep/wake sequence(s) (0-5)\n"},
+
+	{0, "\nFile I/O Commands:", "\n"},
+	{1, "  Close", "Close debug output file\n"},
+	{1, "  Load <Input Filename>", "Load ACPI table from a file\n"},
+	{1, "  Open <Output Filename>", "Open a file for debug output\n"},
+	{1, "  Unload <Namepath>",
+	 "Unload an ACPI table via namespace object\n"},
+
+	{0, "\nUser Space Commands:", "\n"},
+	{1, "  Terminate", "Delete namespace and all internal objects\n"},
+	{1, "  Thread <Threads><Loops><NamePath>",
+	 "Spawn threads to execute method(s)\n"},
+
+	{0, "\nDebug Test Commands:", "\n"},
+	{3, "  Test <TestName>", "Invoke a debug test\n"},
+	{1, "     Objects", "Read/write/compare all namespace data objects\n"},
+	{1, "     Predefined",
+	 "Execute all ACPI predefined names (_STA, etc.)\n"},
+#endif
+	{0, NULL, NULL}
+};
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_match_command_help
+ *
+ * PARAMETERS:  command             - Command string to match
+ *              help                - Help table entry to attempt match
+ *
+ * RETURN:      TRUE if command matched, FALSE otherwise
+ *
+ * DESCRIPTION: Attempt to match a command in the help table in order to
+ *              print help information for a single command.
+ *
+ ******************************************************************************/
+
+static u8
+acpi_db_match_command_help(char *command,
+			   const struct acpi_db_command_help *help)
+{
+	char *invocation = help->invocation;
+	u32 line_count;
+
+	/* Valid commands in the help table begin with a couple of spaces */
+
+	if (*invocation != ' ') {
+		return (FALSE);
+	}
+
+	while (*invocation == ' ') {
+		invocation++;
+	}
+
+	/* Match command name (full command or substring) */
+
+	while ((*command) && (*invocation) && (*invocation != ' ')) {
+		if (tolower((int)*command) != tolower((int)*invocation)) {
+			return (FALSE);
+		}
+
+		invocation++;
+		command++;
+	}
+
+	/* Print the appropriate number of help lines */
+
+	line_count = help->line_count;
+	while (line_count) {
+		acpi_os_printf("%-38s : %s", help->invocation,
+			       help->description);
+		help++;
+		line_count--;
+	}
+
+	return (TRUE);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_display_command_info
+ *
+ * PARAMETERS:  command             - Command string to match
+ *              display_all         - Display all matching commands, or just
+ *                                    the first one (substring match)
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Display help information for a Debugger command.
+ *
+ ******************************************************************************/
+
+static void acpi_db_display_command_info(char *command, u8 display_all)
+{
+	const struct acpi_db_command_help *next;
+	u8 matched;
+
+	next = acpi_gbl_db_command_help;
+	while (next->invocation) {
+		matched = acpi_db_match_command_help(command, next);
+		if (!display_all && matched) {
+			return;
+		}
+
+		next++;
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_display_help
+ *
+ * PARAMETERS:  command             - Optional command string to display help.
+ *                                    if not specified, all debugger command
+ *                                    help strings are displayed
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Display help for a single debugger command, or all of them.
+ *
+ ******************************************************************************/
+
+static void acpi_db_display_help(char *command)
+{
+	const struct acpi_db_command_help *next = acpi_gbl_db_command_help;
+
+	if (!command) {
+
+		/* No argument to help, display help for all commands */
+
+		while (next->invocation) {
+			acpi_os_printf("%-38s%s", next->invocation,
+				       next->description);
+			next++;
+		}
+	} else {
+		/* Display help for all commands that match the subtring */
+
+		acpi_db_display_command_info(command, TRUE);
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_get_next_token
+ *
+ * PARAMETERS:  string          - Command buffer
+ *              next            - Return value, end of next token
+ *
+ * RETURN:      Pointer to the start of the next token.
+ *
+ * DESCRIPTION: Command line parsing. Get the next token on the command line
+ *
+ ******************************************************************************/
+
+char *acpi_db_get_next_token(char *string,
+			     char **next, acpi_object_type * return_type)
+{
+	char *start;
+	u32 depth;
+	acpi_object_type type = ACPI_TYPE_INTEGER;
+
+	/* At end of buffer? */
+
+	if (!string || !(*string)) {
+		return (NULL);
+	}
+
+	/* Remove any spaces at the beginning */
+
+	if (*string == ' ') {
+		while (*string && (*string == ' ')) {
+			string++;
+		}
+
+		if (!(*string)) {
+			return (NULL);
+		}
+	}
+
+	switch (*string) {
+	case '"':
+
+		/* This is a quoted string, scan until closing quote */
+
+		string++;
+		start = string;
+		type = ACPI_TYPE_STRING;
+
+		/* Find end of string */
+
+		while (*string && (*string != '"')) {
+			string++;
+		}
+		break;
+
+	case '(':
+
+		/* This is the start of a buffer, scan until closing paren */
+
+		string++;
+		start = string;
+		type = ACPI_TYPE_BUFFER;
+
+		/* Find end of buffer */
+
+		while (*string && (*string != ')')) {
+			string++;
+		}
+		break;
+
+	case '[':
+
+		/* This is the start of a package, scan until closing bracket */
+
+		string++;
+		depth = 1;
+		start = string;
+		type = ACPI_TYPE_PACKAGE;
+
+		/* Find end of package (closing bracket) */
+
+		while (*string) {
+
+			/* Handle String package elements */
+
+			if (*string == '"') {
+				/* Find end of string */
+
+				string++;
+				while (*string && (*string != '"')) {
+					string++;
+				}
+				if (!(*string)) {
+					break;
+				}
+			} else if (*string == '[') {
+				depth++;	/* A nested package declaration */
+			} else if (*string == ']') {
+				depth--;
+				if (depth == 0) {	/* Found final package closing bracket */
+					break;
+				}
+			}
+
+			string++;
+		}
+		break;
+
+	default:
+
+		start = string;
+
+		/* Find end of token */
+
+		while (*string && (*string != ' ')) {
+			string++;
+		}
+		break;
+	}
+
+	if (!(*string)) {
+		*next = NULL;
+	} else {
+		*string = 0;
+		*next = string + 1;
+	}
+
+	*return_type = type;
+	return (start);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_get_line
+ *
+ * PARAMETERS:  input_buffer        - Command line buffer
+ *
+ * RETURN:      Count of arguments to the command
+ *
+ * DESCRIPTION: Get the next command line from the user. Gets entire line
+ *              up to the next newline
+ *
+ ******************************************************************************/
+
+static u32 acpi_db_get_line(char *input_buffer)
+{
+	u32 i;
+	u32 count;
+	char *next;
+	char *this;
+
+	if (acpi_ut_safe_strcpy
+	    (acpi_gbl_db_parsed_buf, sizeof(acpi_gbl_db_parsed_buf),
+	     input_buffer)) {
+		acpi_os_printf
+		    ("Buffer overflow while parsing input line (max %u characters)\n",
+		     sizeof(acpi_gbl_db_parsed_buf));
+		return (0);
+	}
+
+	this = acpi_gbl_db_parsed_buf;
+	for (i = 0; i < ACPI_DEBUGGER_MAX_ARGS; i++) {
+		acpi_gbl_db_args[i] = acpi_db_get_next_token(this, &next,
+							     &acpi_gbl_db_arg_types
+							     [i]);
+		if (!acpi_gbl_db_args[i]) {
+			break;
+		}
+
+		this = next;
+	}
+
+	/* Uppercase the actual command */
+
+	if (acpi_gbl_db_args[0]) {
+		acpi_ut_strupr(acpi_gbl_db_args[0]);
+	}
+
+	count = i;
+	if (count) {
+		count--;	/* Number of args only */
+	}
+
+	return (count);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_match_command
+ *
+ * PARAMETERS:  user_command            - User command line
+ *
+ * RETURN:      Index into command array, -1 if not found
+ *
+ * DESCRIPTION: Search command array for a command match
+ *
+ ******************************************************************************/
+
+static u32 acpi_db_match_command(char *user_command)
+{
+	u32 i;
+
+	if (!user_command || user_command[0] == 0) {
+		return (CMD_NULL);
+	}
+
+	for (i = CMD_FIRST_VALID; acpi_gbl_db_commands[i].name; i++) {
+		if (strstr(acpi_gbl_db_commands[i].name, user_command) ==
+		    acpi_gbl_db_commands[i].name) {
+			return (i);
+		}
+	}
+
+	/* Command not recognized */
+
+	return (CMD_NOT_FOUND);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_command_dispatch
+ *
+ * PARAMETERS:  input_buffer        - Command line buffer
+ *              walk_state          - Current walk
+ *              op                  - Current (executing) parse op
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Command dispatcher.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_db_command_dispatch(char *input_buffer,
+			 struct acpi_walk_state * walk_state,
+			 union acpi_parse_object * op)
+{
+	u32 temp;
+	u32 command_index;
+	u32 param_count;
+	char *command_line;
+	acpi_status status = AE_CTRL_TRUE;
+
+	/* If acpi_terminate has been called, terminate this thread */
+
+	if (acpi_gbl_db_terminate_threads) {
+		return (AE_CTRL_TERMINATE);
+	}
+
+	/* Find command and add to the history buffer */
+
+	param_count = acpi_db_get_line(input_buffer);
+	command_index = acpi_db_match_command(acpi_gbl_db_args[0]);
+	temp = 0;
+
+	/*
+	 * We don't want to add the !! command to the history buffer. It
+	 * would cause an infinite loop because it would always be the
+	 * previous command.
+	 */
+	if (command_index != CMD_HISTORY_LAST) {
+		acpi_db_add_to_history(input_buffer);
+	}
+
+	/* Verify that we have the minimum number of params */
+
+	if (param_count < acpi_gbl_db_commands[command_index].min_args) {
+		acpi_os_printf
+		    ("%u parameters entered, [%s] requires %u parameters\n",
+		     param_count, acpi_gbl_db_commands[command_index].name,
+		     acpi_gbl_db_commands[command_index].min_args);
+
+		acpi_db_display_command_info(acpi_gbl_db_commands
+					     [command_index].name, FALSE);
+		return (AE_CTRL_TRUE);
+	}
+
+	/* Decode and dispatch the command */
+
+	switch (command_index) {
+	case CMD_NULL:
+
+		if (op) {
+			return (AE_OK);
+		}
+		break;
+
+	case CMD_ALLOCATIONS:
+
+#ifdef ACPI_DBG_TRACK_ALLOCATIONS
+		acpi_ut_dump_allocations((u32)-1, NULL);
+#endif
+		break;
+
+	case CMD_ARGS:
+	case CMD_ARGUMENTS:
+
+		acpi_db_display_arguments();
+		break;
+
+	case CMD_BREAKPOINT:
+
+		acpi_db_set_method_breakpoint(acpi_gbl_db_args[1], walk_state,
+					      op);
+		break;
+
+	case CMD_BUSINFO:
+
+		acpi_db_get_bus_info();
+		break;
+
+	case CMD_CALL:
+
+		acpi_db_set_method_call_breakpoint(op);
+		status = AE_OK;
+		break;
+
+	case CMD_DEBUG:
+
+		acpi_db_execute(acpi_gbl_db_args[1],
+				&acpi_gbl_db_args[2], &acpi_gbl_db_arg_types[2],
+				EX_SINGLE_STEP);
+		break;
+
+	case CMD_DISASSEMBLE:
+	case CMD_DISASM:
+
+		(void)acpi_db_disassemble_method(acpi_gbl_db_args[1]);
+		break;
+
+	case CMD_DUMP:
+
+		acpi_db_decode_and_display_object(acpi_gbl_db_args[1],
+						  acpi_gbl_db_args[2]);
+		break;
+
+	case CMD_EVALUATE:
+	case CMD_EXECUTE:
+
+		acpi_db_execute(acpi_gbl_db_args[1],
+				&acpi_gbl_db_args[2], &acpi_gbl_db_arg_types[2],
+				EX_NO_SINGLE_STEP);
+		break;
+
+	case CMD_FIND:
+
+		status = acpi_db_find_name_in_namespace(acpi_gbl_db_args[1]);
+		break;
+
+	case CMD_GO:
+
+		acpi_gbl_cm_single_step = FALSE;
+		return (AE_OK);
+
+	case CMD_HANDLERS:
+
+		acpi_db_display_handlers();
+		break;
+
+	case CMD_HELP:
+	case CMD_HELP2:
+
+		acpi_db_display_help(acpi_gbl_db_args[1]);
+		break;
+
+	case CMD_HISTORY:
+
+		acpi_db_display_history();
+		break;
+
+	case CMD_HISTORY_EXE:	/* ! command */
+
+		command_line = acpi_db_get_from_history(acpi_gbl_db_args[1]);
+		if (!command_line) {
+			return (AE_CTRL_TRUE);
+		}
+
+		status = acpi_db_command_dispatch(command_line, walk_state, op);
+		return (status);
+
+	case CMD_HISTORY_LAST:	/* !! command */
+
+		command_line = acpi_db_get_from_history(NULL);
+		if (!command_line) {
+			return (AE_CTRL_TRUE);
+		}
+
+		status = acpi_db_command_dispatch(command_line, walk_state, op);
+		return (status);
+
+	case CMD_INFORMATION:
+
+		acpi_db_display_method_info(op);
+		break;
+
+	case CMD_INTEGRITY:
+
+		acpi_db_check_integrity();
+		break;
+
+	case CMD_INTO:
+
+		if (op) {
+			acpi_gbl_cm_single_step = TRUE;
+			return (AE_OK);
+		}
+		break;
+
+	case CMD_LEVEL:
+
+		if (param_count == 0) {
+			acpi_os_printf
+			    ("Current debug level for file output is:    %8.8lX\n",
+			     acpi_gbl_db_debug_level);
+			acpi_os_printf
+			    ("Current debug level for console output is: %8.8lX\n",
+			     acpi_gbl_db_console_debug_level);
+		} else if (param_count == 2) {
+			temp = acpi_gbl_db_console_debug_level;
+			acpi_gbl_db_console_debug_level =
+			    strtoul(acpi_gbl_db_args[1], NULL, 16);
+			acpi_os_printf
+			    ("Debug Level for console output was %8.8lX, now %8.8lX\n",
+			     temp, acpi_gbl_db_console_debug_level);
+		} else {
+			temp = acpi_gbl_db_debug_level;
+			acpi_gbl_db_debug_level =
+			    strtoul(acpi_gbl_db_args[1], NULL, 16);
+			acpi_os_printf
+			    ("Debug Level for file output was %8.8lX, now %8.8lX\n",
+			     temp, acpi_gbl_db_debug_level);
+		}
+		break;
+
+	case CMD_LIST:
+
+		acpi_db_disassemble_aml(acpi_gbl_db_args[1], op);
+		break;
+
+	case CMD_LOCKS:
+
+		acpi_db_display_locks();
+		break;
+
+	case CMD_LOCALS:
+
+		acpi_db_display_locals();
+		break;
+
+	case CMD_METHODS:
+
+		status = acpi_db_display_objects("METHOD", acpi_gbl_db_args[1]);
+		break;
+
+	case CMD_NAMESPACE:
+
+		acpi_db_dump_namespace(acpi_gbl_db_args[1],
+				       acpi_gbl_db_args[2]);
+		break;
+
+	case CMD_NOTIFY:
+
+		temp = strtoul(acpi_gbl_db_args[2], NULL, 0);
+		acpi_db_send_notify(acpi_gbl_db_args[1], temp);
+		break;
+
+	case CMD_OBJECTS:
+
+		acpi_ut_strupr(acpi_gbl_db_args[1]);
+		status =
+		    acpi_db_display_objects(acpi_gbl_db_args[1],
+					    acpi_gbl_db_args[2]);
+		break;
+
+	case CMD_OSI:
+
+		acpi_db_display_interfaces(acpi_gbl_db_args[1],
+					   acpi_gbl_db_args[2]);
+		break;
+
+	case CMD_OWNER:
+
+		acpi_db_dump_namespace_by_owner(acpi_gbl_db_args[1],
+						acpi_gbl_db_args[2]);
+		break;
+
+	case CMD_PATHS:
+
+		acpi_db_dump_namespace_paths();
+		break;
+
+	case CMD_PREFIX:
+
+		acpi_db_set_scope(acpi_gbl_db_args[1]);
+		break;
+
+	case CMD_REFERENCES:
+
+		acpi_db_find_references(acpi_gbl_db_args[1]);
+		break;
+
+	case CMD_RESOURCES:
+
+		acpi_db_display_resources(acpi_gbl_db_args[1]);
+		break;
+
+	case CMD_RESULTS:
+
+		acpi_db_display_results();
+		break;
+
+	case CMD_SET:
+
+		acpi_db_set_method_data(acpi_gbl_db_args[1],
+					acpi_gbl_db_args[2],
+					acpi_gbl_db_args[3]);
+		break;
+
+	case CMD_STATS:
+
+		status = acpi_db_display_statistics(acpi_gbl_db_args[1]);
+		break;
+
+	case CMD_STOP:
+
+		return (AE_NOT_IMPLEMENTED);
+
+	case CMD_TABLES:
+
+		acpi_db_display_table_info(acpi_gbl_db_args[1]);
+		break;
+
+	case CMD_TEMPLATE:
+
+		acpi_db_display_template(acpi_gbl_db_args[1]);
+		break;
+
+	case CMD_TRACE:
+
+		acpi_db_trace(acpi_gbl_db_args[1], acpi_gbl_db_args[2],
+			      acpi_gbl_db_args[3]);
+		break;
+
+	case CMD_TREE:
+
+		acpi_db_display_calling_tree();
+		break;
+
+	case CMD_TYPE:
+
+		acpi_db_display_object_type(acpi_gbl_db_args[1]);
+		break;
+
+#ifdef ACPI_APPLICATION
+
+		/* Hardware simulation commands. */
+
+	case CMD_ENABLEACPI:
+#if (!ACPI_REDUCED_HARDWARE)
+
+		status = acpi_enable();
+		if (ACPI_FAILURE(status)) {
+			acpi_os_printf("AcpiEnable failed (Status=%X)\n",
+				       status);
+			return (status);
+		}
+#endif				/* !ACPI_REDUCED_HARDWARE */
+		break;
+
+	case CMD_EVENT:
+
+		acpi_os_printf("Event command not implemented\n");
+		break;
+
+	case CMD_GPE:
+
+		acpi_db_generate_gpe(acpi_gbl_db_args[1], acpi_gbl_db_args[2]);
+		break;
+
+	case CMD_GPES:
+
+		acpi_db_display_gpes();
+		break;
+
+	case CMD_SCI:
+
+		acpi_db_generate_sci();
+		break;
+
+	case CMD_SLEEP:
+
+		status = acpi_db_sleep(acpi_gbl_db_args[1]);
+		break;
+
+		/* File I/O commands. */
+
+	case CMD_CLOSE:
+
+		acpi_db_close_debug_file();
+		break;
+
+	case CMD_LOAD:
+
+		status =
+		    acpi_db_get_table_from_file(acpi_gbl_db_args[1], NULL,
+						FALSE);
+		break;
+
+	case CMD_OPEN:
+
+		acpi_db_open_debug_file(acpi_gbl_db_args[1]);
+		break;
+
+		/* User space commands. */
+
+	case CMD_TERMINATE:
+
+		acpi_db_set_output_destination(ACPI_DB_REDIRECTABLE_OUTPUT);
+		acpi_ut_subsystem_shutdown();
+
+		/*
+		 * TBD: [Restructure] Need some way to re-initialize without
+		 * re-creating the semaphores!
+		 */
+
+		/*  acpi_initialize (NULL); */
+		break;
+
+	case CMD_THREADS:
+
+		acpi_db_create_execution_threads(acpi_gbl_db_args[1],
+						 acpi_gbl_db_args[2],
+						 acpi_gbl_db_args[3]);
+		break;
+
+		/* Debug test commands. */
+
+	case CMD_PREDEFINED:
+
+		acpi_db_check_predefined_names();
+		break;
+
+	case CMD_TEST:
+
+		acpi_db_execute_test(acpi_gbl_db_args[1]);
+		break;
+
+	case CMD_UNLOAD:
+
+		acpi_db_unload_acpi_table(acpi_gbl_db_args[1]);
+		break;
+#endif
+
+	case CMD_EXIT:
+	case CMD_QUIT:
+
+		if (op) {
+			acpi_os_printf("Method execution terminated\n");
+			return (AE_CTRL_TERMINATE);
+		}
+
+		if (!acpi_gbl_db_output_to_file) {
+			acpi_dbg_level = ACPI_DEBUG_DEFAULT;
+		}
+#ifdef ACPI_APPLICATION
+		acpi_db_close_debug_file();
+#endif
+		acpi_gbl_db_terminate_threads = TRUE;
+		return (AE_CTRL_TERMINATE);
+
+	case CMD_NOT_FOUND:
+	default:
+
+		acpi_os_printf("%s: unknown command\n", acpi_gbl_db_args[0]);
+		return (AE_CTRL_TRUE);
+	}
+
+	if (ACPI_SUCCESS(status)) {
+		status = AE_CTRL_TRUE;
+	}
+
+	return (status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_execute_thread
+ *
+ * PARAMETERS:  context         - Not used
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Debugger execute thread. Waits for a command line, then
+ *              simply dispatches it.
+ *
+ ******************************************************************************/
+
+void ACPI_SYSTEM_XFACE acpi_db_execute_thread(void *context)
+{
+	acpi_status status = AE_OK;
+	acpi_status Mstatus;
+
+	while (status != AE_CTRL_TERMINATE) {
+		acpi_gbl_method_executing = FALSE;
+		acpi_gbl_step_to_next_call = FALSE;
+
+		Mstatus = acpi_os_acquire_mutex(acpi_gbl_db_command_ready,
+						ACPI_WAIT_FOREVER);
+		if (ACPI_FAILURE(Mstatus)) {
+			return;
+		}
+
+		status =
+		    acpi_db_command_dispatch(acpi_gbl_db_line_buf, NULL, NULL);
+
+		acpi_os_release_mutex(acpi_gbl_db_command_complete);
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_single_thread
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Debugger execute thread. Waits for a command line, then
+ *              simply dispatches it.
+ *
+ ******************************************************************************/
+
+static void acpi_db_single_thread(void)
+{
+
+	acpi_gbl_method_executing = FALSE;
+	acpi_gbl_step_to_next_call = FALSE;
+
+	(void)acpi_db_command_dispatch(acpi_gbl_db_line_buf, NULL, NULL);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_user_commands
+ *
+ * PARAMETERS:  prompt              - User prompt (depends on mode)
+ *              op                  - Current executing parse op
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Command line execution for the AML debugger. Commands are
+ *              matched and dispatched here.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_db_user_commands(char prompt, union acpi_parse_object *op)
+{
+	acpi_status status = AE_OK;
+
+	acpi_os_printf("\n");
+
+	/* TBD: [Restructure] Need a separate command line buffer for step mode */
+
+	while (!acpi_gbl_db_terminate_threads) {
+
+		/* Force output to console until a command is entered */
+
+		acpi_db_set_output_destination(ACPI_DB_CONSOLE_OUTPUT);
+
+		/* Different prompt if method is executing */
+
+		if (!acpi_gbl_method_executing) {
+			acpi_os_printf("%1c ", ACPI_DEBUGGER_COMMAND_PROMPT);
+		} else {
+			acpi_os_printf("%1c ", ACPI_DEBUGGER_EXECUTE_PROMPT);
+		}
+
+		/* Get the user input line */
+
+		status = acpi_os_get_line(acpi_gbl_db_line_buf,
+					  ACPI_DB_LINE_BUFFER_SIZE, NULL);
+		if (ACPI_FAILURE(status)) {
+			ACPI_EXCEPTION((AE_INFO, status,
+					"While parsing command line"));
+			return (status);
+		}
+
+		/* Check for single or multithreaded debug */
+
+		if (acpi_gbl_debugger_configuration & DEBUGGER_MULTI_THREADED) {
+			/*
+			 * Signal the debug thread that we have a command to execute,
+			 * and wait for the command to complete.
+			 */
+			acpi_os_release_mutex(acpi_gbl_db_command_ready);
+			if (ACPI_FAILURE(status)) {
+				return (status);
+			}
+
+			status =
+			    acpi_os_acquire_mutex(acpi_gbl_db_command_complete,
+						  ACPI_WAIT_FOREVER);
+			if (ACPI_FAILURE(status)) {
+				return (status);
+			}
+		} else {
+			/* Just call to the command line interpreter */
+
+			acpi_db_single_thread();
+		}
+	}
+
+	/* Shut down the debugger */
+
+	acpi_terminate_debugger();
+
+	/*
+	 * Only this thread (the original thread) should actually terminate the
+	 * subsystem, because all the semaphores are deleted during termination
+	 */
+	status = acpi_terminate();
+	return (status);
+}
diff --git a/drivers/acpi/acpica/dbmethod.c b/drivers/acpi/acpica/dbmethod.c
new file mode 100644
index 0000000..01e5a71
--- /dev/null
+++ b/drivers/acpi/acpica/dbmethod.c
@@ -0,0 +1,369 @@
+/*******************************************************************************
+ *
+ * Module Name: dbmethod - Debug commands for control methods
+ *
+ ******************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2015, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include <acpi/acpi.h>
+#include "accommon.h"
+#include "acdispat.h"
+#include "acnamesp.h"
+#include "acdebug.h"
+#include "acparser.h"
+#include "acpredef.h"
+
+#define _COMPONENT          ACPI_CA_DEBUGGER
+ACPI_MODULE_NAME("dbmethod")
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_set_method_breakpoint
+ *
+ * PARAMETERS:  location            - AML offset of breakpoint
+ *              walk_state          - Current walk info
+ *              op                  - Current Op (from parse walk)
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Set a breakpoint in a control method at the specified
+ *              AML offset
+ *
+ ******************************************************************************/
+void
+acpi_db_set_method_breakpoint(char *location,
+			      struct acpi_walk_state *walk_state,
+			      union acpi_parse_object *op)
+{
+	u32 address;
+	u32 aml_offset;
+
+	if (!op) {
+		acpi_os_printf("There is no method currently executing\n");
+		return;
+	}
+
+	/* Get and verify the breakpoint address */
+
+	address = strtoul(location, NULL, 16);
+	aml_offset = (u32)ACPI_PTR_DIFF(op->common.aml,
+					walk_state->parser_state.aml_start);
+	if (address <= aml_offset) {
+		acpi_os_printf("Breakpoint %X is beyond current address %X\n",
+			       address, aml_offset);
+	}
+
+	/* Save breakpoint in current walk */
+
+	walk_state->user_breakpoint = address;
+	acpi_os_printf("Breakpoint set at AML offset %X\n", address);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_set_method_call_breakpoint
+ *
+ * PARAMETERS:  op                  - Current Op (from parse walk)
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Set a breakpoint in a control method at the specified
+ *              AML offset
+ *
+ ******************************************************************************/
+
+void acpi_db_set_method_call_breakpoint(union acpi_parse_object *op)
+{
+
+	if (!op) {
+		acpi_os_printf("There is no method currently executing\n");
+		return;
+	}
+
+	acpi_gbl_step_to_next_call = TRUE;
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_set_method_data
+ *
+ * PARAMETERS:  type_arg        - L for local, A for argument
+ *              index_arg       - which one
+ *              value_arg       - Value to set.
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Set a local or argument for the running control method.
+ *              NOTE: only object supported is Number.
+ *
+ ******************************************************************************/
+
+void acpi_db_set_method_data(char *type_arg, char *index_arg, char *value_arg)
+{
+	char type;
+	u32 index;
+	u32 value;
+	struct acpi_walk_state *walk_state;
+	union acpi_operand_object *obj_desc;
+	acpi_status status;
+	struct acpi_namespace_node *node;
+
+	/* Validate type_arg */
+
+	acpi_ut_strupr(type_arg);
+	type = type_arg[0];
+	if ((type != 'L') && (type != 'A') && (type != 'N')) {
+		acpi_os_printf("Invalid SET operand: %s\n", type_arg);
+		return;
+	}
+
+	value = strtoul(value_arg, NULL, 16);
+
+	if (type == 'N') {
+		node = acpi_db_convert_to_node(index_arg);
+		if (!node) {
+			return;
+		}
+
+		if (node->type != ACPI_TYPE_INTEGER) {
+			acpi_os_printf("Can only set Integer nodes\n");
+			return;
+		}
+		obj_desc = node->object;
+		obj_desc->integer.value = value;
+		return;
+	}
+
+	/* Get the index and value */
+
+	index = strtoul(index_arg, NULL, 16);
+
+	walk_state = acpi_ds_get_current_walk_state(acpi_gbl_current_walk_list);
+	if (!walk_state) {
+		acpi_os_printf("There is no method currently executing\n");
+		return;
+	}
+
+	/* Create and initialize the new object */
+
+	obj_desc = acpi_ut_create_integer_object((u64)value);
+	if (!obj_desc) {
+		acpi_os_printf("Could not create an internal object\n");
+		return;
+	}
+
+	/* Store the new object into the target */
+
+	switch (type) {
+	case 'A':
+
+		/* Set a method argument */
+
+		if (index > ACPI_METHOD_MAX_ARG) {
+			acpi_os_printf("Arg%u - Invalid argument name\n",
+				       index);
+			goto cleanup;
+		}
+
+		status = acpi_ds_store_object_to_local(ACPI_REFCLASS_ARG,
+						       index, obj_desc,
+						       walk_state);
+		if (ACPI_FAILURE(status)) {
+			goto cleanup;
+		}
+
+		obj_desc = walk_state->arguments[index].object;
+
+		acpi_os_printf("Arg%u: ", index);
+		acpi_db_display_internal_object(obj_desc, walk_state);
+		break;
+
+	case 'L':
+
+		/* Set a method local */
+
+		if (index > ACPI_METHOD_MAX_LOCAL) {
+			acpi_os_printf
+			    ("Local%u - Invalid local variable name\n", index);
+			goto cleanup;
+		}
+
+		status = acpi_ds_store_object_to_local(ACPI_REFCLASS_LOCAL,
+						       index, obj_desc,
+						       walk_state);
+		if (ACPI_FAILURE(status)) {
+			goto cleanup;
+		}
+
+		obj_desc = walk_state->local_variables[index].object;
+
+		acpi_os_printf("Local%u: ", index);
+		acpi_db_display_internal_object(obj_desc, walk_state);
+		break;
+
+	default:
+
+		break;
+	}
+
+cleanup:
+	acpi_ut_remove_reference(obj_desc);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_disassemble_aml
+ *
+ * PARAMETERS:  statements          - Number of statements to disassemble
+ *              op                  - Current Op (from parse walk)
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Display disassembled AML (ASL) starting from Op for the number
+ *              of statements specified.
+ *
+ ******************************************************************************/
+
+void acpi_db_disassemble_aml(char *statements, union acpi_parse_object *op)
+{
+	u32 num_statements = 8;
+
+	if (!op) {
+		acpi_os_printf("There is no method currently executing\n");
+		return;
+	}
+
+	if (statements) {
+		num_statements = strtoul(statements, NULL, 0);
+	}
+#ifdef ACPI_DISASSEMBLER
+	acpi_dm_disassemble(NULL, op, num_statements);
+#endif
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_disassemble_method
+ *
+ * PARAMETERS:  name            - Name of control method
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Display disassembled AML (ASL) starting from Op for the number
+ *              of statements specified.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_db_disassemble_method(char *name)
+{
+	acpi_status status;
+	union acpi_parse_object *op;
+	struct acpi_walk_state *walk_state;
+	union acpi_operand_object *obj_desc;
+	struct acpi_namespace_node *method;
+
+	method = acpi_db_convert_to_node(name);
+	if (!method) {
+		return (AE_BAD_PARAMETER);
+	}
+
+	if (method->type != ACPI_TYPE_METHOD) {
+		ACPI_ERROR((AE_INFO, "%s (%s): Object must be a control method",
+			    name, acpi_ut_get_type_name(method->type)));
+		return (AE_BAD_PARAMETER);
+	}
+
+	obj_desc = method->object;
+
+	op = acpi_ps_create_scope_op(obj_desc->method.aml_start);
+	if (!op) {
+		return (AE_NO_MEMORY);
+	}
+
+	/* Create and initialize a new walk state */
+
+	walk_state = acpi_ds_create_walk_state(0, op, NULL, NULL);
+	if (!walk_state) {
+		return (AE_NO_MEMORY);
+	}
+
+	status = acpi_ds_init_aml_walk(walk_state, op, NULL,
+				       obj_desc->method.aml_start,
+				       obj_desc->method.aml_length, NULL,
+				       ACPI_IMODE_LOAD_PASS1);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	status = acpi_ut_allocate_owner_id(&obj_desc->method.owner_id);
+	walk_state->owner_id = obj_desc->method.owner_id;
+
+	/* Push start scope on scope stack and make it current */
+
+	status = acpi_ds_scope_stack_push(method, method->type, walk_state);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	/* Parse the entire method AML including deferred operators */
+
+	walk_state->parse_flags &= ~ACPI_PARSE_DELETE_TREE;
+	walk_state->parse_flags |= ACPI_PARSE_DISASSEMBLE;
+
+	status = acpi_ps_parse_aml(walk_state);
+
+#ifdef ACPI_DISASSEMBLER
+	(void)acpi_dm_parse_deferred_ops(op);
+
+	/* Now we can disassemble the method */
+
+	acpi_gbl_dm_opt_verbose = FALSE;
+	acpi_dm_disassemble(NULL, op, 0);
+	acpi_gbl_dm_opt_verbose = TRUE;
+#endif
+
+	acpi_ps_delete_parse_tree(op);
+
+	/* Method cleanup */
+
+	acpi_ns_delete_namespace_subtree(method);
+	acpi_ns_delete_namespace_by_owner(obj_desc->method.owner_id);
+	acpi_ut_release_owner_id(&obj_desc->method.owner_id);
+	return (AE_OK);
+}
diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.c
new file mode 100644
index 0000000..04ff1eb
--- /dev/null
+++ b/drivers/acpi/acpica/dbnames.c
@@ -0,0 +1,947 @@
+/*******************************************************************************
+ *
+ * Module Name: dbnames - Debugger commands for the acpi namespace
+ *
+ ******************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2015, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include <acpi/acpi.h>
+#include "accommon.h"
+#include "acnamesp.h"
+#include "acdebug.h"
+#include "acpredef.h"
+
+#define _COMPONENT          ACPI_CA_DEBUGGER
+ACPI_MODULE_NAME("dbnames")
+
+/* Local prototypes */
+static acpi_status
+acpi_db_walk_and_match_name(acpi_handle obj_handle,
+			    u32 nesting_level,
+			    void *context, void **return_value);
+
+static acpi_status
+acpi_db_walk_for_predefined_names(acpi_handle obj_handle,
+				  u32 nesting_level,
+				  void *context, void **return_value);
+
+static acpi_status
+acpi_db_walk_for_specific_objects(acpi_handle obj_handle,
+				  u32 nesting_level,
+				  void *context, void **return_value);
+
+static acpi_status
+acpi_db_walk_for_object_counts(acpi_handle obj_handle,
+			       u32 nesting_level,
+			       void *context, void **return_value);
+
+static acpi_status
+acpi_db_integrity_walk(acpi_handle obj_handle,
+		       u32 nesting_level, void *context, void **return_value);
+
+static acpi_status
+acpi_db_walk_for_references(acpi_handle obj_handle,
+			    u32 nesting_level,
+			    void *context, void **return_value);
+
+static acpi_status
+acpi_db_bus_walk(acpi_handle obj_handle,
+		 u32 nesting_level, void *context, void **return_value);
+
+/*
+ * Arguments for the Objects command
+ * These object types map directly to the ACPI_TYPES
+ */
+static struct acpi_db_argument_info acpi_db_object_types[] = {
+	{"ANY"},
+	{"INTEGERS"},
+	{"STRINGS"},
+	{"BUFFERS"},
+	{"PACKAGES"},
+	{"FIELDS"},
+	{"DEVICES"},
+	{"EVENTS"},
+	{"METHODS"},
+	{"MUTEXES"},
+	{"REGIONS"},
+	{"POWERRESOURCES"},
+	{"PROCESSORS"},
+	{"THERMALZONES"},
+	{"BUFFERFIELDS"},
+	{"DDBHANDLES"},
+	{"DEBUG"},
+	{"REGIONFIELDS"},
+	{"BANKFIELDS"},
+	{"INDEXFIELDS"},
+	{"REFERENCES"},
+	{"ALIASES"},
+	{"METHODALIASES"},
+	{"NOTIFY"},
+	{"ADDRESSHANDLER"},
+	{"RESOURCE"},
+	{"RESOURCEFIELD"},
+	{"SCOPES"},
+	{NULL}			/* Must be null terminated */
+};
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_set_scope
+ *
+ * PARAMETERS:  name                - New scope path
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Set the "current scope" as maintained by this utility.
+ *              The scope is used as a prefix to ACPI paths.
+ *
+ ******************************************************************************/
+
+void acpi_db_set_scope(char *name)
+{
+	acpi_status status;
+	struct acpi_namespace_node *node;
+
+	if (!name || name[0] == 0) {
+		acpi_os_printf("Current scope: %s\n", acpi_gbl_db_scope_buf);
+		return;
+	}
+
+	acpi_db_prep_namestring(name);
+
+	if (ACPI_IS_ROOT_PREFIX(name[0])) {
+
+		/* Validate new scope from the root */
+
+		status = acpi_ns_get_node(acpi_gbl_root_node, name,
+					  ACPI_NS_NO_UPSEARCH, &node);
+		if (ACPI_FAILURE(status)) {
+			goto error_exit;
+		}
+
+		acpi_gbl_db_scope_buf[0] = 0;
+	} else {
+		/* Validate new scope relative to old scope */
+
+		status = acpi_ns_get_node(acpi_gbl_db_scope_node, name,
+					  ACPI_NS_NO_UPSEARCH, &node);
+		if (ACPI_FAILURE(status)) {
+			goto error_exit;
+		}
+	}
+
+	/* Build the final pathname */
+
+	if (acpi_ut_safe_strcat
+	    (acpi_gbl_db_scope_buf, sizeof(acpi_gbl_db_scope_buf), name)) {
+		status = AE_BUFFER_OVERFLOW;
+		goto error_exit;
+	}
+
+	if (acpi_ut_safe_strcat
+	    (acpi_gbl_db_scope_buf, sizeof(acpi_gbl_db_scope_buf), "\\")) {
+		status = AE_BUFFER_OVERFLOW;
+		goto error_exit;
+	}
+
+	acpi_gbl_db_scope_node = node;
+	acpi_os_printf("New scope: %s\n", acpi_gbl_db_scope_buf);
+	return;
+
+error_exit:
+
+	acpi_os_printf("Could not attach scope: %s, %s\n",
+		       name, acpi_format_exception(status));
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_dump_namespace
+ *
+ * PARAMETERS:  start_arg       - Node to begin namespace dump
+ *              depth_arg       - Maximum tree depth to be dumped
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Dump entire namespace or a subtree. Each node is displayed
+ *              with type and other information.
+ *
+ ******************************************************************************/
+
+void acpi_db_dump_namespace(char *start_arg, char *depth_arg)
+{
+	acpi_handle subtree_entry = acpi_gbl_root_node;
+	u32 max_depth = ACPI_UINT32_MAX;
+
+	/* No argument given, just start at the root and dump entire namespace */
+
+	if (start_arg) {
+		subtree_entry = acpi_db_convert_to_node(start_arg);
+		if (!subtree_entry) {
+			return;
+		}
+
+		/* Now we can check for the depth argument */
+
+		if (depth_arg) {
+			max_depth = strtoul(depth_arg, NULL, 0);
+		}
+	}
+
+	acpi_db_set_output_destination(ACPI_DB_DUPLICATE_OUTPUT);
+	acpi_os_printf("ACPI Namespace (from %4.4s (%p) subtree):\n",
+		       ((struct acpi_namespace_node *)subtree_entry)->name.
+		       ascii, subtree_entry);
+
+	/* Display the subtree */
+
+	acpi_db_set_output_destination(ACPI_DB_REDIRECTABLE_OUTPUT);
+	acpi_ns_dump_objects(ACPI_TYPE_ANY, ACPI_DISPLAY_SUMMARY, max_depth,
+			     ACPI_OWNER_ID_MAX, subtree_entry);
+	acpi_db_set_output_destination(ACPI_DB_CONSOLE_OUTPUT);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_dump_namespace_paths
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Dump entire namespace with full object pathnames and object
+ *              type information. Alternative to "namespace" command.
+ *
+ ******************************************************************************/
+
+void acpi_db_dump_namespace_paths(void)
+{
+
+	acpi_db_set_output_destination(ACPI_DB_DUPLICATE_OUTPUT);
+	acpi_os_printf("ACPI Namespace (from root):\n");
+
+	/* Display the entire namespace */
+
+	acpi_db_set_output_destination(ACPI_DB_REDIRECTABLE_OUTPUT);
+	acpi_ns_dump_object_paths(ACPI_TYPE_ANY, ACPI_DISPLAY_SUMMARY,
+				  ACPI_UINT32_MAX, ACPI_OWNER_ID_MAX,
+				  acpi_gbl_root_node);
+
+	acpi_db_set_output_destination(ACPI_DB_CONSOLE_OUTPUT);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_dump_namespace_by_owner
+ *
+ * PARAMETERS:  owner_arg       - Owner ID whose nodes will be displayed
+ *              depth_arg       - Maximum tree depth to be dumped
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Dump elements of the namespace that are owned by the owner_id.
+ *
+ ******************************************************************************/
+
+void acpi_db_dump_namespace_by_owner(char *owner_arg, char *depth_arg)
+{
+	acpi_handle subtree_entry = acpi_gbl_root_node;
+	u32 max_depth = ACPI_UINT32_MAX;
+	acpi_owner_id owner_id;
+
+	owner_id = (acpi_owner_id) strtoul(owner_arg, NULL, 0);
+
+	/* Now we can check for the depth argument */
+
+	if (depth_arg) {
+		max_depth = strtoul(depth_arg, NULL, 0);
+	}
+
+	acpi_db_set_output_destination(ACPI_DB_DUPLICATE_OUTPUT);
+	acpi_os_printf("ACPI Namespace by owner %X:\n", owner_id);
+
+	/* Display the subtree */
+
+	acpi_db_set_output_destination(ACPI_DB_REDIRECTABLE_OUTPUT);
+	acpi_ns_dump_objects(ACPI_TYPE_ANY, ACPI_DISPLAY_SUMMARY, max_depth,
+			     owner_id, subtree_entry);
+	acpi_db_set_output_destination(ACPI_DB_CONSOLE_OUTPUT);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_walk_and_match_name
+ *
+ * PARAMETERS:  Callback from walk_namespace
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Find a particular name/names within the namespace. Wildcards
+ *              are supported -- '?' matches any character.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_db_walk_and_match_name(acpi_handle obj_handle,
+			    u32 nesting_level,
+			    void *context, void **return_value)
+{
+	acpi_status status;
+	char *requested_name = (char *)context;
+	u32 i;
+	struct acpi_buffer buffer;
+	struct acpi_walk_info info;
+
+	/* Check for a name match */
+
+	for (i = 0; i < 4; i++) {
+
+		/* Wildcard support */
+
+		if ((requested_name[i] != '?') &&
+		    (requested_name[i] != ((struct acpi_namespace_node *)
+					   obj_handle)->name.ascii[i])) {
+
+			/* No match, just exit */
+
+			return (AE_OK);
+		}
+	}
+
+	/* Get the full pathname to this object */
+
+	buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
+	status = acpi_ns_handle_to_pathname(obj_handle, &buffer, TRUE);
+	if (ACPI_FAILURE(status)) {
+		acpi_os_printf("Could Not get pathname for object %p\n",
+			       obj_handle);
+	} else {
+		info.owner_id = ACPI_OWNER_ID_MAX;
+		info.debug_level = ACPI_UINT32_MAX;
+		info.display_type = ACPI_DISPLAY_SUMMARY | ACPI_DISPLAY_SHORT;
+
+		acpi_os_printf("%32s", (char *)buffer.pointer);
+		(void)acpi_ns_dump_one_object(obj_handle, nesting_level, &info,
+					      NULL);
+		ACPI_FREE(buffer.pointer);
+	}
+
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_find_name_in_namespace
+ *
+ * PARAMETERS:  name_arg        - The 4-character ACPI name to find.
+ *                                wildcards are supported.
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Search the namespace for a given name (with wildcards)
+ *
+ ******************************************************************************/
+
+acpi_status acpi_db_find_name_in_namespace(char *name_arg)
+{
+	char acpi_name[5] = "____";
+	char *acpi_name_ptr = acpi_name;
+
+	if (strlen(name_arg) > ACPI_NAME_SIZE) {
+		acpi_os_printf("Name must be no longer than 4 characters\n");
+		return (AE_OK);
+	}
+
+	/* Pad out name with underscores as necessary to create a 4-char name */
+
+	acpi_ut_strupr(name_arg);
+	while (*name_arg) {
+		*acpi_name_ptr = *name_arg;
+		acpi_name_ptr++;
+		name_arg++;
+	}
+
+	/* Walk the namespace from the root */
+
+	(void)acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
+				  ACPI_UINT32_MAX, acpi_db_walk_and_match_name,
+				  NULL, acpi_name, NULL);
+
+	acpi_db_set_output_destination(ACPI_DB_CONSOLE_OUTPUT);
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_walk_for_predefined_names
+ *
+ * PARAMETERS:  Callback from walk_namespace
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Detect and display predefined ACPI names (names that start with
+ *              an underscore)
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_db_walk_for_predefined_names(acpi_handle obj_handle,
+				  u32 nesting_level,
+				  void *context, void **return_value)
+{
+	struct acpi_namespace_node *node =
+	    (struct acpi_namespace_node *)obj_handle;
+	u32 *count = (u32 *)context;
+	const union acpi_predefined_info *predefined;
+	const union acpi_predefined_info *package = NULL;
+	char *pathname;
+	char string_buffer[48];
+
+	predefined = acpi_ut_match_predefined_method(node->name.ascii);
+	if (!predefined) {
+		return (AE_OK);
+	}
+
+	pathname = acpi_ns_get_external_pathname(node);
+	if (!pathname) {
+		return (AE_OK);
+	}
+
+	/* If method returns a package, the info is in the next table entry */
+
+	if (predefined->info.expected_btypes & ACPI_RTYPE_PACKAGE) {
+		package = predefined + 1;
+	}
+
+	acpi_ut_get_expected_return_types(string_buffer,
+					  predefined->info.expected_btypes);
+
+	acpi_os_printf("%-32s Arguments %X, Return Types: %s", pathname,
+		       METHOD_GET_ARG_COUNT(predefined->info.argument_list),
+		       string_buffer);
+
+	if (package) {
+		acpi_os_printf(" (PkgType %2.2X, ObjType %2.2X, Count %2.2X)",
+			       package->ret_info.type,
+			       package->ret_info.object_type1,
+			       package->ret_info.count1);
+	}
+
+	acpi_os_printf("\n");
+
+	/* Check that the declared argument count matches the ACPI spec */
+
+	acpi_ns_check_acpi_compliance(pathname, node, predefined);
+
+	ACPI_FREE(pathname);
+	(*count)++;
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_check_predefined_names
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Validate all predefined names in the namespace
+ *
+ ******************************************************************************/
+
+void acpi_db_check_predefined_names(void)
+{
+	u32 count = 0;
+
+	/* Search all nodes in namespace */
+
+	(void)acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
+				  ACPI_UINT32_MAX,
+				  acpi_db_walk_for_predefined_names, NULL,
+				  (void *)&count, NULL);
+
+	acpi_os_printf("Found %u predefined names in the namespace\n", count);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_walk_for_object_counts
+ *
+ * PARAMETERS:  Callback from walk_namespace
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Display short info about objects in the namespace
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_db_walk_for_object_counts(acpi_handle obj_handle,
+			       u32 nesting_level,
+			       void *context, void **return_value)
+{
+	struct acpi_object_info *info = (struct acpi_object_info *)context;
+	struct acpi_namespace_node *node =
+	    (struct acpi_namespace_node *)obj_handle;
+
+	if (node->type > ACPI_TYPE_NS_NODE_MAX) {
+		acpi_os_printf("[%4.4s]: Unknown object type %X\n",
+			       node->name.ascii, node->type);
+	} else {
+		info->types[node->type]++;
+	}
+
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_walk_for_specific_objects
+ *
+ * PARAMETERS:  Callback from walk_namespace
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Display short info about objects in the namespace
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_db_walk_for_specific_objects(acpi_handle obj_handle,
+				  u32 nesting_level,
+				  void *context, void **return_value)
+{
+	struct acpi_walk_info *info = (struct acpi_walk_info *)context;
+	struct acpi_buffer buffer;
+	acpi_status status;
+
+	info->count++;
+
+	/* Get and display the full pathname to this object */
+
+	buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
+	status = acpi_ns_handle_to_pathname(obj_handle, &buffer, TRUE);
+	if (ACPI_FAILURE(status)) {
+		acpi_os_printf("Could Not get pathname for object %p\n",
+			       obj_handle);
+		return (AE_OK);
+	}
+
+	acpi_os_printf("%32s", (char *)buffer.pointer);
+	ACPI_FREE(buffer.pointer);
+
+	/* Dump short info about the object */
+
+	(void)acpi_ns_dump_one_object(obj_handle, nesting_level, info, NULL);
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_display_objects
+ *
+ * PARAMETERS:  obj_type_arg        - Type of object to display
+ *              display_count_arg   - Max depth to display
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Display objects in the namespace of the requested type
+ *
+ ******************************************************************************/
+
+acpi_status acpi_db_display_objects(char *obj_type_arg, char *display_count_arg)
+{
+	struct acpi_walk_info info;
+	acpi_object_type type;
+	struct acpi_object_info *object_info;
+	u32 i;
+	u32 total_objects = 0;
+
+	/* No argument means display summary/count of all object types */
+
+	if (!obj_type_arg) {
+		object_info =
+		    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_object_info));
+
+		/* Walk the namespace from the root */
+
+		(void)acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
+					  ACPI_UINT32_MAX,
+					  acpi_db_walk_for_object_counts, NULL,
+					  (void *)object_info, NULL);
+
+		acpi_os_printf("\nSummary of namespace objects:\n\n");
+
+		for (i = 0; i < ACPI_TOTAL_TYPES; i++) {
+			acpi_os_printf("%8u %s\n", object_info->types[i],
+				       acpi_ut_get_type_name(i));
+
+			total_objects += object_info->types[i];
+		}
+
+		acpi_os_printf("\n%8u Total namespace objects\n\n",
+			       total_objects);
+
+		ACPI_FREE(object_info);
+		return (AE_OK);
+	}
+
+	/* Get the object type */
+
+	type = acpi_db_match_argument(obj_type_arg, acpi_db_object_types);
+	if (type == ACPI_TYPE_NOT_FOUND) {
+		acpi_os_printf("Invalid or unsupported argument\n");
+		return (AE_OK);
+	}
+
+	acpi_db_set_output_destination(ACPI_DB_DUPLICATE_OUTPUT);
+	acpi_os_printf
+	    ("Objects of type [%s] defined in the current ACPI Namespace:\n",
+	     acpi_ut_get_type_name(type));
+
+	acpi_db_set_output_destination(ACPI_DB_REDIRECTABLE_OUTPUT);
+
+	info.count = 0;
+	info.owner_id = ACPI_OWNER_ID_MAX;
+	info.debug_level = ACPI_UINT32_MAX;
+	info.display_type = ACPI_DISPLAY_SUMMARY | ACPI_DISPLAY_SHORT;
+
+	/* Walk the namespace from the root */
+
+	(void)acpi_walk_namespace(type, ACPI_ROOT_OBJECT, ACPI_UINT32_MAX,
+				  acpi_db_walk_for_specific_objects, NULL,
+				  (void *)&info, NULL);
+
+	acpi_os_printf
+	    ("\nFound %u objects of type [%s] in the current ACPI Namespace\n",
+	     info.count, acpi_ut_get_type_name(type));
+
+	acpi_db_set_output_destination(ACPI_DB_CONSOLE_OUTPUT);
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_integrity_walk
+ *
+ * PARAMETERS:  Callback from walk_namespace
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Examine one NS node for valid values.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_db_integrity_walk(acpi_handle obj_handle,
+		       u32 nesting_level, void *context, void **return_value)
+{
+	struct acpi_integrity_info *info =
+	    (struct acpi_integrity_info *)context;
+	struct acpi_namespace_node *node =
+	    (struct acpi_namespace_node *)obj_handle;
+	union acpi_operand_object *object;
+	u8 alias = TRUE;
+
+	info->nodes++;
+
+	/* Verify the NS node, and dereference aliases */
+
+	while (alias) {
+		if (ACPI_GET_DESCRIPTOR_TYPE(node) != ACPI_DESC_TYPE_NAMED) {
+			acpi_os_printf
+			    ("Invalid Descriptor Type for Node %p [%s] - "
+			     "is %2.2X should be %2.2X\n", node,
+			     acpi_ut_get_descriptor_name(node),
+			     ACPI_GET_DESCRIPTOR_TYPE(node),
+			     ACPI_DESC_TYPE_NAMED);
+			return (AE_OK);
+		}
+
+		if ((node->type == ACPI_TYPE_LOCAL_ALIAS) ||
+		    (node->type == ACPI_TYPE_LOCAL_METHOD_ALIAS)) {
+			node = (struct acpi_namespace_node *)node->object;
+		} else {
+			alias = FALSE;
+		}
+	}
+
+	if (node->type > ACPI_TYPE_LOCAL_MAX) {
+		acpi_os_printf("Invalid Object Type for Node %p, Type = %X\n",
+			       node, node->type);
+		return (AE_OK);
+	}
+
+	if (!acpi_ut_valid_acpi_name(node->name.ascii)) {
+		acpi_os_printf("Invalid AcpiName for Node %p\n", node);
+		return (AE_OK);
+	}
+
+	object = acpi_ns_get_attached_object(node);
+	if (object) {
+		info->objects++;
+		if (ACPI_GET_DESCRIPTOR_TYPE(object) != ACPI_DESC_TYPE_OPERAND) {
+			acpi_os_printf
+			    ("Invalid Descriptor Type for Object %p [%s]\n",
+			     object, acpi_ut_get_descriptor_name(object));
+		}
+	}
+
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_check_integrity
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Check entire namespace for data structure integrity
+ *
+ ******************************************************************************/
+
+void acpi_db_check_integrity(void)
+{
+	struct acpi_integrity_info info = { 0, 0 };
+
+	/* Search all nodes in namespace */
+
+	(void)acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
+				  ACPI_UINT32_MAX, acpi_db_integrity_walk, NULL,
+				  (void *)&info, NULL);
+
+	acpi_os_printf("Verified %u namespace nodes with %u Objects\n",
+		       info.nodes, info.objects);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_walk_for_references
+ *
+ * PARAMETERS:  Callback from walk_namespace
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Check if this namespace object refers to the target object
+ *              that is passed in as the context value.
+ *
+ * Note: Currently doesn't check subobjects within the Node's object
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_db_walk_for_references(acpi_handle obj_handle,
+			    u32 nesting_level,
+			    void *context, void **return_value)
+{
+	union acpi_operand_object *obj_desc =
+	    (union acpi_operand_object *)context;
+	struct acpi_namespace_node *node =
+	    (struct acpi_namespace_node *)obj_handle;
+
+	/* Check for match against the namespace node itself */
+
+	if (node == (void *)obj_desc) {
+		acpi_os_printf("Object is a Node [%4.4s]\n",
+			       acpi_ut_get_node_name(node));
+	}
+
+	/* Check for match against the object attached to the node */
+
+	if (acpi_ns_get_attached_object(node) == obj_desc) {
+		acpi_os_printf("Reference at Node->Object %p [%4.4s]\n",
+			       node, acpi_ut_get_node_name(node));
+	}
+
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_find_references
+ *
+ * PARAMETERS:  object_arg      - String with hex value of the object
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Search namespace for all references to the input object
+ *
+ ******************************************************************************/
+
+void acpi_db_find_references(char *object_arg)
+{
+	union acpi_operand_object *obj_desc;
+	acpi_size address;
+
+	/* Convert string to object pointer */
+
+	address = strtoul(object_arg, NULL, 16);
+	obj_desc = ACPI_TO_POINTER(address);
+
+	/* Search all nodes in namespace */
+
+	(void)acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
+				  ACPI_UINT32_MAX, acpi_db_walk_for_references,
+				  NULL, (void *)obj_desc, NULL);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_bus_walk
+ *
+ * PARAMETERS:  Callback from walk_namespace
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Display info about device objects that have a corresponding
+ *              _PRT method.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_db_bus_walk(acpi_handle obj_handle,
+		 u32 nesting_level, void *context, void **return_value)
+{
+	struct acpi_namespace_node *node =
+	    (struct acpi_namespace_node *)obj_handle;
+	acpi_status status;
+	struct acpi_buffer buffer;
+	struct acpi_namespace_node *temp_node;
+	struct acpi_device_info *info;
+	u32 i;
+
+	if ((node->type != ACPI_TYPE_DEVICE) &&
+	    (node->type != ACPI_TYPE_PROCESSOR)) {
+		return (AE_OK);
+	}
+
+	/* Exit if there is no _PRT under this device */
+
+	status = acpi_get_handle(node, METHOD_NAME__PRT,
+				 ACPI_CAST_PTR(acpi_handle, &temp_node));
+	if (ACPI_FAILURE(status)) {
+		return (AE_OK);
+	}
+
+	/* Get the full path to this device object */
+
+	buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
+	status = acpi_ns_handle_to_pathname(obj_handle, &buffer, TRUE);
+	if (ACPI_FAILURE(status)) {
+		acpi_os_printf("Could Not get pathname for object %p\n",
+			       obj_handle);
+		return (AE_OK);
+	}
+
+	status = acpi_get_object_info(obj_handle, &info);
+	if (ACPI_FAILURE(status)) {
+		return (AE_OK);
+	}
+
+	/* Display the full path */
+
+	acpi_os_printf("%-32s Type %X", (char *)buffer.pointer, node->type);
+	ACPI_FREE(buffer.pointer);
+
+	if (info->flags & ACPI_PCI_ROOT_BRIDGE) {
+		acpi_os_printf(" - Is PCI Root Bridge");
+	}
+	acpi_os_printf("\n");
+
+	/* _PRT info */
+
+	acpi_os_printf("_PRT: %p\n", temp_node);
+
+	/* Dump _ADR, _HID, _UID, _CID */
+
+	if (info->valid & ACPI_VALID_ADR) {
+		acpi_os_printf("_ADR: %8.8X%8.8X\n",
+			       ACPI_FORMAT_UINT64(info->address));
+	} else {
+		acpi_os_printf("_ADR: <Not Present>\n");
+	}
+
+	if (info->valid & ACPI_VALID_HID) {
+		acpi_os_printf("_HID: %s\n", info->hardware_id.string);
+	} else {
+		acpi_os_printf("_HID: <Not Present>\n");
+	}
+
+	if (info->valid & ACPI_VALID_UID) {
+		acpi_os_printf("_UID: %s\n", info->unique_id.string);
+	} else {
+		acpi_os_printf("_UID: <Not Present>\n");
+	}
+
+	if (info->valid & ACPI_VALID_CID) {
+		for (i = 0; i < info->compatible_id_list.count; i++) {
+			acpi_os_printf("_CID: %s\n",
+				       info->compatible_id_list.ids[i].string);
+		}
+	} else {
+		acpi_os_printf("_CID: <Not Present>\n");
+	}
+
+	ACPI_FREE(info);
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_get_bus_info
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Display info about system busses.
+ *
+ ******************************************************************************/
+
+void acpi_db_get_bus_info(void)
+{
+	/* Search all nodes in namespace */
+
+	(void)acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
+				  ACPI_UINT32_MAX, acpi_db_bus_walk, NULL, NULL,
+				  NULL);
+}
diff --git a/drivers/acpi/acpica/dbobject.c b/drivers/acpi/acpica/dbobject.c
new file mode 100644
index 0000000..116f6db8
--- /dev/null
+++ b/drivers/acpi/acpica/dbobject.c
@@ -0,0 +1,533 @@
+/*******************************************************************************
+ *
+ * Module Name: dbobject - ACPI object decode and display
+ *
+ ******************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2015, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include <acpi/acpi.h>
+#include "accommon.h"
+#include "acnamesp.h"
+#include "acdebug.h"
+
+#define _COMPONENT          ACPI_CA_DEBUGGER
+ACPI_MODULE_NAME("dbobject")
+
+/* Local prototypes */
+static void acpi_db_decode_node(struct acpi_namespace_node *node);
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_dump_method_info
+ *
+ * PARAMETERS:  status          - Method execution status
+ *              walk_state      - Current state of the parse tree walk
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Called when a method has been aborted because of an error.
+ *              Dumps the method execution stack, and the method locals/args,
+ *              and disassembles the AML opcode that failed.
+ *
+ ******************************************************************************/
+
+void
+acpi_db_dump_method_info(acpi_status status, struct acpi_walk_state *walk_state)
+{
+	struct acpi_thread_state *thread;
+
+	/* Ignore control codes, they are not errors */
+
+	if ((status & AE_CODE_MASK) == AE_CODE_CONTROL) {
+		return;
+	}
+
+	/* We may be executing a deferred opcode */
+
+	if (walk_state->deferred_node) {
+		acpi_os_printf("Executing subtree for Buffer/Package/Region\n");
+		return;
+	}
+
+	/*
+	 * If there is no Thread, we are not actually executing a method.
+	 * This can happen when the iASL compiler calls the interpreter
+	 * to perform constant folding.
+	 */
+	thread = walk_state->thread;
+	if (!thread) {
+		return;
+	}
+
+	/* Display the method locals and arguments */
+
+	acpi_os_printf("\n");
+	acpi_db_decode_locals(walk_state);
+	acpi_os_printf("\n");
+	acpi_db_decode_arguments(walk_state);
+	acpi_os_printf("\n");
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_decode_internal_object
+ *
+ * PARAMETERS:  obj_desc        - Object to be displayed
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Short display of an internal object. Numbers/Strings/Buffers.
+ *
+ ******************************************************************************/
+
+void acpi_db_decode_internal_object(union acpi_operand_object *obj_desc)
+{
+	u32 i;
+
+	if (!obj_desc) {
+		acpi_os_printf(" Uninitialized");
+		return;
+	}
+
+	if (ACPI_GET_DESCRIPTOR_TYPE(obj_desc) != ACPI_DESC_TYPE_OPERAND) {
+		acpi_os_printf(" %p [%s]", obj_desc,
+			       acpi_ut_get_descriptor_name(obj_desc));
+		return;
+	}
+
+	acpi_os_printf(" %s", acpi_ut_get_object_type_name(obj_desc));
+
+	switch (obj_desc->common.type) {
+	case ACPI_TYPE_INTEGER:
+
+		acpi_os_printf(" %8.8X%8.8X",
+			       ACPI_FORMAT_UINT64(obj_desc->integer.value));
+		break;
+
+	case ACPI_TYPE_STRING:
+
+		acpi_os_printf("(%u) \"%.24s",
+			       obj_desc->string.length,
+			       obj_desc->string.pointer);
+
+		if (obj_desc->string.length > 24) {
+			acpi_os_printf("...");
+		} else {
+			acpi_os_printf("\"");
+		}
+		break;
+
+	case ACPI_TYPE_BUFFER:
+
+		acpi_os_printf("(%u)", obj_desc->buffer.length);
+		for (i = 0; (i < 8) && (i < obj_desc->buffer.length); i++) {
+			acpi_os_printf(" %2.2X", obj_desc->buffer.pointer[i]);
+		}
+		break;
+
+	default:
+
+		acpi_os_printf(" %p", obj_desc);
+		break;
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_decode_node
+ *
+ * PARAMETERS:  node        - Object to be displayed
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Short display of a namespace node
+ *
+ ******************************************************************************/
+
+static void acpi_db_decode_node(struct acpi_namespace_node *node)
+{
+
+	acpi_os_printf("<Node>          Name %4.4s",
+		       acpi_ut_get_node_name(node));
+
+	if (node->flags & ANOBJ_METHOD_ARG) {
+		acpi_os_printf(" [Method Arg]");
+	}
+	if (node->flags & ANOBJ_METHOD_LOCAL) {
+		acpi_os_printf(" [Method Local]");
+	}
+
+	switch (node->type) {
+
+		/* These types have no attached object */
+
+	case ACPI_TYPE_DEVICE:
+
+		acpi_os_printf(" Device");
+		break;
+
+	case ACPI_TYPE_THERMAL:
+
+		acpi_os_printf(" Thermal Zone");
+		break;
+
+	default:
+
+		acpi_db_decode_internal_object(acpi_ns_get_attached_object
+					       (node));
+		break;
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_display_internal_object
+ *
+ * PARAMETERS:  obj_desc        - Object to be displayed
+ *              walk_state      - Current walk state
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Short display of an internal object
+ *
+ ******************************************************************************/
+
+void
+acpi_db_display_internal_object(union acpi_operand_object *obj_desc,
+				struct acpi_walk_state *walk_state)
+{
+	u8 type;
+
+	acpi_os_printf("%p ", obj_desc);
+
+	if (!obj_desc) {
+		acpi_os_printf("<Null Object>\n");
+		return;
+	}
+
+	/* Decode the object type */
+
+	switch (ACPI_GET_DESCRIPTOR_TYPE(obj_desc)) {
+	case ACPI_DESC_TYPE_PARSER:
+
+		acpi_os_printf("<Parser> ");
+		break;
+
+	case ACPI_DESC_TYPE_NAMED:
+
+		acpi_db_decode_node((struct acpi_namespace_node *)obj_desc);
+		break;
+
+	case ACPI_DESC_TYPE_OPERAND:
+
+		type = obj_desc->common.type;
+		if (type > ACPI_TYPE_LOCAL_MAX) {
+			acpi_os_printf(" Type %X [Invalid Type]", (u32)type);
+			return;
+		}
+
+		/* Decode the ACPI object type */
+
+		switch (obj_desc->common.type) {
+		case ACPI_TYPE_LOCAL_REFERENCE:
+
+			acpi_os_printf("[%s] ",
+				       acpi_ut_get_reference_name(obj_desc));
+
+			/* Decode the refererence */
+
+			switch (obj_desc->reference.class) {
+			case ACPI_REFCLASS_LOCAL:
+
+				acpi_os_printf("%X ",
+					       obj_desc->reference.value);
+				if (walk_state) {
+					obj_desc = walk_state->local_variables
+					    [obj_desc->reference.value].object;
+					acpi_os_printf("%p", obj_desc);
+					acpi_db_decode_internal_object
+					    (obj_desc);
+				}
+				break;
+
+			case ACPI_REFCLASS_ARG:
+
+				acpi_os_printf("%X ",
+					       obj_desc->reference.value);
+				if (walk_state) {
+					obj_desc = walk_state->arguments
+					    [obj_desc->reference.value].object;
+					acpi_os_printf("%p", obj_desc);
+					acpi_db_decode_internal_object
+					    (obj_desc);
+				}
+				break;
+
+			case ACPI_REFCLASS_INDEX:
+
+				switch (obj_desc->reference.target_type) {
+				case ACPI_TYPE_BUFFER_FIELD:
+
+					acpi_os_printf("%p",
+						       obj_desc->reference.
+						       object);
+					acpi_db_decode_internal_object
+					    (obj_desc->reference.object);
+					break;
+
+				case ACPI_TYPE_PACKAGE:
+
+					acpi_os_printf("%p",
+						       obj_desc->reference.
+						       where);
+					if (!obj_desc->reference.where) {
+						acpi_os_printf
+						    (" Uninitialized WHERE pointer");
+					} else {
+						acpi_db_decode_internal_object(*
+									       (obj_desc->
+										reference.
+										where));
+					}
+					break;
+
+				default:
+
+					acpi_os_printf
+					    ("Unknown index target type");
+					break;
+				}
+				break;
+
+			case ACPI_REFCLASS_REFOF:
+
+				if (!obj_desc->reference.object) {
+					acpi_os_printf
+					    ("Uninitialized reference subobject pointer");
+					break;
+				}
+
+				/* Reference can be to a Node or an Operand object */
+
+				switch (ACPI_GET_DESCRIPTOR_TYPE
+					(obj_desc->reference.object)) {
+				case ACPI_DESC_TYPE_NAMED:
+
+					acpi_db_decode_node(obj_desc->reference.
+							    object);
+					break;
+
+				case ACPI_DESC_TYPE_OPERAND:
+
+					acpi_db_decode_internal_object
+					    (obj_desc->reference.object);
+					break;
+
+				default:
+					break;
+				}
+				break;
+
+			case ACPI_REFCLASS_NAME:
+
+				acpi_db_decode_node(obj_desc->reference.node);
+				break;
+
+			case ACPI_REFCLASS_DEBUG:
+			case ACPI_REFCLASS_TABLE:
+
+				acpi_os_printf("\n");
+				break;
+
+			default:	/* Unknown reference class */
+
+				acpi_os_printf("%2.2X\n",
+					       obj_desc->reference.class);
+				break;
+			}
+			break;
+
+		default:
+
+			acpi_os_printf("<Obj>          ");
+			acpi_db_decode_internal_object(obj_desc);
+			break;
+		}
+		break;
+
+	default:
+
+		acpi_os_printf("<Not a valid ACPI Object Descriptor> [%s]",
+			       acpi_ut_get_descriptor_name(obj_desc));
+		break;
+	}
+
+	acpi_os_printf("\n");
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_decode_locals
+ *
+ * PARAMETERS:  walk_state      - State for current method
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Display all locals for the currently running control method
+ *
+ ******************************************************************************/
+
+void acpi_db_decode_locals(struct acpi_walk_state *walk_state)
+{
+	u32 i;
+	union acpi_operand_object *obj_desc;
+	struct acpi_namespace_node *node;
+	u8 display_locals = FALSE;
+
+	obj_desc = walk_state->method_desc;
+	node = walk_state->method_node;
+
+	if (!node) {
+		acpi_os_printf
+		    ("No method node (Executing subtree for buffer or opregion)\n");
+		return;
+	}
+
+	if (node->type != ACPI_TYPE_METHOD) {
+		acpi_os_printf("Executing subtree for Buffer/Package/Region\n");
+		return;
+	}
+
+	/* Are any locals actually set? */
+
+	for (i = 0; i < ACPI_METHOD_NUM_LOCALS; i++) {
+		obj_desc = walk_state->local_variables[i].object;
+		if (obj_desc) {
+			display_locals = TRUE;
+			break;
+		}
+	}
+
+	/* If any are set, only display the ones that are set */
+
+	if (display_locals) {
+		acpi_os_printf
+		    ("\nInitialized Local Variables for method [%4.4s]:\n",
+		     acpi_ut_get_node_name(node));
+
+		for (i = 0; i < ACPI_METHOD_NUM_LOCALS; i++) {
+			obj_desc = walk_state->local_variables[i].object;
+			if (obj_desc) {
+				acpi_os_printf("  Local%X: ", i);
+				acpi_db_display_internal_object(obj_desc,
+								walk_state);
+			}
+		}
+	} else {
+		acpi_os_printf
+		    ("No Local Variables are initialized for method [%4.4s]\n",
+		     acpi_ut_get_node_name(node));
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_decode_arguments
+ *
+ * PARAMETERS:  walk_state      - State for current method
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Display all arguments for the currently running control method
+ *
+ ******************************************************************************/
+
+void acpi_db_decode_arguments(struct acpi_walk_state *walk_state)
+{
+	u32 i;
+	union acpi_operand_object *obj_desc;
+	struct acpi_namespace_node *node;
+	u8 display_args = FALSE;
+
+	node = walk_state->method_node;
+	obj_desc = walk_state->method_desc;
+
+	if (!node) {
+		acpi_os_printf
+		    ("No method node (Executing subtree for buffer or opregion)\n");
+		return;
+	}
+
+	if (node->type != ACPI_TYPE_METHOD) {
+		acpi_os_printf("Executing subtree for Buffer/Package/Region\n");
+		return;
+	}
+
+	/* Are any arguments actually set? */
+
+	for (i = 0; i < ACPI_METHOD_NUM_ARGS; i++) {
+		obj_desc = walk_state->arguments[i].object;
+		if (obj_desc) {
+			display_args = TRUE;
+			break;
+		}
+	}
+
+	/* If any are set, only display the ones that are set */
+
+	if (display_args) {
+		acpi_os_printf("Initialized Arguments for Method [%4.4s]:  "
+			       "(%X arguments defined for method invocation)\n",
+			       acpi_ut_get_node_name(node),
+			       obj_desc->method.param_count);
+
+		for (i = 0; i < ACPI_METHOD_NUM_ARGS; i++) {
+			obj_desc = walk_state->arguments[i].object;
+			if (obj_desc) {
+				acpi_os_printf("  Arg%u:   ", i);
+				acpi_db_display_internal_object(obj_desc,
+								walk_state);
+			}
+		}
+	} else {
+		acpi_os_printf
+		    ("No Arguments are initialized for method [%4.4s]\n",
+		     acpi_ut_get_node_name(node));
+	}
+}
diff --git a/drivers/acpi/acpica/dbstats.c b/drivers/acpi/acpica/dbstats.c
new file mode 100644
index 0000000..4ba0a20
--- /dev/null
+++ b/drivers/acpi/acpica/dbstats.c
@@ -0,0 +1,546 @@
+/*******************************************************************************
+ *
+ * Module Name: dbstats - Generation and display of ACPI table statistics
+ *
+ ******************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2015, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include <acpi/acpi.h>
+#include "accommon.h"
+#include "acdebug.h"
+#include "acnamesp.h"
+
+#define _COMPONENT          ACPI_CA_DEBUGGER
+ACPI_MODULE_NAME("dbstats")
+
+/* Local prototypes */
+static void acpi_db_count_namespace_objects(void);
+
+static void acpi_db_enumerate_object(union acpi_operand_object *obj_desc);
+
+static acpi_status
+acpi_db_classify_one_object(acpi_handle obj_handle,
+			    u32 nesting_level,
+			    void *context, void **return_value);
+
+#if defined ACPI_DBG_TRACK_ALLOCATIONS || defined ACPI_USE_LOCAL_CACHE
+static void acpi_db_list_info(struct acpi_memory_list *list);
+#endif
+
+/*
+ * Statistics subcommands
+ */
+static struct acpi_db_argument_info acpi_db_stat_types[] = {
+	{"ALLOCATIONS"},
+	{"OBJECTS"},
+	{"MEMORY"},
+	{"MISC"},
+	{"TABLES"},
+	{"SIZES"},
+	{"STACK"},
+	{NULL}			/* Must be null terminated */
+};
+
+#define CMD_STAT_ALLOCATIONS     0
+#define CMD_STAT_OBJECTS         1
+#define CMD_STAT_MEMORY          2
+#define CMD_STAT_MISC            3
+#define CMD_STAT_TABLES          4
+#define CMD_STAT_SIZES           5
+#define CMD_STAT_STACK           6
+
+#if defined ACPI_DBG_TRACK_ALLOCATIONS || defined ACPI_USE_LOCAL_CACHE
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_list_info
+ *
+ * PARAMETERS:  list            - Memory list/cache to be displayed
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Display information about the input memory list or cache.
+ *
+ ******************************************************************************/
+
+static void acpi_db_list_info(struct acpi_memory_list *list)
+{
+#ifdef ACPI_DBG_TRACK_ALLOCATIONS
+	u32 outstanding;
+#endif
+
+	acpi_os_printf("\n%s\n", list->list_name);
+
+	/* max_depth > 0 indicates a cache object */
+
+	if (list->max_depth > 0) {
+		acpi_os_printf
+		    ("    Cache: [Depth    MaxD Avail  Size]                "
+		     "%8.2X %8.2X %8.2X %8.2X\n", list->current_depth,
+		     list->max_depth, list->max_depth - list->current_depth,
+		     (list->current_depth * list->object_size));
+	}
+#ifdef ACPI_DBG_TRACK_ALLOCATIONS
+	if (list->max_depth > 0) {
+		acpi_os_printf
+		    ("    Cache: [Requests Hits Misses ObjSize]             "
+		     "%8.2X %8.2X %8.2X %8.2X\n", list->requests, list->hits,
+		     list->requests - list->hits, list->object_size);
+	}
+
+	outstanding = acpi_db_get_cache_info(list);
+
+	if (list->object_size) {
+		acpi_os_printf
+		    ("    Mem:   [Alloc    Free Max    CurSize Outstanding] "
+		     "%8.2X %8.2X %8.2X %8.2X %8.2X\n", list->total_allocated,
+		     list->total_freed, list->max_occupied,
+		     outstanding * list->object_size, outstanding);
+	} else {
+		acpi_os_printf
+		    ("    Mem:   [Alloc Free Max CurSize Outstanding Total] "
+		     "%8.2X %8.2X %8.2X %8.2X %8.2X %8.2X\n",
+		     list->total_allocated, list->total_freed,
+		     list->max_occupied, list->current_total_size, outstanding,
+		     list->total_size);
+	}
+#endif
+}
+#endif
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_enumerate_object
+ *
+ * PARAMETERS:  obj_desc            - Object to be counted
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Add this object to the global counts, by object type.
+ *              Limited recursion handles subobjects and packages, and this
+ *              is probably acceptable within the AML debugger only.
+ *
+ ******************************************************************************/
+
+static void acpi_db_enumerate_object(union acpi_operand_object *obj_desc)
+{
+	u32 i;
+
+	if (!obj_desc) {
+		return;
+	}
+
+	/* Enumerate this object first */
+
+	acpi_gbl_num_objects++;
+
+	if (obj_desc->common.type > ACPI_TYPE_NS_NODE_MAX) {
+		acpi_gbl_obj_type_count_misc++;
+	} else {
+		acpi_gbl_obj_type_count[obj_desc->common.type]++;
+	}
+
+	/* Count the sub-objects */
+
+	switch (obj_desc->common.type) {
+	case ACPI_TYPE_PACKAGE:
+
+		for (i = 0; i < obj_desc->package.count; i++) {
+			acpi_db_enumerate_object(obj_desc->package.elements[i]);
+		}
+		break;
+
+	case ACPI_TYPE_DEVICE:
+
+		acpi_db_enumerate_object(obj_desc->device.notify_list[0]);
+		acpi_db_enumerate_object(obj_desc->device.notify_list[1]);
+		acpi_db_enumerate_object(obj_desc->device.handler);
+		break;
+
+	case ACPI_TYPE_BUFFER_FIELD:
+
+		if (acpi_ns_get_secondary_object(obj_desc)) {
+			acpi_gbl_obj_type_count[ACPI_TYPE_BUFFER_FIELD]++;
+		}
+		break;
+
+	case ACPI_TYPE_REGION:
+
+		acpi_gbl_obj_type_count[ACPI_TYPE_LOCAL_REGION_FIELD]++;
+		acpi_db_enumerate_object(obj_desc->region.handler);
+		break;
+
+	case ACPI_TYPE_POWER:
+
+		acpi_db_enumerate_object(obj_desc->power_resource.
+					 notify_list[0]);
+		acpi_db_enumerate_object(obj_desc->power_resource.
+					 notify_list[1]);
+		break;
+
+	case ACPI_TYPE_PROCESSOR:
+
+		acpi_db_enumerate_object(obj_desc->processor.notify_list[0]);
+		acpi_db_enumerate_object(obj_desc->processor.notify_list[1]);
+		acpi_db_enumerate_object(obj_desc->processor.handler);
+		break;
+
+	case ACPI_TYPE_THERMAL:
+
+		acpi_db_enumerate_object(obj_desc->thermal_zone.notify_list[0]);
+		acpi_db_enumerate_object(obj_desc->thermal_zone.notify_list[1]);
+		acpi_db_enumerate_object(obj_desc->thermal_zone.handler);
+		break;
+
+	default:
+
+		break;
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_classify_one_object
+ *
+ * PARAMETERS:  Callback for walk_namespace
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Enumerate both the object descriptor (including subobjects) and
+ *              the parent namespace node.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_db_classify_one_object(acpi_handle obj_handle,
+			    u32 nesting_level,
+			    void *context, void **return_value)
+{
+	struct acpi_namespace_node *node;
+	union acpi_operand_object *obj_desc;
+	u32 type;
+
+	acpi_gbl_num_nodes++;
+
+	node = (struct acpi_namespace_node *)obj_handle;
+	obj_desc = acpi_ns_get_attached_object(node);
+
+	acpi_db_enumerate_object(obj_desc);
+
+	type = node->type;
+	if (type > ACPI_TYPE_NS_NODE_MAX) {
+		acpi_gbl_node_type_count_misc++;
+	} else {
+		acpi_gbl_node_type_count[type]++;
+	}
+
+	return (AE_OK);
+
+#ifdef ACPI_FUTURE_IMPLEMENTATION
+
+	/* TBD: These need to be counted during the initial parsing phase */
+
+	if (acpi_ps_is_named_op(op->opcode)) {
+		num_nodes++;
+	}
+
+	if (is_method) {
+		num_method_elements++;
+	}
+
+	num_grammar_elements++;
+	op = acpi_ps_get_depth_next(root, op);
+
+	size_of_parse_tree = (num_grammar_elements - num_method_elements) *
+	    (u32)sizeof(union acpi_parse_object);
+	size_of_method_trees =
+	    num_method_elements * (u32)sizeof(union acpi_parse_object);
+	size_of_node_entries =
+	    num_nodes * (u32)sizeof(struct acpi_namespace_node);
+	size_of_acpi_objects =
+	    num_nodes * (u32)sizeof(union acpi_operand_object);
+#endif
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_count_namespace_objects
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Count and classify the entire namespace, including all
+ *              namespace nodes and attached objects.
+ *
+ ******************************************************************************/
+
+static void acpi_db_count_namespace_objects(void)
+{
+	u32 i;
+
+	acpi_gbl_num_nodes = 0;
+	acpi_gbl_num_objects = 0;
+
+	acpi_gbl_obj_type_count_misc = 0;
+	for (i = 0; i < (ACPI_TYPE_NS_NODE_MAX - 1); i++) {
+		acpi_gbl_obj_type_count[i] = 0;
+		acpi_gbl_node_type_count[i] = 0;
+	}
+
+	(void)acpi_ns_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
+				     ACPI_UINT32_MAX, FALSE,
+				     acpi_db_classify_one_object, NULL, NULL,
+				     NULL);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_display_statistics
+ *
+ * PARAMETERS:  type_arg        - Subcommand
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Display various statistics
+ *
+ ******************************************************************************/
+
+acpi_status acpi_db_display_statistics(char *type_arg)
+{
+	u32 i;
+	u32 temp;
+
+	acpi_ut_strupr(type_arg);
+	temp = acpi_db_match_argument(type_arg, acpi_db_stat_types);
+	if (temp == ACPI_TYPE_NOT_FOUND) {
+		acpi_os_printf("Invalid or unsupported argument\n");
+		return (AE_OK);
+	}
+
+	switch (temp) {
+	case CMD_STAT_ALLOCATIONS:
+
+#ifdef ACPI_DBG_TRACK_ALLOCATIONS
+		acpi_ut_dump_allocation_info();
+#endif
+		break;
+
+	case CMD_STAT_TABLES:
+
+		acpi_os_printf("ACPI Table Information (not implemented):\n\n");
+		break;
+
+	case CMD_STAT_OBJECTS:
+
+		acpi_db_count_namespace_objects();
+
+		acpi_os_printf
+		    ("\nObjects defined in the current namespace:\n\n");
+
+		acpi_os_printf("%16.16s %10.10s %10.10s\n",
+			       "ACPI_TYPE", "NODES", "OBJECTS");
+
+		for (i = 0; i < ACPI_TYPE_NS_NODE_MAX; i++) {
+			acpi_os_printf("%16.16s % 10ld% 10ld\n",
+				       acpi_ut_get_type_name(i),
+				       acpi_gbl_node_type_count[i],
+				       acpi_gbl_obj_type_count[i]);
+		}
+		acpi_os_printf("%16.16s % 10ld% 10ld\n", "Misc/Unknown",
+			       acpi_gbl_node_type_count_misc,
+			       acpi_gbl_obj_type_count_misc);
+
+		acpi_os_printf("%16.16s % 10ld% 10ld\n", "TOTALS:",
+			       acpi_gbl_num_nodes, acpi_gbl_num_objects);
+		break;
+
+	case CMD_STAT_MEMORY:
+
+#ifdef ACPI_DBG_TRACK_ALLOCATIONS
+		acpi_os_printf
+		    ("\n----Object Statistics (all in hex)---------\n");
+
+		acpi_db_list_info(acpi_gbl_global_list);
+		acpi_db_list_info(acpi_gbl_ns_node_list);
+#endif
+
+#ifdef ACPI_USE_LOCAL_CACHE
+		acpi_os_printf
+		    ("\n----Cache Statistics (all in hex)---------\n");
+		acpi_db_list_info(acpi_gbl_operand_cache);
+		acpi_db_list_info(acpi_gbl_ps_node_cache);
+		acpi_db_list_info(acpi_gbl_ps_node_ext_cache);
+		acpi_db_list_info(acpi_gbl_state_cache);
+#endif
+
+		break;
+
+	case CMD_STAT_MISC:
+
+		acpi_os_printf("\nMiscellaneous Statistics:\n\n");
+		acpi_os_printf("Calls to AcpiPsFind:.. ........% 7ld\n",
+			       acpi_gbl_ps_find_count);
+		acpi_os_printf("Calls to AcpiNsLookup:..........% 7ld\n",
+			       acpi_gbl_ns_lookup_count);
+
+		acpi_os_printf("\n");
+
+		acpi_os_printf("Mutex usage:\n\n");
+		for (i = 0; i < ACPI_NUM_MUTEX; i++) {
+			acpi_os_printf("%-28s:     % 7ld\n",
+				       acpi_ut_get_mutex_name(i),
+				       acpi_gbl_mutex_info[i].use_count);
+		}
+		break;
+
+	case CMD_STAT_SIZES:
+
+		acpi_os_printf("\nInternal object sizes:\n\n");
+
+		acpi_os_printf("Common         %3d\n",
+			       sizeof(struct acpi_object_common));
+		acpi_os_printf("Number         %3d\n",
+			       sizeof(struct acpi_object_integer));
+		acpi_os_printf("String         %3d\n",
+			       sizeof(struct acpi_object_string));
+		acpi_os_printf("Buffer         %3d\n",
+			       sizeof(struct acpi_object_buffer));
+		acpi_os_printf("Package        %3d\n",
+			       sizeof(struct acpi_object_package));
+		acpi_os_printf("BufferField    %3d\n",
+			       sizeof(struct acpi_object_buffer_field));
+		acpi_os_printf("Device         %3d\n",
+			       sizeof(struct acpi_object_device));
+		acpi_os_printf("Event          %3d\n",
+			       sizeof(struct acpi_object_event));
+		acpi_os_printf("Method         %3d\n",
+			       sizeof(struct acpi_object_method));
+		acpi_os_printf("Mutex          %3d\n",
+			       sizeof(struct acpi_object_mutex));
+		acpi_os_printf("Region         %3d\n",
+			       sizeof(struct acpi_object_region));
+		acpi_os_printf("PowerResource  %3d\n",
+			       sizeof(struct acpi_object_power_resource));
+		acpi_os_printf("Processor      %3d\n",
+			       sizeof(struct acpi_object_processor));
+		acpi_os_printf("ThermalZone    %3d\n",
+			       sizeof(struct acpi_object_thermal_zone));
+		acpi_os_printf("RegionField    %3d\n",
+			       sizeof(struct acpi_object_region_field));
+		acpi_os_printf("BankField      %3d\n",
+			       sizeof(struct acpi_object_bank_field));
+		acpi_os_printf("IndexField     %3d\n",
+			       sizeof(struct acpi_object_index_field));
+		acpi_os_printf("Reference      %3d\n",
+			       sizeof(struct acpi_object_reference));
+		acpi_os_printf("Notify         %3d\n",
+			       sizeof(struct acpi_object_notify_handler));
+		acpi_os_printf("AddressSpace   %3d\n",
+			       sizeof(struct acpi_object_addr_handler));
+		acpi_os_printf("Extra          %3d\n",
+			       sizeof(struct acpi_object_extra));
+		acpi_os_printf("Data           %3d\n",
+			       sizeof(struct acpi_object_data));
+
+		acpi_os_printf("\n");
+
+		acpi_os_printf("ParseObject    %3d\n",
+			       sizeof(struct acpi_parse_obj_common));
+		acpi_os_printf("ParseObjectNamed %3d\n",
+			       sizeof(struct acpi_parse_obj_named));
+		acpi_os_printf("ParseObjectAsl %3d\n",
+			       sizeof(struct acpi_parse_obj_asl));
+		acpi_os_printf("OperandObject  %3d\n",
+			       sizeof(union acpi_operand_object));
+		acpi_os_printf("NamespaceNode  %3d\n",
+			       sizeof(struct acpi_namespace_node));
+		acpi_os_printf("AcpiObject     %3d\n",
+			       sizeof(union acpi_object));
+
+		acpi_os_printf("\n");
+
+		acpi_os_printf("Generic State  %3d\n",
+			       sizeof(union acpi_generic_state));
+		acpi_os_printf("Common State   %3d\n",
+			       sizeof(struct acpi_common_state));
+		acpi_os_printf("Control State  %3d\n",
+			       sizeof(struct acpi_control_state));
+		acpi_os_printf("Update State   %3d\n",
+			       sizeof(struct acpi_update_state));
+		acpi_os_printf("Scope State    %3d\n",
+			       sizeof(struct acpi_scope_state));
+		acpi_os_printf("Parse Scope    %3d\n",
+			       sizeof(struct acpi_pscope_state));
+		acpi_os_printf("Package State  %3d\n",
+			       sizeof(struct acpi_pkg_state));
+		acpi_os_printf("Thread State   %3d\n",
+			       sizeof(struct acpi_thread_state));
+		acpi_os_printf("Result Values  %3d\n",
+			       sizeof(struct acpi_result_values));
+		acpi_os_printf("Notify Info    %3d\n",
+			       sizeof(struct acpi_notify_info));
+		break;
+
+	case CMD_STAT_STACK:
+#if defined(ACPI_DEBUG_OUTPUT)
+
+		temp =
+		    (u32)ACPI_PTR_DIFF(acpi_gbl_entry_stack_pointer,
+				       acpi_gbl_lowest_stack_pointer);
+
+		acpi_os_printf("\nSubsystem Stack Usage:\n\n");
+		acpi_os_printf("Entry Stack Pointer        %p\n",
+			       acpi_gbl_entry_stack_pointer);
+		acpi_os_printf("Lowest Stack Pointer       %p\n",
+			       acpi_gbl_lowest_stack_pointer);
+		acpi_os_printf("Stack Use                  %X (%u)\n", temp,
+			       temp);
+		acpi_os_printf("Deepest Procedure Nesting  %u\n",
+			       acpi_gbl_deepest_nesting);
+#endif
+		break;
+
+	default:
+
+		break;
+	}
+
+	acpi_os_printf("\n");
+	return (AE_OK);
+}
diff --git a/drivers/acpi/acpica/dbtest.c b/drivers/acpi/acpica/dbtest.c
new file mode 100644
index 0000000..10ea8bf
--- /dev/null
+++ b/drivers/acpi/acpica/dbtest.c
@@ -0,0 +1,1057 @@
+/*******************************************************************************
+ *
+ * Module Name: dbtest - Various debug-related tests
+ *
+ ******************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2015, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include <acpi/acpi.h>
+#include "accommon.h"
+#include "acdebug.h"
+#include "acnamesp.h"
+#include "acpredef.h"
+
+#define _COMPONENT          ACPI_CA_DEBUGGER
+ACPI_MODULE_NAME("dbtest")
+
+/* Local prototypes */
+static void acpi_db_test_all_objects(void);
+
+static acpi_status
+acpi_db_test_one_object(acpi_handle obj_handle,
+			u32 nesting_level, void *context, void **return_value);
+
+static acpi_status
+acpi_db_test_integer_type(struct acpi_namespace_node *node, u32 bit_length);
+
+static acpi_status
+acpi_db_test_buffer_type(struct acpi_namespace_node *node, u32 bit_length);
+
+static acpi_status
+acpi_db_test_string_type(struct acpi_namespace_node *node, u32 byte_length);
+
+static acpi_status
+acpi_db_read_from_object(struct acpi_namespace_node *node,
+			 acpi_object_type expected_type,
+			 union acpi_object **value);
+
+static acpi_status
+acpi_db_write_to_object(struct acpi_namespace_node *node,
+			union acpi_object *value);
+
+static void acpi_db_evaluate_all_predefined_names(char *count_arg);
+
+static acpi_status
+acpi_db_evaluate_one_predefined_name(acpi_handle obj_handle,
+				     u32 nesting_level,
+				     void *context, void **return_value);
+
+/*
+ * Test subcommands
+ */
+static struct acpi_db_argument_info acpi_db_test_types[] = {
+	{"OBJECTS"},
+	{"PREDEFINED"},
+	{NULL}			/* Must be null terminated */
+};
+
+#define CMD_TEST_OBJECTS        0
+#define CMD_TEST_PREDEFINED     1
+
+#define BUFFER_FILL_VALUE       0xFF
+
+/*
+ * Support for the special debugger read/write control methods.
+ * These methods are installed into the current namespace and are
+ * used to read and write the various namespace objects. The point
+ * is to force the AML interpreter do all of the work.
+ */
+#define ACPI_DB_READ_METHOD     "\\_T98"
+#define ACPI_DB_WRITE_METHOD    "\\_T99"
+
+static acpi_handle read_handle = NULL;
+static acpi_handle write_handle = NULL;
+
+/* ASL Definitions of the debugger read/write control methods */
+
+#if 0
+definition_block("ssdt.aml", "SSDT", 2, "Intel", "DEBUG", 0x00000001)
+{
+	method(_T98, 1, not_serialized) {	/* Read */
+		return (de_ref_of(arg0))
+	}
+}
+
+definition_block("ssdt2.aml", "SSDT", 2, "Intel", "DEBUG", 0x00000001)
+{
+	method(_T99, 2, not_serialized) {	/* Write */
+		store(arg1, arg0)
+	}
+}
+#endif
+
+static unsigned char read_method_code[] = {
+	0x53, 0x53, 0x44, 0x54, 0x2E, 0x00, 0x00, 0x00,	/* 00000000    "SSDT...." */
+	0x02, 0xC9, 0x49, 0x6E, 0x74, 0x65, 0x6C, 0x00,	/* 00000008    "..Intel." */
+	0x44, 0x45, 0x42, 0x55, 0x47, 0x00, 0x00, 0x00,	/* 00000010    "DEBUG..." */
+	0x01, 0x00, 0x00, 0x00, 0x49, 0x4E, 0x54, 0x4C,	/* 00000018    "....INTL" */
+	0x18, 0x12, 0x13, 0x20, 0x14, 0x09, 0x5F, 0x54,	/* 00000020    "... .._T" */
+	0x39, 0x38, 0x01, 0xA4, 0x83, 0x68	/* 00000028    "98...h"   */
+};
+
+static unsigned char write_method_code[] = {
+	0x53, 0x53, 0x44, 0x54, 0x2E, 0x00, 0x00, 0x00,	/* 00000000    "SSDT...." */
+	0x02, 0x15, 0x49, 0x6E, 0x74, 0x65, 0x6C, 0x00,	/* 00000008    "..Intel." */
+	0x44, 0x45, 0x42, 0x55, 0x47, 0x00, 0x00, 0x00,	/* 00000010    "DEBUG..." */
+	0x01, 0x00, 0x00, 0x00, 0x49, 0x4E, 0x54, 0x4C,	/* 00000018    "....INTL" */
+	0x18, 0x12, 0x13, 0x20, 0x14, 0x09, 0x5F, 0x54,	/* 00000020    "... .._T" */
+	0x39, 0x39, 0x02, 0x70, 0x69, 0x68	/* 00000028    "99.pih"   */
+};
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_execute_test
+ *
+ * PARAMETERS:  type_arg        - Subcommand
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Execute various debug tests.
+ *
+ * Note: Code is prepared for future expansion of the TEST command.
+ *
+ ******************************************************************************/
+
+void acpi_db_execute_test(char *type_arg)
+{
+	u32 temp;
+
+	acpi_ut_strupr(type_arg);
+	temp = acpi_db_match_argument(type_arg, acpi_db_test_types);
+	if (temp == ACPI_TYPE_NOT_FOUND) {
+		acpi_os_printf("Invalid or unsupported argument\n");
+		return;
+	}
+
+	switch (temp) {
+	case CMD_TEST_OBJECTS:
+
+		acpi_db_test_all_objects();
+		break;
+
+	case CMD_TEST_PREDEFINED:
+
+		acpi_db_evaluate_all_predefined_names(NULL);
+		break;
+
+	default:
+		break;
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_test_all_objects
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: This test implements the OBJECTS subcommand. It exercises the
+ *              namespace by reading/writing/comparing all data objects such
+ *              as integers, strings, buffers, fields, buffer fields, etc.
+ *
+ ******************************************************************************/
+
+static void acpi_db_test_all_objects(void)
+{
+	acpi_status status;
+
+	/* Install the debugger read-object control method if necessary */
+
+	if (!read_handle) {
+		status = acpi_install_method(read_method_code);
+		if (ACPI_FAILURE(status)) {
+			acpi_os_printf
+			    ("%s, Could not install debugger read method\n",
+			     acpi_format_exception(status));
+			return;
+		}
+
+		status =
+		    acpi_get_handle(NULL, ACPI_DB_READ_METHOD, &read_handle);
+		if (ACPI_FAILURE(status)) {
+			acpi_os_printf
+			    ("Could not obtain handle for debug method %s\n",
+			     ACPI_DB_READ_METHOD);
+			return;
+		}
+	}
+
+	/* Install the debugger write-object control method if necessary */
+
+	if (!write_handle) {
+		status = acpi_install_method(write_method_code);
+		if (ACPI_FAILURE(status)) {
+			acpi_os_printf
+			    ("%s, Could not install debugger write method\n",
+			     acpi_format_exception(status));
+			return;
+		}
+
+		status =
+		    acpi_get_handle(NULL, ACPI_DB_WRITE_METHOD, &write_handle);
+		if (ACPI_FAILURE(status)) {
+			acpi_os_printf
+			    ("Could not obtain handle for debug method %s\n",
+			     ACPI_DB_WRITE_METHOD);
+			return;
+		}
+	}
+
+	/* Walk the entire namespace, testing each supported named data object */
+
+	(void)acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
+				  ACPI_UINT32_MAX, acpi_db_test_one_object,
+				  NULL, NULL, NULL);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_test_one_object
+ *
+ * PARAMETERS:  acpi_walk_callback
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Test one namespace object. Supported types are Integer,
+ *              String, Buffer, buffer_field, and field_unit. All other object
+ *              types are simply ignored.
+ *
+ *              Note: Support for Packages is not implemented.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_db_test_one_object(acpi_handle obj_handle,
+			u32 nesting_level, void *context, void **return_value)
+{
+	struct acpi_namespace_node *node;
+	union acpi_operand_object *obj_desc;
+	union acpi_operand_object *region_obj;
+	acpi_object_type local_type;
+	u32 bit_length = 0;
+	u32 byte_length = 0;
+	acpi_status status = AE_OK;
+
+	node = ACPI_CAST_PTR(struct acpi_namespace_node, obj_handle);
+	obj_desc = node->object;
+
+	/*
+	 * For the supported types, get the actual bit length or
+	 * byte length. Map the type to one of Integer/String/Buffer.
+	 */
+	switch (node->type) {
+	case ACPI_TYPE_INTEGER:
+
+		/* Integer width is either 32 or 64 */
+
+		local_type = ACPI_TYPE_INTEGER;
+		bit_length = acpi_gbl_integer_bit_width;
+		break;
+
+	case ACPI_TYPE_STRING:
+
+		local_type = ACPI_TYPE_STRING;
+		byte_length = obj_desc->string.length;
+		break;
+
+	case ACPI_TYPE_BUFFER:
+
+		local_type = ACPI_TYPE_BUFFER;
+		byte_length = obj_desc->buffer.length;
+		bit_length = byte_length * 8;
+		break;
+
+	case ACPI_TYPE_FIELD_UNIT:
+	case ACPI_TYPE_BUFFER_FIELD:
+	case ACPI_TYPE_LOCAL_REGION_FIELD:
+	case ACPI_TYPE_LOCAL_INDEX_FIELD:
+	case ACPI_TYPE_LOCAL_BANK_FIELD:
+
+		local_type = ACPI_TYPE_INTEGER;
+		if (obj_desc) {
+			/*
+			 * Returned object will be a Buffer if the field length
+			 * is larger than the size of an Integer (32 or 64 bits
+			 * depending on the DSDT version).
+			 */
+			bit_length = obj_desc->common_field.bit_length;
+			byte_length = ACPI_ROUND_BITS_UP_TO_BYTES(bit_length);
+			if (bit_length > acpi_gbl_integer_bit_width) {
+				local_type = ACPI_TYPE_BUFFER;
+			}
+		}
+		break;
+
+	default:
+
+		/* Ignore all other types */
+
+		return (AE_OK);
+	}
+
+	/* Emit the common prefix: Type:Name */
+
+	acpi_os_printf("%14s: %4.4s",
+		       acpi_ut_get_type_name(node->type), node->name.ascii);
+	if (!obj_desc) {
+		acpi_os_printf(" Ignoring, no attached object\n");
+		return (AE_OK);
+	}
+
+	/*
+	 * Check for unsupported region types. Note: acpi_exec simulates
+	 * access to system_memory, system_IO, PCI_Config, and EC.
+	 */
+	switch (node->type) {
+	case ACPI_TYPE_LOCAL_REGION_FIELD:
+
+		region_obj = obj_desc->field.region_obj;
+		switch (region_obj->region.space_id) {
+		case ACPI_ADR_SPACE_SYSTEM_MEMORY:
+		case ACPI_ADR_SPACE_SYSTEM_IO:
+		case ACPI_ADR_SPACE_PCI_CONFIG:
+		case ACPI_ADR_SPACE_EC:
+
+			break;
+
+		default:
+
+			acpi_os_printf
+			    ("    %s space is not supported [%4.4s]\n",
+			     acpi_ut_get_region_name(region_obj->region.
+						     space_id),
+			     region_obj->region.node->name.ascii);
+			return (AE_OK);
+		}
+		break;
+
+	default:
+		break;
+	}
+
+	/* At this point, we have resolved the object to one of the major types */
+
+	switch (local_type) {
+	case ACPI_TYPE_INTEGER:
+
+		status = acpi_db_test_integer_type(node, bit_length);
+		break;
+
+	case ACPI_TYPE_STRING:
+
+		status = acpi_db_test_string_type(node, byte_length);
+		break;
+
+	case ACPI_TYPE_BUFFER:
+
+		status = acpi_db_test_buffer_type(node, bit_length);
+		break;
+
+	default:
+
+		acpi_os_printf(" Ignoring, type not implemented (%2.2X)",
+			       local_type);
+		break;
+	}
+
+	switch (node->type) {
+	case ACPI_TYPE_LOCAL_REGION_FIELD:
+
+		region_obj = obj_desc->field.region_obj;
+		acpi_os_printf(" (%s)",
+			       acpi_ut_get_region_name(region_obj->region.
+						       space_id));
+		break;
+
+	default:
+		break;
+	}
+
+	acpi_os_printf("\n");
+	return (status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_test_integer_type
+ *
+ * PARAMETERS:  node                - Parent NS node for the object
+ *              bit_length          - Actual length of the object. Used for
+ *                                    support of arbitrary length field_unit
+ *                                    and buffer_field objects.
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Test read/write for an Integer-valued object. Performs a
+ *              write/read/compare of an arbitrary new value, then performs
+ *              a write/read/compare of the original value.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_db_test_integer_type(struct acpi_namespace_node *node, u32 bit_length)
+{
+	union acpi_object *temp1 = NULL;
+	union acpi_object *temp2 = NULL;
+	union acpi_object *temp3 = NULL;
+	union acpi_object write_value;
+	u64 value_to_write;
+	acpi_status status;
+
+	if (bit_length > 64) {
+		acpi_os_printf(" Invalid length for an Integer: %u",
+			       bit_length);
+		return (AE_OK);
+	}
+
+	/* Read the original value */
+
+	status = acpi_db_read_from_object(node, ACPI_TYPE_INTEGER, &temp1);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	acpi_os_printf(" (%4.4X/%3.3X) %8.8X%8.8X",
+		       bit_length, ACPI_ROUND_BITS_UP_TO_BYTES(bit_length),
+		       ACPI_FORMAT_UINT64(temp1->integer.value));
+
+	value_to_write = ACPI_UINT64_MAX >> (64 - bit_length);
+	if (temp1->integer.value == value_to_write) {
+		value_to_write = 0;
+	}
+
+	/* Write a new value */
+
+	write_value.type = ACPI_TYPE_INTEGER;
+	write_value.integer.value = value_to_write;
+	status = acpi_db_write_to_object(node, &write_value);
+	if (ACPI_FAILURE(status)) {
+		goto exit;
+	}
+
+	/* Ensure that we can read back the new value */
+
+	status = acpi_db_read_from_object(node, ACPI_TYPE_INTEGER, &temp2);
+	if (ACPI_FAILURE(status)) {
+		goto exit;
+	}
+
+	if (temp2->integer.value != value_to_write) {
+		acpi_os_printf(" MISMATCH 2: %8.8X%8.8X, expecting %8.8X%8.8X",
+			       ACPI_FORMAT_UINT64(temp2->integer.value),
+			       ACPI_FORMAT_UINT64(value_to_write));
+	}
+
+	/* Write back the original value */
+
+	write_value.integer.value = temp1->integer.value;
+	status = acpi_db_write_to_object(node, &write_value);
+	if (ACPI_FAILURE(status)) {
+		goto exit;
+	}
+
+	/* Ensure that we can read back the original value */
+
+	status = acpi_db_read_from_object(node, ACPI_TYPE_INTEGER, &temp3);
+	if (ACPI_FAILURE(status)) {
+		goto exit;
+	}
+
+	if (temp3->integer.value != temp1->integer.value) {
+		acpi_os_printf(" MISMATCH 3: %8.8X%8.8X, expecting %8.8X%8.8X",
+			       ACPI_FORMAT_UINT64(temp3->integer.value),
+			       ACPI_FORMAT_UINT64(temp1->integer.value));
+	}
+
+exit:
+	if (temp1) {
+		acpi_os_free(temp1);
+	}
+	if (temp2) {
+		acpi_os_free(temp2);
+	}
+	if (temp3) {
+		acpi_os_free(temp3);
+	}
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_test_buffer_type
+ *
+ * PARAMETERS:  node                - Parent NS node for the object
+ *              bit_length          - Actual length of the object.
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Test read/write for an Buffer-valued object. Performs a
+ *              write/read/compare of an arbitrary new value, then performs
+ *              a write/read/compare of the original value.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_db_test_buffer_type(struct acpi_namespace_node *node, u32 bit_length)
+{
+	union acpi_object *temp1 = NULL;
+	union acpi_object *temp2 = NULL;
+	union acpi_object *temp3 = NULL;
+	u8 *buffer;
+	union acpi_object write_value;
+	acpi_status status;
+	u32 byte_length;
+	u32 i;
+	u8 extra_bits;
+
+	byte_length = ACPI_ROUND_BITS_UP_TO_BYTES(bit_length);
+	if (byte_length == 0) {
+		acpi_os_printf(" Ignoring zero length buffer");
+		return (AE_OK);
+	}
+
+	/* Allocate a local buffer */
+
+	buffer = ACPI_ALLOCATE_ZEROED(byte_length);
+	if (!buffer) {
+		return (AE_NO_MEMORY);
+	}
+
+	/* Read the original value */
+
+	status = acpi_db_read_from_object(node, ACPI_TYPE_BUFFER, &temp1);
+	if (ACPI_FAILURE(status)) {
+		goto exit;
+	}
+
+	/* Emit a few bytes of the buffer */
+
+	acpi_os_printf(" (%4.4X/%3.3X)", bit_length, temp1->buffer.length);
+	for (i = 0; ((i < 4) && (i < byte_length)); i++) {
+		acpi_os_printf(" %2.2X", temp1->buffer.pointer[i]);
+	}
+	acpi_os_printf("... ");
+
+	/*
+	 * Write a new value.
+	 *
+	 * Handle possible extra bits at the end of the buffer. Can
+	 * happen for field_units larger than an integer, but the bit
+	 * count is not an integral number of bytes. Zero out the
+	 * unused bits.
+	 */
+	memset(buffer, BUFFER_FILL_VALUE, byte_length);
+	extra_bits = bit_length % 8;
+	if (extra_bits) {
+		buffer[byte_length - 1] = ACPI_MASK_BITS_ABOVE(extra_bits);
+	}
+
+	write_value.type = ACPI_TYPE_BUFFER;
+	write_value.buffer.length = byte_length;
+	write_value.buffer.pointer = buffer;
+
+	status = acpi_db_write_to_object(node, &write_value);
+	if (ACPI_FAILURE(status)) {
+		goto exit;
+	}
+
+	/* Ensure that we can read back the new value */
+
+	status = acpi_db_read_from_object(node, ACPI_TYPE_BUFFER, &temp2);
+	if (ACPI_FAILURE(status)) {
+		goto exit;
+	}
+
+	if (memcmp(temp2->buffer.pointer, buffer, byte_length)) {
+		acpi_os_printf(" MISMATCH 2: New buffer value");
+	}
+
+	/* Write back the original value */
+
+	write_value.buffer.length = byte_length;
+	write_value.buffer.pointer = temp1->buffer.pointer;
+
+	status = acpi_db_write_to_object(node, &write_value);
+	if (ACPI_FAILURE(status)) {
+		goto exit;
+	}
+
+	/* Ensure that we can read back the original value */
+
+	status = acpi_db_read_from_object(node, ACPI_TYPE_BUFFER, &temp3);
+	if (ACPI_FAILURE(status)) {
+		goto exit;
+	}
+
+	if (memcmp(temp1->buffer.pointer, temp3->buffer.pointer, byte_length)) {
+		acpi_os_printf(" MISMATCH 3: While restoring original buffer");
+	}
+
+exit:
+	ACPI_FREE(buffer);
+	if (temp1) {
+		acpi_os_free(temp1);
+	}
+	if (temp2) {
+		acpi_os_free(temp2);
+	}
+	if (temp3) {
+		acpi_os_free(temp3);
+	}
+	return (status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_test_string_type
+ *
+ * PARAMETERS:  node                - Parent NS node for the object
+ *              byte_length         - Actual length of the object.
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Test read/write for an String-valued object. Performs a
+ *              write/read/compare of an arbitrary new value, then performs
+ *              a write/read/compare of the original value.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_db_test_string_type(struct acpi_namespace_node *node, u32 byte_length)
+{
+	union acpi_object *temp1 = NULL;
+	union acpi_object *temp2 = NULL;
+	union acpi_object *temp3 = NULL;
+	char *value_to_write = "Test String from AML Debugger";
+	union acpi_object write_value;
+	acpi_status status;
+
+	/* Read the original value */
+
+	status = acpi_db_read_from_object(node, ACPI_TYPE_STRING, &temp1);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	acpi_os_printf(" (%4.4X/%3.3X) \"%s\"", (temp1->string.length * 8),
+		       temp1->string.length, temp1->string.pointer);
+
+	/* Write a new value */
+
+	write_value.type = ACPI_TYPE_STRING;
+	write_value.string.length = strlen(value_to_write);
+	write_value.string.pointer = value_to_write;
+
+	status = acpi_db_write_to_object(node, &write_value);
+	if (ACPI_FAILURE(status)) {
+		goto exit;
+	}
+
+	/* Ensure that we can read back the new value */
+
+	status = acpi_db_read_from_object(node, ACPI_TYPE_STRING, &temp2);
+	if (ACPI_FAILURE(status)) {
+		goto exit;
+	}
+
+	if (strcmp(temp2->string.pointer, value_to_write)) {
+		acpi_os_printf(" MISMATCH 2: %s, expecting %s",
+			       temp2->string.pointer, value_to_write);
+	}
+
+	/* Write back the original value */
+
+	write_value.string.length = strlen(temp1->string.pointer);
+	write_value.string.pointer = temp1->string.pointer;
+
+	status = acpi_db_write_to_object(node, &write_value);
+	if (ACPI_FAILURE(status)) {
+		goto exit;
+	}
+
+	/* Ensure that we can read back the original value */
+
+	status = acpi_db_read_from_object(node, ACPI_TYPE_STRING, &temp3);
+	if (ACPI_FAILURE(status)) {
+		goto exit;
+	}
+
+	if (strcmp(temp1->string.pointer, temp3->string.pointer)) {
+		acpi_os_printf(" MISMATCH 3: %s, expecting %s",
+			       temp3->string.pointer, temp1->string.pointer);
+	}
+
+exit:
+	if (temp1) {
+		acpi_os_free(temp1);
+	}
+	if (temp2) {
+		acpi_os_free(temp2);
+	}
+	if (temp3) {
+		acpi_os_free(temp3);
+	}
+	return (status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_read_from_object
+ *
+ * PARAMETERS:  node                - Parent NS node for the object
+ *              expected_type       - Object type expected from the read
+ *              value               - Where the value read is returned
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Performs a read from the specified object by invoking the
+ *              special debugger control method that reads the object. Thus,
+ *              the AML interpreter is doing all of the work, increasing the
+ *              validity of the test.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_db_read_from_object(struct acpi_namespace_node *node,
+			 acpi_object_type expected_type,
+			 union acpi_object **value)
+{
+	union acpi_object *ret_value;
+	struct acpi_object_list param_objects;
+	union acpi_object params[2];
+	struct acpi_buffer return_obj;
+	acpi_status status;
+
+	params[0].type = ACPI_TYPE_LOCAL_REFERENCE;
+	params[0].reference.actual_type = node->type;
+	params[0].reference.handle = ACPI_CAST_PTR(acpi_handle, node);
+
+	param_objects.count = 1;
+	param_objects.pointer = params;
+
+	return_obj.length = ACPI_ALLOCATE_BUFFER;
+
+	acpi_gbl_method_executing = TRUE;
+	status = acpi_evaluate_object(read_handle, NULL,
+				      &param_objects, &return_obj);
+	acpi_gbl_method_executing = FALSE;
+
+	if (ACPI_FAILURE(status)) {
+		acpi_os_printf("Could not read from object, %s",
+			       acpi_format_exception(status));
+		return (status);
+	}
+
+	ret_value = (union acpi_object *)return_obj.pointer;
+
+	switch (ret_value->type) {
+	case ACPI_TYPE_INTEGER:
+	case ACPI_TYPE_BUFFER:
+	case ACPI_TYPE_STRING:
+		/*
+		 * Did we receive the type we wanted? Most important for the
+		 * Integer/Buffer case (when a field is larger than an Integer,
+		 * it should return a Buffer).
+		 */
+		if (ret_value->type != expected_type) {
+			acpi_os_printf
+			    (" Type mismatch: Expected %s, Received %s",
+			     acpi_ut_get_type_name(expected_type),
+			     acpi_ut_get_type_name(ret_value->type));
+
+			return (AE_TYPE);
+		}
+
+		*value = ret_value;
+		break;
+
+	default:
+
+		acpi_os_printf(" Unsupported return object type, %s",
+			       acpi_ut_get_type_name(ret_value->type));
+
+		acpi_os_free(return_obj.pointer);
+		return (AE_TYPE);
+	}
+
+	return (status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_write_to_object
+ *
+ * PARAMETERS:  node                - Parent NS node for the object
+ *              value               - Value to be written
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Performs a write to the specified object by invoking the
+ *              special debugger control method that writes the object. Thus,
+ *              the AML interpreter is doing all of the work, increasing the
+ *              validity of the test.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_db_write_to_object(struct acpi_namespace_node *node,
+			union acpi_object *value)
+{
+	struct acpi_object_list param_objects;
+	union acpi_object params[2];
+	acpi_status status;
+
+	params[0].type = ACPI_TYPE_LOCAL_REFERENCE;
+	params[0].reference.actual_type = node->type;
+	params[0].reference.handle = ACPI_CAST_PTR(acpi_handle, node);
+
+	/* Copy the incoming user parameter */
+
+	memcpy(&params[1], value, sizeof(union acpi_object));
+
+	param_objects.count = 2;
+	param_objects.pointer = params;
+
+	acpi_gbl_method_executing = TRUE;
+	status = acpi_evaluate_object(write_handle, NULL, &param_objects, NULL);
+	acpi_gbl_method_executing = FALSE;
+
+	if (ACPI_FAILURE(status)) {
+		acpi_os_printf("Could not write to object, %s",
+			       acpi_format_exception(status));
+	}
+
+	return (status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_evaluate_all_predefined_names
+ *
+ * PARAMETERS:  count_arg           - Max number of methods to execute
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Namespace batch execution. Execute predefined names in the
+ *              namespace, up to the max count, if specified.
+ *
+ ******************************************************************************/
+
+static void acpi_db_evaluate_all_predefined_names(char *count_arg)
+{
+	struct acpi_db_execute_walk info;
+
+	info.count = 0;
+	info.max_count = ACPI_UINT32_MAX;
+
+	if (count_arg) {
+		info.max_count = strtoul(count_arg, NULL, 0);
+	}
+
+	/* Search all nodes in namespace */
+
+	(void)acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
+				  ACPI_UINT32_MAX,
+				  acpi_db_evaluate_one_predefined_name, NULL,
+				  (void *)&info, NULL);
+
+	acpi_os_printf("Evaluated %u predefined names in the namespace\n",
+		       info.count);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_evaluate_one_predefined_name
+ *
+ * PARAMETERS:  Callback from walk_namespace
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Batch execution module. Currently only executes predefined
+ *              ACPI names.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_db_evaluate_one_predefined_name(acpi_handle obj_handle,
+				     u32 nesting_level,
+				     void *context, void **return_value)
+{
+	struct acpi_namespace_node *node =
+	    (struct acpi_namespace_node *)obj_handle;
+	struct acpi_db_execute_walk *info =
+	    (struct acpi_db_execute_walk *)context;
+	char *pathname;
+	const union acpi_predefined_info *predefined;
+	struct acpi_device_info *obj_info;
+	struct acpi_object_list param_objects;
+	union acpi_object params[ACPI_METHOD_NUM_ARGS];
+	union acpi_object *this_param;
+	struct acpi_buffer return_obj;
+	acpi_status status;
+	u16 arg_type_list;
+	u8 arg_count;
+	u8 arg_type;
+	u32 i;
+
+	/* The name must be a predefined ACPI name */
+
+	predefined = acpi_ut_match_predefined_method(node->name.ascii);
+	if (!predefined) {
+		return (AE_OK);
+	}
+
+	if (node->type == ACPI_TYPE_LOCAL_SCOPE) {
+		return (AE_OK);
+	}
+
+	pathname = acpi_ns_get_external_pathname(node);
+	if (!pathname) {
+		return (AE_OK);
+	}
+
+	/* Get the object info for number of method parameters */
+
+	status = acpi_get_object_info(obj_handle, &obj_info);
+	if (ACPI_FAILURE(status)) {
+		ACPI_FREE(pathname);
+		return (status);
+	}
+
+	param_objects.count = 0;
+	param_objects.pointer = NULL;
+
+	if (obj_info->type == ACPI_TYPE_METHOD) {
+
+		/* Setup default parameters (with proper types) */
+
+		arg_type_list = predefined->info.argument_list;
+		arg_count = METHOD_GET_ARG_COUNT(arg_type_list);
+
+		/*
+		 * Setup the ACPI-required number of arguments, regardless of what
+		 * the actual method defines. If there is a difference, then the
+		 * method is wrong and a warning will be issued during execution.
+		 */
+		this_param = params;
+		for (i = 0; i < arg_count; i++) {
+			arg_type = METHOD_GET_NEXT_TYPE(arg_type_list);
+			this_param->type = arg_type;
+
+			switch (arg_type) {
+			case ACPI_TYPE_INTEGER:
+
+				this_param->integer.value = 1;
+				break;
+
+			case ACPI_TYPE_STRING:
+
+				this_param->string.pointer =
+				    "This is the default argument string";
+				this_param->string.length =
+				    strlen(this_param->string.pointer);
+				break;
+
+			case ACPI_TYPE_BUFFER:
+
+				this_param->buffer.pointer = (u8 *)params;	/* just a garbage buffer */
+				this_param->buffer.length = 48;
+				break;
+
+			case ACPI_TYPE_PACKAGE:
+
+				this_param->package.elements = NULL;
+				this_param->package.count = 0;
+				break;
+
+			default:
+
+				acpi_os_printf
+				    ("%s: Unsupported argument type: %u\n",
+				     pathname, arg_type);
+				break;
+			}
+
+			this_param++;
+		}
+
+		param_objects.count = arg_count;
+		param_objects.pointer = params;
+	}
+
+	ACPI_FREE(obj_info);
+	return_obj.pointer = NULL;
+	return_obj.length = ACPI_ALLOCATE_BUFFER;
+
+	/* Do the actual method execution */
+
+	acpi_gbl_method_executing = TRUE;
+
+	status = acpi_evaluate_object(node, NULL, &param_objects, &return_obj);
+
+	acpi_os_printf("%-32s returned %s\n",
+		       pathname, acpi_format_exception(status));
+	acpi_gbl_method_executing = FALSE;
+	ACPI_FREE(pathname);
+
+	/* Ignore status from method execution */
+
+	status = AE_OK;
+
+	/* Update count, check if we have executed enough methods */
+
+	info->count++;
+	if (info->count >= info->max_count) {
+		status = AE_CTRL_TERMINATE;
+	}
+
+	return (status);
+}
diff --git a/drivers/acpi/acpica/dbutils.c b/drivers/acpi/acpica/dbutils.c
new file mode 100644
index 0000000..86790e0
--- /dev/null
+++ b/drivers/acpi/acpica/dbutils.c
@@ -0,0 +1,457 @@
+/*******************************************************************************
+ *
+ * Module Name: dbutils - AML debugger utilities
+ *
+ ******************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2015, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include <acpi/acpi.h>
+#include "accommon.h"
+#include "acnamesp.h"
+#include "acdebug.h"
+
+#define _COMPONENT          ACPI_CA_DEBUGGER
+ACPI_MODULE_NAME("dbutils")
+
+/* Local prototypes */
+#ifdef ACPI_OBSOLETE_FUNCTIONS
+acpi_status acpi_db_second_pass_parse(union acpi_parse_object *root);
+
+void acpi_db_dump_buffer(u32 address);
+#endif
+
+static char *gbl_hex_to_ascii = "0123456789ABCDEF";
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_match_argument
+ *
+ * PARAMETERS:  user_argument           - User command line
+ *              arguments               - Array of commands to match against
+ *
+ * RETURN:      Index into command array or ACPI_TYPE_NOT_FOUND if not found
+ *
+ * DESCRIPTION: Search command array for a command match
+ *
+ ******************************************************************************/
+
+acpi_object_type
+acpi_db_match_argument(char *user_argument,
+		       struct acpi_db_argument_info *arguments)
+{
+	u32 i;
+
+	if (!user_argument || user_argument[0] == 0) {
+		return (ACPI_TYPE_NOT_FOUND);
+	}
+
+	for (i = 0; arguments[i].name; i++) {
+		if (strstr(arguments[i].name, user_argument) ==
+		    arguments[i].name) {
+			return (i);
+		}
+	}
+
+	/* Argument not recognized */
+
+	return (ACPI_TYPE_NOT_FOUND);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_set_output_destination
+ *
+ * PARAMETERS:  output_flags        - Current flags word
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Set the current destination for debugger output. Also sets
+ *              the debug output level accordingly.
+ *
+ ******************************************************************************/
+
+void acpi_db_set_output_destination(u32 output_flags)
+{
+
+	acpi_gbl_db_output_flags = (u8)output_flags;
+
+	if ((output_flags & ACPI_DB_REDIRECTABLE_OUTPUT) &&
+	    acpi_gbl_db_output_to_file) {
+		acpi_dbg_level = acpi_gbl_db_debug_level;
+	} else {
+		acpi_dbg_level = acpi_gbl_db_console_debug_level;
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_dump_external_object
+ *
+ * PARAMETERS:  obj_desc        - External ACPI object to dump
+ *              level           - Nesting level.
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Dump the contents of an ACPI external object
+ *
+ ******************************************************************************/
+
+void acpi_db_dump_external_object(union acpi_object *obj_desc, u32 level)
+{
+	u32 i;
+
+	if (!obj_desc) {
+		acpi_os_printf("[Null Object]\n");
+		return;
+	}
+
+	for (i = 0; i < level; i++) {
+		acpi_os_printf(" ");
+	}
+
+	switch (obj_desc->type) {
+	case ACPI_TYPE_ANY:
+
+		acpi_os_printf("[Null Object] (Type=0)\n");
+		break;
+
+	case ACPI_TYPE_INTEGER:
+
+		acpi_os_printf("[Integer] = %8.8X%8.8X\n",
+			       ACPI_FORMAT_UINT64(obj_desc->integer.value));
+		break;
+
+	case ACPI_TYPE_STRING:
+
+		acpi_os_printf("[String] Length %.2X = ",
+			       obj_desc->string.length);
+		acpi_ut_print_string(obj_desc->string.pointer, ACPI_UINT8_MAX);
+		acpi_os_printf("\n");
+		break;
+
+	case ACPI_TYPE_BUFFER:
+
+		acpi_os_printf("[Buffer] Length %.2X = ",
+			       obj_desc->buffer.length);
+		if (obj_desc->buffer.length) {
+			if (obj_desc->buffer.length > 16) {
+				acpi_os_printf("\n");
+			}
+			acpi_ut_debug_dump_buffer(ACPI_CAST_PTR
+						  (u8,
+						   obj_desc->buffer.pointer),
+						  obj_desc->buffer.length,
+						  DB_BYTE_DISPLAY, _COMPONENT);
+		} else {
+			acpi_os_printf("\n");
+		}
+		break;
+
+	case ACPI_TYPE_PACKAGE:
+
+		acpi_os_printf("[Package] Contains %u Elements:\n",
+			       obj_desc->package.count);
+
+		for (i = 0; i < obj_desc->package.count; i++) {
+			acpi_db_dump_external_object(&obj_desc->package.
+						     elements[i], level + 1);
+		}
+		break;
+
+	case ACPI_TYPE_LOCAL_REFERENCE:
+
+		acpi_os_printf("[Object Reference] = ");
+		acpi_db_display_internal_object(obj_desc->reference.handle,
+						NULL);
+		break;
+
+	case ACPI_TYPE_PROCESSOR:
+
+		acpi_os_printf("[Processor]\n");
+		break;
+
+	case ACPI_TYPE_POWER:
+
+		acpi_os_printf("[Power Resource]\n");
+		break;
+
+	default:
+
+		acpi_os_printf("[Unknown Type] %X\n", obj_desc->type);
+		break;
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_prep_namestring
+ *
+ * PARAMETERS:  name            - String to prepare
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Translate all forward slashes and dots to backslashes.
+ *
+ ******************************************************************************/
+
+void acpi_db_prep_namestring(char *name)
+{
+
+	if (!name) {
+		return;
+	}
+
+	acpi_ut_strupr(name);
+
+	/* Convert a leading forward slash to a backslash */
+
+	if (*name == '/') {
+		*name = '\\';
+	}
+
+	/* Ignore a leading backslash, this is the root prefix */
+
+	if (ACPI_IS_ROOT_PREFIX(*name)) {
+		name++;
+	}
+
+	/* Convert all slash path separators to dots */
+
+	while (*name) {
+		if ((*name == '/') || (*name == '\\')) {
+			*name = '.';
+		}
+
+		name++;
+	}
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_local_ns_lookup
+ *
+ * PARAMETERS:  name            - Name to lookup
+ *
+ * RETURN:      Pointer to a namespace node, null on failure
+ *
+ * DESCRIPTION: Lookup a name in the ACPI namespace
+ *
+ * Note: Currently begins search from the root. Could be enhanced to use
+ * the current prefix (scope) node as the search beginning point.
+ *
+ ******************************************************************************/
+
+struct acpi_namespace_node *acpi_db_local_ns_lookup(char *name)
+{
+	char *internal_path;
+	acpi_status status;
+	struct acpi_namespace_node *node = NULL;
+
+	acpi_db_prep_namestring(name);
+
+	/* Build an internal namestring */
+
+	status = acpi_ns_internalize_name(name, &internal_path);
+	if (ACPI_FAILURE(status)) {
+		acpi_os_printf("Invalid namestring: %s\n", name);
+		return (NULL);
+	}
+
+	/*
+	 * Lookup the name.
+	 * (Uses root node as the search starting point)
+	 */
+	status = acpi_ns_lookup(NULL, internal_path, ACPI_TYPE_ANY,
+				ACPI_IMODE_EXECUTE,
+				ACPI_NS_NO_UPSEARCH | ACPI_NS_DONT_OPEN_SCOPE,
+				NULL, &node);
+	if (ACPI_FAILURE(status)) {
+		acpi_os_printf("Could not locate name: %s, %s\n",
+			       name, acpi_format_exception(status));
+	}
+
+	ACPI_FREE(internal_path);
+	return (node);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_uint32_to_hex_string
+ *
+ * PARAMETERS:  value           - The value to be converted to string
+ *              buffer          - Buffer for result (not less than 11 bytes)
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Convert the unsigned 32-bit value to the hexadecimal image
+ *
+ * NOTE: It is the caller's responsibility to ensure that the length of buffer
+ *       is sufficient.
+ *
+ ******************************************************************************/
+
+void acpi_db_uint32_to_hex_string(u32 value, char *buffer)
+{
+	int i;
+
+	if (value == 0) {
+		strcpy(buffer, "0");
+		return;
+	}
+
+	buffer[8] = '\0';
+
+	for (i = 7; i >= 0; i--) {
+		buffer[i] = gbl_hex_to_ascii[value & 0x0F];
+		value = value >> 4;
+	}
+}
+
+#ifdef ACPI_OBSOLETE_FUNCTIONS
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_second_pass_parse
+ *
+ * PARAMETERS:  root            - Root of the parse tree
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Second pass parse of the ACPI tables. We need to wait until
+ *              second pass to parse the control methods
+ *
+ ******************************************************************************/
+
+acpi_status acpi_db_second_pass_parse(union acpi_parse_object *root)
+{
+	union acpi_parse_object *op = root;
+	union acpi_parse_object *method;
+	union acpi_parse_object *search_op;
+	union acpi_parse_object *start_op;
+	acpi_status status = AE_OK;
+	u32 base_aml_offset;
+	struct acpi_walk_state *walk_state;
+
+	ACPI_FUNCTION_ENTRY();
+
+	acpi_os_printf("Pass two parse ....\n");
+
+	while (op) {
+		if (op->common.aml_opcode == AML_METHOD_OP) {
+			method = op;
+
+			/* Create a new walk state for the parse */
+
+			walk_state =
+			    acpi_ds_create_walk_state(0, NULL, NULL, NULL);
+			if (!walk_state) {
+				return (AE_NO_MEMORY);
+			}
+
+			/* Init the Walk State */
+
+			walk_state->parser_state.aml =
+			    walk_state->parser_state.aml_start =
+			    method->named.data;
+			walk_state->parser_state.aml_end =
+			    walk_state->parser_state.pkg_end =
+			    method->named.data + method->named.length;
+			walk_state->parser_state.start_scope = op;
+
+			walk_state->descending_callback =
+			    acpi_ds_load1_begin_op;
+			walk_state->ascending_callback = acpi_ds_load1_end_op;
+
+			/* Perform the AML parse */
+
+			status = acpi_ps_parse_aml(walk_state);
+
+			base_aml_offset =
+			    (method->common.value.arg)->common.aml_offset + 1;
+			start_op = (method->common.value.arg)->common.next;
+			search_op = start_op;
+
+			while (search_op) {
+				search_op->common.aml_offset += base_aml_offset;
+				search_op =
+				    acpi_ps_get_depth_next(start_op, search_op);
+			}
+		}
+
+		if (op->common.aml_opcode == AML_REGION_OP) {
+
+			/* TBD: [Investigate] this isn't quite the right thing to do! */
+			/*
+			 *
+			 * Method = (ACPI_DEFERRED_OP *) Op;
+			 * Status = acpi_ps_parse_aml (Op, Method->Body, Method->body_length);
+			 */
+		}
+
+		if (ACPI_FAILURE(status)) {
+			break;
+		}
+
+		op = acpi_ps_get_depth_next(root, op);
+	}
+
+	return (status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_dump_buffer
+ *
+ * PARAMETERS:  address             - Pointer to the buffer
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Print a portion of a buffer
+ *
+ ******************************************************************************/
+
+void acpi_db_dump_buffer(u32 address)
+{
+
+	acpi_os_printf("\nLocation %X:\n", address);
+
+	acpi_dbg_level |= ACPI_LV_TABLES;
+	acpi_ut_debug_dump_buffer(ACPI_TO_POINTER(address), 64, DB_BYTE_DISPLAY,
+				  ACPI_UINT32_MAX);
+}
+#endif
diff --git a/drivers/acpi/acpica/dbxface.c b/drivers/acpi/acpica/dbxface.c
new file mode 100644
index 0000000..26023bd
--- /dev/null
+++ b/drivers/acpi/acpica/dbxface.c
@@ -0,0 +1,467 @@
+/*******************************************************************************
+ *
+ * Module Name: dbxface - AML Debugger external interfaces
+ *
+ ******************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2015, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include <acpi/acpi.h>
+#include "accommon.h"
+#include "amlcode.h"
+#include "acdebug.h"
+
+#define _COMPONENT          ACPI_CA_DEBUGGER
+ACPI_MODULE_NAME("dbxface")
+
+/* Local prototypes */
+static acpi_status
+acpi_db_start_command(struct acpi_walk_state *walk_state,
+		      union acpi_parse_object *op);
+
+#ifdef ACPI_OBSOLETE_FUNCTIONS
+void acpi_db_method_end(struct acpi_walk_state *walk_state);
+#endif
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_start_command
+ *
+ * PARAMETERS:  walk_state      - Current walk
+ *              op              - Current executing Op, from AML interpreter
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Enter debugger command loop
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_db_start_command(struct acpi_walk_state *walk_state,
+		      union acpi_parse_object *op)
+{
+	acpi_status status;
+
+	/* TBD: [Investigate] are there namespace locking issues here? */
+
+	/* acpi_ut_release_mutex (ACPI_MTX_NAMESPACE); */
+
+	/* Go into the command loop and await next user command */
+
+	acpi_gbl_method_executing = TRUE;
+	status = AE_CTRL_TRUE;
+	while (status == AE_CTRL_TRUE) {
+		if (acpi_gbl_debugger_configuration == DEBUGGER_MULTI_THREADED) {
+
+			/* Handshake with the front-end that gets user command lines */
+
+			acpi_os_release_mutex(acpi_gbl_db_command_complete);
+
+			status =
+			    acpi_os_acquire_mutex(acpi_gbl_db_command_ready,
+						  ACPI_WAIT_FOREVER);
+			if (ACPI_FAILURE(status)) {
+				return (status);
+			}
+		} else {
+			/* Single threaded, we must get a command line ourselves */
+
+			/* Force output to console until a command is entered */
+
+			acpi_db_set_output_destination(ACPI_DB_CONSOLE_OUTPUT);
+
+			/* Different prompt if method is executing */
+
+			if (!acpi_gbl_method_executing) {
+				acpi_os_printf("%1c ",
+					       ACPI_DEBUGGER_COMMAND_PROMPT);
+			} else {
+				acpi_os_printf("%1c ",
+					       ACPI_DEBUGGER_EXECUTE_PROMPT);
+			}
+
+			/* Get the user input line */
+
+			status = acpi_os_get_line(acpi_gbl_db_line_buf,
+						  ACPI_DB_LINE_BUFFER_SIZE,
+						  NULL);
+			if (ACPI_FAILURE(status)) {
+				ACPI_EXCEPTION((AE_INFO, status,
+						"While parsing command line"));
+				return (status);
+			}
+		}
+
+		status =
+		    acpi_db_command_dispatch(acpi_gbl_db_line_buf, walk_state,
+					     op);
+	}
+
+	/* acpi_ut_acquire_mutex (ACPI_MTX_NAMESPACE); */
+
+	return (status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_single_step
+ *
+ * PARAMETERS:  walk_state      - Current walk
+ *              op              - Current executing op (from aml interpreter)
+ *              opcode_class    - Class of the current AML Opcode
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Called just before execution of an AML opcode.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_db_single_step(struct acpi_walk_state * walk_state,
+		    union acpi_parse_object * op, u32 opcode_class)
+{
+	union acpi_parse_object *next;
+	acpi_status status = AE_OK;
+	u32 original_debug_level;
+	union acpi_parse_object *display_op;
+	union acpi_parse_object *parent_op;
+	u32 aml_offset;
+
+	ACPI_FUNCTION_ENTRY();
+
+	/* Check the abort flag */
+
+	if (acpi_gbl_abort_method) {
+		acpi_gbl_abort_method = FALSE;
+		return (AE_ABORT_METHOD);
+	}
+
+	aml_offset = (u32)ACPI_PTR_DIFF(op->common.aml,
+					walk_state->parser_state.aml_start);
+
+	/* Check for single-step breakpoint */
+
+	if (walk_state->method_breakpoint &&
+	    (walk_state->method_breakpoint <= aml_offset)) {
+
+		/* Check if the breakpoint has been reached or passed */
+		/* Hit the breakpoint, resume single step, reset breakpoint */
+
+		acpi_os_printf("***Break*** at AML offset %X\n", aml_offset);
+		acpi_gbl_cm_single_step = TRUE;
+		acpi_gbl_step_to_next_call = FALSE;
+		walk_state->method_breakpoint = 0;
+	}
+
+	/* Check for user breakpoint (Must be on exact Aml offset) */
+
+	else if (walk_state->user_breakpoint &&
+		 (walk_state->user_breakpoint == aml_offset)) {
+		acpi_os_printf("***UserBreakpoint*** at AML offset %X\n",
+			       aml_offset);
+		acpi_gbl_cm_single_step = TRUE;
+		acpi_gbl_step_to_next_call = FALSE;
+		walk_state->method_breakpoint = 0;
+	}
+
+	/*
+	 * Check if this is an opcode that we are interested in --
+	 * namely, opcodes that have arguments
+	 */
+	if (op->common.aml_opcode == AML_INT_NAMEDFIELD_OP) {
+		return (AE_OK);
+	}
+
+	switch (opcode_class) {
+	case AML_CLASS_UNKNOWN:
+	case AML_CLASS_ARGUMENT:	/* constants, literals, etc. do nothing */
+
+		return (AE_OK);
+
+	default:
+
+		/* All other opcodes -- continue */
+		break;
+	}
+
+	/*
+	 * Under certain debug conditions, display this opcode and its operands
+	 */
+	if ((acpi_gbl_db_output_to_file) ||
+	    (acpi_gbl_cm_single_step) || (acpi_dbg_level & ACPI_LV_PARSE)) {
+		if ((acpi_gbl_db_output_to_file) ||
+		    (acpi_dbg_level & ACPI_LV_PARSE)) {
+			acpi_os_printf
+			    ("\n[AmlDebug] Next AML Opcode to execute:\n");
+		}
+
+		/*
+		 * Display this op (and only this op - zero out the NEXT field
+		 * temporarily, and disable parser trace output for the duration of
+		 * the display because we don't want the extraneous debug output)
+		 */
+		original_debug_level = acpi_dbg_level;
+		acpi_dbg_level &= ~(ACPI_LV_PARSE | ACPI_LV_FUNCTIONS);
+		next = op->common.next;
+		op->common.next = NULL;
+
+		display_op = op;
+		parent_op = op->common.parent;
+		if (parent_op) {
+			if ((walk_state->control_state) &&
+			    (walk_state->control_state->common.state ==
+			     ACPI_CONTROL_PREDICATE_EXECUTING)) {
+				/*
+				 * We are executing the predicate of an IF or WHILE statement
+				 * Search upwards for the containing IF or WHILE so that the
+				 * entire predicate can be displayed.
+				 */
+				while (parent_op) {
+					if ((parent_op->common.aml_opcode ==
+					     AML_IF_OP)
+					    || (parent_op->common.aml_opcode ==
+						AML_WHILE_OP)) {
+						display_op = parent_op;
+						break;
+					}
+					parent_op = parent_op->common.parent;
+				}
+			} else {
+				while (parent_op) {
+					if ((parent_op->common.aml_opcode ==
+					     AML_IF_OP)
+					    || (parent_op->common.aml_opcode ==
+						AML_ELSE_OP)
+					    || (parent_op->common.aml_opcode ==
+						AML_SCOPE_OP)
+					    || (parent_op->common.aml_opcode ==
+						AML_METHOD_OP)
+					    || (parent_op->common.aml_opcode ==
+						AML_WHILE_OP)) {
+						break;
+					}
+					display_op = parent_op;
+					parent_op = parent_op->common.parent;
+				}
+			}
+		}
+
+		/* Now we can display it */
+
+#ifdef ACPI_DISASSEMBLER
+		acpi_dm_disassemble(walk_state, display_op, ACPI_UINT32_MAX);
+#endif
+
+		if ((op->common.aml_opcode == AML_IF_OP) ||
+		    (op->common.aml_opcode == AML_WHILE_OP)) {
+			if (walk_state->control_state->common.value) {
+				acpi_os_printf
+				    ("Predicate = [True], IF block was executed\n");
+			} else {
+				acpi_os_printf
+				    ("Predicate = [False], Skipping IF block\n");
+			}
+		} else if (op->common.aml_opcode == AML_ELSE_OP) {
+			acpi_os_printf
+			    ("Predicate = [False], ELSE block was executed\n");
+		}
+
+		/* Restore everything */
+
+		op->common.next = next;
+		acpi_os_printf("\n");
+		if ((acpi_gbl_db_output_to_file) ||
+		    (acpi_dbg_level & ACPI_LV_PARSE)) {
+			acpi_os_printf("\n");
+		}
+		acpi_dbg_level = original_debug_level;
+	}
+
+	/* If we are not single stepping, just continue executing the method */
+
+	if (!acpi_gbl_cm_single_step) {
+		return (AE_OK);
+	}
+
+	/*
+	 * If we are executing a step-to-call command,
+	 * Check if this is a method call.
+	 */
+	if (acpi_gbl_step_to_next_call) {
+		if (op->common.aml_opcode != AML_INT_METHODCALL_OP) {
+
+			/* Not a method call, just keep executing */
+
+			return (AE_OK);
+		}
+
+		/* Found a method call, stop executing */
+
+		acpi_gbl_step_to_next_call = FALSE;
+	}
+
+	/*
+	 * If the next opcode is a method call, we will "step over" it
+	 * by default.
+	 */
+	if (op->common.aml_opcode == AML_INT_METHODCALL_OP) {
+
+		/* Force no more single stepping while executing called method */
+
+		acpi_gbl_cm_single_step = FALSE;
+
+		/*
+		 * Set the breakpoint on/before the call, it will stop execution
+		 * as soon as we return
+		 */
+		walk_state->method_breakpoint = 1;	/* Must be non-zero! */
+	}
+
+	status = acpi_db_start_command(walk_state, op);
+
+	/* User commands complete, continue execution of the interrupted method */
+
+	return (status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_initialize_debugger
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Init and start debugger
+ *
+ ******************************************************************************/
+
+acpi_status acpi_initialize_debugger(void)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(acpi_initialize_debugger);
+
+	/* Init globals */
+
+	acpi_gbl_db_buffer = NULL;
+	acpi_gbl_db_filename = NULL;
+	acpi_gbl_db_output_to_file = FALSE;
+
+	acpi_gbl_db_debug_level = ACPI_LV_VERBOSITY2;
+	acpi_gbl_db_console_debug_level = ACPI_NORMAL_DEFAULT | ACPI_LV_TABLES;
+	acpi_gbl_db_output_flags = ACPI_DB_CONSOLE_OUTPUT;
+
+	acpi_gbl_db_opt_no_ini_methods = FALSE;
+
+	acpi_gbl_db_buffer = acpi_os_allocate(ACPI_DEBUG_BUFFER_SIZE);
+	if (!acpi_gbl_db_buffer) {
+		return_ACPI_STATUS(AE_NO_MEMORY);
+	}
+	memset(acpi_gbl_db_buffer, 0, ACPI_DEBUG_BUFFER_SIZE);
+
+	/* Initial scope is the root */
+
+	acpi_gbl_db_scope_buf[0] = AML_ROOT_PREFIX;
+	acpi_gbl_db_scope_buf[1] = 0;
+	acpi_gbl_db_scope_node = acpi_gbl_root_node;
+
+	/*
+	 * If configured for multi-thread support, the debug executor runs in
+	 * a separate thread so that the front end can be in another address
+	 * space, environment, or even another machine.
+	 */
+	if (acpi_gbl_debugger_configuration & DEBUGGER_MULTI_THREADED) {
+
+		/* These were created with one unit, grab it */
+
+		status = acpi_os_acquire_mutex(acpi_gbl_db_command_complete,
+					       ACPI_WAIT_FOREVER);
+		if (ACPI_FAILURE(status)) {
+			acpi_os_printf("Could not get debugger mutex\n");
+			return_ACPI_STATUS(status);
+		}
+
+		status = acpi_os_acquire_mutex(acpi_gbl_db_command_ready,
+					       ACPI_WAIT_FOREVER);
+		if (ACPI_FAILURE(status)) {
+			acpi_os_printf("Could not get debugger mutex\n");
+			return_ACPI_STATUS(status);
+		}
+
+		/* Create the debug execution thread to execute commands */
+
+		status = acpi_os_execute(OSL_DEBUGGER_THREAD,
+					 acpi_db_execute_thread, NULL);
+		if (ACPI_FAILURE(status)) {
+			ACPI_EXCEPTION((AE_INFO, status,
+					"Could not start debugger thread"));
+			return_ACPI_STATUS(status);
+		}
+	}
+
+	return_ACPI_STATUS(AE_OK);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_initialize_debugger)
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_terminate_debugger
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Stop debugger
+ *
+ ******************************************************************************/
+void acpi_terminate_debugger(void)
+{
+
+	if (acpi_gbl_db_buffer) {
+		acpi_os_free(acpi_gbl_db_buffer);
+		acpi_gbl_db_buffer = NULL;
+	}
+
+	/* Ensure that debug output is now disabled */
+
+	acpi_gbl_db_output_flags = ACPI_DB_DISABLE_OUTPUT;
+}
+
+ACPI_EXPORT_SYMBOL(acpi_terminate_debugger)
-- 
1.7.10
