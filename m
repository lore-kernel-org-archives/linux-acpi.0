From: Len Brown <len.brown@intel.com>
Subject: [PATCH 012/105] ACPI: EC: Block queries until EC is fully initialized
Date: Sun, 29 Apr 2007 00:50:12 -0400
Message-ID: <11778223152006-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
 <1177822310688-git-send-email-len.brown@intel.com>
 <11778223112050-git-send-email-len.brown@intel.com>
 <11778223122850-git-send-email-len.brown@intel.com>
 <11778223131932-git-send-email-len.brown@intel.com>
 <11778223143898-git-send-email-len.brown@intel.com>
 <11778223151972-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57052 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754595AbXD2Ev4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:51:56 -0400
In-Reply-To: <11778223151972-git-send-email-len.brown@intel.com>
Message-Id: <9fd9f8e8bdcfc9aa309dae5bccc55d02804337d0.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 2a17229..e08cf98 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -599,7 +599,7 @@ static struct acpi_ec *make_acpi_ec(void)
 	if (!ec)
 		return NULL;
 
-	atomic_set(&ec->query_pending, 0);
+	atomic_set(&ec->query_pending, 1);
 	atomic_set(&ec->event_count, 1);
 	mutex_init(&ec->lock);
 	init_waitqueue_head(&ec->wait);
@@ -715,6 +715,9 @@ static int ec_install_handlers(struct acpi_ec *ec)
 		return -ENODEV;
 	}
 
+	/* EC is fully operational, allow queries */
+	atomic_set(&ec->query_pending, 0);
+
 	return 0;
 }
 
-- 
1.5.2.rc0.34.gda94
