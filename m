From: Lin Ming <ming.m.lin@intel.com>
Subject: ACPICA Release 20091112 linuxized patches
Date: Fri, 13 Nov 2009 10:43:34 +0800
Message-ID: <1258080214.7863.0.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-ZnkSx97vyhkN4mu2jjBN"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45304 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755147AbZKMC7H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Nov 2009 21:59:07 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>


--=-ZnkSx97vyhkN4mu2jjBN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi, Len

ACPICA Release 20091112 linuxized patches attched.
Applied on top of linux-acpi-2.6/test branch cleanly.

[PATCH 1/9] ACPICA: Reduce severity of predefined repair messages, Warning to Info
[PATCH 2/9] ACPICA: Change package length error message to an info message
[PATCH 3/9] ACPICA: Add post-order callback to acpi_walk_namespace
[PATCH 4/9] ACPICA: Fix possible fault if return Package objects contain NULL elements
[PATCH 5/9] ACPICA: Add repair for predefined methods that must return sorted lists
[PATCH 6/9] ACPICA: New internal utility function to create Integer objects
[PATCH 7/9] ACPICA: Deploy new create integer interface where appropriate
[PATCH 8/9] ACPICA: Add additional module-level code support
[PATCH 9/9] ACPICA: Update version to 20091112.

Lin Ming


--=-ZnkSx97vyhkN4mu2jjBN
Content-Disposition: attachment; filename="acpica-v20091112.patch"
Content-Type: text/x-patch; name="acpica-v20091112.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 752542e365879b94f04b0cc4c030eced01ffc489 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Thu, 12 Nov 2009 09:18:45 +0800
Subject: [PATCH 1/9] ACPICA: Reduce severity of predefined repair messages, Warning to Info

Since the object was successfully repaired, a Warning is too
severe.  Reduced to Info for now. We may eventually change these
messages to debug-only. ACPICA BZ 812.

http://www.acpica.org/bugzilla/show_bug.cgi?id=812

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/acmacros.h |    3 ++
 drivers/acpi/acpica/acutils.h  |    5 ++++
 drivers/acpi/acpica/nsrepair.c |    8 +++---
 drivers/acpi/acpica/utmisc.c   |   42 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index 3acd9c6..7d9ba6e 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -341,6 +341,7 @@
 #define ACPI_ERROR_NAMESPACE(s, e)      acpi_ns_report_error (AE_INFO, s, e);
 #define ACPI_ERROR_METHOD(s, n, p, e)   acpi_ns_report_method_error (AE_INFO, s, n, p, e);
 #define ACPI_WARN_PREDEFINED(plist)     acpi_ut_predefined_warning plist
+#define ACPI_INFO_PREDEFINED(plist)     acpi_ut_predefined_info plist
 
 #else
 
@@ -349,6 +350,8 @@
 #define ACPI_ERROR_NAMESPACE(s, e)
 #define ACPI_ERROR_METHOD(s, n, p, e)
 #define ACPI_WARN_PREDEFINED(plist)
+#define ACPI_INFO_PREDEFINED(plist)
+
 #endif		/* ACPI_NO_ERROR_MESSAGES */
 
 /*
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 863a264..f920d89 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -481,6 +481,11 @@ acpi_ut_predefined_warning(const char *module_name,
 			   char *pathname,
 			   u8 node_flags, const char *format, ...);
 
+void ACPI_INTERNAL_VAR_XFACE
+acpi_ut_predefined_info(const char *module_name,
+			u32 line_number,
+			char *pathname, u8 node_flags, const char *format, ...);
+
 /* Values for Base above (16=Hex, 10=Decimal) */
 
 #define ACPI_ANY_BASE        0
diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index f2f5269..d563f1a 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -185,14 +185,14 @@ acpi_ns_repair_object(struct acpi_predefined_data *data,
 			return_object->common.reference_count--;
 		}
 
-		ACPI_WARN_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
+		ACPI_INFO_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
 				      "Converted %s to expected %s at index %u",
 				      acpi_ut_get_object_type_name
 				      (return_object),
 				      acpi_ut_get_object_type_name(new_object),
 				      package_index));
 	} else {
-		ACPI_WARN_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
+		ACPI_INFO_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
 				      "Converted %s to expected %s",
 				      acpi_ut_get_object_type_name
 				      (return_object),
@@ -254,8 +254,8 @@ acpi_ns_repair_package_list(struct acpi_predefined_data *data,
 	*obj_desc_ptr = pkg_obj_desc;
 	data->flags |= ACPI_OBJECT_REPAIRED;
 
-	ACPI_WARN_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
-			      "Incorrectly formed Package, attempting repair"));
+	ACPI_INFO_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
+			      "Repaired Incorrectly formed Package"));
 
 	return (AE_OK);
 }
diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
index 61f6315..6c6a513 100644
--- a/drivers/acpi/acpica/utmisc.c
+++ b/drivers/acpi/acpica/utmisc.c
@@ -1161,3 +1161,45 @@ acpi_ut_predefined_warning(const char *module_name,
 	ACPI_COMMON_MSG_SUFFIX;
 	va_end(args);
 }
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_predefined_info
+ *
+ * PARAMETERS:  module_name     - Caller's module name (for error output)
+ *              line_number     - Caller's line number (for error output)
+ *              Pathname        - Full pathname to the node
+ *              node_flags      - From Namespace node for the method/object
+ *              Format          - Printf format string + additional args
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Info messages for the predefined validation module. Messages
+ *              are only emitted the first time a problem with a particular
+ *              method/object is detected. This prevents a flood of
+ *              messages for methods that are repeatedly evaluated.
+ *
+ ******************************************************************************/
+
+void ACPI_INTERNAL_VAR_XFACE
+acpi_ut_predefined_info(const char *module_name,
+			u32 line_number,
+			char *pathname, u8 node_flags, const char *format, ...)
+{
+	va_list args;
+
+	/*
+	 * Warning messages for this method/object will be disabled after the
+	 * first time a validation fails or an object is successfully repaired.
+	 */
+	if (node_flags & ANOBJ_EVALUATED) {
+		return;
+	}
+
+	acpi_os_printf("ACPI Info for %s: ", pathname);
+
+	va_start(args, format);
+	acpi_os_vprintf(format, args);
+	ACPI_COMMON_MSG_SUFFIX;
+	va_end(args);
+}

>From ea012c243a55449533804e283dccee2cb79b8a39 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Thu, 12 Nov 2009 09:31:50 +0800
Subject: [PATCH 2/9] ACPICA: Change package length error message to an info message

This message happens when the package element list is longer than
the declared length of the package. Changed to an info message
because this condition is not actually an error. It is caused by
the BIOS attempting to truncate the package on the fly by adjusting
the package element count at the start of the package definition.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/dsobject.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/dsobject.c b/drivers/acpi/acpica/dsobject.c
index 507e1f0..9bc1ba0 100644
--- a/drivers/acpi/acpica/dsobject.c
+++ b/drivers/acpi/acpica/dsobject.c
@@ -486,7 +486,7 @@ acpi_ds_build_internal_package_obj(struct acpi_walk_state *walk_state,
 		 *
 		 * Note: technically, this is an error, from ACPI spec: "It is an error
 		 * for NumElements to be less than the number of elements in the
-		 * PackageList". However, we just print an error message and
+		 * PackageList". However, we just print a message and
 		 * no exception is returned. This provides Windows compatibility. Some
 		 * BIOSs will alter the num_elements on the fly, creating this type
 		 * of ill-formed package object.
@@ -510,9 +510,9 @@ acpi_ds_build_internal_package_obj(struct acpi_walk_state *walk_state,
 			arg = arg->common.next;
 		}
 
-		ACPI_WARNING((AE_INFO,
-			    "Package List length (0x%X) larger than NumElements count (0x%X), truncated\n",
-			    i, element_count));
+		ACPI_INFO((AE_INFO,
+			   "Actual Package length (0x%X) is larger than NumElements field (0x%X), truncated\n",
+			   i, element_count));
 	} else if (i < element_count) {
 		/*
 		 * Arg list (elements) was exhausted, but we did not reach num_elements count.

>From bfb447d882cc94dea5a68ddaf4b21cfb582949e5 Mon Sep 17 00:00:00 2001
From: Lin Ming <ming.m.lin@intel.com>
Date: Fri, 13 Nov 2009 10:06:08 +0800
Subject: [PATCH 3/9] ACPICA: Add post-order callback to acpi_walk_namespace

The existing interface only has a pre-order callback. This change
adds an additional parameter for a post-order callback which will
be more useful for bus scans. ACPICA BZ 779.

Also update the external calls to acpi_walk_namespace.

http://www.acpica.org/bugzilla/show_bug.cgi?id=779

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 arch/ia64/sn/kernel/io_acpi_init.c     |    2 +-
 arch/x86/kernel/cpu/cpufreq/longhaul.c |    2 +-
 drivers/acpi/acpi_memhotplug.c         |    4 +-
 drivers/acpi/acpica/acnamesp.h         |    3 +-
 drivers/acpi/acpica/dsinit.c           |    2 +-
 drivers/acpi/acpica/evgpeblk.c         |    8 +-
 drivers/acpi/acpica/evregion.c         |    6 +-
 drivers/acpi/acpica/nsdump.c           |    4 +-
 drivers/acpi/acpica/nsdumpdv.c         |    3 +-
 drivers/acpi/acpica/nsinit.c           |    8 +-
 drivers/acpi/acpica/nswalk.c           |  200 +++++++++++++++++++-------------
 drivers/acpi/acpica/nsxfeval.c         |   32 +++--
 drivers/acpi/container.c               |    4 +-
 drivers/acpi/dock.c                    |    6 +-
 drivers/acpi/ec.c                      |    2 +-
 drivers/acpi/glue.c                    |    2 +-
 drivers/acpi/pci_slot.c                |    8 +-
 drivers/acpi/processor_core.c          |    4 +-
 drivers/acpi/scan.c                    |    2 +-
 drivers/acpi/video_detect.c            |    6 +-
 drivers/gpu/drm/i915/intel_lvds.c      |    2 +-
 drivers/i2c/busses/i2c-scmi.c          |    2 +-
 drivers/pci/hotplug/acpi_pcihp.c       |    2 +-
 drivers/pci/hotplug/acpiphp_glue.c     |   22 ++--
 drivers/pci/hotplug/acpiphp_ibm.c      |    2 +-
 drivers/platform/x86/intel_menlow.c    |    2 +-
 drivers/platform/x86/sony-laptop.c     |    2 +-
 drivers/platform/x86/thinkpad_acpi.c   |    2 +-
 include/acpi/acpixf.h                  |    3 +-
 29 files changed, 196 insertions(+), 151 deletions(-)

diff --git a/arch/ia64/sn/kernel/io_acpi_init.c b/arch/ia64/sn/kernel/io_acpi_init.c
index fd50ff9..66f633b 100644
--- a/arch/ia64/sn/kernel/io_acpi_init.c
+++ b/arch/ia64/sn/kernel/io_acpi_init.c
@@ -390,7 +390,7 @@ sn_acpi_get_pcidev_info(struct pci_dev *dev, struct pcidev_info **pcidev_info,
 	pcidev_match.handle = NULL;
 
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, rootbus_handle, ACPI_UINT32_MAX,
-			    find_matching_device, &pcidev_match, NULL);
+			    find_matching_device, NULL, &pcidev_match, NULL);
 
 	if (!pcidev_match.handle) {
 		printk(KERN_ERR
diff --git a/arch/x86/kernel/cpu/cpufreq/longhaul.c b/arch/x86/kernel/cpu/cpufreq/longhaul.c
index ce2ed3e..dc28ed1 100644
--- a/arch/x86/kernel/cpu/cpufreq/longhaul.c
+++ b/arch/x86/kernel/cpu/cpufreq/longhaul.c
@@ -885,7 +885,7 @@ static int __init longhaul_cpu_init(struct cpufreq_policy *policy)
 
 	/* Find ACPI data for processor */
 	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
-				ACPI_UINT32_MAX, &longhaul_walk_callback,
+				ACPI_UINT32_MAX, &longhaul_walk_callback, NULL,
 				NULL, (void *)&pr);
 
 	/* Check ACPI support for C3 state */
diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index 28ccdbc..3597d73 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -537,7 +537,7 @@ static int __init acpi_memory_device_init(void)
 
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 				     ACPI_UINT32_MAX,
-				     acpi_memory_register_notify_handler,
+				     acpi_memory_register_notify_handler, NULL,
 				     NULL, NULL);
 
 	if (ACPI_FAILURE(status)) {
@@ -561,7 +561,7 @@ static void __exit acpi_memory_device_exit(void)
 	 */
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 				     ACPI_UINT32_MAX,
-				     acpi_memory_deregister_notify_handler,
+				     acpi_memory_deregister_notify_handler, NULL,
 				     NULL, NULL);
 
 	if (ACPI_FAILURE(status))
diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 09a2764..168e608 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -104,7 +104,8 @@ acpi_ns_walk_namespace(acpi_object_type type,
 		       acpi_handle start_object,
 		       u32 max_depth,
 		       u32 flags,
-		       acpi_walk_callback user_function,
+		       acpi_walk_callback pre_order_visit,
+		       acpi_walk_callback post_order_visit,
 		       void *context, void **return_value);
 
 struct acpi_namespace_node *acpi_ns_get_next_node(struct acpi_namespace_node
diff --git a/drivers/acpi/acpica/dsinit.c b/drivers/acpi/acpica/dsinit.c
index 3aae13f..f23fa0b 100644
--- a/drivers/acpi/acpica/dsinit.c
+++ b/drivers/acpi/acpica/dsinit.c
@@ -192,7 +192,7 @@ acpi_ds_initialize_objects(u32 table_index,
 	status =
 	    acpi_ns_walk_namespace(ACPI_TYPE_ANY, start_node, ACPI_UINT32_MAX,
 				   ACPI_NS_WALK_UNLOCK, acpi_ds_init_one_object,
-				   &info, NULL);
+				   NULL, &info, NULL);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "During WalkNamespace"));
 	}
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index a60aaa7..2479209 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -945,8 +945,8 @@ acpi_ev_create_gpe_block(struct acpi_namespace_node *gpe_device,
 
 	status = acpi_ns_walk_namespace(ACPI_TYPE_METHOD, gpe_device,
 					ACPI_UINT32_MAX, ACPI_NS_WALK_NO_UNLOCK,
-					acpi_ev_save_method_info, gpe_block,
-					NULL);
+					acpi_ev_save_method_info, NULL,
+					gpe_block, NULL);
 
 	/* Return the new block */
 
@@ -1022,8 +1022,8 @@ acpi_ev_initialize_gpe_block(struct acpi_namespace_node *gpe_device,
 		status =
 		    acpi_ns_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 					   ACPI_UINT32_MAX, ACPI_NS_WALK_UNLOCK,
-					   acpi_ev_match_prw_and_gpe, &gpe_info,
-					   NULL);
+					   acpi_ev_match_prw_and_gpe, NULL,
+					   &gpe_info, NULL);
 	}
 
 	/*
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index c9fa040..582b0af 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -1025,8 +1025,8 @@ acpi_ev_install_space_handler(struct acpi_namespace_node * node,
 	 */
 	status = acpi_ns_walk_namespace(ACPI_TYPE_ANY, node, ACPI_UINT32_MAX,
 					ACPI_NS_WALK_UNLOCK,
-					acpi_ev_install_handler, handler_obj,
-					NULL);
+					acpi_ev_install_handler, NULL,
+					handler_obj, NULL);
 
       unlock_and_exit:
 	return_ACPI_STATUS(status);
@@ -1062,7 +1062,7 @@ acpi_ev_execute_reg_methods(struct acpi_namespace_node *node,
 	 */
 	status = acpi_ns_walk_namespace(ACPI_TYPE_ANY, node, ACPI_UINT32_MAX,
 					ACPI_NS_WALK_UNLOCK, acpi_ev_reg_run,
-					&space_id, NULL);
+					NULL, &space_id, NULL);
 
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 2bad613..2deb986 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -634,8 +634,8 @@ acpi_ns_dump_objects(acpi_object_type type,
 	(void)acpi_ns_walk_namespace(type, start_handle, max_depth,
 				     ACPI_NS_WALK_NO_UNLOCK |
 				     ACPI_NS_WALK_TEMP_NODES,
-				     acpi_ns_dump_one_object, (void *)&info,
-				     NULL);
+				     acpi_ns_dump_one_object, NULL,
+				     (void *)&info, NULL);
 }
 #endif				/* ACPI_FUTURE_USAGE */
 
diff --git a/drivers/acpi/acpica/nsdumpdv.c b/drivers/acpi/acpica/nsdumpdv.c
index 0fe87f1..36be7f0 100644
--- a/drivers/acpi/acpica/nsdumpdv.c
+++ b/drivers/acpi/acpica/nsdumpdv.c
@@ -131,7 +131,8 @@ void acpi_ns_dump_root_devices(void)
 
 	status = acpi_ns_walk_namespace(ACPI_TYPE_DEVICE, sys_bus_handle,
 					ACPI_UINT32_MAX, ACPI_NS_WALK_NO_UNLOCK,
-					acpi_ns_dump_one_device, NULL, NULL);
+					acpi_ns_dump_one_device, NULL, NULL,
+					NULL);
 }
 
 #endif
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index 1d5b360..4f8abac 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -96,7 +96,7 @@ acpi_status acpi_ns_initialize_objects(void)
 	/* Walk entire namespace from the supplied root */
 
 	status = acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
-				     ACPI_UINT32_MAX, acpi_ns_init_one_object,
+				     ACPI_UINT32_MAX, acpi_ns_init_one_object, NULL,
 				     &info, NULL);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "During WalkNamespace"));
@@ -156,7 +156,8 @@ acpi_status acpi_ns_initialize_devices(void)
 
 	status = acpi_ns_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
 					ACPI_UINT32_MAX, FALSE,
-					acpi_ns_find_ini_methods, &info, NULL);
+					acpi_ns_find_ini_methods, NULL, &info,
+					NULL);
 	if (ACPI_FAILURE(status)) {
 		goto error_exit;
 	}
@@ -189,7 +190,8 @@ acpi_status acpi_ns_initialize_devices(void)
 
 	status = acpi_ns_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
 					ACPI_UINT32_MAX, FALSE,
