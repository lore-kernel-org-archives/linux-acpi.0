From: Len Brown <len.brown@intel.com>
Subject: [PATCH 09/25] ACPI: Fix a warning of discarding qualifiers from pointer target type
Date: Fri, 24 Aug 2007 03:20:56 -0400
Message-ID: <1187940085345-git-send-email-len.brown@intel.com>
References: <11879400723077-git-send-email-len.brown@intel.com>
 <11879400762710-git-send-email-len.brown@intel.com>
 <11879400782033-git-send-email-len.brown@intel.com>
 <11879400793131-git-send-email-len.brown@intel.com>
 <11879400794174-git-send-email-len.brown@intel.com>
 <11879400802531-git-send-email-len.brown@intel.com>
 <11879400812208-git-send-email-len.brown@intel.com>
 <11879400823500-git-send-email-len.brown@intel.com>
 <11879400841550-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12497 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762486AbXHXHV1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 03:21:27 -0400
In-Reply-To: <11879400841550-git-send-email-len.brown@intel.com>
Message-Id: <f63211caacf6822049f02015faf1b78ba7a7984f.1187939442.git.len.brown@intel.com>
In-Reply-To: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
References: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Al Viro <viro@ftp.linux.org.uk>, Al Viro <viro@zeniv.linux.org.uk>, Len Brown <len.brown@intel.com>

From: Al Viro <viro@ftp.linux.org.uk>

drivers/acpi/ec.c: In function `acpi_ec_ecdt_probe':
drivers/acpi/ec.c:873: warning: passing arg 1 of `acpi_get_devices' discards qualifiers from pointer target type

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/namespace/nsxfeval.c |    2 +-
 include/acpi/acpixf.h             |    2 +-
 include/acpi/acstruct.h           |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/namespace/nsxfeval.c b/drivers/acpi/namespace/nsxfeval.c
index ab65b2c..f39fbc6 100644
--- a/drivers/acpi/namespace/nsxfeval.c
+++ b/drivers/acpi/namespace/nsxfeval.c
@@ -540,7 +540,7 @@ acpi_ns_get_device_callback(acpi_handle obj_handle,
  ******************************************************************************/
 
 acpi_status
-acpi_get_devices(char *HID,
+acpi_get_devices(const char *HID,
 		 acpi_walk_callback user_function,
 		 void *context, void **return_value)
 {
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index b5cca5d..3d7ab9e 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -130,7 +130,7 @@ acpi_walk_namespace(acpi_object_type type,
 		    void *context, void **return_value);
 
 acpi_status
-acpi_get_devices(char *HID,
+acpi_get_devices(const char *HID,
 		 acpi_walk_callback user_function,
 		 void *context, void **return_value);
 
diff --git a/include/acpi/acstruct.h b/include/acpi/acstruct.h
index aeb4498..8848265 100644
--- a/include/acpi/acstruct.h
+++ b/include/acpi/acstruct.h
@@ -146,7 +146,7 @@ struct acpi_init_walk_info {
 struct acpi_get_devices_info {
 	acpi_walk_callback user_function;
 	void *context;
-	char *hid;
+	const char *hid;
 };
 
 union acpi_aml_operands {
-- 
1.5.3.rc6.17.g1911
