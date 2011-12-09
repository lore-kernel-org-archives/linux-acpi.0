From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [BUG] ACPI resource validation not working [Was: Re: ITE 8728F]
Date: Fri, 09 Dec 2011 10:01:49 +0800
Message-ID: <1323396109.27764.44.camel@minggr>
References: <CAKPcRGofYw_DcVL1QDorSp8Gr1ZL6-ur=oZnDs0w_e91ZuwKbQ@mail.gmail.com>
	 <94F2FBAB4432B54E8AACC7DFDE6C92E316EE2575@ORSMSX101.amr.corp.intel.com>
	 <1322531323.1467.10.camel@minggr>
	 <CAKPcRGpXP=A-WHVLyvf_ZazY8br5d4-CxrDpnCbpJbcsnMVpiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:63432 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754164Ab1LICBw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Dec 2011 21:01:52 -0500
In-Reply-To: <CAKPcRGpXP=A-WHVLyvf_ZazY8br5d4-CxrDpnCbpJbcsnMVpiQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, Jean Delvare <khali@linux-fr.org>, Nikolay Mikov <nik.mikov@gmail.com>, Thomas <trenn@suse.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, lenb <lenb@kernel.org>

On Tue, 2011-11-29 at 21:18 +0800, Luca Tettamanti wrote:
> On Tue, Nov 29, 2011 at 2:48 AM, Lin Ming <ming.m.lin@intel.com> wrote:
> > On Tue, 2011-11-29 at 06:56 +0800, Moore, Robert wrote:
> >> I'm going to let Lin Ming respond to this, since the functions in question appear to be Linux extensions to ACPICA.
> [...]
> > Yes, we should put the call back.
> 
> Great, are you going to push this patch yourself?

Hi Luca,

We have investigated this issue more and think that it's better to move
the resource validation code into ACPICA core.

Here is the new patch.

The major changes include:
- Remove acpi_os_validate_address/acpi_os_invalidate_address from osl.c.
  They are reimplemented in ACPICA core: 
  acpi_ut_add_address_range/acpi_ut_remove_address_range.

- Add new interface for drivers to check resource conflict:
  acpi_check_address_range

Could you help to test it?

Thanks,
Lin Ming
---
 drivers/acpi/acpica/Makefile    |    2 +-
 drivers/acpi/acpica/acconfig.h  |    4 +
 drivers/acpi/acpica/acglobal.h  |    2 +
 drivers/acpi/acpica/aclocal.h   |    9 ++
 drivers/acpi/acpica/acutils.h   |   18 +++
 drivers/acpi/acpica/dsargs.c    |    7 +
 drivers/acpi/acpica/utaddress.c |  295 +++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/utdelete.c  |   13 +-
 drivers/acpi/acpica/utglobal.c  |    6 +
 drivers/acpi/acpica/utinit.c    |    1 +
 drivers/acpi/acpica/utxface.c   |   38 +++++
 drivers/acpi/osl.c              |  202 ++-------------------------
 include/acpi/acpixf.h           |    5 +
 13 files changed, 406 insertions(+), 196 deletions(-)

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index 301bd2d..855785b 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -45,4 +45,4 @@ acpi-y += tbxface.o tbinstal.o tbutils.o tbfind.o tbfadt.o tbxfroot.o
 acpi-y += utalloc.o utdebug.o uteval.o utinit.o utmisc.o utxface.o \
 		utcopy.o utdelete.o utglobal.o utmath.o utobject.o \
 		utstate.o utmutex.o utobject.o utresrc.o utlock.o utids.o \
-		utosi.o utxferror.o utdecode.o
+		utosi.o utxferror.o utdecode.o utaddress.o
diff --git a/drivers/acpi/acpica/acconfig.h b/drivers/acpi/acpica/acconfig.h
index f895a24..4dbd010 100644
--- a/drivers/acpi/acpica/acconfig.h
+++ b/drivers/acpi/acpica/acconfig.h
@@ -123,6 +123,10 @@
 
 #define ACPI_MAX_SLEEP                  2000	/* Two seconds */
 
