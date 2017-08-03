From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 14/15] ACPICA: Revert "Update resource descriptor handling"
Date: Thu,  3 Aug 2017 14:27:42 +0800
Message-ID: <cf55bd9eb84f94dc1a15a4c0cfb2c30f4b0c790d.1501730699.git.lv.zheng@intel.com>
References: <cover.1501730699.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:57917 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751263AbdHCG1q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Aug 2017 02:27:46 -0400
In-Reply-To: <cover.1501730699.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Erik Schmauss <erik.schmauss@intel.com>

From: Erik Schmauss <erik.schmauss@intel.com>

ACPICA commit f3300640c63df138d133740b54e2c0a1befa4086

This reverts commit c8eac10178b387f9eb1935694e509d4518da77bb.

Link: https://github.com/acpica/acpica/commit/f3300640
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utresrc.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpica/utresrc.c b/drivers/acpi/acpica/utresrc.c
index 517acf8..f9801d1 100644
--- a/drivers/acpi/acpica/utresrc.c
+++ b/drivers/acpi/acpica/utresrc.c
@@ -184,11 +184,9 @@ acpi_ut_walk_aml_resources(struct acpi_walk_state *walk_state,
 
 	ACPI_FUNCTION_TRACE(ut_walk_aml_resources);
 
-	/*
-	 * The absolute minimum resource template is one end_tag descriptor.
-	 * However, we will treat a lone end_tag as just a simple buffer.
-	 */
-	if (aml_length <= sizeof(struct aml_resource_end_tag)) {
+	/* The absolute minimum resource template is one end_tag descriptor */
+
+	if (aml_length < sizeof(struct aml_resource_end_tag)) {
 		return_ACPI_STATUS(AE_AML_NO_RESOURCE_END_TAG);
 	}
 
@@ -252,10 +250,8 @@ acpi_ut_walk_aml_resources(struct acpi_walk_state *walk_state,
 				*context = aml;
 			}
 
-			/*
-			 * Normal exit. Note: We allow the buffer to be larger than
-			 * the resource template, as long as the END_TAG exists.
-			 */
+			/* Normal exit */
+
 			return_ACPI_STATUS(AE_OK);
 		}
 
-- 
2.7.4

