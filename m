From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 3/4] ACPI / EC: Add support to handle EC events earlier
Date: Fri, 11 Aug 2017 14:36:39 +0800
Message-ID: <344e4a55bac9c1cd53c95eba563cdeeeb23bd479.1502432974.git.lv.zheng@intel.com>
References: <99f23db65bbe89ee856018629654584a96734c84.1501141963.git.lv.zheng@intel.com> <cover.1502432974.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1502432974.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Now as GPE poller is implemented, EC driver is able to detect EC events
during suspend/resume noirq stages, we can try to move EC event handling
earlier without being worried about post-resume event stuck. This may help
to solve driver order issues during resume.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Tested-by: Tomislav Ivek <tomislav.ivek@gmail.com>
---
 drivers/acpi/ec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 5be62933..396e81d 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1016,7 +1016,9 @@ static void acpi_ec_start(struct acpi_ec *ec, bool resuming)
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
