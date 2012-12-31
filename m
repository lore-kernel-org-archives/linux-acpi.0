From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 16/27] ACPICA: iASL: Finish support for the TPM2 table.
Date: Mon, 31 Dec 2012 08:06:44 +0800
Message-ID: <e884ae010edf5598c73c98242fe30e4e35c8e529.1356668534.git.lv.zheng@intel.com>
References: <cover.1356668530.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:23674 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755200Ab2LaAGx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Dec 2012 19:06:53 -0500
In-Reply-To: <cover.1356668530.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Add disassembler, table compiler, and template support.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl3.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index a067d7d..c4aae22 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -75,7 +75,6 @@
 
 /* Reserved table signatures */
 
-#define ACPI_SIG_CSRT           "CSRT"	/* Core System Resources Table */
 #define ACPI_SIG_MATR           "MATR"	/* Memory Address Translation Table */
 #define ACPI_SIG_MSDM           "MSDM"	/* Microsoft Data Management Table */
 #define ACPI_SIG_WPBT           "WPBT"	/* Windows Platform Binary Table */
-- 
1.7.10

