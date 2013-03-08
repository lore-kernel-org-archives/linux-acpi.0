From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 14/21] ACPICA: Remove trailing comma in enum declarations
Date: Fri,  8 Mar 2013 17:22:48 +0800
Message-ID: <05dfa62d28182cb9988e1da1c4456a6aa1219dfd.1361292877.git.lv.zheng@intel.com>
References: <cover.1361292877.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25218 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933331Ab3CHJXG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Mar 2013 04:23:06 -0500
In-Reply-To: <cover.1361292877.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

SunStudio compiler complains about trailing commas in enum
declarations.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl3.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 9f27890..e2c0931 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -174,7 +174,7 @@ struct acpi_fpdt_header {
 
 enum acpi_fpdt_type {
 	ACPI_FPDT_TYPE_BOOT = 0,
-	ACPI_FPDT_TYPE_S3PERF = 1,
+	ACPI_FPDT_TYPE_S3PERF = 1
 };
 
 /*
@@ -223,7 +223,7 @@ struct acpi_s3pt_header {
 
 enum acpi_s3pt_type {
 	ACPI_S3PT_TYPE_RESUME = 0,
-	ACPI_S3PT_TYPE_SUSPEND = 1,
+	ACPI_S3PT_TYPE_SUSPEND = 1
 };
 
 struct acpi_s3pt_resume {
-- 
1.7.10