+/* Address Range lists are per-space_id (Memory and I/O only) */
+
+#define ACPI_ADDRESS_RANGE_MAX          2
+
 /******************************************************************************
  *
  * ACPI Specification constants (Do not change unless the specification changes)
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 76dc02f..b7e7fbd 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -295,6 +295,8 @@ ACPI_EXTERN u8 acpi_gbl_acpi_hardware_present;
 ACPI_EXTERN u8 acpi_gbl_events_initialized;
 ACPI_EXTERN u8 acpi_gbl_osi_data;
 ACPI_EXTERN struct acpi_interface_info *acpi_gbl_supported_interfaces;
+ACPI_EXTERN struct acpi_address_range
+    *acpi_gbl_address_range_list[ACPI_ADDRESS_RANGE_MAX];
 
 #ifndef DEFINE_ACPI_GLOBALS
 
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 5552125..44a2164 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -625,6 +625,15 @@ union acpi_generic_state {
 
 typedef acpi_status(*ACPI_EXECUTE_OP) (struct acpi_walk_state * walk_state);
 
+/* Address Range info block */
+
+struct acpi_address_range {
+	struct acpi_address_range *next;
+	struct acpi_namespace_node *region_node;
+	acpi_physical_address start_address;
+	acpi_physical_address end_address;
+};
+
 /*****************************************************************************
  *
  * Parser typedefs and structs
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 99c140d..dfea11d 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -579,6 +579,24 @@ acpi_ut_create_list(char *list_name,
 #endif				/* ACPI_DBG_TRACK_ALLOCATIONS */
 
 /*
+ * utaddress - address range check
+ */
+acpi_status
+acpi_ut_add_address_range(acpi_adr_space_type space_id,
+			  acpi_physical_address address,
+			  u32 length, struct acpi_namespace_node *region_node);
+
+void
+acpi_ut_remove_address_range(acpi_adr_space_type space_id,
+			     struct acpi_namespace_node *region_node);
+
+u32
+acpi_ut_check_address_range(acpi_adr_space_type space_id,
+			    acpi_physical_address address, u32 length, u8 warn);
+
+void acpi_ut_delete_address_lists(void);
+
+/*
  * utxferror - various error/warning output functions
  */
 void ACPI_INTERNAL_VAR_XFACE
