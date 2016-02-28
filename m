From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ACPI / utils: remove redundant check if element is NULL
Date: Sun, 28 Feb 2016 20:31:49 +0000
Message-ID: <1456691509-7855-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:48470 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176AbcB1Ubw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 28 Feb 2016 15:31:52 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

element is &package->package.elements[i] which can never be NULL
so the check to see if it is NULL is redundant and can be removed.

Detected with static analysis by CoverityScan

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/acpi/utils.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index f2f9873..f12a724 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -201,10 +201,6 @@ acpi_extract_package(union acpi_object *package,
 		u8 **pointer = NULL;
 		union acpi_object *element = &(package->package.elements[i]);
 
-		if (!element) {
-			return AE_BAD_DATA;
-		}
-
 		switch (element->type) {
 
 		case ACPI_TYPE_INTEGER:
-- 
2.7.0

