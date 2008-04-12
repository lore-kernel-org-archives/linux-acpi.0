From: Len Brown <lenb@kernel.org>
Subject: [PATCH 57/73] ACPICA: Added new error messages
Date: Sat, 12 Apr 2008 00:25:40 -0400
Message-ID: <0e29795892c683650ae7aad8a05f323feeda1b9d.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:45175 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753518AbYDLE2L (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:11 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

New messages for the 2 AE_SUPPORT cases.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utilities/utcopy.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/utilities/utcopy.c b/drivers/acpi/utilities/utcopy.c
index ba89971..4c4021d 100644
--- a/drivers/acpi/utilities/utcopy.c
+++ b/drivers/acpi/utilities/utcopy.c
@@ -215,6 +215,11 @@ acpi_ut_copy_isimple_to_esimple(union acpi_operand_object *internal_object,
 		/*
 		 * There is no corresponding external object type
 		 */
+		ACPI_ERROR((AE_INFO,
+			    "Unsupported object type, cannot convert to external object: %s",
+			    acpi_ut_get_type_name(ACPI_GET_OBJECT_TYPE
+						  (internal_object))));
+
 		return_ACPI_STATUS(AE_SUPPORT);
 	}
 
@@ -467,6 +472,10 @@ acpi_ut_copy_esimple_to_isimple(union acpi_object *external_object,
 	default:
 		/* All other types are not supported */
 
+		ACPI_ERROR((AE_INFO,
+			    "Unsupported object type, cannot convert to internal object: %s",
+			    acpi_ut_get_type_name(external_object->type)));
+
 		return_ACPI_STATUS(AE_SUPPORT);
 	}
 
-- 
1.5.5.29.g7134