diff --git a/drivers/acpi/acpica/dsargs.c b/drivers/acpi/acpica/dsargs.c
index 8c7b997..0e62474 100644
--- a/drivers/acpi/acpica/dsargs.c
+++ b/drivers/acpi/acpica/dsargs.c
@@ -387,5 +387,12 @@ acpi_status acpi_ds_get_region_arguments(union acpi_operand_object *obj_desc)
 	status = acpi_ds_execute_arguments(node, node->parent,
 					   extra_desc->extra.aml_length,
 					   extra_desc->extra.aml_start);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	status = acpi_ut_add_address_range(obj_desc->region.space_id,
+					   obj_desc->region.address,
+					   obj_desc->region.length, node);
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/utaddress.c b/drivers/acpi/acpica/utaddress.c
new file mode 100644
index 0000000..6ef7649
--- /dev/null
+++ b/drivers/acpi/acpica/utaddress.c
@@ -0,0 +1,295 @@
+/******************************************************************************
+ *
+ * Module Name: utaddress - op_region address range check
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2011, Intel Corp.
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
+
+#define _COMPONENT          ACPI_UTILITIES
+ACPI_MODULE_NAME("utaddress")
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_add_address_range
+ *
+ * PARAMETERS:  space_id            - Address space ID
+ *              Address             - op_region start address
+ *              Length              - op_region length
+ *              region_node         - op_region namespace node
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Add the Operation Region address range to the global list.
+ *              The only supported Space IDs are Memory and I/O. Called when
+ *              the op_region address/length operands are fully evaluated.
+ *
+ * MUTEX:       Locks the namespace
+ *
+ * NOTE: Because this interface is only called when an op_region argument
+ * list is evaluated, there cannot be any duplicate region_nodes.
+ * Duplicate Address/Length values are allowed, however, so that multiple
+ * address conflicts can be detected.
+ *
+ ******************************************************************************/
+acpi_status
+acpi_ut_add_address_range(acpi_adr_space_type space_id,
+			  acpi_physical_address address,
+			  u32 length, struct acpi_namespace_node *region_node)
+{
+	struct acpi_address_range *range_info;
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(ut_add_address_range);
+
+	if ((space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY) &&
+	    (space_id != ACPI_ADR_SPACE_SYSTEM_IO)) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/* Allocate/init a new info block, add it to the appropriate list */
+
+	range_info = ACPI_ALLOCATE(sizeof(struct acpi_address_range));
+	if (!range_info) {
+		status = AE_NO_MEMORY;
+		goto exit;
+	}
+
+	range_info->start_address = address;
+	range_info->end_address = (address + length - 1);
+	range_info->region_node = region_node;
+
+	range_info->next = acpi_gbl_address_range_list[space_id];
+	acpi_gbl_address_range_list[space_id] = range_info;
+
+	ACPI_DEBUG_PRINT((ACPI_DB_NAMES,
+			  "\nAdded [%4.4s] address range: 0x%p-0x%p\n",
+			  acpi_ut_get_node_name(range_info->region_node),
+			  ACPI_CAST_PTR(void, address),
+			  ACPI_CAST_PTR(void, range_info->end_address)));
+
+      exit:
+	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_remove_address_range
+ *
+ * PARAMETERS:  space_id            - Address space ID
+ *              region_node         - op_region namespace node
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Remove the Operation Region from the global list. The only
+ *              supported Space IDs are Memory and I/O. Called when an
+ *              op_region is deleted.
+ *
+ * MUTEX:       Assumes the namespace is locked
+ *
+ ******************************************************************************/
+
+void
+acpi_ut_remove_address_range(acpi_adr_space_type space_id,
+			     struct acpi_namespace_node *region_node)
+{
+	struct acpi_address_range *range_info;
+	struct acpi_address_range *prev;
+
+	ACPI_FUNCTION_TRACE(ut_remove_address_range);
+
+	if ((space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY) &&
+	    (space_id != ACPI_ADR_SPACE_SYSTEM_IO)) {
+		return_VOID;
+	}
+
+	/* Get the appropriate list head and check the list */
+
+	range_info = prev = acpi_gbl_address_range_list[space_id];
+	while (range_info) {
+		if (range_info->region_node == region_node) {
+			if (range_info == prev) {	/* Found at list head */
+				acpi_gbl_address_range_list[space_id] =
+				    range_info->next;
+			} else {
+				prev->next = range_info->next;
+			}
+
+			ACPI_DEBUG_PRINT((ACPI_DB_NAMES,
+					  "\nRemoved [%4.4s] address range: 0x%p-0x%p\n",
+					  acpi_ut_get_node_name(range_info->
+								region_node),
+					  ACPI_CAST_PTR(void,
+							range_info->
+							start_address),
+					  ACPI_CAST_PTR(void,
+							range_info->
+							end_address)));
+
+			ACPI_FREE(range_info);
+			return_VOID;
+		}
+
+		prev = range_info;
+		range_info = range_info->next;
+	}
+
+	return_VOID;
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_check_address_range
+ *
+ * PARAMETERS:  space_id            - Address space ID
+ *              Address             - Start address
+ *              Length              - Length of address range
+ *              Warn                - TRUE if warning on overlap desired
+ *
+ * RETURN:      Count of the number of conflicts detected. Zero is always
+ *              returned for Space IDs other than Memory or I/O.
+ *
+ * DESCRIPTION: Check if the input address range overlaps any of the
+ *              ASL operation region address ranges. The only supported
+ *              Space IDs are Memory and I/O.
+ *
+ * MUTEX:       Assumes the namespace is locked.
+ *
+ ******************************************************************************/
+
+u32
+acpi_ut_check_address_range(acpi_adr_space_type space_id,
+			    acpi_physical_address address, u32 length, u8 warn)
+{
+	struct acpi_address_range *range_info;
+	acpi_physical_address end_address;
+	char *pathname;
+	u32 overlap_count = 0;
+
+	ACPI_FUNCTION_TRACE(ut_check_address_range);
+
+	if ((space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY) &&
+	    (space_id != ACPI_ADR_SPACE_SYSTEM_IO)) {
+		return_UINT32(0);
+	}
+
+	range_info = acpi_gbl_address_range_list[space_id];
+	end_address = address + length - 1;
+
+	/* Check entire list for all possible conflicts */
+
+	while (range_info) {
+		/*
+		 * Check if the requested Address/Length overlaps this address_range.
+		 * Four cases to consider:
+		 *
+		 * 1) Input address/length is contained completely in the address range
+		 * 2) Input address/length overlaps range at the range start
+		 * 3) Input address/length overlaps range at the range end
+		 * 4) Input address/length completely encompasses the range
+		 */
+		if ((address <= range_info->end_address) &&
+		    (end_address >= range_info->start_address)) {
+
+			/* Found an address range overlap */
+
+			overlap_count++;
+			if (warn) {	/* Optional warning message */
+				pathname =
+				    acpi_ns_get_external_pathname(range_info->
+								  region_node);
+
+				ACPI_WARNING((AE_INFO,
+					      "0x%p-0x%p %s conflicts with Region %s %d",
+					      ACPI_CAST_PTR(void, address),
+					      ACPI_CAST_PTR(void, end_address),
+					      acpi_ut_get_region_name(space_id),
+					      pathname, overlap_count));
+				ACPI_FREE(pathname);
+			}
+		}
+
+		range_info = range_info->next;
+	}
+
+	return_UINT32(overlap_count);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_delete_address_lists
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Delete all global address range lists (called during
+ *              subsystem shutdown).
+ *
+ ******************************************************************************/
+
+void acpi_ut_delete_address_lists(void)
+{
+	struct acpi_address_range *next;
+	struct acpi_address_range *range_info;
+	int i;
+
+	/* Delete all elements in all address range lists */
+
+	for (i = 0; i < ACPI_ADDRESS_RANGE_MAX; i++) {
+		next = acpi_gbl_address_range_list[i];
+
+		while (next) {
+			range_info = next;
+			next = range_info->next;
+			ACPI_FREE(range_info);
+		}
+
+		acpi_gbl_address_range_list[i] = NULL;
+	}
+}
diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index 31f5a78..93ec06b 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -215,11 +215,14 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object)
 		ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS,
 				  "***** Region %p\n", object));
 
