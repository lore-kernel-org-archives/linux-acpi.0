From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 3/3] ACPI: Add wakeup reason support
Date: Thu, 14 Dec 2017 14:38:47 +0800
Message-ID: <fb7408a260920fc0e93f7292c2a1dc7f7b6a547e.1513233415.git.lv.zheng@intel.com>
References: <cover.1513233415.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:14017 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751042AbdLNGiv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Dec 2017 01:38:51 -0500
In-Reply-To: <cover.1513233415.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

This patch adds kernel side invocation of wakeup reason detection
mechanism.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/sleep.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 7c70c3c..9b245a6 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -963,6 +963,8 @@ static int acpi_s2idle_prepare(void)
 	}
 	if (acpi_sci_irq_valid())
 		enable_irq_wake(acpi_sci_irq);
+	pr_info(PREFIX "Low-level suspend completed\n");
+	acpi_detect_wakeup_reasons();
 
 	return 0;
 }
-- 
2.7.4

