From: Andrew Patterson <andrew.patterson@hp.com>
Subject: [PATCH 3/4] ACPI: Check for any matching CID when walking namespace.
Date: Tue, 22 Jan 2008 17:18:22 -0700
Message-ID: <20080123001822.28190.3147.stgit@bluto.andrew>
References: <20080123001807.28190.32648.stgit@bluto.andrew>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:9104 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913AbYAWASY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jan 2008 19:18:24 -0500
In-Reply-To: <20080123001807.28190.32648.stgit@bluto.andrew>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, lenb@kernel.org, gregkh@suse.de, matthew@wil.cx, tom.l.nguyen@intel.com, linux-acpi@vger.kernel.org, Andrew Patterson <andrew.patterson@hp.com>

From: Andrew Patterson <andrew.patterson@hp.com>

The callback function acpi_ns_get_device_callback called from
acpi_get_devices() will check CID's if the HID does not match.  This code
has a bug where it requires that all CIDs match the HID. Changed the code
so that any CID match will do.

Signed-off-by: Andrew Patterson <andrew.patterson@hp.com>
---

 drivers/acpi/namespace/nsxfeval.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/namespace/nsxfeval.c b/drivers/acpi/namespace/nsxfeval.c
index f39fbc6..e562b24 100644
--- a/drivers/acpi/namespace/nsxfeval.c
+++ b/drivers/acpi/namespace/nsxfeval.c
@@ -443,6 +443,7 @@ acpi_ns_get_device_callback(acpi_handle obj_handle,
 	struct acpica_device_id hid;
 	struct acpi_compatible_id_list *cid;
 	acpi_native_uint i;
+	int found;
 
 	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
 	if (ACPI_FAILURE(status)) {
@@ -496,16 +497,20 @@ acpi_ns_get_device_callback(acpi_handle obj_handle,
 
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
+			if (!found) {
+				return (AE_OK);
+			}
 		}
 	}
 