-		/* Invalidate the region address/length via the host OS */
-
-		acpi_os_invalidate_address(object->region.space_id,
-					  object->region.address,
-					  (acpi_size) object->region.length);
+		/*
+		 * Update address_range list. However, only permanent regions
+		 * are installed in this list. (Not created within a method)
+		 */
+		if (!(object->region.node->flags & ANOBJ_TEMPORARY)) {
+			acpi_ut_remove_address_range(object->region.space_id,
+						     object->region.node);
+		}
 
 		second_desc = acpi_ns_get_secondary_object(object);
 		if (second_desc) {
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index ffba0a3..3cf758b 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -264,6 +264,12 @@ acpi_status acpi_ut_init_globals(void)
 		return_ACPI_STATUS(status);
 	}
 
+	/* Address Range lists */
+
+	for (i = 0; i < ACPI_ADDRESS_RANGE_MAX; i++) {
+		acpi_gbl_address_range_list[i] = NULL;
+	}
+
 	/* Mutex locked flags */
 
 	for (i = 0; i < ACPI_NUM_MUTEX; i++) {
diff --git a/drivers/acpi/acpica/utinit.c b/drivers/acpi/acpica/utinit.c
index 191b682..cab61a0 100644
--- a/drivers/acpi/acpica/utinit.c
+++ b/drivers/acpi/acpica/utinit.c
@@ -92,6 +92,7 @@ static void acpi_ut_terminate(void)
 		gpe_xrupt_info = next_gpe_xrupt_info;
 	}
 
