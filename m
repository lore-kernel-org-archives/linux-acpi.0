From: Len Brown <lenb@kernel.org>
Subject: [PATCH 024/112] ACPI: Check for any matching CID when walking namespace.
Date: Thu,  7 Feb 2008 04:33:46 -0500
Message-ID: <02f8a8586574350a1f3c2cee79cbc0faf630961d.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:32156 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757697AbYBGJfv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:35:51 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Andrew Patterson <andrew.patterson@hp.com>, Len Brown <len.brown@intel.com>

From: Andrew Patterson <andrew.patterson@hp.com>

The callback function acpi_ns_get_device_callback called from
acpi_get_devices() will check CID's if the HID does not match.  This code
has a bug where it requires that all CIDs match the HID. Changed the code
so that any CID match will do.

Signed-off-by: Andrew Patterson <andrew.patterson@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/namespace/nsxfeval.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/namespace/nsxfeval.c b/drivers/acpi/namespace/nsxfeval.c
index f39fbc6..b92133f 100644
--- a/drivers/acpi/namespace/nsxfeval.c
+++ b/drivers/acpi/namespace/nsxfeval.c
@@ -443,6 +443,7 @@ acpi_ns_get_device_callback(acpi_handle obj_handle,
 	struct acpica_device_id hid;
 	struct acpi_compatible_id_list *cid;
 	acpi_native_uint i;
+	int found;
 
 	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
 	if (ACPI_FAILURE(status)) {
@@ -496,16 +497,19 @@ acpi_ns_get_device_callback(acpi_handle obj_handle,
 
 			/* Walk the CID list */
 
+			found = 0;
 			for (i = 0; i < cid->count; i++) {
 				if (ACPI_STRNCMP(cid->id[i].value, info->hid,
 						 sizeof(struct
-							acpi_compatible_id)) !=
+							acpi_compatible_id)) ==
 				    0) {
-					ACPI_FREE(cid);
-					return (AE_OK);
+					found = 1;
+					break;
 				}
 			}
 			ACPI_FREE(cid);
+			if (!found)
+				return (AE_OK);
 		}
 	}
 
-- 
1.5.4.23.gef5b9

