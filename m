From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/26] ACPICA: Fix unmerged utility divergences.
Date: Wed, 31 Oct 2012 10:25:05 +0800
Message-ID: <ccb57129c251e5af8340bfa50eea6a48ddac638d.1351649950.git.lv.zheng@intel.com>
References: <cover.1351649949.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:34710 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753797Ab2JaCZO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2012 22:25:14 -0400
In-Reply-To: <cover.1351649949.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>

Utility improvements in ACPICA are partial ignored by ACPICA Linux
release.  This will lead to divergences between Linux and ACPICA.
This patch ports the entire "utility" into Linux and makes them
igored in the compilation stage by "ACPI_FUTURE_USAGE".
The following "Utility" files have been ported into the Linux:
  drivers/acpi/uttrack.c
  drivers/acpi/utcache.c
  drivers/acpi/utids.c

This patch will not affect the generated vmlinx binary.
This will decrease 274 lines of 20120913 divergence.diff.

Signed-off-by: Robert Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/Makefile  |    3 +
 drivers/acpi/acpica/acutils.h |   51 ++-
 drivers/acpi/acpica/utcache.c |  323 ++++++++++++++++++
 drivers/acpi/acpica/utclib.c  |  748 +++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/utdebug.c |    9 +-
 drivers/acpi/acpica/utmisc.c  |   99 +++++-
 drivers/acpi/acpica/uttrack.c |  650 +++++++++++++++++++++++++++++++++++
 7 files changed, 1852 insertions(+), 31 deletions(-)
 create mode 100644 drivers/acpi/acpica/utcache.c
 create mode 100644 drivers/acpi/acpica/utclib.c
 create mode 100644 drivers/acpi/acpica/uttrack.c

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index 7f1d407..c8bc24b 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -161,3 +161,6 @@ acpi-y +=		\
 	utxfinit.o	\
 	utxferror.o	\
 	utxfmutex.o
+
+acpi-$(ACPI_FUTURE_USAGE) += uttrack.o utcache.o utclib.o
+
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 68cb6de..82d6025 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -69,6 +69,22 @@ extern const char *acpi_gbl_siz_decode[];
 extern const char *acpi_gbl_trs_decode[];
 extern const char *acpi_gbl_ttp_decode[];
 extern const char *acpi_gbl_typ_decode[];
+extern const char *acpi_gbl_ppc_decode[];
+extern const char *acpi_gbl_ior_decode[];
+extern const char *acpi_gbl_dts_decode[];
+extern const char *acpi_gbl_ct_decode[];
+extern const char *acpi_gbl_sbt_decode[];
+extern const char *acpi_gbl_am_decode[];
+extern const char *acpi_gbl_sm_decode[];
+extern const char *acpi_gbl_wm_decode[];
+extern const char *acpi_gbl_cph_decode[];
+extern const char *acpi_gbl_cpo_decode[];
+extern const char *acpi_gbl_dp_decode[];
+extern const char *acpi_gbl_ed_decode[];
+extern const char *acpi_gbl_bpb_decode[];
+extern const char *acpi_gbl_sb_decode[];
+extern const char *acpi_gbl_fc_decode[];
+extern const char *acpi_gbl_pt_decode[];
 #endif
 
 /* Types for Resource descriptor entries */
@@ -79,14 +95,14 @@ extern const char *acpi_gbl_typ_decode[];
 #define ACPI_SMALL_VARIABLE_LENGTH      3
 
 typedef
-acpi_status(*acpi_walk_aml_callback) (u8 * aml,
+acpi_status(*acpi_walk_aml_callback) (u8 *aml,
 				      u32 length,
 				      u32 offset,
 				      u8 resource_index, void **context);
 
 typedef
 acpi_status(*acpi_pkg_callback) (u8 object_type,
-				 union acpi_operand_object * source_object,
+				 union acpi_operand_object *source_object,
 				 union acpi_generic_state * state,
 				 void *context);
 
@@ -202,7 +218,9 @@ extern const u8 _acpi_ctype[];
 #define ACPI_IS_PRINT(c)  (_acpi_ctype[(unsigned char)(c)] & (_ACPI_LO | _ACPI_UP | _ACPI_DI | _ACPI_SP | _ACPI_PU))
 #define ACPI_IS_ALPHA(c)  (_acpi_ctype[(unsigned char)(c)] & (_ACPI_LO | _ACPI_UP))
 
-#endif				/* ACPI_USE_SYSTEM_CLIBRARY */
+#endif				/* !ACPI_USE_SYSTEM_CLIBRARY */
+
+#define ACPI_IS_ASCII(c)  ((c) < 0x80)
 
 /*
  * utcopy - Object construction and conversion interfaces
@@ -210,11 +228,11 @@ extern const u8 _acpi_ctype[];
 acpi_status
 acpi_ut_build_simple_object(union acpi_operand_object *obj,
 			    union acpi_object *user_obj,
-			    u8 * data_space, u32 * buffer_space_used);
+			    u8 *data_space, u32 *buffer_space_used);
 
 acpi_status
 acpi_ut_build_package_object(union acpi_operand_object *obj,
-			     u8 * buffer, u32 * space_used);
+			     u8 *buffer, u32 *space_used);
 
 acpi_status
 acpi_ut_copy_iobject_to_eobject(union acpi_operand_object *obj,
@@ -287,9 +305,9 @@ acpi_ut_ptr_exit(u32 line_number,
 		 const char *function_name,
 		 const char *module_name, u32 component_id, u8 *ptr);
 
-void acpi_ut_dump_buffer(u8 * buffer, u32 count, u32 display, u32 component_id);
+void acpi_ut_dump_buffer(u8 *buffer, u32 count, u32 display, u32 component_id);
 
-void acpi_ut_dump_buffer2(u8 * buffer, u32 count, u32 display);
+void acpi_ut_dump_buffer2(u8 *buffer, u32 count, u32 display);
 
 void acpi_ut_report_error(char *module_name, u32 line_number);
 
@@ -337,15 +355,15 @@ acpi_ut_execute_power_methods(struct acpi_namespace_node *device_node,
  */
 acpi_status
 acpi_ut_execute_HID(struct acpi_namespace_node *device_node,
-		    struct acpica_device_id **return_id);
+		    struct acpica_device_id ** return_id);
 
 acpi_status
 acpi_ut_execute_UID(struct acpi_namespace_node *device_node,
-		    struct acpica_device_id **return_id);
+		    struct acpica_device_id ** return_id);
 
 acpi_status
 acpi_ut_execute_CID(struct acpi_namespace_node *device_node,
-		    struct acpica_device_id_list **return_cid_list);
+		    struct acpica_device_id_list ** return_cid_list);
 
 /*
  * utlock - reader/writer locks
@@ -479,6 +497,10 @@ acpi_ut_walk_package_tree(union acpi_operand_object *source_object,
 
 void acpi_ut_strupr(char *src_string);
 
+void acpi_ut_strlwr(char *src_string);
+
+int acpi_ut_stricmp(char *string1, char *string2);
+
 void acpi_ut_print_string(char *string, u8 max_length);
 
 u8 acpi_ut_valid_acpi_name(u32 name);
@@ -487,7 +509,7 @@ void acpi_ut_repair_name(char *name);
 
 u8 acpi_ut_valid_acpi_char(char character, u32 position);
 
-acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 * ret_integer);
+acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 *ret_integer);
 
 /* Values for Base above (16=Hex, 10=Decimal) */
 