-					acpi_ns_init_one_device, &info, NULL);
+					acpi_ns_init_one_device, NULL, &info,
+					NULL);
 
 	ACPI_FREE(info.evaluate_info);
 	if (ACPI_FAILURE(status)) {
diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
index 35539df..d7e6b52 100644
--- a/drivers/acpi/acpica/nswalk.c
+++ b/drivers/acpi/acpica/nswalk.c
@@ -165,24 +165,27 @@ struct acpi_namespace_node *acpi_ns_get_next_node_typed(acpi_object_type type,
  *              max_depth           - Depth to which search is to reach
  *              Flags               - Whether to unlock the NS before invoking
  *                                    the callback routine
- *              user_function       - Called when an object of "Type" is found
- *              Context             - Passed to user function
- *              return_value        - from the user_function if terminated early.
- *                                    Otherwise, returns NULL.
+ *              pre_order_visit     - Called during tree pre-order visit
+ *                                    when an object of "Type" is found
+ *              post_order_visit    - Called during tree post-order visit
+ *                                    when an object of "Type" is found
+ *              Context             - Passed to user function(s) above
+ *              return_value        - from the user_function if terminated
+ *                                    early. Otherwise, returns NULL.
  * RETURNS:     Status
  *
  * DESCRIPTION: Performs a modified depth-first walk of the namespace tree,
  *              starting (and ending) at the node specified by start_handle.
- *              The user_function is called whenever a node that matches
- *              the type parameter is found.  If the user function returns
+ *              The callback function is called whenever a node that matches
+ *              the type parameter is found. If the callback function returns
  *              a non-zero value, the search is terminated immediately and
  *              this value is returned to the caller.
  *
  *              The point of this procedure is to provide a generic namespace
  *              walk routine that can be called from multiple places to
- *              provide multiple services;  the User Function can be tailored
- *              to each task, whether it is a print function, a compare
- *              function, etc.
+ *              provide multiple services; the callback function(s) can be
+ *              tailored to each task, whether it is a print function,
+ *              a compare function, etc.
  *
  ******************************************************************************/
 
@@ -191,7 +194,8 @@ acpi_ns_walk_namespace(acpi_object_type type,
 		       acpi_handle start_node,
 		       u32 max_depth,
 		       u32 flags,
-		       acpi_walk_callback user_function,
+		       acpi_walk_callback pre_order_visit,
+		       acpi_walk_callback post_order_visit,
 		       void *context, void **return_value)
 {
 	acpi_status status;
@@ -200,6 +204,7 @@ acpi_ns_walk_namespace(acpi_object_type type,
 	struct acpi_namespace_node *parent_node;
 	acpi_object_type child_type;
 	u32 level;
+	u8 node_previously_visited = FALSE;
 
 	ACPI_FUNCTION_TRACE(ns_walk_namespace);
 
@@ -212,7 +217,7 @@ acpi_ns_walk_namespace(acpi_object_type type,
 	/* Null child means "get first node" */
 
 	parent_node = start_node;
-	child_node = NULL;
+	child_node = acpi_ns_get_next_node(parent_node, NULL);
 	child_type = ACPI_TYPE_ANY;
 	level = 1;
 
@@ -221,102 +226,129 @@ acpi_ns_walk_namespace(acpi_object_type type,
 	 * started. When Level is zero, the loop is done because we have
 	 * bubbled up to (and passed) the original parent handle (start_entry)
 	 */
-	while (level > 0) {
+	while (level > 0 && child_node) {
+		status = AE_OK;
 
-		/* Get the next node in this scope.  Null if not found */
+		/* Found next child, get the type if we are not searching for ANY */
 
-		status = AE_OK;
-		child_node = acpi_ns_get_next_node(parent_node, child_node);
-		if (child_node) {
+		if (type != ACPI_TYPE_ANY) {
+			child_type = child_node->type;
+		}
 
-			/* Found next child, get the type if we are not searching for ANY */
+		/*
+		 * Ignore all temporary namespace nodes (created during control
+		 * method execution) unless told otherwise. These temporary nodes
+		 * can cause a race condition because they can be deleted during
+		 * the execution of the user function (if the namespace is
+		 * unlocked before invocation of the user function.) Only the
+		 * debugger namespace dump will examine the temporary nodes.
+		 */
+		if ((child_node->flags & ANOBJ_TEMPORARY) &&
+		    !(flags & ACPI_NS_WALK_TEMP_NODES)) {
+			status = AE_CTRL_DEPTH;
+		}
 
-			if (type != ACPI_TYPE_ANY) {
-				child_type = child_node->type;
-			}
+		/* Type must match requested type */
 
+		else if (child_type == type) {
 			/*
-			 * Ignore all temporary namespace nodes (created during control
-			 * method execution) unless told otherwise. These temporary nodes
-			 * can cause a race condition because they can be deleted during
-			 * the execution of the user function (if the namespace is
-			 * unlocked before invocation of the user function.) Only the
-			 * debugger namespace dump will examine the temporary nodes.
+			 * Found a matching node, invoke the user callback function.
+			 * Unlock the namespace if flag is set.
 			 */
-			if ((child_node->flags & ANOBJ_TEMPORARY) &&
-			    !(flags & ACPI_NS_WALK_TEMP_NODES)) {
-				status = AE_CTRL_DEPTH;
+			if (flags & ACPI_NS_WALK_UNLOCK) {
+				mutex_status =
+				    acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+				if (ACPI_FAILURE(mutex_status)) {
+					return_ACPI_STATUS(mutex_status);
+				}
 			}
 
-			/* Type must match requested type */
-
-			else if (child_type == type) {
-				/*
-				 * Found a matching node, invoke the user callback function.
-				 * Unlock the namespace if flag is set.
-				 */
-				if (flags & ACPI_NS_WALK_UNLOCK) {
-					mutex_status =
-					    acpi_ut_release_mutex
-					    (ACPI_MTX_NAMESPACE);
-					if (ACPI_FAILURE(mutex_status)) {
-						return_ACPI_STATUS
-						    (mutex_status);
-					}
+			/*
+			 * Invoke the user function, either pre-order or post-order
+			 * or both.
+			 */
+			if (!node_previously_visited) {
+				if (pre_order_visit) {
+					status =
+					    pre_order_visit(child_node, level,
+							    context,
+							    return_value);
 				}
+			} else {
+				if (post_order_visit) {
+					status =
+					    post_order_visit(child_node, level,
+							     context,
+							     return_value);
+				}
+			}
 
-				status =
-				    user_function(child_node, level, context,
-						  return_value);
-
-				if (flags & ACPI_NS_WALK_UNLOCK) {
-					mutex_status =
-					    acpi_ut_acquire_mutex
-					    (ACPI_MTX_NAMESPACE);
-					if (ACPI_FAILURE(mutex_status)) {
-						return_ACPI_STATUS
-						    (mutex_status);
-					}
+			if (flags & ACPI_NS_WALK_UNLOCK) {
+				mutex_status =
+				    acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+				if (ACPI_FAILURE(mutex_status)) {
+					return_ACPI_STATUS(mutex_status);
 				}
+			}
 
-				switch (status) {
-				case AE_OK:
-				case AE_CTRL_DEPTH:
+			switch (status) {
+			case AE_OK:
+			case AE_CTRL_DEPTH:
 
-					/* Just keep going */
-					break;
+				/* Just keep going */
+				break;
 
-				case AE_CTRL_TERMINATE:
+			case AE_CTRL_TERMINATE:
 
-					/* Exit now, with OK status */
+				/* Exit now, with OK status */
 
-					return_ACPI_STATUS(AE_OK);
+				return_ACPI_STATUS(AE_OK);
 
-				default:
+			default:
 
-					/* All others are valid exceptions */
+				/* All others are valid exceptions */
 
-					return_ACPI_STATUS(status);
-				}
+				return_ACPI_STATUS(status);
+			}
+		}
+
+		/*
+		 * Depth first search: Attempt to go down another level in the
+		 * namespace if we are allowed to.  Don't go any further if we have
+		 * reached the caller specified maximum depth or if the user
+		 * function has specified that the maximum depth has been reached.
+		 */
+		if (!node_previously_visited &&
+		    (level < max_depth) && (status != AE_CTRL_DEPTH)) {
+			if (child_node->child) {
+
+				/* There is at least one child of this node, visit it */
+
+				level++;
+				parent_node = child_node;
+				child_node =
+				    acpi_ns_get_next_node(parent_node, NULL);
+				continue;
 			}
+		}
 
-			/*
-			 * Depth first search: Attempt to go down another level in the
-			 * namespace if we are allowed to.  Don't go any further if we have
-			 * reached the caller specified maximum depth or if the user
-			 * function has specified that the maximum depth has been reached.
-			 */
-			if ((level < max_depth) && (status != AE_CTRL_DEPTH)) {
-				if (child_node->child) {
+		/* No more children, re-visit this node */
 
-					/* There is at least one child of this node, visit it */
+		if (!node_previously_visited) {
+			node_previously_visited = TRUE;
+			continue;
+		}
 
-					level++;
-					parent_node = child_node;
-					child_node = NULL;
-				}
-			}
-		} else {
+		/* No more children, visit peers */
+
+		child_node = acpi_ns_get_next_node(parent_node, child_node);
+		if (child_node) {
+			node_previously_visited = FALSE;
+		}
+
+		/* No peers, re-visit parent */
+
+		else {
 			/*
 			 * No more children of this node (acpi_ns_get_next_node failed), go
 			 * back upwards in the namespace tree to the node's parent.
@@ -324,6 +356,8 @@ acpi_ns_walk_namespace(acpi_object_type type,
 			level--;
 			child_node = parent_node;
 			parent_node = acpi_ns_get_parent_node(parent_node);
+
+			node_previously_visited = TRUE;
 		}
 	}
 
diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index 4929dbd..f2bd1da 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -433,8 +433,11 @@ static void acpi_ns_resolve_references(struct acpi_evaluate_info *info)
  * PARAMETERS:  Type                - acpi_object_type to search for
  *              start_object        - Handle in namespace where search begins
  *              max_depth           - Depth to which search is to reach
- *              user_function       - Called when an object of "Type" is found
- *              Context             - Passed to user function
+ *              pre_order_visit     - Called during tree pre-order visit
+ *                                    when an object of "Type" is found
+ *              post_order_visit    - Called during tree post-order visit
+ *                                    when an object of "Type" is found
+ *              Context             - Passed to user function(s) above
  *              return_value        - Location where return value of
  *                                    user_function is put if terminated early
  *
@@ -443,16 +446,16 @@ static void acpi_ns_resolve_references(struct acpi_evaluate_info *info)
  *
  * DESCRIPTION: Performs a modified depth-first walk of the namespace tree,
  *              starting (and ending) at the object specified by start_handle.
- *              The user_function is called whenever an object that matches
- *              the type parameter is found.  If the user function returns
+ *              The callback function is called whenever an object that matches
+ *              the type parameter is found. If the callback function returns
  *              a non-zero value, the search is terminated immediately and this
  *              value is returned to the caller.
  *
  *              The point of this procedure is to provide a generic namespace
  *              walk routine that can be called from multiple places to
- *              provide multiple services;  the User Function can be tailored
- *              to each task, whether it is a print function, a compare
- *              function, etc.
+ *              provide multiple services; the callback function(s) can be
+ *              tailored to each task, whether it is a print function,
+ *              a compare function, etc.
  *
  ******************************************************************************/
 
@@ -460,7 +463,8 @@ acpi_status
 acpi_walk_namespace(acpi_object_type type,
 		    acpi_handle start_object,
 		    u32 max_depth,
-		    acpi_walk_callback user_function,
+		    acpi_walk_callback pre_order_visit,
+		    acpi_walk_callback post_order_visit,
 		    void *context, void **return_value)
 {
 	acpi_status status;
@@ -469,7 +473,8 @@ acpi_walk_namespace(acpi_object_type type,
 
 	/* Parameter validation */
 
-	if ((type > ACPI_TYPE_LOCAL_MAX) || (!max_depth) || (!user_function)) {
+	if ((type > ACPI_TYPE_LOCAL_MAX) ||
+	    (!max_depth) || (!pre_order_visit && !post_order_visit)) {
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
@@ -501,8 +506,9 @@ acpi_walk_namespace(acpi_object_type type,
 	}
 
 	status = acpi_ns_walk_namespace(type, start_object, max_depth,
-					ACPI_NS_WALK_UNLOCK, user_function,
-					context, return_value);
+					ACPI_NS_WALK_UNLOCK, pre_order_visit,
+					post_order_visit, context,
+					return_value);
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 
@@ -681,8 +687,8 @@ acpi_get_devices(const char *HID,
 
 	status = acpi_ns_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 					ACPI_UINT32_MAX, ACPI_NS_WALK_UNLOCK,
-					acpi_ns_get_device_callback, &info,
-					return_value);
+					acpi_ns_get_device_callback, NULL,
+					&info, return_value);
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS(status);
diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 642bb30..5faf6c2 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -258,7 +258,7 @@ static int __init acpi_container_init(void)
 	acpi_walk_namespace(ACPI_TYPE_DEVICE,
 			    ACPI_ROOT_OBJECT,
 			    ACPI_UINT32_MAX,
-			    container_walk_namespace_cb, &action, NULL);
+			    container_walk_namespace_cb, NULL, &action, NULL);
 
 	return (0);
 }
@@ -271,7 +271,7 @@ static void __exit acpi_container_exit(void)
 	acpi_walk_namespace(ACPI_TYPE_DEVICE,
 			    ACPI_ROOT_OBJECT,
 			    ACPI_UINT32_MAX,
-			    container_walk_namespace_cb, &action, NULL);
+			    container_walk_namespace_cb, NULL, &action, NULL);
 
 	acpi_bus_unregister_driver(&acpi_container_driver);
 
diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index d374f19..b539144 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -968,7 +968,7 @@ static int dock_add(acpi_handle handle)
 
 	/* Find dependent devices */
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT, ACPI_UINT32_MAX,
-			    find_dock_devices, dock_station, NULL);
+			    find_dock_devices, NULL, dock_station, NULL);
 
 	/* add the dock station as a device dependent on itself */
 	ret = add_dock_dependent_device(dock_station, handle);
@@ -1048,11 +1048,11 @@ static int __init dock_init(void)
 
 	/* look for a dock station */
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-			    ACPI_UINT32_MAX, find_dock, NULL, NULL);
+			    ACPI_UINT32_MAX, find_dock, NULL, NULL, NULL);
 
 	/* look for bay */
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-			ACPI_UINT32_MAX, find_bay, NULL, NULL);
+			ACPI_UINT32_MAX, find_bay, NULL, NULL, NULL);
 	if (!dock_station_count) {
 		printk(KERN_INFO PREFIX "No dock devices found.\n");
 		return 0;
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index baef28c..75b147f 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -820,7 +820,7 @@ static int acpi_ec_add(struct acpi_device *device)
 
 	/* Find and register all query methods */
 	acpi_walk_namespace(ACPI_TYPE_METHOD, ec->handle, 1,
-			    acpi_ec_register_query_methods, ec, NULL);
+			    acpi_ec_register_query_methods, NULL, ec, NULL);
 
 	if (!first_ec)
 		first_ec = ec;
diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index c6645f2..4c8fcff 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -113,7 +113,7 @@ acpi_handle acpi_get_child(acpi_handle parent, acpi_integer address)
 	if (!parent)
 		return NULL;
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, parent,
-			    1, do_acpi_find_child, &find, NULL);
+			    1, do_acpi_find_child, NULL, &find, NULL);
 	return find.handle;
 }
 
diff --git a/drivers/acpi/pci_slot.c b/drivers/acpi/pci_slot.c
index 45da2ba..11f2197 100644
--- a/drivers/acpi/pci_slot.c
+++ b/drivers/acpi/pci_slot.c
@@ -219,12 +219,12 @@ walk_p2p_bridge(acpi_handle handle, u32 lvl, void *context, void **rv)
 
 	dbg("p2p bridge walk, pci_bus = %x\n", dev->subordinate->number);
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, (u32)1,
-				     user_function, &child_context, NULL);
+				     user_function, NULL, &child_context, NULL);
 	if (ACPI_FAILURE(status))
 		goto out;
 
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, (u32)1,
-				     walk_p2p_bridge, &child_context, NULL);
+				     walk_p2p_bridge, NULL, &child_context, NULL);
 out:
 	pci_dev_put(dev);
 	return AE_OK;
