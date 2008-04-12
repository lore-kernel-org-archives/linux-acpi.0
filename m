From: Len Brown <lenb@kernel.org>
Subject: [PATCH 65/73] ACPICA: Fix for extraneous debug message for packages
Date: Sat, 12 Apr 2008 00:25:48 -0400
Message-ID: <d67cc0dd29df98d6ac4824a617c151d7842e3a73.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:49384 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756654AbYDLE2Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:16 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixed a problem where an extraneous debug message was produced for
package objects (when debugging enabled). The message "Package
List length larger than NumElements count" is now produced in
the correct case, and is also an error message rather than a
debug message. Added a debug message for the opposite case, where
NumElements is larger than the Package List, and the package has
been padded out with NULL elements.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dsobject.c |   33 ++++++++++++++++++++++++++++++---
 1 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsobject.c b/drivers/acpi/dispatcher/dsobject.c
index 58d4d91..5184278 100644
--- a/drivers/acpi/dispatcher/dsobject.c
+++ b/drivers/acpi/dispatcher/dsobject.c
@@ -476,10 +476,37 @@ acpi_ds_build_internal_package_obj(struct acpi_walk_state *walk_state,
 		arg = arg->common.next;
 	}
 
-	if (!arg) {
+	/* Check for match between num_elements and actual length of package_list */
+
+	if (arg) {
+		/*
+		 * num_elements was exhausted, but there are remaining elements in the
+		 * package_list.
+		 *
+		 * Note: technically, this is an error, from ACPI spec: "It is an error
+		 * for NumElements to be less than the number of elements in the
+		 * PackageList". However, for now, we just print an error message and
+		 * no exception is returned.
+		 */
+		while (arg) {
+
+			/* Find out how many elements there really are */
+
+			i++;
+			arg = arg->common.next;
+		}
+
+		ACPI_ERROR((AE_INFO,
+			    "Package List length (%X) larger than NumElements count (%X), truncated\n",
+			    i, element_count));
+	} else if (i < element_count) {
+		/*
+		 * Arg list (elements) was exhausted, but we did not reach num_elements count.
+		 * Note: this is not an error, the package is padded out with NULLs.
+		 */
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Package List length larger than NumElements count (%X), truncated\n",
-				  element_count));
+				  "Package List length (%X) smaller than NumElements count (%X), padded with null elements\n",
+				  i, element_count));
 	}
 
 	obj_desc->package.flags |= AOPOBJ_DATA_VALID;
-- 
1.5.5.29.g7134

