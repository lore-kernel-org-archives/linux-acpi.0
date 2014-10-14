From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/5] ACPI/EC: Add CPU ID to debugging messages.
Date: Tue, 14 Oct 2014 14:23:38 +0800
Message-ID: <af5377c5d949eaa027cf38b3a15b4d1e18cf1d3f.1413267704.git.lv.zheng@intel.com>
References: <cover.1413267704.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17450 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754652AbaJNGXn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Oct 2014 02:23:43 -0400
In-Reply-To: <cover.1413267704.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

This patch adds CPU ID to the context entries' debugging output. no
functional changes.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 083e513..3eac545 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -181,7 +181,8 @@ static bool advance_transaction(struct acpi_ec *ec)
 	u8 status;
 	bool wakeup = false;
 
-	pr_debug("===== %s =====\n", in_interrupt() ? "IRQ" : "TASK");
+	pr_debug("===== %s (%d) =====\n",
+		 in_interrupt() ? "IRQ" : "TASK", smp_processor_id());
 	status = acpi_ec_read_status(ec);
 	t = ec->curr;
 	if (!t)
-- 
1.7.10

