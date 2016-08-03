From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 2/5] ACPI / EC: Fix an issue that SCI_EVT cannot be detected after event is enabled
Date: Wed,  3 Aug 2016 16:01:30 +0800
Message-ID: <061fb2fc7b9e0ca8ff0324afabdfc80bc10582f1.1470205312.git.lv.zheng@intel.com>
References: <bd9df7ba491b33cfbaa46f4cc6a6325f74153e36.1469093001.git.lv.zheng@intel.com> <cover.1470205312.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:60556 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755215AbcHCILT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 3 Aug 2016 04:11:19 -0400
In-Reply-To: <cover.1470205312.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

After enabling the EC event handling, Linux is still in the noirq stage, if
there is no triggering source (EC transaction, GPE STS status),
advance_transaction() will not be invoked and SCI_EVT cannot be detected.
This patch adds one more triggering source after enabling the EC event
handling to poll the pending SCI_EVT.

Known issues:
1. Still no SCI_EVT triggering source
   There could still be no SCI_EVT triggering source after handling the
   first SCI_EVT (polled by this patch if any). Because after handling the
   first SCI_EVT, Linux could still be in noirq stage and there could still
   be no further triggering source in this stage. Then the second SCI_EVT
   indicated during this stage still cannot be detected by the EC driver.
   With this improvement applied, it is then possible to move
   acpi_ec_enable_event() out of the noirq stage to fix this issue (if the
   first SCI_EVT is handled out of the noirq stage, the follow-up SCI_EVTs
   should be able to trigger IRQs).

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Tested-by: Todd E Brandt <todd.e.brandt@linux.intel.com>
---
 drivers/acpi/ec.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 4ab34d7..79305be 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -468,6 +468,8 @@ static inline void __acpi_ec_enable_event(struct acpi_ec *ec)
 {
 	if (!test_and_set_bit(EC_FLAGS_QUERY_ENABLED, &ec->flags))
 		ec_log_drv("event unblocked");
+	if (!test_bit(EC_FLAGS_QUERY_PENDING, &ec->flags))
+		advance_transaction(ec);
 }
 
 static inline void __acpi_ec_disable_event(struct acpi_ec *ec)
-- 
1.7.10

