From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 6/7] ACPICA: Update predefined info table for _MLS method
Date: Fri, 25 Jan 2013 13:41:22 +0800
Message-ID: <cc2cd8dd3f86fcad08e63bbeb239f7f8b5e29d4a.1358825277.git.lv.zheng@intel.com>
References: <cover.1358825277.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21011 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751227Ab3AYFlg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 Jan 2013 00:41:36 -0500
In-Reply-To: <cover.1358825277.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

The second object for each sub-package of the _MLS method is
defined to be a unicode Buffer object. This fixes the predefined
table where this object was incorrectly defined as a String.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acpredef.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index c11b66d..752cc40 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -345,8 +345,8 @@ static const union acpi_predefined_info predefined_names[] = {
 	{{"_MBM", 0, ACPI_RTYPE_PACKAGE}},	/* Fixed-length (8 Int) */
 	{{{ACPI_PTYPE1_FIXED, ACPI_RTYPE_INTEGER, 8, 0}, 0, 0}},
 
-	{{"_MLS", 0, ACPI_RTYPE_PACKAGE}}, /* Variable-length (Pkgs) each (2 Str) */
-			  {{{ACPI_PTYPE2, ACPI_RTYPE_STRING, 2,0}, 0,0}},
+	{{"_MLS", 0, ACPI_RTYPE_PACKAGE}},	/* Variable-length (Pkgs) each (1 Str/1 Buf) */
+	{{{ACPI_PTYPE2, ACPI_RTYPE_STRING, 1, ACPI_RTYPE_BUFFER}, 1, 0}},
 
 	{{"_MSG", 1, 0}},
 	{{"_MSM", 4, ACPI_RTYPE_INTEGER}},
-- 
1.7.10

