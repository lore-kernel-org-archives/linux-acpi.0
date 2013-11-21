From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/6] ACPICA: Tests: Add CHECKSUM_ABORT protection for test utilities.
Date: Thu, 21 Nov 2013 12:17:27 +0800
Message-ID: <338f20845ed8addd685d973341dac5e042a31322.1384747397.git.lv.zheng@intel.com>
References: <cover.1384747396.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:34585 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373Ab3KUERp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Nov 2013 23:17:45 -0500
In-Reply-To: <cover.1384747396.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

This patch adds protection around ACPI_CHECKSUM_ABORT so that ACPI user
space test utilities can re-define it for their own purposes (currently
used by ASLTS build environment).
This patch doesn't affect Linux kernel behavior.  Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/acconfig.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index d98c670..3ea214c 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -83,7 +83,9 @@
  * Should the subsystem abort the loading of an ACPI table if the
  * table checksum is incorrect?
  */
+#ifndef ACPI_CHECKSUM_ABORT
 #define ACPI_CHECKSUM_ABORT             FALSE
+#endif
 
 /*
  * Generate a version of ACPICA that only supports "reduced hardware"
-- 
1.7.10

