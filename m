From: Len Brown <lenb@kernel.org>
Subject: [PATCH 20/22] ACPICA: Update/clarify some parameter names associated
 with acpi_handle
Date: Thu, 20 May 2010 01:18:48 -0400
Message-ID: <b47cf58edfa15cb8f384a4a5e7e7d65babb602f6.1274332658.git.len.brown@intel.com>
References: <1274332730-27370-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:36044 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613Ab0ETGPd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 May 2010 02:15:33 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L2P007GDG0X9AM5@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 20 May 2010 01:15:00 -0500 (CDT)
In-reply-to: <1274332730-27370-1-git-send-email-lenb@kernel.org>
In-reply-to: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
References: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Simple rename of some parameters to standardize them.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acpiosxf.h |    4 ++--
 include/acpi/acpixf.h   |   28 +++++++++++-----------------
 include/acpi/actypes.h  |    2 +-
 3 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index b396854..29bf945 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -233,8 +233,8 @@ acpi_os_write_pci_configuration(struct acpi_pci_id *pci_id,
  * Interim function needed for PCI IRQ routing
  */
 void
-acpi_os_derive_pci_id(acpi_handle rhandle,
-		      acpi_handle chandle, struct acpi_pci_id **pci_id);
+acpi_os_derive_pci_id(acpi_handle device,
+		      acpi_handle region, struct acpi_pci_id **pci_id);
 
 /*
  * Miscellaneous
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index e5bce4c..5366edf 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -166,7 +166,7 @@ acpi_get_devices(const char *HID,
 		 void *context, void **return_value);
 
 acpi_status
-acpi_get_name(acpi_handle handle,
+acpi_get_name(acpi_handle object,
 	      u32 name_type, struct acpi_buffer *ret_path_ptr);
 
 acpi_status
@@ -174,14 +174,12 @@ acpi_get_handle(acpi_handle parent,
 		acpi_string pathname, acpi_handle * ret_handle);
 
 acpi_status
-acpi_attach_data(acpi_handle obj_handle,
-		 acpi_object_handler handler, void *data);
+acpi_attach_data(acpi_handle object, acpi_object_handler handler, void *data);
 
-acpi_status
-acpi_detach_data(acpi_handle obj_handle, acpi_object_handler handler);
+acpi_status acpi_detach_data(acpi_handle object, acpi_object_handler handler);
 
 acpi_status
-acpi_get_data(acpi_handle obj_handle, acpi_object_handler handler, void **data);
+acpi_get_data(acpi_handle object, acpi_object_handler handler, void **data);
 
 acpi_status
 acpi_debug_trace(char *name, u32 debug_level, u32 debug_layer, u32 flags);
@@ -203,7 +201,7 @@ acpi_evaluate_object_typed(acpi_handle object,
 			   acpi_object_type return_type);
 
 acpi_status
-acpi_get_object_info(acpi_handle handle,
+acpi_get_object_info(acpi_handle object,
 		     struct acpi_device_info **return_buffer);
 
 acpi_status acpi_install_method(u8 *buffer);
@@ -318,33 +316,29 @@ acpi_status(*acpi_walk_resource_callback) (struct acpi_resource * resource,
 					   void *context);
 
 acpi_status
-acpi_get_vendor_resource(acpi_handle device_handle,
+acpi_get_vendor_resource(acpi_handle device,
 			 char *name,
 			 struct acpi_vendor_uuid *uuid,
 			 struct acpi_buffer *ret_buffer);
 
 acpi_status
-acpi_get_current_resources(acpi_handle device_handle,
-			   struct acpi_buffer *ret_buffer);
+acpi_get_current_resources(acpi_handle device, struct acpi_buffer *ret_buffer);
 
 #ifdef ACPI_FUTURE_USAGE
 acpi_status
-acpi_get_possible_resources(acpi_handle device_handle,
-			    struct acpi_buffer *ret_buffer);
+acpi_get_possible_resources(acpi_handle device, struct acpi_buffer *ret_buffer);
 #endif
 
 acpi_status
-acpi_walk_resources(acpi_handle device_handle,
+acpi_walk_resources(acpi_handle device,
 		    char *name,
 		    acpi_walk_resource_callback user_function, void *context);
 
 acpi_status
-acpi_set_current_resources(acpi_handle device_handle,
-			   struct acpi_buffer *in_buffer);
+acpi_set_current_resources(acpi_handle device, struct acpi_buffer *in_buffer);
 
 acpi_status
-acpi_get_irq_routing_table(acpi_handle bus_device_handle,
-			   struct acpi_buffer *ret_buffer);
+acpi_get_irq_routing_table(acpi_handle device, struct acpi_buffer *ret_buffer);
 
 acpi_status
 acpi_resource_to_address64(struct acpi_resource *resource,
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index de5e99a..bade172 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -951,7 +951,7 @@ acpi_status(*acpi_adr_space_setup) (acpi_handle region_handle,
 #define ACPI_REGION_DEACTIVATE  1
 
 typedef
-acpi_status(*acpi_walk_callback) (acpi_handle obj_handle,
+acpi_status(*acpi_walk_callback) (acpi_handle object,
 				  u32 nesting_level,
 				  void *context, void **return_value);
 
-- 
1.6.0.6

