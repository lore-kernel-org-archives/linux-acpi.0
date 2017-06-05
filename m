From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 37/53] ACPICA: Update resource descriptor handling
Date: Mon,  5 Jun 2017 16:40:50 +0800
Message-ID: <0c6820111292a5a0f46991f6dec03270ec1b6d73.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:51301 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751478AbdFEIkx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:40:53 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit c8eac10178b387f9eb1935694e509d4518da77bb

This change restores the change introduced by commit 23b5bbe and
adds a comment concerning resource descriptor buffers that extend
beyond the END_TAG descriptor.

Link: https://github.com/acpica/acpica/commit/c8eac101
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utresrc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/utresrc.c b/drivers/acpi/acpica/utresrc.c
index b4282ea..ddb9365 100644
--- a/drivers/acpi/acpica/utresrc.c
+++ b/drivers/acpi/acpica/utresrc.c
@@ -448,9 +448,11 @@ acpi_ut_walk_aml_resources(struct acpi_walk_state *walk_state,
 
 	ACPI_FUNCTION_TRACE(ut_walk_aml_resources);
 
-	/* The absolute minimum resource template is one end_tag descriptor */
-
-	if (aml_length < sizeof(struct aml_resource_end_tag)) {
+	/*
+	 * The absolute minimum resource template is one end_tag descriptor.
+	 * However, we will treat a lone end_tag as just a simple buffer.
+	 */
+	if (aml_length <= sizeof(struct aml_resource_end_tag)) {
 		return_ACPI_STATUS(AE_AML_NO_RESOURCE_END_TAG);
 	}
 
@@ -516,8 +518,10 @@ acpi_ut_walk_aml_resources(struct acpi_walk_state *walk_state,
 				*context = aml;
 			}
 
-			/* Normal exit */
-
+			/*
+			 * Normal exit. Note: We allow the buffer to be larger than
+			 * the resource template, as long as the END_TAG exists.
+			 */
 			return_ACPI_STATUS(AE_OK);
 		}
 
-- 
2.7.4