+	acpi_ut_delete_address_lists();
 	return_VOID;
 }
 
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index 420ebfe..15cbdde 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -48,6 +48,7 @@
 #include "acnamesp.h"
 #include "acdebug.h"
 #include "actables.h"
+#include "acinterp.h"
 
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utxface")
@@ -640,4 +641,41 @@ acpi_status acpi_install_interface_handler(acpi_interface_handler handler)
 }
 
 ACPI_EXPORT_SYMBOL(acpi_install_interface_handler)
+
+/*****************************************************************************
+ *
+ * FUNCTION:    acpi_check_address_range
+ *
+ * PARAMETERS:  space_id            - Address space ID
+ *              Address             - Start address
+ *              Length              - Length
+ *              Warn                - TRUE if warning on overlap desired
+ *
+ * RETURN:      Count of the number of conflicts detected.
+ *
+ * DESCRIPTION: Check if the input address range overlaps any of the
+ *              ASL operation region address ranges.
+ *
+ ****************************************************************************/
+u32
+acpi_check_address_range(acpi_adr_space_type space_id,
+			 acpi_physical_address address,
+			 acpi_size length, u8 warn)
+{
+	u32 overlaps;
+	acpi_status status;
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+	if (ACPI_FAILURE(status)) {
+		return (0);
+	}
+
+	overlaps = acpi_ut_check_address_range(space_id, address,
+					       (u32)length, warn);
+
+	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+	return (overlaps);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_check_address_range)
 #endif				/* !ACPI_ASL_COMPILER */
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index f31c5c5..3e57fbd 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -83,19 +83,6 @@ static struct workqueue_struct *kacpi_notify_wq;
 struct workqueue_struct *kacpi_hotplug_wq;
 EXPORT_SYMBOL(kacpi_hotplug_wq);
 
