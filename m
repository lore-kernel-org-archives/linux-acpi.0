From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 3/4] ACPI / EC: Add support to handle EC events earlier
Date: Mon, 31 Jul 2017 13:48:39 +0800
Message-ID: <589506f5f9685c5bb21a690e25f5154bbd3b9cb0.1501479412.git.lv.zheng@intel.com>
References: <99f23db65bbe89ee856018629654584a96734c84.1501141963.git.lv.zheng@intel.com> <cover.1501479412.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:47256 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751623AbdGaFsn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 31 Jul 2017 01:48:43 -0400
In-Reply-To: <cover.1501479412.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Now as GPE poller is implemented, EC driver is able to detect EC events
during suspend/resume noirq stages, we can try to move EC event handling
earlier without being worried about post-resume event stuck.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index f1cffd4..5f951ba 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1004,7 +1004,9 @@ static void acpi_ec_start(struct acpi_ec *ec, bool resuming)
 		if (!resuming) {
 			acpi_ec_submit_request(ec);
 			ec_dbg_ref(ec, "Increase driver");
-		}
+		} else if (!ec_freeze_events &&
+			   ec_gpe_polling == ACPI_EC_GPE_POLL_RESUME)
+			__acpi_ec_enable_event(ec);
 		ec_log_drv("EC started");
 	}
 	spin_unlock_irqrestore(&ec->lock, flags);
-- 
2.7.4

