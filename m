From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 04/30] ACPICA: Headers: Minor update for SPCR ACPI table
Date: Thu, 24 Mar 2016 09:38:49 +0800
Message-ID: <45de14411558933523113ef48b7f43b59cab44ee.1458714003.git.lv.zheng@intel.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:4778 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756495AbcCXBiw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Mar 2016 21:38:52 -0400
In-Reply-To: <cover.1458714002.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit f3caa7f2e63be31f7fb8dbccabffbb70c29c3021

Update version number and date of specification document.
Point to DBG2 table for some constants.

Link: https://github.com/acpica/acpica/commit/f3caa7f2
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl2.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 7702b27..e9d3cc1 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1107,10 +1107,10 @@ struct acpi_table_slic {
 /*******************************************************************************
  *
  * SPCR - Serial Port Console Redirection table
- *        Version 1
+ *        Version 2
  *
  * Conforms to "Serial Port Console Redirection Table",
- * Version 1.00, January 11, 2002
+ * Version 1.03, August 10, 2015
  *
  ******************************************************************************/
 
@@ -1142,6 +1142,8 @@ struct acpi_table_spcr {
 
 #define ACPI_SPCR_DO_NOT_DISABLE    (1)
 
+/* Values for Interface Type: See the definition of the DBG2 table */
+
 /*******************************************************************************
  *
  * SPMI - Server Platform Management Interface table
-- 
1.7.10