-struct acpi_res_list {
-	resource_size_t start;
-	resource_size_t end;
-	acpi_adr_space_type resource_type; /* IO port, System memory, ...*/
-	char name[5];   /* only can have a length of 4 chars, make use of this
-			   one instead of res->name, no need to kalloc then */
-	struct list_head resource_list;
-	int count;
-};
-
-static LIST_HEAD(resource_list_head);
-static DEFINE_SPINLOCK(acpi_res_lock);
-
 /*
  * This list of permanent mappings is for memory that may be accessed from
  * interrupt context, where we can't do the ioremap().
@@ -1278,44 +1265,28 @@ __setup("acpi_enforce_resources=", acpi_enforce_resources_setup);
  * drivers */
 int acpi_check_resource_conflict(const struct resource *res)
 {
-	struct acpi_res_list *res_list_elem;
-	int ioport = 0, clash = 0;
+	acpi_adr_space_type space_id;
+	acpi_size length;
+	u8 warn = 0;
+	int clash = 0;
 
 	if (acpi_enforce_resources == ENFORCE_RESOURCES_NO)
 		return 0;
 	if (!(res->flags & IORESOURCE_IO) && !(res->flags & IORESOURCE_MEM))
 		return 0;
 
-	ioport = res->flags & IORESOURCE_IO;
-
-	spin_lock(&acpi_res_lock);
-	list_for_each_entry(res_list_elem, &resource_list_head,
-			    resource_list) {
-		if (ioport && (res_list_elem->resource_type
-			       != ACPI_ADR_SPACE_SYSTEM_IO))
-			continue;
-		if (!ioport && (res_list_elem->resource_type
-				!= ACPI_ADR_SPACE_SYSTEM_MEMORY))
-			continue;
+	if (res->flags & IORESOURCE_IO)
+		space_id = ACPI_ADR_SPACE_SYSTEM_IO;
+	else
+		space_id = ACPI_ADR_SPACE_SYSTEM_MEMORY;
 
-		if (res->end < res_list_elem->start
-		    || res_list_elem->end < res->start)
-			continue;
-		clash = 1;
-		break;
-	}
-	spin_unlock(&acpi_res_lock);
+	length = res->end - res->start + 1;
+	if (acpi_enforce_resources != ENFORCE_RESOURCES_NO)
+		warn = 1;
+	clash = acpi_check_address_range(space_id, res->start, length, warn);
 
 	if (clash) {
 		if (acpi_enforce_resources != ENFORCE_RESOURCES_NO) {
-			printk(KERN_WARNING "ACPI: resource %s %pR"
-			       " conflicts with ACPI region %s "
-			       "[%s 0x%zx-0x%zx]\n",
-			       res->name, res, res_list_elem->name,
-			       (res_list_elem->resource_type ==
-				ACPI_ADR_SPACE_SYSTEM_IO) ? "io" : "mem",
-			       (size_t) res_list_elem->start,
-			       (size_t) res_list_elem->end);
 			if (acpi_enforce_resources == ENFORCE_RESOURCES_LAX)
 				printk(KERN_NOTICE "ACPI: This conflict may"
 				       " cause random problems and system"
@@ -1467,155 +1438,6 @@ acpi_status acpi_os_release_object(acpi_cache_t * cache, void *object)
 	kmem_cache_free(cache, object);
 	return (AE_OK);
 }
-
-static inline int acpi_res_list_add(struct acpi_res_list *res)
-{
-	struct acpi_res_list *res_list_elem;
-
-	list_for_each_entry(res_list_elem, &resource_list_head,
-			    resource_list) {
-
-		if (res->resource_type == res_list_elem->resource_type &&
-		    res->start == res_list_elem->start &&
-		    res->end == res_list_elem->end) {
-
-			/*
-			 * The Region(addr,len) already exist in the list,
-			 * just increase the count
-			 */
-
-			res_list_elem->count++;
-			return 0;
-		}
-	}
-
-	res->count = 1;
-	list_add(&res->resource_list, &resource_list_head);
-	return 1;
-}
-
-static inline void acpi_res_list_del(struct acpi_res_list *res)
-{
-	struct acpi_res_list *res_list_elem;
-
-	list_for_each_entry(res_list_elem, &resource_list_head,
-			    resource_list) {
-
-		if (res->resource_type == res_list_elem->resource_type &&
-		    res->start == res_list_elem->start &&
-		    res->end == res_list_elem->end) {
-
-			/*
-			 * If the res count is decreased to 0,
-			 * remove and free it
-			 */
-
-			if (--res_list_elem->count == 0) {
-				list_del(&res_list_elem->resource_list);
-				kfree(res_list_elem);
-			}
-			return;
-		}
-	}
-}
-
-acpi_status
-acpi_os_invalidate_address(
-    u8                   space_id,
-    acpi_physical_address   address,
-    acpi_size               length)
-{
-	struct acpi_res_list res;
-
-	switch (space_id) {
-	case ACPI_ADR_SPACE_SYSTEM_IO:
-	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
-		/* Only interference checks against SystemIO and SystemMemory
-		   are needed */
-		res.start = address;
-		res.end = address + length - 1;
-		res.resource_type = space_id;
-		spin_lock(&acpi_res_lock);
-		acpi_res_list_del(&res);
-		spin_unlock(&acpi_res_lock);
-		break;
-	case ACPI_ADR_SPACE_PCI_CONFIG:
-	case ACPI_ADR_SPACE_EC:
-	case ACPI_ADR_SPACE_SMBUS:
-	case ACPI_ADR_SPACE_CMOS:
-	case ACPI_ADR_SPACE_PCI_BAR_TARGET:
-	case ACPI_ADR_SPACE_DATA_TABLE:
-	case ACPI_ADR_SPACE_FIXED_HARDWARE:
-		break;
-	}
-	return AE_OK;
-}
-
-/******************************************************************************
- *
- * FUNCTION:    acpi_os_validate_address
- *
- * PARAMETERS:  space_id             - ACPI space ID
- *              address             - Physical address
- *              length              - Address length
- *
- * RETURN:      AE_OK if address/length is valid for the space_id. Otherwise,
- *              should return AE_AML_ILLEGAL_ADDRESS.
- *
- * DESCRIPTION: Validate a system address via the host OS. Used to validate
- *              the addresses accessed by AML operation regions.
- *
- *****************************************************************************/
-
-acpi_status
-acpi_os_validate_address (
-    u8                   space_id,
-    acpi_physical_address   address,
-    acpi_size               length,
-    char *name)
-{
-	struct acpi_res_list *res;
-	int added;
-	if (acpi_enforce_resources == ENFORCE_RESOURCES_NO)
-		return AE_OK;
-
-	switch (space_id) {
-	case ACPI_ADR_SPACE_SYSTEM_IO:
-	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
-		/* Only interference checks against SystemIO and SystemMemory
-		   are needed */
-		res = kzalloc(sizeof(struct acpi_res_list), GFP_KERNEL);
-		if (!res)
-			return AE_OK;
-		/* ACPI names are fixed to 4 bytes, still better use strlcpy */
-		strlcpy(res->name, name, 5);
-		res->start = address;
-		res->end = address + length - 1;
-		res->resource_type = space_id;
-		spin_lock(&acpi_res_lock);
-		added = acpi_res_list_add(res);
-		spin_unlock(&acpi_res_lock);
-		pr_debug("%s %s resource: start: 0x%llx, end: 0x%llx, "
-			 "name: %s\n", added ? "Added" : "Already exist",
-			 (space_id == ACPI_ADR_SPACE_SYSTEM_IO)
-			 ? "SystemIO" : "System Memory",
-			 (unsigned long long)res->start,
-			 (unsigned long long)res->end,
-			 res->name);
-		if (!added)
-			kfree(res);
-		break;
-	case ACPI_ADR_SPACE_PCI_CONFIG:
-	case ACPI_ADR_SPACE_EC:
-	case ACPI_ADR_SPACE_SMBUS:
-	case ACPI_ADR_SPACE_CMOS:
-	case ACPI_ADR_SPACE_PCI_BAR_TARGET:
-	case ACPI_ADR_SPACE_DATA_TABLE:
-	case ACPI_ADR_SPACE_FIXED_HARDWARE:
-		break;
-	}
-	return AE_OK;
-}
 #endif
 
 acpi_status __init acpi_os_initialize(void)
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index f554a93..7d7df17 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -111,6 +111,11 @@ acpi_status acpi_install_interface(acpi_string interface_name);
 
 acpi_status acpi_remove_interface(acpi_string interface_name);
 
+u32
+acpi_check_address_range(acpi_adr_space_type space_id,
+			 acpi_physical_address address,
+			 acpi_size length, u8 warn);
+
 /*
  * ACPI Memory management
  */


> 
> > diff --git a/drivers/acpi/acpica/dsargs.c b/drivers/acpi/acpica/dsargs.c
> > index 8c7b997..42163d8 100644
> > --- a/drivers/acpi/acpica/dsargs.c
> > +++ b/drivers/acpi/acpica/dsargs.c
> > @@ -387,5 +387,29 @@ acpi_status acpi_ds_get_region_arguments(union acpi_operand_object *obj_desc)
> >        status = acpi_ds_execute_arguments(node, node->parent,
> >                                           extra_desc->extra.aml_length,
> >                                           extra_desc->extra.aml_start);
> > +       if (ACPI_FAILURE(status)) {
> > +               return_ACPI_STATUS(status);
> > +       }
> > +
> > +       /* Validate the region address/length via the host OS */
> > +
> > +       status = acpi_os_validate_address(obj_desc->region.space_id,
> > +                                         obj_desc->region.address,
> > +                                         (acpi_size) obj_desc->region.length,
> > +                                         acpi_ut_get_node_name(node));
> > +
> > +       if (ACPI_FAILURE(status)) {
> > +               /*
> > +                * Invalid address/length. We will emit an error message and mark
> > +                * the region as invalid, so that it will cause an additional error if
> > +                * it is ever used. Then return AE_OK.
> > +                */
> > +               ACPI_EXCEPTION((AE_INFO, status,
> > +                               "During address validation of OpRegion [%4.4s]",
> > +                               node->name.ascii));
> > +               obj_desc->common.flags |= AOPOBJ_INVALID;
> > +               status = AE_OK;
> > +       }
> > +
> >        return_ACPI_STATUS(status);
> >  }
> 
> thanks,
> Luca