@@ -277,12 +277,12 @@ walk_root_bridge(acpi_handle handle, acpi_walk_callback user_function)
 
 	dbg("root bridge walk, pci_bus = %x\n", pci_bus->number);
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, (u32)1,
-				     user_function, &context, NULL);
+				     user_function, NULL, &context, NULL);
 	if (ACPI_FAILURE(status))
 		return status;
 
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, (u32)1,
-				     walk_p2p_bridge, &context, NULL);
+				     walk_p2p_bridge, NULL, &context, NULL);
 	if (ACPI_FAILURE(status))
 		err("%s: walk_p2p_bridge failure - %d\n", __func__, status);
 
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 7f11f51..65b9f29 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -1102,7 +1102,7 @@ void acpi_processor_install_hotplug_notify(void)
 	acpi_walk_namespace(ACPI_TYPE_PROCESSOR,
 			    ACPI_ROOT_OBJECT,
 			    ACPI_UINT32_MAX,
-			    processor_walk_namespace_cb, &action, NULL);
+			    processor_walk_namespace_cb, NULL, &action, NULL);
 #endif
 	register_hotcpu_notifier(&acpi_cpu_notifier);
 }
@@ -1115,7 +1115,7 @@ void acpi_processor_uninstall_hotplug_notify(void)
 	acpi_walk_namespace(ACPI_TYPE_PROCESSOR,
 			    ACPI_ROOT_OBJECT,
 			    ACPI_UINT32_MAX,
-			    processor_walk_namespace_cb, &action, NULL);
+			    processor_walk_namespace_cb, NULL, &action, NULL);
 #endif
 	unregister_hotcpu_notifier(&acpi_cpu_notifier);
 }
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 14a7481..ff9f622 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1332,7 +1332,7 @@ static int acpi_bus_scan(acpi_handle handle, struct acpi_bus_ops *ops,
 	status = acpi_bus_check_add(handle, 0, ops, &device);
 	if (ACPI_SUCCESS(status))
 		acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
-				    acpi_bus_check_add, ops, &device);
+				    acpi_bus_check_add, NULL, ops, &device);
 
 	if (child)
 		*child = device;
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 575593a..8c1b431 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -101,7 +101,7 @@ long acpi_is_video_device(struct acpi_device *device)
 	/* Only check for backlight functionality if one of the above hit. */
 	if (video_caps)
 		acpi_walk_namespace(ACPI_TYPE_DEVICE, device->handle,
-				    ACPI_UINT32_MAX, acpi_backlight_cap_match,
+				    ACPI_UINT32_MAX, acpi_backlight_cap_match, NULL,
 				    &video_caps, NULL);
 
 	return video_caps;
@@ -151,7 +151,7 @@ long acpi_video_get_capabilities(acpi_handle graphics_handle)
 	if (!graphics_handle) {
 		/* Only do the global walk through all graphics devices once */
 		acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-				    ACPI_UINT32_MAX, find_video,
+				    ACPI_UINT32_MAX, find_video, NULL,
 				    &caps, NULL);
 		/* There might be boot param flags set already... */
 		acpi_video_support |= caps;
@@ -173,7 +173,7 @@ long acpi_video_get_capabilities(acpi_handle graphics_handle)
 			return 0;
 		}
 		acpi_walk_namespace(ACPI_TYPE_DEVICE, graphics_handle,
-				    ACPI_UINT32_MAX, find_video,
+				    ACPI_UINT32_MAX, find_video, NULL,
 				    &caps, NULL);
 	}
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "We have 0x%lX video support %s %s\n",
diff --git a/drivers/gpu/drm/i915/intel_lvds.c b/drivers/gpu/drm/i915/intel_lvds.c
index 05598ae..eb36502 100644
--- a/drivers/gpu/drm/i915/intel_lvds.c
+++ b/drivers/gpu/drm/i915/intel_lvds.c
@@ -899,7 +899,7 @@ static int intel_lid_present(void)
 
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 				ACPI_UINT32_MAX,
-				check_lid_device, &lid_present, NULL);
+				check_lid_device, NULL, &lid_present, NULL);
 
 	return lid_present;
 }
diff --git a/drivers/i2c/busses/i2c-scmi.c b/drivers/i2c/busses/i2c-scmi.c
index b4a55d4..365e0be 100644
--- a/drivers/i2c/busses/i2c-scmi.c
+++ b/drivers/i2c/busses/i2c-scmi.c
@@ -363,7 +363,7 @@ static int acpi_smbus_cmi_add(struct acpi_device *device)
 	smbus_cmi->cap_write = 0;
 
 	acpi_walk_namespace(ACPI_TYPE_METHOD, smbus_cmi->handle, 1,
-			    acpi_smbus_cmi_query_methods, smbus_cmi, NULL);
+			    acpi_smbus_cmi_query_methods, NULL, smbus_cmi, NULL);
 
 	if (smbus_cmi->cap_info == 0)
 		goto err;
diff --git a/drivers/pci/hotplug/acpi_pcihp.c b/drivers/pci/hotplug/acpi_pcihp.c
index a73028e..0f32571 100644
--- a/drivers/pci/hotplug/acpi_pcihp.c
+++ b/drivers/pci/hotplug/acpi_pcihp.c
@@ -471,7 +471,7 @@ int acpi_pci_detect_ejectable(acpi_handle handle)
 		return found;
 
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
-			    check_hotplug, (void *)&found, NULL);
+			    check_hotplug, NULL, (void *)&found, NULL);
 	return found;
 }
 EXPORT_SYMBOL_GPL(acpi_pci_detect_ejectable);
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 58d25a1..df1b0ea 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -266,7 +266,7 @@ static int detect_ejectable_slots(acpi_handle handle)
 	int found = acpi_pci_detect_ejectable(handle);
 	if (!found) {
 		acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, (u32)1,
-				    is_pci_dock_device, (void *)&found, NULL);
+				    is_pci_dock_device, NULL, (void *)&found, NULL);
 	}
 	return found;
 }
@@ -281,7 +281,7 @@ static void init_bridge_misc(struct acpiphp_bridge *bridge)
 
 	/* register all slot objects under this bridge */
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, bridge->handle, (u32)1,
-				     register_slot, bridge, NULL);
+				     register_slot, NULL, bridge, NULL);
 	if (ACPI_FAILURE(status)) {
 		list_del(&bridge->list);
 		return;
@@ -447,7 +447,7 @@ find_p2p_bridge(acpi_handle handle, u32 lvl, void *context, void **rv)
 
 	/* search P2P bridges under this p2p bridge */
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, (u32)1,
-				     find_p2p_bridge, NULL, NULL);
+				     find_p2p_bridge, NULL, NULL, NULL);
 	if (ACPI_FAILURE(status))
 		warn("find_p2p_bridge failed (error code = 0x%x)\n", status);
 
@@ -485,7 +485,7 @@ static int add_bridge(acpi_handle handle)
 
 	/* search P2P bridges under this host bridge */
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, (u32)1,
-				     find_p2p_bridge, NULL, NULL);
+				     find_p2p_bridge, NULL, NULL, NULL);
 
 	if (ACPI_FAILURE(status))
 		warn("find_p2p_bridge failed (error code = 0x%x)\n", status);
@@ -573,7 +573,7 @@ cleanup_p2p_bridge(acpi_handle handle, u32 lvl, void *context, void **rv)
 	/* cleanup p2p bridges under this P2P bridge
 	   in a depth-first manner */
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, (u32)1,
-				cleanup_p2p_bridge, NULL, NULL);
+				cleanup_p2p_bridge, NULL, NULL, NULL);
 
 	bridge = acpiphp_handle_to_bridge(handle);
 	if (bridge)
