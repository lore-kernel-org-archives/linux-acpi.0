From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 23/42] ACPICA: getopt: Comment update, no functional change
Date: Tue, 29 Dec 2015 13:58:27 +0800
Message-ID: <4da30067ab5a50a80fdd910dd223c7a742df24a9.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16001 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751538AbbL2F6b (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Dec 2015 00:58:31 -0500
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 0d784a90bc3aac75227c4459c3553de18b9ebe7a

Document one of the option string operators.

Link: https://github.com/acpica/acpica/commit/0d784a90
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 tools/power/acpi/common/getopt.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/acpi/common/getopt.c b/tools/power/acpi/common/getopt.c
index 2496629..efefe30 100644
--- a/tools/power/acpi/common/getopt.c
+++ b/tools/power/acpi/common/getopt.c
@@ -47,6 +47,7 @@
  * Option strings:
  *    "f"       - Option has no arguments
  *    "f:"      - Option requires an argument
+ *    "f+"      - Option has an optional argument
  *    "f^"      - Option has optional single-char sub-options
  *    "f|"      - Option has required single-char sub-options
  */
-- 
1.7.10

