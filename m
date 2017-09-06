From: Zhenhua <lizhenhuajiyang@163.com>
Subject: [PATCH 1/1] ACPI: NULL pointer checking
Date: Wed,  6 Sep 2017 21:35:22 +0800
Message-ID: <20170906133522.7884-1-lizhenhuajiyang@163.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from m50-132.163.com ([123.125.50.132]:57298 "EHLO m50-132.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753237AbdIFNvC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 6 Sep 2017 09:51:02 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: devel@acpica.org, robert.moore@intel.com, lv.zheng@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Zhenhua <lizhenhuajiyang@163.com>

These two pointers should be checked, for some broken devices they may
cause system crash.

Signed-off-by: Zhenhua <lizhenhuajiyang@163.com>
---
 drivers/acpi/acpica/nsaccess.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index f2733f51ca8d..151abb0ef4d5 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -338,7 +338,7 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 			return_ACPI_STATUS(AE_AML_INTERNAL);
 		}
 
-		if (!(flags & ACPI_NS_PREFIX_IS_SCOPE)) {
+		if ((!prefix_node) && (!(flags & ACPI_NS_PREFIX_IS_SCOPE))) {
 			/*
 			 * This node might not be a actual "scope" node (such as a
 			 * Device/Method, etc.)  It could be a Package or other object
@@ -369,7 +369,7 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 		ACPI_DEBUG_PRINT((ACPI_DB_NAMES,
 				  "Null Pathname (Zero segments), Flags=%X\n",
 				  flags));
-	} else {
+	} else if (path) {
 		/*
 		 * Name pointer is valid (and must be in internal name format)
 		 *
-- 
2.14.1