@@ -508,12 +530,12 @@ acpi_ut_display_init_pathname(u8 type,
  * utresrc
  */
 acpi_status
-acpi_ut_walk_aml_resources(u8 * aml,
+acpi_ut_walk_aml_resources(u8 *aml,
 			   acpi_size aml_length,
 			   acpi_walk_aml_callback user_function,
 			   void **context);
 
-acpi_status acpi_ut_validate_resource(void *aml, u8 * return_index);
+acpi_status acpi_ut_validate_resource(void *aml, u8 *return_index);
 
 u32 acpi_ut_get_descriptor_length(void *aml);
 
@@ -524,8 +546,7 @@ u8 acpi_ut_get_resource_header_length(void *aml);
 u8 acpi_ut_get_resource_type(void *aml);
 
 acpi_status
-acpi_ut_get_resource_end_tag(union acpi_operand_object *obj_desc,
-			     u8 ** end_tag);
+acpi_ut_get_resource_end_tag(union acpi_operand_object *obj_desc, u8 **end_tag);
 
 /*
  * utmutex - mutex support
diff --git a/drivers/acpi/acpica/utcache.c b/drivers/acpi/acpica/utcache.c
new file mode 100644
index 0000000..eacb9ba
--- /dev/null
+++ b/drivers/acpi/acpica/utcache.c
@@ -0,0 +1,323 @@
+/******************************************************************************
+ *
+ * Module Name: utcache - local cache allocation routines
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2012, Intel Corp.
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
+
+#define _COMPONENT          ACPI_UTILITIES
+ACPI_MODULE_NAME("utcache")
+
+#ifdef ACPI_USE_LOCAL_CACHE
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_os_create_cache
+ *
+ * PARAMETERS:  cache_name      - Ascii name for the cache
+ *              object_size     - Size of each cached object
+ *              max_depth       - Maximum depth of the cache (in objects)
+ *              return_cache    - Where the new cache object is returned
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Create a cache object
+ *
+ ******************************************************************************/
+acpi_status
+acpi_os_create_cache(char *cache_name,
+		     u16 object_size,
+		     u16 max_depth, struct acpi_memory_list ** return_cache)
+{
+	struct acpi_memory_list *cache;
+
+	ACPI_FUNCTION_ENTRY();
+
+	if (!cache_name || !return_cache || (object_size < 16)) {
+		return (AE_BAD_PARAMETER);
+	}
+
+	/* Create the cache object */
+
+	cache = acpi_os_allocate(sizeof(struct acpi_memory_list));
+	if (!cache) {
+		return (AE_NO_MEMORY);
+	}
+
+	/* Populate the cache object and return it */
+
+	ACPI_MEMSET(cache, 0, sizeof(struct acpi_memory_list));
+	cache->link_offset = 8;
+	cache->list_name = cache_name;
+	cache->object_size = object_size;
+	cache->max_depth = max_depth;
+
+	*return_cache = cache;
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_os_purge_cache
+ *
+ * PARAMETERS:  cache           - Handle to cache object
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Free all objects within the requested cache.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_os_purge_cache(struct acpi_memory_list * cache)
+{
+	char *next;
+	acpi_status status;
+
+	ACPI_FUNCTION_ENTRY();
+
+	if (!cache) {
+		return (AE_BAD_PARAMETER);
+	}
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_CACHES);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	/* Walk the list of objects in this cache */
+
+	while (cache->list_head) {
+
+		/* Delete and unlink one cached state object */
+
+		next = *(ACPI_CAST_INDIRECT_PTR(char,
+						&(((char *)cache->
+						   list_head)[cache->
+							      link_offset])));
+		ACPI_FREE(cache->list_head);
+
+		cache->list_head = next;
+		cache->current_depth--;
+	}
+
+	(void)acpi_ut_release_mutex(ACPI_MTX_CACHES);
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_os_delete_cache
+ *
+ * PARAMETERS:  cache           - Handle to cache object
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Free all objects within the requested cache and delete the
+ *              cache object.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_os_delete_cache(struct acpi_memory_list * cache)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_ENTRY();
+
+	/* Purge all objects in the cache */
+
+	status = acpi_os_purge_cache(cache);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	/* Now we can delete the cache object */
+
+	acpi_os_free(cache);
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_os_release_object
+ *
+ * PARAMETERS:  cache       - Handle to cache object
+ *              object      - The object to be released
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Release an object to the specified cache.  If cache is full,
+ *              the object is deleted.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_os_release_object(struct acpi_memory_list * cache, void *object)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_ENTRY();
+
+	if (!cache || !object) {
+		return (AE_BAD_PARAMETER);
+	}
+
+	/* If cache is full, just free this object */
+
+	if (cache->current_depth >= cache->max_depth) {
+		ACPI_FREE(object);
+		ACPI_MEM_TRACKING(cache->total_freed++);
+	}
+
+	/* Otherwise put this object back into the cache */
+
+	else {
+		status = acpi_ut_acquire_mutex(ACPI_MTX_CACHES);
+		if (ACPI_FAILURE(status)) {
+			return (status);
+		}
+
+		/* Mark the object as cached */
+
+		ACPI_MEMSET(object, 0xCA, cache->object_size);
+		ACPI_SET_DESCRIPTOR_TYPE(object, ACPI_DESC_TYPE_CACHED);
+
+		/* Put the object at the head of the cache list */
+
+		*(ACPI_CAST_INDIRECT_PTR(char,
+					 &(((char *)object)[cache->
+							    link_offset]))) =
+		    cache->list_head;
+		cache->list_head = object;
+		cache->current_depth++;
+
+		(void)acpi_ut_release_mutex(ACPI_MTX_CACHES);
+	}
+
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_os_acquire_object
+ *
+ * PARAMETERS:  cache           - Handle to cache object
+ *
+ * RETURN:      the acquired object.  NULL on error
+ *
+ * DESCRIPTION: Get an object from the specified cache.  If cache is empty,
+ *              the object is allocated.
+ *
+ ******************************************************************************/
+
+void *acpi_os_acquire_object(struct acpi_memory_list *cache)
+{
+	acpi_status status;
+	void *object;
+
+	ACPI_FUNCTION_NAME(os_acquire_object);
+
+	if (!cache) {
+		return (NULL);
+	}
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_CACHES);
+	if (ACPI_FAILURE(status)) {
+		return (NULL);
+	}
+
+	ACPI_MEM_TRACKING(cache->requests++);
+
+	/* Check the cache first */
+
+	if (cache->list_head) {
+
+		/* There is an object available, use it */
+
+		object = cache->list_head;
+		cache->list_head = *(ACPI_CAST_INDIRECT_PTR(char,
+							    &(((char *)
+							       object)[cache->
+								       link_offset])));
+
+		cache->current_depth--;
+
+		ACPI_MEM_TRACKING(cache->hits++);
+		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
+				  "Object %p from %s cache\n", object,
+				  cache->list_name));
+
+		status = acpi_ut_release_mutex(ACPI_MTX_CACHES);
+		if (ACPI_FAILURE(status)) {
+			return (NULL);
+		}
+
+		/* Clear (zero) the previously used Object */
+
+		ACPI_MEMSET(object, 0, cache->object_size);
+	} else {
+		/* The cache is empty, create a new object */
+
+		ACPI_MEM_TRACKING(cache->total_allocated++);
+
+#ifdef ACPI_DBG_TRACK_ALLOCATIONS
+		if ((cache->total_allocated - cache->total_freed) >
+		    cache->max_occupied) {
+			cache->max_occupied =
+			    cache->total_allocated - cache->total_freed;
+		}
+#endif
+
+		/* Avoid deadlock with ACPI_ALLOCATE_ZEROED */
+
+		status = acpi_ut_release_mutex(ACPI_MTX_CACHES);
+		if (ACPI_FAILURE(status)) {
+			return (NULL);
+		}
+
+		object = ACPI_ALLOCATE_ZEROED(cache->object_size);
+		if (!object) {
+			return (NULL);
+		}
+	}
+
+	return (object);
+}
+#endif				/* ACPI_USE_LOCAL_CACHE */
diff --git a/drivers/acpi/acpica/utclib.c b/drivers/acpi/acpica/utclib.c
new file mode 100644
index 0000000..f887f93
--- /dev/null
+++ b/drivers/acpi/acpica/utclib.c
@@ -0,0 +1,748 @@
+/******************************************************************************
+ *
+ * Module Name: cmclib - Local implementation of C library functions
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2012, Intel Corp.
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
+
+/*
+ * These implementations of standard C Library routines can optionally be
+ * used if a C library is not available.  In general, they are less efficient
+ * than an inline or assembly implementation
+ */
+
+#define _COMPONENT          ACPI_UTILITIES
+ACPI_MODULE_NAME("cmclib")
+
+#ifndef ACPI_USE_SYSTEM_CLIBRARY
+#define NEGATIVE    1
+#define POSITIVE    0
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_memcmp (memcmp)
+ *
+ * PARAMETERS:  buffer1         - First Buffer
+ *              buffer2         - Second Buffer
+ *              count           - Maximum # of bytes to compare
+ *
+ * RETURN:      Index where Buffers mismatched, or 0 if Buffers matched
+ *
+ * DESCRIPTION: Compare two Buffers, with a maximum length
+ *
+ ******************************************************************************/
+int acpi_ut_memcmp(const char *buffer1, const char *buffer2, acpi_size count)
+{
+
+	return ((count == ACPI_SIZE_MAX) ? 0 : ((unsigned char)*buffer1 -
+						(unsigned char)*buffer2));
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_memcpy (memcpy)
+ *
+ * PARAMETERS:  dest        - Target of the copy
+ *              src         - Source buffer to copy
+ *              count       - Number of bytes to copy
+ *
+ * RETURN:      Dest
+ *
+ * DESCRIPTION: Copy arbitrary bytes of memory
+ *
+ ******************************************************************************/
+
+void *acpi_ut_memcpy(void *dest, const void *src, acpi_size count)
+{
+	char *new = (char *)dest;
+	char *old = (char *)src;
+
+	while (count) {
+		*new = *old;
+		new++;
+		old++;
+		count--;
+	}
+
+	return (dest);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_memset (memset)
+ *
+ * PARAMETERS:  dest        - Buffer to set
+ *              value       - Value to set each byte of memory
+ *              count       - Number of bytes to set
+ *
+ * RETURN:      Dest
+ *
+ * DESCRIPTION: Initialize a buffer to a known value.
+ *
+ ******************************************************************************/
+
+void *acpi_ut_memset(void *dest, u8 value, acpi_size count)
+{
+	char *new = (char *)dest;
+
+	while (count) {
+		*new = (char)value;
+		new++;
+		count--;
+	}
+
+	return (dest);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_strlen (strlen)
+ *
+ * PARAMETERS:  string              - Null terminated string
+ *
+ * RETURN:      Length
+ *
+ * DESCRIPTION: Returns the length of the input string
+ *
+ ******************************************************************************/
+
+acpi_size acpi_ut_strlen(const char *string)
+{
+	u32 length = 0;
+
+	/* Count the string until a null is encountered */
+
+	while (*string) {
+		length++;
+		string++;
+	}
+
+	return (length);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_strcpy (strcpy)
+ *
+ * PARAMETERS:  dst_string      - Target of the copy
+ *              src_string      - The source string to copy
+ *
+ * RETURN:      dst_string
+ *
+ * DESCRIPTION: Copy a null terminated string
+ *
+ ******************************************************************************/
+
+char *acpi_ut_strcpy(char *dst_string, const char *src_string)
+{
+	char *string = dst_string;
+
+	/* Move bytes brute force */
+
+	while (*src_string) {
+		*string = *src_string;
+
+		string++;
+		src_string++;
+	}
+
+	/* Null terminate */
+
+	*string = 0;
+	return (dst_string);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_strncpy (strncpy)
+ *
+ * PARAMETERS:  dst_string      - Target of the copy
+ *              src_string      - The source string to copy
+ *              count           - Maximum # of bytes to copy
+ *
+ * RETURN:      dst_string
+ *
+ * DESCRIPTION: Copy a null terminated string, with a maximum length
+ *
+ ******************************************************************************/
+
+char *acpi_ut_strncpy(char *dst_string, const char *src_string, acpi_size count)
+{
+	char *string = dst_string;
+
+	/* Copy the string */
+
+	for (string = dst_string;
+	     count && (count--, (*string++ = *src_string++));) {;
+	}
+
+	/* Pad with nulls if necessary */
+
+	while (count--) {
+		*string = 0;
+		string++;
+	}
+
+	/* Return original pointer */
+
+	return (dst_string);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_strcmp (strcmp)
+ *
+ * PARAMETERS:  string1         - First string
+ *              string2         - Second string
+ *
+ * RETURN:      Index where strings mismatched, or 0 if strings matched
+ *
+ * DESCRIPTION: Compare two null terminated strings
+ *
+ ******************************************************************************/
+
+int acpi_ut_strcmp(const char *string1, const char *string2)
+{
+
+	for (; (*string1 == *string2); string2++) {
+		if (!*string1++) {
+			return (0);
+		}
+	}
+
+	return ((unsigned char)*string1 - (unsigned char)*string2);
+}
+
+#ifdef ACPI_FUTURE_IMPLEMENTATION
+/* Not used at this time */
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_strchr (strchr)
+ *
+ * PARAMETERS:  string          - Search string
+ *              ch              - character to search for
+ *
+ * RETURN:      Ptr to char or NULL if not found
+ *
+ * DESCRIPTION: Search a string for a character
+ *
+ ******************************************************************************/
+
+char *acpi_ut_strchr(const char *string, int ch)
+{
+
+	for (; (*string); string++) {
+		if ((*string) == (char)ch) {
+			return ((char *)string);
+		}
+	}
+
+	return (NULL);
+}
+#endif
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_strncmp (strncmp)
+ *
+ * PARAMETERS:  string1         - First string
+ *              string2         - Second string
+ *              count           - Maximum # of bytes to compare
+ *
+ * RETURN:      Index where strings mismatched, or 0 if strings matched
+ *
+ * DESCRIPTION: Compare two null terminated strings, with a maximum length
+ *
+ ******************************************************************************/
+
+int acpi_ut_strncmp(const char *string1, const char *string2, acpi_size count)
+{
+
+	for (; count-- && (*string1 == *string2); string2++) {
+		if (!*string1++) {
+			return (0);
+		}
+	}
+
+	return ((count == ACPI_SIZE_MAX) ? 0 : ((unsigned char)*string1 -
+						(unsigned char)*string2));
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_strcat (Strcat)
+ *
+ * PARAMETERS:  dst_string      - Target of the copy
+ *              src_string      - The source string to copy
+ *
+ * RETURN:      dst_string
+ *
+ * DESCRIPTION: Append a null terminated string to a null terminated string
+ *
+ ******************************************************************************/
+
+char *acpi_ut_strcat(char *dst_string, const char *src_string)
+{
+	char *string;
+
+	/* Find end of the destination string */
+
+	for (string = dst_string; *string++;) {;
+	}
+
+	/* Concatenate the string */
+
+	for (--string; (*string++ = *src_string++);) {;
+	}
+
+	return (dst_string);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_strncat (strncat)
+ *
+ * PARAMETERS:  dst_string      - Target of the copy
+ *              src_string      - The source string to copy
+ *              count           - Maximum # of bytes to copy
+ *
+ * RETURN:      dst_string
+ *
+ * DESCRIPTION: Append a null terminated string to a null terminated string,
+ *              with a maximum count.
+ *
+ ******************************************************************************/
+
+char *acpi_ut_strncat(char *dst_string, const char *src_string, acpi_size count)
+{
+	char *string;
+
+	if (count) {
+
+		/* Find end of the destination string */
+
+		for (string = dst_string; *string++;) {;
+		}
+
+		/* Concatenate the string */
+
+		for (--string; (*string++ = *src_string++) && --count;) {;
+		}
+
+		/* Null terminate if necessary */
+
+		if (!count) {
+			*string = 0;
+		}
+	}
+
+	return (dst_string);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_strstr (strstr)
+ *
+ * PARAMETERS:  string1         - Target string
+ *              string2         - Substring to search for
+ *
+ * RETURN:      Where substring match starts, Null if no match found
+ *
+ * DESCRIPTION: Checks if String2 occurs in String1. This is not really a
+ *              full implementation of strstr, only sufficient for command
+ *              matching
+ *
+ ******************************************************************************/
+
+char *acpi_ut_strstr(char *string1, char *string2)
+{
+	char *string;
+
+	if (acpi_ut_strlen(string2) > acpi_ut_strlen(string1)) {
+		return (NULL);
+	}
+
+	/* Walk entire string, comparing the letters */
+
+	for (string = string1; *string2;) {
+		if (*string2 != *string) {
+			return (NULL);
+		}
+
+		string2++;
+		string++;
+	}
+
+	return (string1);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_strtoul (strtoul)
+ *
+ * PARAMETERS:  string          - Null terminated string
+ *              terminater      - Where a pointer to the terminating byte is
+ *                                returned
+ *              base            - Radix of the string
+ *
+ * RETURN:      Converted value
+ *
+ * DESCRIPTION: Convert a string into a 32-bit unsigned value.
+ *              Note: use acpi_ut_strtoul64 for 64-bit integers.
+ *
+ ******************************************************************************/
+
+u32 acpi_ut_strtoul(const char *string, char **terminator, u32 base)
+{
+	u32 converted = 0;
+	u32 index;
+	u32 sign;
+	const char *string_start;
+	u32 return_value = 0;
+	acpi_status status = AE_OK;
+
+	/*
+	 * Save the value of the pointer to the buffer's first
+	 * character, save the current errno value, and then
+	 * skip over any white space in the buffer:
+	 */
+	string_start = string;
+	while (ACPI_IS_SPACE(*string) || *string == '\t') {
+		++string;
+	}
+
+	/*
+	 * The buffer may contain an optional plus or minus sign.
+	 * If it does, then skip over it but remember what is was:
+	 */
+	if (*string == '-') {
+		sign = NEGATIVE;
+		++string;
+	} else if (*string == '+') {
+		++string;
+		sign = POSITIVE;
+	} else {
+		sign = POSITIVE;
+	}
+
+	/*
+	 * If the input parameter Base is zero, then we need to
+	 * determine if it is octal, decimal, or hexadecimal:
+	 */
+	if (base == 0) {
+		if (*string == '0') {
+			if (acpi_ut_to_lower(*(++string)) == 'x') {
+				base = 16;
+				++string;
+			} else {
+				base = 8;
+			}
+		} else {
+			base = 10;
+		}
+	} else if (base < 2 || base > 36) {
+		/*
+		 * The specified Base parameter is not in the domain of
+		 * this function:
+		 */
+		goto done;
+	}
+
+	/*
+	 * For octal and hexadecimal bases, skip over the leading
+	 * 0 or 0x, if they are present.
+	 */
+	if (base == 8 && *string == '0') {
+		string++;
+	}
+
+	if (base == 16 &&
+	    *string == '0' && acpi_ut_to_lower(*(++string)) == 'x') {
+		string++;
+	}
+
+	/*
+	 * Main loop: convert the string to an unsigned long:
+	 */
+	while (*string) {
+		if (ACPI_IS_DIGIT(*string)) {
+			index = (u32)((u8)*string - '0');
+		} else {
+			index = (u32)acpi_ut_to_upper(*string);
+			if (ACPI_IS_UPPER(index)) {
+				index = index - 'A' + 10;
+			} else {
+				goto done;
+			}
+		}
+
+		if (index >= base) {
+			goto done;
+		}
+
+		/*
+		 * Check to see if value is out of range:
+		 */
+
+		if (return_value > ((ACPI_UINT32_MAX - (u32)index) / (u32)base)) {
+			status = AE_ERROR;
+			return_value = 0;	/* reset */
+		} else {
+			return_value *= base;
+			return_value += index;
+			converted = 1;
+		}
+
+		++string;
+	}
+
+      done:
+	/*
+	 * If appropriate, update the caller's pointer to the next
+	 * unconverted character in the buffer.
+	 */
+	if (terminator) {
+		if (converted == 0 && return_value == 0 && string != NULL) {
+			*terminator = (char *)string_start;
+		} else {
+			*terminator = (char *)string;
+		}
+	}
+
+	if (status == AE_ERROR) {
+		return_value = ACPI_UINT32_MAX;
+	}
+
+	/*
+	 * If a minus sign was present, then "the conversion is negated":
+	 */
+	if (sign == NEGATIVE) {
+		return_value = (ACPI_UINT32_MAX - return_value) + 1;
+	}
+
+	return (return_value);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_to_upper (TOUPPER)
+ *
+ * PARAMETERS:  c           - Character to convert
+ *
+ * RETURN:      Converted character as an int
+ *
+ * DESCRIPTION: Convert character to uppercase
+ *
+ ******************************************************************************/
+
+int acpi_ut_to_upper(int c)
+{
+
+	return (ACPI_IS_LOWER(c) ? ((c) - 0x20) : (c));
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_to_lower (TOLOWER)
+ *
+ * PARAMETERS:  c           - Character to convert
+ *
+ * RETURN:      Converted character as an int
+ *
+ * DESCRIPTION: Convert character to lowercase
+ *
+ ******************************************************************************/
+
+int acpi_ut_to_lower(int c)
+{
+
+	return (ACPI_IS_UPPER(c) ? ((c) + 0x20) : (c));
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    is* functions
+ *
+ * DESCRIPTION: is* functions use the ctype table below
+ *
+ ******************************************************************************/
+
+const u8 _acpi_ctype[257] = {
+	_ACPI_CN,		/* 0x0      0.     */
+	_ACPI_CN,		/* 0x1      1.     */
+	_ACPI_CN,		/* 0x2      2.     */
+	_ACPI_CN,		/* 0x3      3.     */
+	_ACPI_CN,		/* 0x4      4.     */
+	_ACPI_CN,		/* 0x5      5.     */
+	_ACPI_CN,		/* 0x6      6.     */
+	_ACPI_CN,		/* 0x7      7.     */
+	_ACPI_CN,		/* 0x8      8.     */
+	_ACPI_CN | _ACPI_SP,	/* 0x9      9.     */
+	_ACPI_CN | _ACPI_SP,	/* 0xA     10.     */
+	_ACPI_CN | _ACPI_SP,	/* 0xB     11.     */
+	_ACPI_CN | _ACPI_SP,	/* 0xC     12.     */
+	_ACPI_CN | _ACPI_SP,	/* 0xD     13.     */
+	_ACPI_CN,		/* 0xE     14.     */
+	_ACPI_CN,		/* 0xF     15.     */
+	_ACPI_CN,		/* 0x10    16.     */
+	_ACPI_CN,		/* 0x11    17.     */
+	_ACPI_CN,		/* 0x12    18.     */
+	_ACPI_CN,		/* 0x13    19.     */
+	_ACPI_CN,		/* 0x14    20.     */
+	_ACPI_CN,		/* 0x15    21.     */
+	_ACPI_CN,		/* 0x16    22.     */
+	_ACPI_CN,		/* 0x17    23.     */
+	_ACPI_CN,		/* 0x18    24.     */
+	_ACPI_CN,		/* 0x19    25.     */
+	_ACPI_CN,		/* 0x1A    26.     */
+	_ACPI_CN,		/* 0x1B    27.     */
+	_ACPI_CN,		/* 0x1C    28.     */
+	_ACPI_CN,		/* 0x1D    29.     */
+	_ACPI_CN,		/* 0x1E    30.     */
+	_ACPI_CN,		/* 0x1F    31.     */
+	_ACPI_XS | _ACPI_SP,	/* 0x20    32. ' ' */
+	_ACPI_PU,		/* 0x21    33. '!' */
+	_ACPI_PU,		/* 0x22    34. '"' */
+	_ACPI_PU,		/* 0x23    35. '#' */
+	_ACPI_PU,		/* 0x24    36. '$' */
+	_ACPI_PU,		/* 0x25    37. '%' */
+	_ACPI_PU,		/* 0x26    38. '&' */
+	_ACPI_PU,		/* 0x27    39. ''' */
+	_ACPI_PU,		/* 0x28    40. '(' */
+	_ACPI_PU,		/* 0x29    41. ')' */
+	_ACPI_PU,		/* 0x2A    42. '*' */
+	_ACPI_PU,		/* 0x2B    43. '+' */
+	_ACPI_PU,		/* 0x2C    44. ',' */
+	_ACPI_PU,		/* 0x2D    45. '-' */
+	_ACPI_PU,		/* 0x2E    46. '.' */
+	_ACPI_PU,		/* 0x2F    47. '/' */
+	_ACPI_XD | _ACPI_DI,	/* 0x30    48. '0' */
+	_ACPI_XD | _ACPI_DI,	/* 0x31    49. '1' */
+	_ACPI_XD | _ACPI_DI,	/* 0x32    50. '2' */
+	_ACPI_XD | _ACPI_DI,	/* 0x33    51. '3' */
+	_ACPI_XD | _ACPI_DI,	/* 0x34    52. '4' */
+	_ACPI_XD | _ACPI_DI,	/* 0x35    53. '5' */
+	_ACPI_XD | _ACPI_DI,	/* 0x36    54. '6' */
+	_ACPI_XD | _ACPI_DI,	/* 0x37    55. '7' */
+	_ACPI_XD | _ACPI_DI,	/* 0x38    56. '8' */
+	_ACPI_XD | _ACPI_DI,	/* 0x39    57. '9' */
+	_ACPI_PU,		/* 0x3A    58. ':' */
+	_ACPI_PU,		/* 0x3B    59. ';' */
+	_ACPI_PU,		/* 0x3C    60. '<' */
+	_ACPI_PU,		/* 0x3D    61. '=' */
+	_ACPI_PU,		/* 0x3E    62. '>' */
+	_ACPI_PU,		/* 0x3F    63. '?' */
+	_ACPI_PU,		/* 0x40    64. '@' */
+	_ACPI_XD | _ACPI_UP,	/* 0x41    65. 'A' */
+	_ACPI_XD | _ACPI_UP,	/* 0x42    66. 'B' */
+	_ACPI_XD | _ACPI_UP,	/* 0x43    67. 'C' */
+	_ACPI_XD | _ACPI_UP,	/* 0x44    68. 'D' */
+	_ACPI_XD | _ACPI_UP,	/* 0x45    69. 'E' */
+	_ACPI_XD | _ACPI_UP,	/* 0x46    70. 'F' */
+	_ACPI_UP,		/* 0x47    71. 'G' */
+	_ACPI_UP,		/* 0x48    72. 'H' */
+	_ACPI_UP,		/* 0x49    73. 'I' */
+	_ACPI_UP,		/* 0x4A    74. 'J' */
+	_ACPI_UP,		/* 0x4B    75. 'K' */
+	_ACPI_UP,		/* 0x4C    76. 'L' */
+	_ACPI_UP,		/* 0x4D    77. 'M' */
+	_ACPI_UP,		/* 0x4E    78. 'N' */
+	_ACPI_UP,		/* 0x4F    79. 'O' */
+	_ACPI_UP,		/* 0x50    80. 'P' */
+	_ACPI_UP,		/* 0x51    81. 'Q' */
+	_ACPI_UP,		/* 0x52    82. 'R' */
+	_ACPI_UP,		/* 0x53    83. 'S' */
+	_ACPI_UP,		/* 0x54    84. 'T' */
+	_ACPI_UP,		/* 0x55    85. 'U' */
+	_ACPI_UP,		/* 0x56    86. 'V' */
+	_ACPI_UP,		/* 0x57    87. 'W' */
+	_ACPI_UP,		/* 0x58    88. 'X' */
+	_ACPI_UP,		/* 0x59    89. 'Y' */
+	_ACPI_UP,		/* 0x5A    90. 'Z' */
+	_ACPI_PU,		/* 0x5B    91. '[' */
+	_ACPI_PU,		/* 0x5C    92. '\' */
+	_ACPI_PU,		/* 0x5D    93. ']' */
+	_ACPI_PU,		/* 0x5E    94. '^' */
+	_ACPI_PU,		/* 0x5F    95. '_' */
+	_ACPI_PU,		/* 0x60    96. '`' */
+	_ACPI_XD | _ACPI_LO,	/* 0x61    97. 'a' */
+	_ACPI_XD | _ACPI_LO,	/* 0x62    98. 'b' */
+	_ACPI_XD | _ACPI_LO,	/* 0x63    99. 'c' */
+	_ACPI_XD | _ACPI_LO,	/* 0x64   100. 'd' */
+	_ACPI_XD | _ACPI_LO,	/* 0x65   101. 'e' */
+	_ACPI_XD | _ACPI_LO,	/* 0x66   102. 'f' */
+	_ACPI_LO,		/* 0x67   103. 'g' */
+	_ACPI_LO,		/* 0x68   104. 'h' */
+	_ACPI_LO,		/* 0x69   105. 'i' */
+	_ACPI_LO,		/* 0x6A   106. 'j' */
+	_ACPI_LO,		/* 0x6B   107. 'k' */
+	_ACPI_LO,		/* 0x6C   108. 'l' */
+	_ACPI_LO,		/* 0x6D   109. 'm' */
+	_ACPI_LO,		/* 0x6E   110. 'n' */
+	_ACPI_LO,		/* 0x6F   111. 'o' */
+	_ACPI_LO,		/* 0x70   112. 'p' */
+	_ACPI_LO,		/* 0x71   113. 'q' */
+	_ACPI_LO,		/* 0x72   114. 'r' */
+	_ACPI_LO,		/* 0x73   115. 's' */
+	_ACPI_LO,		/* 0x74   116. 't' */
+	_ACPI_LO,		/* 0x75   117. 'u' */
+	_ACPI_LO,		/* 0x76   118. 'v' */
+	_ACPI_LO,		/* 0x77   119. 'w' */
+	_ACPI_LO,		/* 0x78   120. 'x' */
+	_ACPI_LO,		/* 0x79   121. 'y' */
+	_ACPI_LO,		/* 0x7A   122. 'z' */
+	_ACPI_PU,		/* 0x7B   123. '{' */
+	_ACPI_PU,		/* 0x7C   124. '|' */
+	_ACPI_PU,		/* 0x7D   125. '}' */
+	_ACPI_PU,		/* 0x7E   126. '~' */
+	_ACPI_CN,		/* 0x7F   127.     */
+
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 0x80 to 0x8F    */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 0x90 to 0x9F    */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 0xA0 to 0xAF    */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 0xB0 to 0xBF    */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 0xC0 to 0xCF    */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 0xD0 to 0xDF    */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 0xE0 to 0xEF    */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0	/* 0xF0 to 0x100   */
+};
+
+#endif				/* ACPI_USE_SYSTEM_CLIBRARY */
diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index e810894..6e3ae6a 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -47,8 +47,9 @@
 
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utdebug")
+
 #ifdef ACPI_DEBUG_OUTPUT
-static acpi_thread_id acpi_gbl_prev_thread_id;
+static acpi_thread_id acpi_gbl_prev_thread_id = (acpi_thread_id) 0xFFFFFFFF;
 static char *acpi_gbl_fn_entry_str = "----Entry";
 static char *acpi_gbl_fn_exit_str = "----Exit-";
 
@@ -109,7 +110,7 @@ void acpi_ut_track_stack_ptr(void)
  * RETURN:      Updated pointer to the function name
  *
  * DESCRIPTION: Remove the "Acpi" prefix from the function name, if present.
- *              This allows compiler macros such as __func__ to be used
+ *              This allows compiler macros such as __FUNCTION__ to be used
  *              with no change to the debug output.
  *
  ******************************************************************************/
@@ -519,7 +520,7 @@ acpi_ut_ptr_exit(u32 line_number,
  *
  ******************************************************************************/
 
-void acpi_ut_dump_buffer2(u8 * buffer, u32 count, u32 display)
+void acpi_ut_dump_buffer2(u8 *buffer, u32 count, u32 display)
 {
 	u32 i = 0;
 	u32 j;
@@ -636,7 +637,7 @@ void acpi_ut_dump_buffer2(u8 * buffer, u32 count, u32 display)
  *
  ******************************************************************************/
 
-void acpi_ut_dump_buffer(u8 * buffer, u32 count, u32 display, u32 component_id)
+void acpi_ut_dump_buffer(u8 *buffer, u32 count, u32 display, u32 component_id)
 {
 
 	/* Only dump the buffer if tracing is enabled */
diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
index d179f0e..beea1d4 100644
--- a/drivers/acpi/acpica/utmisc.c
+++ b/drivers/acpi/acpica/utmisc.c
@@ -41,8 +41,6 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
-#include <linux/module.h>
-
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "acnamesp.h"
@@ -201,8 +199,8 @@ acpi_status acpi_ut_allocate_owner_id(acpi_owner_id * owner_id)
 				 */
 				acpi_gbl_owner_id_mask[j] |= (1 << k);
 
-				acpi_gbl_last_owner_id_index = (u8) j;
-				acpi_gbl_next_owner_id_offset = (u8) (k + 1);
+				acpi_gbl_last_owner_id_index = (u8)j;
+				acpi_gbl_next_owner_id_offset = (u8)(k + 1);
 
 				/*
 				 * Construct encoded ID from the index and bit position
@@ -339,6 +337,73 @@ void acpi_ut_strupr(char *src_string)
 	return;
 }
 
+#ifdef ACPI_ASL_COMPILER
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_strlwr (strlwr)
+ *
+ * PARAMETERS:  src_string      - The source string to convert
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Convert string to lowercase
+ *
+ * NOTE: This is not a POSIX function, so it appears here, not in utclib.c
+ *
+ ******************************************************************************/
+
+void acpi_ut_strlwr(char *src_string)
+{
+	char *string;
+
+	ACPI_FUNCTION_ENTRY();
+
+	if (!src_string) {
+		return;
+	}
+
+	/* Walk entire string, lowercasing the letters */
+
+	for (string = src_string; *string; string++) {
+		*string = (char)ACPI_TOLOWER(*string);
+	}
+
+	return;
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_stricmp
+ *
+ * PARAMETERS:  string1             - first string to compare
+ *              string2             - second string to compare
+ *
+ * RETURN:      int that signifies string relationship. Zero means strings
+ *              are equal.
+ *
+ * DESCRIPTION: Implementation of the non-ANSI stricmp function (compare
+ *              strings with no case sensitivity)
+ *
+ ******************************************************************************/
+
+int acpi_ut_stricmp(char *string1, char *string2)
+{
+	int c1;
+	int c2;
+
+	do {
+		c1 = tolower((int)*string1);
+		c2 = tolower((int)*string2);
+
+		string1++;
+		string2++;
+	}
+	while ((c1 == c2) && (c1));
+
+	return (c1 - c2);
+}
+#endif
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_print_string
@@ -638,7 +703,16 @@ u8 acpi_ut_valid_acpi_name(u32 name)
  * RETURN:      Repaired version of the name
  *
  * DESCRIPTION: Repair an ACPI name: Change invalid characters to '*' and
- *              return the new name.
+ *              return the new name. NOTE: the Name parameter must reside in
+ *              read/write memory, cannot be a const.
+ *
+ * An ACPI Name must consist of valid ACPI characters. We will repair the name
+ * if necessary because we don't want to abort because of this, but we want
+ * all namespace names to be printable. A warning message is appropriate.
+ *
+ * This issue came up because there are in fact machines that exhibit
+ * this problem, and we want to be able to enable ACPI support for them,
+ * even though there are a few bad names.
  *
  ******************************************************************************/
 
@@ -699,7 +773,7 @@ void acpi_ut_repair_name(char *name)
  *
  ******************************************************************************/
 
-acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 * ret_integer)
+acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 *ret_integer)
 {
 	u32 this_digit = 0;
 	u64 return_value = 0;
@@ -772,14 +846,14 @@ acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 * ret_integer)
 
 			/* Convert ASCII 0-9 to Decimal value */
 
-			this_digit = ((u8) * string) - '0';
+			this_digit = ((u8)*string) - '0';
 		} else if (base == 10) {
 
 			/* Digit is out of range; possible in to_integer case only */
 
 			term = 1;
 		} else {
-			this_digit = (u8) ACPI_TOUPPER(*string);
+			this_digit = (u8)ACPI_TOUPPER(*string);
 			if (ACPI_IS_XDIGIT((char)this_digit)) {
 
 				/* Convert ASCII Hex char to value */
@@ -806,8 +880,9 @@ acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 * ret_integer)
 
 		valid_digits++;
 
-		if (sign_of0x && ((valid_digits > 16)
-				  || ((valid_digits > 8) && mode32))) {
+		if (sign_of0x
+		    && ((valid_digits > 16)
+			|| ((valid_digits > 8) && mode32))) {
 			/*
 			 * This is to_integer operation case.
 			 * No any restrictions for string-to-integer conversion,
@@ -818,7 +893,7 @@ acpi_status acpi_ut_strtoul64(char *string, u32 base, u64 * ret_integer)
 
 		/* Divide the digit into the correct position */
 
-		(void)acpi_ut_short_divide((dividend - (u64) this_digit),
+		(void)acpi_ut_short_divide((dividend - (u64)this_digit),
 					   base, &quotient, NULL);
 
 		if (return_value > quotient) {
@@ -908,7 +983,7 @@ acpi_ut_create_update_state_and_push(union acpi_operand_object *object,
  ******************************************************************************/
 
 acpi_status
-acpi_ut_walk_package_tree(union acpi_operand_object * source_object,
+acpi_ut_walk_package_tree(union acpi_operand_object *source_object,
 			  void *target_object,
 			  acpi_pkg_callback walk_callback, void *context)
 {
diff --git a/drivers/acpi/acpica/uttrack.c b/drivers/acpi/acpica/uttrack.c
new file mode 100644
index 0000000..73ca27d
--- /dev/null
+++ b/drivers/acpi/acpica/uttrack.c
@@ -0,0 +1,650 @@
+/******************************************************************************
+ *
+ * Module Name: uttrack - Memory allocation tracking routines (debug only)
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2012, Intel Corp.
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
+/*
+ * These procedures are used for tracking memory leaks in the subsystem, and
+ * they get compiled out when the ACPI_DBG_TRACK_ALLOCATIONS is not set.
+ *
+ * Each memory allocation is tracked via a doubly linked list.  Each
+ * element contains the caller's component, module name, function name, and
+ * line number.  acpi_ut_allocate and acpi_ut_allocate_zeroed call
+ * acpi_ut_track_allocation to add an element to the list; deletion
+ * occurs in the body of acpi_ut_free.
+ */
+
+#include <acpi/acpi.h>
+#include "accommon.h"
+
+#ifdef ACPI_DBG_TRACK_ALLOCATIONS
+
+#define _COMPONENT          ACPI_UTILITIES
+ACPI_MODULE_NAME("uttrack")
+
+/* Local prototypes */
+static struct acpi_debug_mem_block *acpi_ut_find_allocation(void *allocation);
+
+static acpi_status
+acpi_ut_track_allocation(struct acpi_debug_mem_block *address,
+			 acpi_size size,
+			 u8 alloc_type,
+			 u32 component, const char *module, u32 line);
+
+static acpi_status
+acpi_ut_remove_allocation(struct acpi_debug_mem_block *address,
+			  u32 component, const char *module, u32 line);
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_create_list
+ *
+ * PARAMETERS:  cache_name      - Ascii name for the cache
+ *              object_size     - Size of each cached object
+ *              return_cache    - Where the new cache object is returned
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Create a local memory list for tracking purposed
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_ut_create_list(char *list_name,
+		    u16 object_size, struct acpi_memory_list **return_cache)
+{
+	struct acpi_memory_list *cache;
+
+	cache = acpi_os_allocate(sizeof(struct acpi_memory_list));
+	if (!cache) {
+		return (AE_NO_MEMORY);
+	}
+
+	ACPI_MEMSET(cache, 0, sizeof(struct acpi_memory_list));
+
+	cache->list_name = list_name;
+	cache->object_size = object_size;
+
+	*return_cache = cache;
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_allocate_and_track
+ *
+ * PARAMETERS:  size                - Size of the allocation
+ *              component           - Component type of caller
+ *              module              - Source file name of caller
+ *              line                - Line number of caller
+ *
+ * RETURN:      Address of the allocated memory on success, NULL on failure.
+ *
+ * DESCRIPTION: The subsystem's equivalent of malloc.
+ *
+ ******************************************************************************/
+
+void *acpi_ut_allocate_and_track(acpi_size size,
+				 u32 component, const char *module, u32 line)
+{
+	struct acpi_debug_mem_block *allocation;
+	acpi_status status;
+
+	allocation =
+	    acpi_ut_allocate(size + sizeof(struct acpi_debug_mem_header),
+			     component, module, line);
+	if (!allocation) {
+		return (NULL);
+	}
+
+	status = acpi_ut_track_allocation(allocation, size,
+					  ACPI_MEM_MALLOC, component, module,
+					  line);
+	if (ACPI_FAILURE(status)) {
+		acpi_os_free(allocation);
+		return (NULL);
+	}
+
+	acpi_gbl_global_list->total_allocated++;
+	acpi_gbl_global_list->total_size += (u32)size;
+	acpi_gbl_global_list->current_total_size += (u32)size;
+	if (acpi_gbl_global_list->current_total_size >
+	    acpi_gbl_global_list->max_occupied) {
+		acpi_gbl_global_list->max_occupied =
+		    acpi_gbl_global_list->current_total_size;
+	}
+
+	return ((void *)&allocation->user_space);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_allocate_zeroed_and_track
+ *
+ * PARAMETERS:  size                - Size of the allocation
+ *              component           - Component type of caller
+ *              module              - Source file name of caller
+ *              line                - Line number of caller
+ *
+ * RETURN:      Address of the allocated memory on success, NULL on failure.
+ *
+ * DESCRIPTION: Subsystem equivalent of calloc.
+ *
+ ******************************************************************************/
+
+void *acpi_ut_allocate_zeroed_and_track(acpi_size size,
+					u32 component,
+					const char *module, u32 line)
+{
+	struct acpi_debug_mem_block *allocation;
+	acpi_status status;
+
+	allocation =
+	    acpi_ut_allocate_zeroed(size + sizeof(struct acpi_debug_mem_header),
+				    component, module, line);
+	if (!allocation) {
+
+		/* Report allocation error */
+
+		ACPI_ERROR((module, line,
+			    "Could not allocate size %u", (u32)size));
+		return (NULL);
+	}
+
+	status = acpi_ut_track_allocation(allocation, size,
+					  ACPI_MEM_CALLOC, component, module,
+					  line);
+	if (ACPI_FAILURE(status)) {
+		acpi_os_free(allocation);
+		return (NULL);
+	}
+
+	acpi_gbl_global_list->total_allocated++;
+	acpi_gbl_global_list->total_size += (u32)size;
+	acpi_gbl_global_list->current_total_size += (u32)size;
+	if (acpi_gbl_global_list->current_total_size >
+	    acpi_gbl_global_list->max_occupied) {
+		acpi_gbl_global_list->max_occupied =
+		    acpi_gbl_global_list->current_total_size;
+	}
+
+	return ((void *)&allocation->user_space);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_free_and_track
+ *
+ * PARAMETERS:  allocation          - Address of the memory to deallocate
+ *              component           - Component type of caller
+ *              module              - Source file name of caller
+ *              line                - Line number of caller
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Frees the memory at Allocation
+ *
+ ******************************************************************************/
+
+void
+acpi_ut_free_and_track(void *allocation,
+		       u32 component, const char *module, u32 line)
+{
+	struct acpi_debug_mem_block *debug_block;
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE_PTR(ut_free, allocation);
+
+	if (NULL == allocation) {
+		ACPI_ERROR((module, line, "Attempt to delete a NULL address"));
+
+		return_VOID;
+	}
+
+	debug_block = ACPI_CAST_PTR(struct acpi_debug_mem_block,
+				    (((char *)allocation) -
+				     sizeof(struct acpi_debug_mem_header)));
+
+	acpi_gbl_global_list->total_freed++;
+	acpi_gbl_global_list->current_total_size -= debug_block->size;
+
+	status = acpi_ut_remove_allocation(debug_block,
+					   component, module, line);
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status, "Could not free memory"));
+	}
+
+	acpi_os_free(debug_block);
+	ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS, "%p freed\n", allocation));
+	return_VOID;
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_find_allocation
+ *
+ * PARAMETERS:  allocation              - Address of allocated memory
+ *
+ * RETURN:      A list element if found; NULL otherwise.
+ *
+ * DESCRIPTION: Searches for an element in the global allocation tracking list.
+ *
+ ******************************************************************************/
+
+static struct acpi_debug_mem_block *acpi_ut_find_allocation(void *allocation)
+{
+	struct acpi_debug_mem_block *element;
+
+	ACPI_FUNCTION_ENTRY();
+
+	element = acpi_gbl_global_list->list_head;
+
+	/* Search for the address. */
+
+	while (element) {
+		if (element == allocation) {
+			return (element);
+		}
+
+		element = element->next;
+	}
+
+	return (NULL);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_track_allocation
+ *
+ * PARAMETERS:  allocation          - Address of allocated memory
+ *              size                - Size of the allocation
+ *              alloc_type          - MEM_MALLOC or MEM_CALLOC
+ *              component           - Component type of caller
+ *              module              - Source file name of caller
+ *              line                - Line number of caller
+ *
+ * RETURN:      None.
+ *
+ * DESCRIPTION: Inserts an element into the global allocation tracking list.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_ut_track_allocation(struct acpi_debug_mem_block *allocation,
+			 acpi_size size,
+			 u8 alloc_type,
+			 u32 component, const char *module, u32 line)
+{
+	struct acpi_memory_list *mem_list;
+	struct acpi_debug_mem_block *element;
+	acpi_status status = AE_OK;
+
+	ACPI_FUNCTION_TRACE_PTR(ut_track_allocation, allocation);
+
+	if (acpi_gbl_disable_mem_tracking) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
+	mem_list = acpi_gbl_global_list;
+	status = acpi_ut_acquire_mutex(ACPI_MTX_MEMORY);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/*
+	 * Search list for this address to make sure it is not already on the list.
+	 * This will catch several kinds of problems.
+	 */
+	element = acpi_ut_find_allocation(allocation);
+	if (element) {
+		ACPI_ERROR((AE_INFO,
+			    "UtTrackAllocation: Allocation already present in list! (%p)",
+			    allocation));
+
+		ACPI_ERROR((AE_INFO, "Element %p Address %p",
+			    element, allocation));
+
+		goto unlock_and_exit;
+	}
+
+	/* Fill in the instance data. */
+
+	allocation->size = (u32)size;
+	allocation->alloc_type = alloc_type;
+	allocation->component = component;
+	allocation->line = line;
+
+	ACPI_STRNCPY(allocation->module, module, ACPI_MAX_MODULE_NAME);
+	allocation->module[ACPI_MAX_MODULE_NAME - 1] = 0;
+
+	/* Insert at list head */
+
+	if (mem_list->list_head) {
+		((struct acpi_debug_mem_block *)(mem_list->list_head))->
+		    previous = allocation;
+	}
+
+	allocation->next = mem_list->list_head;
+	allocation->previous = NULL;
+
+	mem_list->list_head = allocation;
+
+      unlock_and_exit:
+	status = acpi_ut_release_mutex(ACPI_MTX_MEMORY);
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_remove_allocation
+ *
+ * PARAMETERS:  allocation          - Address of allocated memory
+ *              component           - Component type of caller
+ *              module              - Source file name of caller
+ *              line                - Line number of caller
+ *
+ * RETURN:
+ *
+ * DESCRIPTION: Deletes an element from the global allocation tracking list.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_ut_remove_allocation(struct acpi_debug_mem_block *allocation,
+			  u32 component, const char *module, u32 line)
+{
+	struct acpi_memory_list *mem_list;
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(ut_remove_allocation);
+
+	if (acpi_gbl_disable_mem_tracking) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
+	mem_list = acpi_gbl_global_list;
+	if (NULL == mem_list->list_head) {
+
+		/* No allocations! */
+
+		ACPI_ERROR((module, line,
+			    "Empty allocation list, nothing to free!"));
+
+		return_ACPI_STATUS(AE_OK);
+	}
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_MEMORY);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/* Unlink */
+
+	if (allocation->previous) {
+		(allocation->previous)->next = allocation->next;
+	} else {
+		mem_list->list_head = allocation->next;
+	}
+
+	if (allocation->next) {
+		(allocation->next)->previous = allocation->previous;
+	}
+
+	/* Mark the segment as deleted */
+
+	ACPI_MEMSET(&allocation->user_space, 0xEA, allocation->size);
+
+	ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS, "Freeing size 0%X\n",
+			  allocation->size));
+
+	status = acpi_ut_release_mutex(ACPI_MTX_MEMORY);
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_dump_allocation_info
+ *
+ * PARAMETERS:
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Print some info about the outstanding allocations.
+ *
+ ******************************************************************************/
+
+void acpi_ut_dump_allocation_info(void)
+{
+/*
+	struct acpi_memory_list         *mem_list;
+*/
+
+	ACPI_FUNCTION_TRACE(ut_dump_allocation_info);
+
+/*
+	ACPI_DEBUG_PRINT (TRACE_ALLOCATIONS | TRACE_TABLES,
+			  ("%30s: %4d (%3d Kb)\n", "Current allocations",
+			  mem_list->current_count,
+			  ROUND_UP_TO_1K (mem_list->current_size)));
+
+	ACPI_DEBUG_PRINT (TRACE_ALLOCATIONS | TRACE_TABLES,
+			  ("%30s: %4d (%3d Kb)\n", "Max concurrent allocations",
+			  mem_list->max_concurrent_count,
+			  ROUND_UP_TO_1K (mem_list->max_concurrent_size)));
+
+	ACPI_DEBUG_PRINT (TRACE_ALLOCATIONS | TRACE_TABLES,
+			  ("%30s: %4d (%3d Kb)\n", "Total (all) internal objects",
+			  running_object_count,
+			  ROUND_UP_TO_1K (running_object_size)));
+
+	ACPI_DEBUG_PRINT (TRACE_ALLOCATIONS | TRACE_TABLES,
+			  ("%30s: %4d (%3d Kb)\n", "Total (all) allocations",
+			  running_alloc_count,
+			  ROUND_UP_TO_1K (running_alloc_size)));
+
+	ACPI_DEBUG_PRINT (TRACE_ALLOCATIONS | TRACE_TABLES,
+			  ("%30s: %4d (%3d Kb)\n", "Current Nodes",
+			  acpi_gbl_current_node_count,
+			  ROUND_UP_TO_1K (acpi_gbl_current_node_size)));
+
+	ACPI_DEBUG_PRINT (TRACE_ALLOCATIONS | TRACE_TABLES,
+			  ("%30s: %4d (%3d Kb)\n", "Max Nodes",
+			  acpi_gbl_max_concurrent_node_count,
+			  ROUND_UP_TO_1K ((acpi_gbl_max_concurrent_node_count *
+					 sizeof (struct acpi_namespace_node)))));
+*/
+	return_VOID;
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_dump_allocations
+ *
+ * PARAMETERS:  component           - Component(s) to dump info for.
+ *              module              - Module to dump info for.  NULL means all.
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Print a list of all outstanding allocations.
+ *
+ ******************************************************************************/
+
+void acpi_ut_dump_allocations(u32 component, const char *module)
+{
+	struct acpi_debug_mem_block *element;
+	union acpi_descriptor *descriptor;
+	u32 num_outstanding = 0;
+	u8 descriptor_type;
+
+	ACPI_FUNCTION_TRACE(ut_dump_allocations);
+
+	if (acpi_gbl_disable_mem_tracking) {
+		return;
+	}
+
+	/*
+	 * Walk the allocation list.
+	 */
+	if (ACPI_FAILURE(acpi_ut_acquire_mutex(ACPI_MTX_MEMORY))) {
+		return;
+	}
+
+	element = acpi_gbl_global_list->list_head;
+	while (element) {
+		if ((element->component & component) &&
+		    ((module == NULL)
+		     || (0 == ACPI_STRCMP(module, element->module)))) {
+			descriptor =
+			    ACPI_CAST_PTR(union acpi_descriptor,
+					  &element->user_space);
+
+			if (element->size <
+			    sizeof(struct acpi_common_descriptor)) {
+				acpi_os_printf("%p Length 0x%04X %9.9s-%u "
+					       "[Not a Descriptor - too small]\n",
+					       descriptor, element->size,
+					       element->module, element->line);
+			} else {
+				/* Ignore allocated objects that are in a cache */
+
+				if (ACPI_GET_DESCRIPTOR_TYPE(descriptor) !=
+				    ACPI_DESC_TYPE_CACHED) {
+					acpi_os_printf
+					    ("%p Length 0x%04X %9.9s-%u [%s] ",
+					     descriptor, element->size,
+					     element->module, element->line,
+					     acpi_ut_get_descriptor_name
+					     (descriptor));
+
+					/* Validate the descriptor type using Type field and length */
+
+					descriptor_type = 0;	/* Not a valid descriptor type */
+
+					switch (ACPI_GET_DESCRIPTOR_TYPE
+						(descriptor)) {
+					case ACPI_DESC_TYPE_OPERAND:
+						if (element->size ==
+						    sizeof(union
+							   acpi_operand_object))
+						{
+							descriptor_type =
+							    ACPI_DESC_TYPE_OPERAND;
+						}
+						break;
+
+					case ACPI_DESC_TYPE_PARSER:
+						if (element->size ==
+						    sizeof(union
+							   acpi_parse_object)) {
+							descriptor_type =
+							    ACPI_DESC_TYPE_PARSER;
+						}
+						break;
+
+					case ACPI_DESC_TYPE_NAMED:
+						if (element->size ==
+						    sizeof(struct
+							   acpi_namespace_node))
+						{
+							descriptor_type =
+							    ACPI_DESC_TYPE_NAMED;
+						}
+						break;
+
+					default:
+						break;
+					}
+
+					/* Display additional info for the major descriptor types */
+
+					switch (descriptor_type) {
+					case ACPI_DESC_TYPE_OPERAND:
+						acpi_os_printf
+						    ("%12.12s RefCount 0x%04X\n",
+						     acpi_ut_get_type_name
+						     (descriptor->object.common.
+						      type),
+						     descriptor->object.common.
+						     reference_count);
+						break;
+
+					case ACPI_DESC_TYPE_PARSER:
+						acpi_os_printf
+						    ("AmlOpcode 0x%04hX\n",
+						     descriptor->op.asl.
+						     aml_opcode);
+						break;
+
+					case ACPI_DESC_TYPE_NAMED:
+						acpi_os_printf("%4.4s\n",
+							       acpi_ut_get_node_name
+							       (&descriptor->
+								node));
+						break;
+
+					default:
+						acpi_os_printf("\n");
+						break;
+					}
+				}
+			}
+
+			num_outstanding++;
+		}
+
+		element = element->next;
+	}
+
+	(void)acpi_ut_release_mutex(ACPI_MTX_MEMORY);
+
+	/* Print summary */
+
+	if (!num_outstanding) {
+		ACPI_INFO((AE_INFO, "No outstanding allocations"));
+	} else {
+		ACPI_ERROR((AE_INFO, "%u(0x%X) Outstanding allocations",
+			    num_outstanding, num_outstanding));
+	}
+
+	return_VOID;
+}
+
+#endif				/* ACPI_DBG_TRACK_ALLOCATIONS */
-- 
1.7.10