@@ -589,7 +589,7 @@ static void remove_bridge(acpi_handle handle)
 	/* cleanup p2p bridges under this host bridge
 	   in a depth-first manner */
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, handle,
-				(u32)1, cleanup_p2p_bridge, NULL, NULL);
+				(u32)1, cleanup_p2p_bridge, NULL, NULL, NULL);
 
 	/*
 	 * On root bridges with hotplug slots directly underneath (ie,
@@ -778,7 +778,7 @@ static int acpiphp_configure_ioapics(acpi_handle handle)
 {
 	ioapic_add(handle, 0, NULL, NULL);
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, handle,
-			    ACPI_UINT32_MAX, ioapic_add, NULL, NULL);
+			    ACPI_UINT32_MAX, ioapic_add, NULL, NULL, NULL);
 	return 0;
 }
 
@@ -786,7 +786,7 @@ static int acpiphp_unconfigure_ioapics(acpi_handle handle)
 {
 	ioapic_remove(handle, 0, NULL, NULL);
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, handle,
-			    ACPI_UINT32_MAX, ioapic_remove, NULL, NULL);
+			    ACPI_UINT32_MAX, ioapic_remove, NULL, NULL, NULL);
 	return 0;
 }
 
@@ -1367,7 +1367,7 @@ static void handle_hotplug_event_bridge(acpi_handle handle, u32 type, void *cont
 	bridge = acpiphp_handle_to_bridge(handle);
 	if (type == ACPI_NOTIFY_BUS_CHECK) {
 		acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, ACPI_UINT32_MAX,
-			count_sub_bridges, &num_sub_bridges, NULL);
+			count_sub_bridges, NULL, &num_sub_bridges, NULL);
 	}
 
 	if (!bridge && !num_sub_bridges) {
@@ -1388,7 +1388,7 @@ static void handle_hotplug_event_bridge(acpi_handle handle, u32 type, void *cont
 		}
 		if (num_sub_bridges)
 			acpi_walk_namespace(ACPI_TYPE_DEVICE, handle,
-				ACPI_UINT32_MAX, check_sub_bridges, NULL, NULL);
+				ACPI_UINT32_MAX, check_sub_bridges, NULL, NULL, NULL);
 		break;
 
 	case ACPI_NOTIFY_DEVICE_CHECK:
@@ -1512,7 +1512,7 @@ int __init acpiphp_glue_init(void)
 	int num = 0;
 
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-			ACPI_UINT32_MAX, find_root_bridges, &num, NULL);
+			ACPI_UINT32_MAX, find_root_bridges, NULL, &num, NULL);
 
 	if (num <= 0)
 		return -1;
diff --git a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpiphp_ibm.c
index e7be66d..aa5df48 100644
--- a/drivers/pci/hotplug/acpiphp_ibm.c
+++ b/drivers/pci/hotplug/acpiphp_ibm.c
@@ -434,7 +434,7 @@ static int __init ibm_acpiphp_init(void)
 	dbg("%s\n", __func__);
 
 	if (acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-			ACPI_UINT32_MAX, ibm_find_acpi_device,
+			ACPI_UINT32_MAX, ibm_find_acpi_device, NULL,
 			&ibm_acpi_handle, NULL) != FOUND_APCI) {
 		err("%s: acpi_walk_namespace failed\n", __func__);
 		retval = -ENODEV;
diff --git a/drivers/platform/x86/intel_menlow.c b/drivers/platform/x86/intel_menlow.c
index 29432a5..f0a90a6 100644
--- a/drivers/platform/x86/intel_menlow.c
+++ b/drivers/platform/x86/intel_menlow.c
@@ -510,7 +510,7 @@ static int __init intel_menlow_module_init(void)
 	/* Looking for sensors in each ACPI thermal zone */
 	status = acpi_walk_namespace(ACPI_TYPE_THERMAL, ACPI_ROOT_OBJECT,
 				     ACPI_UINT32_MAX,
-				     intel_menlow_register_sensor, NULL, NULL);
+				     intel_menlow_register_sensor, NULL, NULL, NULL);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index a2a742c..7a2cc8a 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -1203,7 +1203,7 @@ static int sony_nc_add(struct acpi_device *device)
 
 	if (debug) {
 		status = acpi_walk_namespace(ACPI_TYPE_METHOD, sony_nc_acpi_handle,
-					     1, sony_walk_callback, NULL, NULL);
+					     1, sony_walk_callback, NULL, NULL, NULL);
 		if (ACPI_FAILURE(status)) {
 			printk(KERN_WARNING DRV_PFX "unable to walk acpi resources\n");
 			result = -ENODEV;
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index d93108d..22cb50f 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -1087,7 +1087,7 @@ static int __init tpacpi_check_std_acpi_brightness_support(void)
 	 */
 
 	status = acpi_walk_namespace(ACPI_TYPE_METHOD, vid_handle, 3,
-				     tpacpi_acpi_walk_find_bcl, NULL,
+				     tpacpi_acpi_walk_find_bcl, NULL, NULL,
 				     &bcl_ptr);
 
 	if (ACPI_SUCCESS(status) && bcl_levels > 2) {
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 0e7efea..f9b8b28 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -154,7 +154,8 @@ acpi_status
 acpi_walk_namespace(acpi_object_type type,
 		    acpi_handle start_object,
 		    u32 max_depth,
-		    acpi_walk_callback user_function,
+		    acpi_walk_callback pre_order_visit,
+		    acpi_walk_callback post_order_visit,
 		    void *context, void **return_value);
 
 acpi_status

>From 7c725d5bd99a198a0b336931e5b698045862438f Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Thu, 12 Nov 2009 09:36:00 +0800
Subject: [PATCH 4/9] ACPICA: Fix possible fault if return Package objects contain NULL elements

For predefined name validation. Also adds a warning if a NULL
element is followed by any non-null elements.  ACPICA BZ 813, 814.

http://www.acpica.org/bugzilla/show_bug.cgi?id=813
http://www.acpica.org/bugzilla/show_bug.cgi?id=814

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/nspredef.c |   43 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index f8427af..4028098 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -601,7 +601,8 @@ acpi_ns_check_package(struct acpi_predefined_data *data,
 		 * there is only one entry). We may be able to repair this by
 		 * wrapping the returned Package with a new outer Package.
 		 */
-		if ((*elements)->common.type != ACPI_TYPE_PACKAGE) {
+		if (*elements
+		    && ((*elements)->common.type != ACPI_TYPE_PACKAGE)) {
 
 			/* Create the new outer package and populate it */
 
@@ -673,6 +674,7 @@ acpi_ns_check_package_list(struct acpi_predefined_data *data,
 	union acpi_operand_object *sub_package;
 	union acpi_operand_object **sub_elements;
 	acpi_status status;
+	u8 non_trailing_null = FALSE;
 	u32 expected_count;
 	u32 i;
 	u32 j;
@@ -680,6 +682,45 @@ acpi_ns_check_package_list(struct acpi_predefined_data *data,
 	/* Validate each sub-Package in the parent Package */
 
 	for (i = 0; i < count; i++) {
+		/*
+		 * Handling for NULL package elements. For now, we will simply allow
+		 * a parent package with trailing NULL elements. This can happen if
+		 * the package was defined to be longer than the initializer list.
+		 * This is legal as per the ACPI specification. It is often used
+		 * to allow for dynamic initialization of a Package.
+		 *
+		 * A future enhancement may be to simply truncate the package to
+		 * remove the trailing NULL elements.
+		 */
+		if (!(*elements)) {
+			if (!non_trailing_null) {
+
+				/* Ensure the remaining elements are all NULL */
+
+				for (j = 1; j < (count - i + 1); j++) {
+					if (elements[j]) {
+						non_trailing_null = TRUE;
+					}
+				}
+
+				if (!non_trailing_null) {
+
+					/* Ignore the trailing NULL elements */
+
+					return (AE_OK);
+				}
+			}
+
+			/* There are trailing non-null elements, issue warning */
+
+			ACPI_WARN_PREDEFINED((AE_INFO, data->pathname,
+					      data->node_flags,
+					      "Found NULL element at package index %u",
+					      i));
+			elements++;
+			continue;
+		}
+
 		sub_package = *elements;
 		sub_elements = sub_package->package.elements;
 

>From 42ef79aa0a52b2ca57811318191ec66150b02dbe Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Thu, 12 Nov 2009 09:44:06 +0800
Subject: [PATCH 5/9] ACPICA: Add repair for predefined methods that must return sorted lists

This change will repair (by sorting) packages returned by _ALR,
_PSS, and _TSS. Drivers can now assume that the packages are
correctly sorted. Adds one new file, nsrepair2.c.
ACPICA BZ 784.

http://www.acpica.org/bugzilla/show_bug.cgi?id=784

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/Makefile    |    2 +-
 drivers/acpi/acpica/acnamesp.h  |   13 +-
 drivers/acpi/acpica/nspredef.c  |    6 +
 drivers/acpi/acpica/nsrepair2.c |  540 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 559 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index e7973bc..7423052 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -28,7 +28,7 @@ acpi-$(ACPI_FUTURE_USAGE) += hwtimer.o
 acpi-y += nsaccess.o  nsload.o    nssearch.o  nsxfeval.o \
 	 nsalloc.o   nseval.o    nsnames.o   nsutils.o   nsxfname.o \
 	 nsdump.o    nsinit.o    nsobject.o  nswalk.o    nsxfobj.o  \
-	 nsparse.o   nspredef.o  nsrepair.o
+	 nsparse.o   nspredef.o  nsrepair.o  nsrepair2.o
 
 acpi-$(ACPI_FUTURE_USAGE) += nsdumpdv.o
 
diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 168e608..ab83919 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -273,7 +273,8 @@ acpi_ns_get_attached_data(struct acpi_namespace_node *node,
 			  acpi_object_handler handler, void **data);
 
 /*
- * nsrepair - return object repair for predefined methods/objects
+ * nsrepair - General return object repair for all
+ * predefined methods/objects
  */
 acpi_status
 acpi_ns_repair_object(struct acpi_predefined_data *data,
@@ -286,6 +287,16 @@ acpi_ns_repair_package_list(struct acpi_predefined_data *data,
 			    union acpi_operand_object **obj_desc_ptr);
 
 /*
+ * nsrepair2 - Return object repair for specific
+ * predefined methods/objects
+ */
+acpi_status
+acpi_ns_complex_repairs(struct acpi_predefined_data *data,
+			struct acpi_namespace_node *node,
+			acpi_status validate_status,
+			union acpi_operand_object **return_object_ptr);
+
+/*
  * nssearch - Namespace searching and entry
  */
 acpi_status
diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 4028098..b05f429 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -232,6 +232,12 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 		status = acpi_ns_check_package(data, return_object_ptr);
 	}
 
+	/*
+	 * Perform additional, more complicated repairs on a per-name
+	 * basis.
+	 */
+	status = acpi_ns_complex_repairs(data, node, status, return_object_ptr);
+
 check_validation_status:
 	/*
 	 * If the object validation failed or if we successfully repaired one
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
new file mode 100644
index 0000000..d07b686
--- /dev/null
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -0,0 +1,540 @@
+/******************************************************************************
+ *
+ * Module Name: nsrepair2 - Repair for objects returned by specific
+ *                          predefined methods
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2009, Intel Corp.
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
+#define _COMPONENT          ACPI_NAMESPACE
+ACPI_MODULE_NAME("nsrepair2")
+
+/*
+ * Information structure and handler for ACPI predefined names that can
+ * be repaired on a per-name basis.
+ */
+typedef
+acpi_status(*acpi_repair_function) (struct acpi_predefined_data *data,
+				    union acpi_operand_object **return_object_ptr);
+
+typedef struct acpi_repair_info {
+	char name[ACPI_NAME_SIZE];
+	acpi_repair_function repair_function;
+
+} acpi_repair_info;
+
+/* Local prototypes */
+
+static const struct acpi_repair_info *acpi_ns_match_repairable_name(struct
+								    acpi_namespace_node
+								    *node);
+
+static acpi_status
+acpi_ns_repair_ALR(struct acpi_predefined_data *data,
+		   union acpi_operand_object **return_object_ptr);
+
+static acpi_status
+acpi_ns_repair_PSS(struct acpi_predefined_data *data,
+		   union acpi_operand_object **return_object_ptr);
+
+static acpi_status
+acpi_ns_repair_TSS(struct acpi_predefined_data *data,
+		   union acpi_operand_object **return_object_ptr);
+
+static acpi_status
+acpi_ns_check_sorted_list(struct acpi_predefined_data *data,
+			  union acpi_operand_object *return_object,
+			  u32 expected_count,
+			  u32 sort_index,
+			  u8 sort_direction, char *sort_key_name);
+
+static acpi_status
+acpi_ns_remove_null_elements(union acpi_operand_object *package);
+
+static acpi_status
+acpi_ns_sort_list(union acpi_operand_object **elements,
+		  u32 count, u32 index, u8 sort_direction);
+
+/* Values for sort_direction above */
+
+#define ACPI_SORT_ASCENDING     0
+#define ACPI_SORT_DESCENDING    1
+
+/*
+ * This table contains the names of the predefined methods for which we can
+ * perform more complex repairs.
+ *
+ * _ALR: Sort the list ascending by ambient_illuminance if necessary
+ * _PSS: Sort the list descending by Power if necessary
+ * _TSS: Sort the list descending by Power if necessary
+ */
+static const struct acpi_repair_info acpi_ns_repairable_names[] = {
+	{"_ALR", acpi_ns_repair_ALR},
+	{"_PSS", acpi_ns_repair_PSS},
+	{"_TSS", acpi_ns_repair_TSS},
+	{{0, 0, 0, 0}, NULL}	/* Table terminator */
+};
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_complex_repairs
+ *
+ * PARAMETERS:  Data                - Pointer to validation data structure
+ *              Node                - Namespace node for the method/object
+ *              validate_status     - Original status of earlier validation
+ *              return_object_ptr   - Pointer to the object returned from the
+ *                                    evaluation of a method or object
+ *
+ * RETURN:      Status. AE_OK if repair was successful. If name is not
+ *              matched, validate_status is returned.
+ *
+ * DESCRIPTION: Attempt to repair/convert a return object of a type that was
+ *              not expected.
+ *
+ *****************************************************************************/
+
+acpi_status
+acpi_ns_complex_repairs(struct acpi_predefined_data *data,
+			struct acpi_namespace_node *node,
+			acpi_status validate_status,
+			union acpi_operand_object **return_object_ptr)
+{
+	const struct acpi_repair_info *predefined;
+	acpi_status status;
+
+	/* Check if this name is in the list of repairable names */
+
+	predefined = acpi_ns_match_repairable_name(node);
+	if (!predefined) {
+		return (validate_status);
+	}
+
+	status = predefined->repair_function(data, return_object_ptr);
+	return (status);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_match_repairable_name
+ *
+ * PARAMETERS:  Node                - Namespace node for the method/object
+ *
+ * RETURN:      Pointer to entry in repair table. NULL indicates not found.
+ *
+ * DESCRIPTION: Check an object name against the repairable object list.
+ *
+ *****************************************************************************/
+
+static const struct acpi_repair_info *acpi_ns_match_repairable_name(struct
+								    acpi_namespace_node
+								    *node)
+{
+	const struct acpi_repair_info *this_name;
+
+	/* Search info table for a repairable predefined method/object name */
+
+	this_name = acpi_ns_repairable_names;
+	while (this_name->repair_function) {
+		if (ACPI_COMPARE_NAME(node->name.ascii, this_name->name)) {
+			return (this_name);
+		}
+		this_name++;
+	}
+
+	return (NULL);		/* Not found */
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_repair_ALR
+ *
+ * PARAMETERS:  Data                - Pointer to validation data structure
+ *              return_object_ptr   - Pointer to the object returned from the
+ *                                    evaluation of a method or object
+ *
+ * RETURN:      Status. AE_OK if object is OK or was repaired successfully
+ *
+ * DESCRIPTION: Repair for the _ALR object. If necessary, sort the object list
+ *              ascending by the ambient illuminance values.
+ *
+ *****************************************************************************/
+
+static acpi_status
+acpi_ns_repair_ALR(struct acpi_predefined_data *data,
+		   union acpi_operand_object **return_object_ptr)
+{
+	union acpi_operand_object *return_object = *return_object_ptr;
+	acpi_status status;
+
+	status = acpi_ns_check_sorted_list(data, return_object, 2, 1,
+					   ACPI_SORT_ASCENDING,
+					   "AmbientIlluminance");
+
+	return (status);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_repair_TSS
+ *
+ * PARAMETERS:  Data                - Pointer to validation data structure
+ *              return_object_ptr   - Pointer to the object returned from the
+ *                                    evaluation of a method or object
+ *
+ * RETURN:      Status. AE_OK if object is OK or was repaired successfully
+ *
+ * DESCRIPTION: Repair for the _TSS object. If necessary, sort the object list
+ *              descending by the power dissipation values.
+ *
+ *****************************************************************************/
+
+static acpi_status
+acpi_ns_repair_TSS(struct acpi_predefined_data *data,
+		   union acpi_operand_object **return_object_ptr)
+{
+	union acpi_operand_object *return_object = *return_object_ptr;
+	acpi_status status;
+
+	status = acpi_ns_check_sorted_list(data, return_object, 5, 1,
+					   ACPI_SORT_DESCENDING,
+					   "PowerDissipation");
+
+	return (status);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_repair_PSS
+ *
+ * PARAMETERS:  Data                - Pointer to validation data structure
+ *              return_object_ptr   - Pointer to the object returned from the
+ *                                    evaluation of a method or object
+ *
+ * RETURN:      Status. AE_OK if object is OK or was repaired successfully
+ *
+ * DESCRIPTION: Repair for the _PSS object. If necessary, sort the object list
+ *              by the CPU frequencies. Check that the power dissipation values
+ *              are all proportional to CPU frequency (i.e., sorting by
+ *              frequency should be the same as sorting by power.)
+ *
+ *****************************************************************************/
+
+static acpi_status
+acpi_ns_repair_PSS(struct acpi_predefined_data *data,
+		   union acpi_operand_object **return_object_ptr)
+{
+	union acpi_operand_object *return_object = *return_object_ptr;
+	union acpi_operand_object **outer_elements;
+	u32 outer_element_count;
+	union acpi_operand_object **elements;
+	union acpi_operand_object *obj_desc;
+	u32 previous_value;
+	acpi_status status;
+	u32 i;
+
+	/*
+	 * Entries (sub-packages) in the _PSS Package must be sorted by power
+	 * dissipation, in descending order. If it appears that the list is
+	 * incorrectly sorted, sort it. We sort by cpu_frequency, since this
+	 * should be proportional to the power.
+	 */
+	status = acpi_ns_check_sorted_list(data, return_object, 6, 0,
+					   ACPI_SORT_DESCENDING,
+					   "CpuFrequency");
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	/*
+	 * We now know the list is correctly sorted by CPU frequency. Check if
+	 * the power dissipation values are proportional.
+	 */
+	previous_value = ACPI_UINT32_MAX;
+	outer_elements = return_object->package.elements;
+	outer_element_count = return_object->package.count;
+
+	for (i = 0; i < outer_element_count; i++) {
+		elements = (*outer_elements)->package.elements;
+		obj_desc = elements[1];	/* Index1 = power_dissipation */
+
+		if ((u32) obj_desc->integer.value > previous_value) {
+			ACPI_WARN_PREDEFINED((AE_INFO, data->pathname,
+					      data->node_flags,
+					      "SubPackage[%u,%u] - suspicious power dissipation values",
+					      i - 1, i));
+		}
+
+		previous_value = (u32) obj_desc->integer.value;
+		outer_elements++;
+	}
+
+	return (AE_OK);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_check_sorted_list
+ *
+ * PARAMETERS:  Data                - Pointer to validation data structure
+ *              return_object       - Pointer to the top-level returned object
+ *              expected_count      - Minimum length of each sub-package
+ *              sort_index          - Sub-package entry to sort on
+ *              sort_direction      - Ascending or descending
+ *              sort_key_name       - Name of the sort_index field
+ *
+ * RETURN:      Status. AE_OK if the list is valid and is sorted correctly or
+ *              has been repaired by sorting the list.
+ *
+ * DESCRIPTION: Check if the package list is valid and sorted correctly by the
+ *              sort_index. If not, then sort the list.
+ *
+ *****************************************************************************/
+
+static acpi_status
+acpi_ns_check_sorted_list(struct acpi_predefined_data *data,
+			  union acpi_operand_object *return_object,
+			  u32 expected_count,
+			  u32 sort_index,
+			  u8 sort_direction, char *sort_key_name)
+{
+	u32 outer_element_count;
+	union acpi_operand_object **outer_elements;
+	union acpi_operand_object **elements;
+	union acpi_operand_object *obj_desc;
+	u32 i;
+	u32 previous_value;
+	acpi_status status;
+
+	/* The top-level object must be a package */
+
+	if (return_object->common.type != ACPI_TYPE_PACKAGE) {
+		return (AE_AML_OPERAND_TYPE);
+	}
+
+	/*
+	 * Detect any NULL package elements and remove them from the
+	 * package.
+	 *
+	 * TBD: We may want to do this for all predefined names that
+	 * return a variable-length package of packages.
+	 */
+	status = acpi_ns_remove_null_elements(return_object);
+	if (status == AE_NULL_ENTRY) {
+		ACPI_INFO_PREDEFINED((AE_INFO, data->pathname, data->node_flags,
+				      "NULL elements removed from package"));
+
+		/* Exit if package is now zero length */
+
+		if (!return_object->package.count) {
+			return (AE_NULL_ENTRY);
+		}
+	}
+
+	outer_elements = return_object->package.elements;
+	outer_element_count = return_object->package.count;
+	if (!outer_element_count) {
+		return (AE_AML_PACKAGE_LIMIT);
+	}
+
+	previous_value = 0;
+	if (sort_direction == ACPI_SORT_DESCENDING) {
+		previous_value = ACPI_UINT32_MAX;
+	}
+
+	/* Examine each subpackage */
+
+	for (i = 0; i < outer_element_count; i++) {
+
+		/* Each element of the top-level package must also be a package */
+
+		if ((*outer_elements)->common.type != ACPI_TYPE_PACKAGE) {
+			return (AE_AML_OPERAND_TYPE);
+		}
+
+		/* Each sub-package must have the minimum length */
+
+		if ((*outer_elements)->package.count < expected_count) {
+			return (AE_AML_PACKAGE_LIMIT);
+		}
+
+		elements = (*outer_elements)->package.elements;
+		obj_desc = elements[sort_index];
+
+		if (obj_desc->common.type != ACPI_TYPE_INTEGER) {
+			return (AE_AML_OPERAND_TYPE);
+		}
+
+		/*
+		 * The list must be sorted in the specified order. If we detect a
+		 * discrepancy, issue a warning and sort the entire list
+		 */
+		if (((sort_direction == ACPI_SORT_ASCENDING) &&
+		     (obj_desc->integer.value < previous_value)) ||
+		    ((sort_direction == ACPI_SORT_DESCENDING) &&
+		     (obj_desc->integer.value > previous_value))) {
+			status =
+			    acpi_ns_sort_list(return_object->package.elements,
+					      outer_element_count, sort_index,
+					      sort_direction);
+			if (ACPI_FAILURE(status)) {
+				return (status);
+			}
+
+			data->flags |= ACPI_OBJECT_REPAIRED;
+
+			ACPI_INFO_PREDEFINED((AE_INFO, data->pathname,
+					      data->node_flags,
+					      "Repaired unsorted list - now sorted by %s",
+					      sort_key_name));
+			return (AE_OK);
+		}
+
+		previous_value = (u32) obj_desc->integer.value;
+		outer_elements++;
+	}
+
+	return (AE_OK);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_remove_null_elements
+ *
+ * PARAMETERS:  obj_desc            - A Package object
+ *
+ * RETURN:      Status. AE_NULL_ENTRY means that one or more elements were
+ *              removed.
+ *
+ * DESCRIPTION: Remove all NULL package elements and update the package count.
+ *
+ *****************************************************************************/
+
+static acpi_status
+acpi_ns_remove_null_elements(union acpi_operand_object *obj_desc)
+{
+	union acpi_operand_object **source;
+	union acpi_operand_object **dest;
+	acpi_status status = AE_OK;
+	u32 count;
+	u32 new_count;
+	u32 i;
+
+	count = obj_desc->package.count;
+	new_count = count;
+
+	source = obj_desc->package.elements;
+	dest = source;
+
+	/* Examine all elements of the package object */
+
+	for (i = 0; i < count; i++) {
+		if (!*source) {
+			status = AE_NULL_ENTRY;
+			new_count--;
+		} else {
+			*dest = *source;
+			dest++;
+		}
+		source++;
+	}
+
+	if (status == AE_NULL_ENTRY) {
+
+		/* NULL terminate list and update the package count */
+
+		*dest = NULL;
+		obj_desc->package.count = new_count;
+	}
+
+	return (status);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_ns_sort_list
+ *
+ * PARAMETERS:  Elements            - Package object element list
+ *              Count               - Element count for above
+ *              Index               - Sort by which package element
+ *              sort_direction      - Ascending or Descending sort
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Sort the objects that are in a package element list.
+ *
+ * NOTE: Assumes that all NULL elements have been removed from the package.
+ *
+ *****************************************************************************/
+
+static acpi_status
+acpi_ns_sort_list(union acpi_operand_object **elements,
+		  u32 count, u32 index, u8 sort_direction)
+{
+	union acpi_operand_object *obj_desc1;
+	union acpi_operand_object *obj_desc2;
+	union acpi_operand_object *temp_obj;
+	u32 i;
+	u32 j;
+
+	/* Simple bubble sort */
+
+	for (i = 1; i < count; i++) {
+		for (j = (count - 1); j >= i; j--) {
+			obj_desc1 = elements[j - 1]->package.elements[index];
+			obj_desc2 = elements[j]->package.elements[index];
+
+			if (((sort_direction == ACPI_SORT_ASCENDING) &&
+			     (obj_desc1->integer.value >
+			      obj_desc2->integer.value))
+			    || ((sort_direction == ACPI_SORT_DESCENDING)
+				&& (obj_desc1->integer.value <
+				    obj_desc2->integer.value))) {
+				temp_obj = elements[j - 1];
+				elements[j - 1] = elements[j];
+				elements[j] = temp_obj;
+			}
+		}
+	}
+
+	return (AE_OK);
+}

>From 1754c0e2df77c095e713187967a7b048e20d48cc Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Thu, 12 Nov 2009 09:49:50 +0800
Subject: [PATCH 6/9] ACPICA: New internal utility function to create Integer objects

acpi_ut_create_integer_object. This function (when deployed) should
simplify some of the object creation code.  ACPICA BZ 823.

http://www.acpica.org/bugzilla/show_bug.cgi?id=823

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/acutils.h  |    2 ++
 drivers/acpi/acpica/utobject.c |   29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index f920d89..3a451a2 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -386,6 +386,8 @@ u8 acpi_ut_valid_internal_object(void *object);
 
 union acpi_operand_object *acpi_ut_create_package_object(u32 count);
 
+union acpi_operand_object *acpi_ut_create_integer_object(u64 value);
+
 union acpi_operand_object *acpi_ut_create_buffer_object(acpi_size buffer_size);
 
 union acpi_operand_object *acpi_ut_create_string_object(acpi_size string_size);
diff --git a/drivers/acpi/acpica/utobject.c b/drivers/acpi/acpica/utobject.c
index 0207b62..42e658b 100644
--- a/drivers/acpi/acpica/utobject.c
+++ b/drivers/acpi/acpica/utobject.c
@@ -190,6 +190,35 @@ union acpi_operand_object *acpi_ut_create_package_object(u32 count)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ut_create_integer_object
+ *
+ * PARAMETERS:  initial_value       - Initial value for the integer
+ *
+ * RETURN:      Pointer to a new Integer object, null on failure
+ *
+ * DESCRIPTION: Create an initialized integer object
+ *
+ ******************************************************************************/
+
+union acpi_operand_object *acpi_ut_create_integer_object(u64 initial_value)
+{
+	union acpi_operand_object *integer_desc;
+
+	ACPI_FUNCTION_TRACE(ut_create_integer_object);
+
+	/* Create and initialize a new integer object */
+
+	integer_desc = acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
+	if (!integer_desc) {
+		return_PTR(NULL);
+	}
+
+	integer_desc->integer.value = initial_value;
+	return_PTR(integer_desc);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ut_create_buffer_object
  *
  * PARAMETERS:  buffer_size            - Size of buffer to be created

>From f081db99cc7b75333b9217c7fceed5a6a43fdcbf Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Thu, 12 Nov 2009 09:52:45 +0800
Subject: [PATCH 7/9] ACPICA: Deploy new create integer interface where appropriate

Simplifies creation of simple integer objects.
ACPICA BZ 823.

http://www.acpica.org/bugzilla/show_bug.cgi?id=823

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/dsmthdat.c |    4 +---
 drivers/acpi/acpica/evregion.c |   11 ++++-------
 drivers/acpi/acpica/exconfig.c |    4 +---
 drivers/acpi/acpica/exconvrt.c |    3 +--
 drivers/acpi/acpica/exfield.c  |    3 +--
 drivers/acpi/acpica/exoparg1.c |   38 +++++++++++++++++---------------------
 drivers/acpi/acpica/exoparg6.c |    7 ++-----
 drivers/acpi/acpica/psparse.c  |    8 ++------
 drivers/acpi/acpica/psxface.c  |    4 +---
 9 files changed, 30 insertions(+), 52 deletions(-)

diff --git a/drivers/acpi/acpica/dsmthdat.c b/drivers/acpi/acpica/dsmthdat.c
index 7d077bb..0ba19f8 100644
--- a/drivers/acpi/acpica/dsmthdat.c
+++ b/drivers/acpi/acpica/dsmthdat.c
@@ -409,13 +409,11 @@ acpi_ds_method_data_get_value(u8 type,
 		/* If slack enabled, init the local_x/arg_x to an Integer of value zero */
 
 		if (acpi_gbl_enable_interpreter_slack) {
-			object =
-			    acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
+			object = acpi_ut_create_integer_object((u64) 0);
 			if (!object) {
 				return_ACPI_STATUS(AE_NO_MEMORY);
 			}
 
-			object->integer.value = 0;
 			node->object = object;
 		}
 
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 582b0af..0bc807c 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -289,23 +289,20 @@ acpi_ev_execute_reg_method(union acpi_operand_object *region_obj, u32 function)
 	 *  connection status 1 for connecting the handler, 0 for disconnecting
 	 *  the handler (Passed as a parameter)
 	 */
-	args[0] = acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
+	args[0] =
+	    acpi_ut_create_integer_object((u64) region_obj->region.space_id);
 	if (!args[0]) {
 		status = AE_NO_MEMORY;
 		goto cleanup1;
 	}
 
-	args[1] = acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
+	args[1] = acpi_ut_create_integer_object((u64) function);
 	if (!args[1]) {
 		status = AE_NO_MEMORY;
 		goto cleanup2;
 	}
 
-	/* Setup the parameter objects */
-
-	args[0]->integer.value = region_obj->region.space_id;
-	args[1]->integer.value = function;
-	args[2] = NULL;
+	args[2] = NULL;		/* Terminate list */
 
 	/* Execute the method, no return value */
 
diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 24afef8..46adfa5 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -170,14 +170,12 @@ acpi_ex_load_table_op(struct acpi_walk_state *walk_state,
 
 		/* Table not found, return an Integer=0 and AE_OK */
 
-		ddb_handle = acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
+		ddb_handle = acpi_ut_create_integer_object((u64) 0);
 		if (!ddb_handle) {
 			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
 
-		ddb_handle->integer.value = 0;
 		*return_desc = ddb_handle;
-
 		return_ACPI_STATUS(AE_OK);
 	}
 
diff --git a/drivers/acpi/acpica/exconvrt.c b/drivers/acpi/acpica/exconvrt.c
index 37d0d39..51d5f22 100644
--- a/drivers/acpi/acpica/exconvrt.c
+++ b/drivers/acpi/acpica/exconvrt.c
@@ -167,7 +167,7 @@ acpi_ex_convert_to_integer(union acpi_operand_object *obj_desc,
 
 	/* Create a new integer */
 
-	return_desc = acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
+	return_desc = acpi_ut_create_integer_object(result);
 	if (!return_desc) {
 		return_ACPI_STATUS(AE_NO_MEMORY);
 	}
@@ -177,7 +177,6 @@ acpi_ex_convert_to_integer(union acpi_operand_object *obj_desc,
 
 	/* Save the Result */
 
-	return_desc->integer.value = result;
 	acpi_ex_truncate_for32bit_table(return_desc);
 	*result_desc = return_desc;
 	return_ACPI_STATUS(AE_OK);
diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index 0b33d6c..1588a2d 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -162,13 +162,12 @@ acpi_ex_read_data_from_field(struct acpi_walk_state *walk_state,
 	} else {
 		/* Field will fit within an Integer (normal case) */
 
-		buffer_desc = acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
+		buffer_desc = acpi_ut_create_integer_object((u64) 0);
 		if (!buffer_desc) {
 			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
 
 		length = acpi_gbl_integer_byte_width;
-		buffer_desc->integer.value = 0;
 		buffer = &buffer_desc->integer.value;
 	}
 
diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index 9635d21..752fe48 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -100,12 +100,12 @@ acpi_status acpi_ex_opcode_0A_0T_1R(struct acpi_walk_state *walk_state)
 
 		/* Create a return object of type Integer */
 
-		return_desc = acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
+		return_desc =
+		    acpi_ut_create_integer_object(acpi_os_get_timer());
 		if (!return_desc) {
 			status = AE_NO_MEMORY;
 			goto cleanup;
 		}
-		return_desc->integer.value = acpi_os_get_timer();
 		break;
 
 	default:		/*  Unknown opcode  */
@@ -599,7 +599,7 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 	switch (walk_state->opcode) {
 	case AML_LNOT_OP:	/* LNot (Operand) */
 
-		return_desc = acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
+		return_desc = acpi_ut_create_integer_object((u64) 0);
 		if (!return_desc) {
 			status = AE_NO_MEMORY;
 			goto cleanup;
@@ -702,13 +702,11 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 
 		/* Allocate a descriptor to hold the type. */
 
-		return_desc = acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
+		return_desc = acpi_ut_create_integer_object((u64) type);
 		if (!return_desc) {
 			status = AE_NO_MEMORY;
 			goto cleanup;
 		}
-
-		return_desc->integer.value = type;
 		break;
 
 	case AML_SIZE_OF_OP:	/* size_of (source_object) */
@@ -777,13 +775,11 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 		 * Now that we have the size of the object, create a result
 		 * object to hold the value
 		 */
-		return_desc = acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
+		return_desc = acpi_ut_create_integer_object(value);
 		if (!return_desc) {
 			status = AE_NO_MEMORY;
 			goto cleanup;
 		}
-
-		return_desc->integer.value = value;
 		break;
 
 	case AML_REF_OF_OP:	/* ref_of (source_object) */
@@ -946,24 +942,24 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 					 * NOTE: index into a buffer is NOT a pointer to a
 					 * sub-buffer of the main buffer, it is only a pointer to a
 					 * single element (byte) of the buffer!
+					 *
+					 * Since we are returning the value of the buffer at the
+					 * indexed location, we don't need to add an additional
+					 * reference to the buffer itself.
 					 */
 					return_desc =
-					    acpi_ut_create_internal_object
-					    (ACPI_TYPE_INTEGER);
+					    acpi_ut_create_integer_object((u64)
+									  temp_desc->
+									  buffer.
+									  pointer
+									  [operand
+									   [0]->
+									   reference.
+									   value]);
 					if (!return_desc) {
 						status = AE_NO_MEMORY;
 						goto cleanup;
 					}
-
-					/*
-					 * Since we are returning the value of the buffer at the
-					 * indexed location, we don't need to add an additional
-					 * reference to the buffer itself.
-					 */
-					return_desc->integer.value =
-					    temp_desc->buffer.
-					    pointer[operand[0]->reference.
-						    value];
 					break;
 
 				case ACPI_TYPE_PACKAGE:
diff --git a/drivers/acpi/acpica/exoparg6.c b/drivers/acpi/acpica/exoparg6.c
index ae43f76..295542e 100644
--- a/drivers/acpi/acpica/exoparg6.c
+++ b/drivers/acpi/acpica/exoparg6.c
@@ -253,18 +253,15 @@ acpi_status acpi_ex_opcode_6A_0T_1R(struct acpi_walk_state * walk_state)
 		}
 
 		/* Create an integer for the return value */
+		/* Default return value is ACPI_INTEGER_MAX if no match found */
 
-		return_desc = acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
+		return_desc = acpi_ut_create_integer_object(ACPI_INTEGER_MAX);
 		if (!return_desc) {
 			status = AE_NO_MEMORY;
 			goto cleanup;
 
 		}
 
-		/* Default return value if no match found */
-
-		return_desc->integer.value = ACPI_INTEGER_MAX;
-
 		/*
 		 * Examine each element until a match is found. Both match conditions
 		 * must be satisfied for a match to occur. Within the loop,
diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index 70838e9..4df8f13 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -610,17 +610,13 @@ acpi_status acpi_ps_parse_aml(struct acpi_walk_state *walk_state)
 					    implicit_return_obj) {
 						previous_walk_state->
 						    implicit_return_obj =
-						    acpi_ut_create_internal_object
-						    (ACPI_TYPE_INTEGER);
+						    acpi_ut_create_integer_object
+						    ((u64) 0);
 						if (!previous_walk_state->
 						    implicit_return_obj) {
 							return_ACPI_STATUS
 							    (AE_NO_MEMORY);
 						}
-
-						previous_walk_state->
-						    implicit_return_obj->
-						    integer.value = 0;
 					}
 
 					/* Restart the calling control method */
diff --git a/drivers/acpi/acpica/psxface.c b/drivers/acpi/acpica/psxface.c
index dd9731c..12934ad 100644
--- a/drivers/acpi/acpica/psxface.c
+++ b/drivers/acpi/acpica/psxface.c
@@ -306,14 +306,12 @@ acpi_status acpi_ps_execute_method(struct acpi_evaluate_info *info)
 	 */
 	if (acpi_gbl_enable_interpreter_slack) {
 		walk_state->implicit_return_obj =
-		    acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
+		    acpi_ut_create_integer_object((u64) 0);
 		if (!walk_state->implicit_return_obj) {
 			status = AE_NO_MEMORY;
 			acpi_ds_delete_walk_state(walk_state);
 			goto cleanup;
 		}
-
-		walk_state->implicit_return_obj->integer.value = 0;
 	}
 
 	/* Parse the AML */

>From 88aa1bc0054f410b70ca7b106f08eef6230953af Mon Sep 17 00:00:00 2001
From: Lin Ming <ming.m.lin@intel.com>
Date: Thu, 12 Nov 2009 09:57:53 +0800
Subject: [PATCH 8/9] ACPICA: Add additional module-level code support

This change will execute module-level code that is not at the
root of the namespace (under a Device object, etc.).
ACPICA BZ 762.

http://www.acpica.org/bugzilla/show_bug.cgi?id=762

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/nseval.c |   50 +++++++++++++++++++++++++++++------------
 drivers/acpi/acpica/psloop.c |   32 +++++++++++++++++++++-----
 2 files changed, 61 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/acpica/nseval.c b/drivers/acpi/acpica/nseval.c
index 846d113..f771e97 100644
--- a/drivers/acpi/acpica/nseval.c
+++ b/drivers/acpi/acpica/nseval.c
@@ -366,33 +366,49 @@ static void
 acpi_ns_exec_module_code(union acpi_operand_object *method_obj,
 			 struct acpi_evaluate_info *info)
 {
-	union acpi_operand_object *root_obj;
+	union acpi_operand_object *parent_obj;
+	struct acpi_namespace_node *parent_node;
+	acpi_object_type type;
 	acpi_status status;
 
 	ACPI_FUNCTION_TRACE(ns_exec_module_code);
 
+	/*
+	 * Get the parent node. We cheat by using the next_object field
+	 * of the method object descriptor.
+	 */
+	parent_node = ACPI_CAST_PTR(struct acpi_namespace_node,
+				    method_obj->method.next_object);
+	type = acpi_ns_get_type(parent_node);
+
+	/* Must clear next_object (acpi_ns_attach_object needs the field) */
+
+	method_obj->method.next_object = NULL;
+
 	/* Initialize the evaluation information block */
 
 	ACPI_MEMSET(info, 0, sizeof(struct acpi_evaluate_info));
-	info->prefix_node = acpi_gbl_root_node;
+	info->prefix_node = parent_node;
 
 	/*
-	 * Get the currently attached root object. Add a reference, because the
+	 * Get the currently attached parent object. Add a reference, because the
 	 * ref count will be decreased when the method object is installed to
-	 * the root node.
+	 * the parent node.
 	 */
-	root_obj = acpi_ns_get_attached_object(acpi_gbl_root_node);
-	acpi_ut_add_reference(root_obj);
+	parent_obj = acpi_ns_get_attached_object(parent_node);
+	if (parent_obj) {
+		acpi_ut_add_reference(parent_obj);
+	}
 
-	/* Install the method (module-level code) in the root node */
+	/* Install the method (module-level code) in the parent node */
 
-	status = acpi_ns_attach_object(acpi_gbl_root_node, method_obj,
+	status = acpi_ns_attach_object(parent_node, method_obj,
 				       ACPI_TYPE_METHOD);
 	if (ACPI_FAILURE(status)) {
 		goto exit;
 	}
 
-	/* Execute the root node as a control method */
+	/* Execute the parent node as a control method */
 
 	status = acpi_ns_evaluate(info);
 
@@ -401,15 +417,19 @@ acpi_ns_exec_module_code(union acpi_operand_object *method_obj,
 
 	/* Detach the temporary method object */
 
-	acpi_ns_detach_object(acpi_gbl_root_node);
+	acpi_ns_detach_object(parent_node);
 
-	/* Restore the original root object */
+	/* Restore the original parent object */
 
-	status =
-	    acpi_ns_attach_object(acpi_gbl_root_node, root_obj,
-				  ACPI_TYPE_DEVICE);
+	if (parent_obj) {
+		status = acpi_ns_attach_object(parent_node, parent_obj, type);
+	} else {
+		parent_node->type = (u8)type;
+	}
 
       exit:
-	acpi_ut_remove_reference(root_obj);
+	if (parent_obj) {
+		acpi_ut_remove_reference(parent_obj);
+	}
 	return_VOID;
 }
diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index cd7995b..0988e4a 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -87,7 +87,8 @@ acpi_ps_complete_final_op(struct acpi_walk_state *walk_state,
 			  union acpi_parse_object *op, acpi_status status);
 
 static void
-acpi_ps_link_module_code(u8 *aml_start, u32 aml_length, acpi_owner_id owner_id);
+acpi_ps_link_module_code(union acpi_parse_object *parent_op,
+			 u8 *aml_start, u32 aml_length, acpi_owner_id owner_id);
 
 /*******************************************************************************
  *
@@ -479,11 +480,14 @@ acpi_ps_get_arguments(struct acpi_walk_state *walk_state,
 				 */
 				if (walk_state->pass_number ==
 				    ACPI_IMODE_LOAD_PASS1) {
-					acpi_ps_link_module_code(aml_op_start,
-								 walk_state->
+					acpi_ps_link_module_code(op->common.
+								 parent,
+								 aml_op_start,
+								 (u32)
+								 (walk_state->
 								 parser_state.
 								 pkg_end -
-								 aml_op_start,
+								 aml_op_start),
 								 walk_state->
 								 owner_id);
 				}
@@ -598,7 +602,8 @@ acpi_ps_get_arguments(struct acpi_walk_state *walk_state,
  *
  * FUNCTION:    acpi_ps_link_module_code
  *
- * PARAMETERS:  aml_start           - Pointer to the AML
+ * PARAMETERS:  parent_op           - Parent parser op
+ *              aml_start           - Pointer to the AML
  *              aml_length          - Length of executable AML
  *              owner_id            - owner_id of module level code
  *
@@ -611,11 +616,13 @@ acpi_ps_get_arguments(struct acpi_walk_state *walk_state,
  ******************************************************************************/
 
 static void
-acpi_ps_link_module_code(u8 *aml_start, u32 aml_length, acpi_owner_id owner_id)
+acpi_ps_link_module_code(union acpi_parse_object *parent_op,
+			 u8 *aml_start, u32 aml_length, acpi_owner_id owner_id)
 {
 	union acpi_operand_object *prev;
 	union acpi_operand_object *next;
 	union acpi_operand_object *method_obj;
+	struct acpi_namespace_node *parent_node;
 
 	/* Get the tail of the list */
 
@@ -639,11 +646,24 @@ acpi_ps_link_module_code(u8 *aml_start, u32 aml_length, acpi_owner_id owner_id)
 			return;
 		}
 
+		if (parent_op->common.node) {
+			parent_node = parent_op->common.node;
+		} else {
+			parent_node = acpi_gbl_root_node;
+		}
+
 		method_obj->method.aml_start = aml_start;
 		method_obj->method.aml_length = aml_length;
 		method_obj->method.owner_id = owner_id;
 		method_obj->method.flags |= AOPOBJ_MODULE_LEVEL;
 
+		/*
+		 * Save the parent node in next_object. This is cheating, but we
+		 * don't want to expand the method object.
+		 */
+		method_obj->method.next_object =
+		    ACPI_CAST_PTR(union acpi_operand_object, parent_node);
+
 		if (!prev) {
 			acpi_gbl_module_code_list = method_obj;
 		} else {

>From 2192674eb11f072fb5c10550b3eff248556f8675 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Fri, 13 Nov 2009 10:01:43 +0800
Subject: [PATCH 9/9] ACPICA: Update version to 20091112.

Version 20091112.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index f9b8b28..5e1ad3c 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -47,7 +47,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20091013
+#define ACPI_CA_VERSION                 0x20091112
 
 #include "actypes.h"
 #include "actbl.h"


--=-ZnkSx97vyhkN4mu2jjBN--

