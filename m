From: Scot Doyle <lkml14@scotdoyle.com>
Subject: [PATCH] ACPI / EC: Remove non-standard log emphasis
Date: Sun, 15 Feb 2015 19:43:08 +0000 (UTC)
Message-ID: <alpine.LNX.2.11.1502151932250.630@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Remove unusual pr_info() visual emphasis introduced in ad479e7f47ca
"ACPI / EC: Introduce STARTED/STOPPED flags to replace BLOCKED flag".

Signed-off-by: Scot Doyle <lkml14@scotdoyle.com>
---
 drivers/acpi/ec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 982b67f..857175e 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -680,7 +680,7 @@ static void acpi_ec_start(struct acpi_ec *ec, bool resuming)
 		/* Enable GPE for event processing (SCI_EVT=1) */
 		if (!resuming)
 			acpi_ec_submit_request(ec);
-		pr_info("+++++ EC started +++++\n");
+		pr_info("EC started\n");
 	}
 	spin_unlock_irqrestore(&ec->lock, flags);
 }
@@ -712,7 +712,7 @@ static void acpi_ec_stop(struct acpi_ec *ec, bool suspending)
 			acpi_ec_complete_request(ec);
 		clear_bit(EC_FLAGS_STARTED, &ec->flags);
 		clear_bit(EC_FLAGS_STOPPED, &ec->flags);
-		pr_info("+++++ EC stopped +++++\n");
+		pr_info("EC stopped\n");
 	}
 	spin_unlock_irqrestore(&ec->lock, flags);
 }
-- 
2.2.1
