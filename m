From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 24/31] ACPICA: Permanently set _REV to the value '2'.
Date: Mon, 13 Apr 2015 11:50:43 +0800
Message-ID: <c965fda85b7b88ced2182192fe7355079693dda5.1428893938.git.lv.zheng@intel.com>
References: <cover.1428893935.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:43632 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932085AbbDMDur (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Apr 2015 23:50:47 -0400
In-Reply-To: <cover.1428893935.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 7af00219681ab35ebe57d64a9189fd04a5a026d8

Windows uses a value of 2, and has no plans to ever change this. So, _REV is
essentially useless for its primary purpose.

Worse, some BIOS vendors have used the difference in _REV values between
Windows and ACPICA to indicate which one is running.

It has been decided by the ACPI community to deprecate this method, and return
1 for ACPI 1.0 (32-bit integers) and 2 for ACPI 2.0 and greater (both 32-bit
and 64-bit integers.

ACPICA is changed to reflect this.

Link: https://github.com/acpica/acpica/commit/7af00219
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utglobal.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index 5e8df91..a72685c 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -102,12 +102,19 @@ const struct acpi_predefined_names acpi_gbl_pre_defined_names[] = {
 	{"_SB_", ACPI_TYPE_DEVICE, NULL},
 	{"_SI_", ACPI_TYPE_LOCAL_SCOPE, NULL},
 	{"_TZ_", ACPI_TYPE_DEVICE, NULL},
-	{"_REV", ACPI_TYPE_INTEGER, (char *)ACPI_CA_SUPPORT_LEVEL},
+	/*
+	 * March, 2015:
+	 * The _REV object is in the process of being deprecated, because
+	 * other ACPI implementations permanently return 2. Thus, it
+	 * has little or no value. Return 2 for compatibility with
+	 * other ACPI implementations.
+	 */
+	{"_REV", ACPI_TYPE_INTEGER, ACPI_CAST_PTR(char, 2)},
 	{"_OS_", ACPI_TYPE_STRING, ACPI_OS_NAME},
-	{"_GL_", ACPI_TYPE_MUTEX, (char *)1},
+	{"_GL_", ACPI_TYPE_MUTEX, ACPI_CAST_PTR(char, 1)},
 
 #if !defined (ACPI_NO_METHOD_EXECUTION) || defined (ACPI_CONSTANT_EVAL_ONLY)
-	{"_OSI", ACPI_TYPE_METHOD, (char *)1},
+	{"_OSI", ACPI_TYPE_METHOD, ACPI_CAST_PTR(char, 1)},
 #endif
 
 	/* Table terminator */
-- 
1.7.10

