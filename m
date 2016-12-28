From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 13/18] ACPICA: Resources: Not a valid resource if buffer length too long
Date: Wed, 28 Dec 2016 15:29:28 +0800
Message-ID: <49f31626f7caa6fa927e879cf1ffe773143824eb.1482821486.git.lv.zheng@intel.com>
References: <cover.1482821486.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1482821486.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 9f76de2d249b18804e35fb55d14b1c2604d627a1
ACPICA commit b2e89d72ef1e9deefd63c3fd1dee90f893575b3a
ACPICA commit 23b5bbe6d78afd3c5abf3adb91a1b098a3000b2e

The declared buffer length must be the same as the length of the
byte initializer list, otherwise not a valid resource descriptor.

Link: https://github.com/acpica/acpica/commit/9f76de2d
Link: https://github.com/acpica/acpica/commit/b2e89d72
Link: https://github.com/acpica/acpica/commit/23b5bbe6
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utresrc.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/utresrc.c b/drivers/acpi/acpica/utresrc.c
index 1de3376..2ad99ea 100644
--- a/drivers/acpi/acpica/utresrc.c
+++ b/drivers/acpi/acpica/utresrc.c
@@ -421,8 +421,10 @@ acpi_ut_walk_aml_resources(struct acpi_walk_state *walk_state,
 
 	ACPI_FUNCTION_TRACE(ut_walk_aml_resources);
 
-	/* The absolute minimum resource template is one end_tag descriptor */
-
+	/*
+	 * The absolute minimum resource template is one end_tag descriptor.
+	 * However, we will treat a lone end_tag as just a simple buffer.
+	 */
 	if (aml_length < sizeof(struct aml_resource_end_tag)) {
 		return_ACPI_STATUS(AE_AML_NO_RESOURCE_END_TAG);
 	}
@@ -454,9 +456,8 @@ acpi_ut_walk_aml_resources(struct acpi_walk_state *walk_state,
 		/* Invoke the user function */
 
 		if (user_function) {
-			status =
-			    user_function(aml, length, offset, resource_index,
-					  context);
+			status = user_function(aml, length, offset,
+					       resource_index, context);
 			if (ACPI_FAILURE(status)) {
 				return_ACPI_STATUS(status);
 			}
@@ -480,6 +481,12 @@ acpi_ut_walk_aml_resources(struct acpi_walk_state *walk_state,
 				*context = aml;
 			}
 
+			/* Check if buffer is defined to be longer than the resource length */
+
+			if (aml_length > (offset + length)) {
+				return_ACPI_STATUS(AE_AML_NO_RESOURCE_END_TAG);
+			}
+
 			/* Normal exit */
 
 			return_ACPI_STATUS(AE_OK);
-- 
2.7.4
