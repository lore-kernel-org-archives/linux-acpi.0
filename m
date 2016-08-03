From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 5/5] ACPI / EC: Enable event freeze mode to improve event handling for suspend process
Date: Wed,  3 Aug 2016 16:01:50 +0800
Message-ID: <fa972437434d4280ac75fad2a62d50538a88616e.1470205312.git.lv.zheng@intel.com>
References: <bd9df7ba491b33cfbaa46f4cc6a6325f74153e36.1469093001.git.lv.zheng@intel.com> <cover.1470205312.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:22676 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756523AbcHCIOM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 3 Aug 2016 04:14:12 -0400
In-Reply-To: <cover.1470205312.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patch enables the event freeze mode, flushing the EC event handling in
.suspend() callback. This feature is experimental, if it is bisected out to
be the cause of the real issues, please report the issues to the kernel
bugzilla for further root causing and improvement.

This mode eliminates useless _Qxx handling during the power saving
operations, thus can help to tune the power saving operations faster. Tests
show that this mode can efficiently block flooding _Qxx during the suspend
process and tune the speed of the suspend faster.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Tested-by: Todd E Brandt <todd.e.brandt@linux.intel.com>
---
 drivers/acpi/ec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 2bec709..1925589 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -146,7 +146,7 @@ static unsigned int ec_storm_threshold  __read_mostly = 8;
 module_param(ec_storm_threshold, uint, 0644);
 MODULE_PARM_DESC(ec_storm_threshold, "Maxim false GPE numbers not considered as GPE storm");
 
-static bool ec_freeze_events __read_mostly = false;
+static bool ec_freeze_events __read_mostly = true;
 module_param(ec_freeze_events, bool, 0644);
 MODULE_PARM_DESC(ec_freeze_events, "Disabling event handling during suspend/resume");
 
-- 
1.7.10

