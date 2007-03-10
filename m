From: Len Brown <lenb@kernel.org>
Subject: [PATCH 21/22] ACPI: EC: Block queries until EC is fully initialized
Date: Fri,  9 Mar 2007 23:00:58 -0500
Message-ID: <11734992782815-git-send-email-lenb@kernel.org>
References: <11734992592550-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:44913 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1767765AbXCJEBT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Mar 2007 23:01:19 -0500
In-Reply-To: <11734992592550-git-send-email-lenb@kernel.org>
Message-Id: <5923a5eb97e66a7678742b84352b82597673c766.1173498658.git.len.brown@intel.com>
In-Reply-To: <941b1971a405f95537bc6f9a738e737eb2186e45.1173498647.git.len.brown@intel.com>
References: <941b1971a405f95537bc6f9a738e737eb2186e45.1173498647.git.len.brown@intel.com>
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
1.5.0.3.310.g05ef5
