From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 7/9] ACPI osl: Debug interface used for error message cleanup
Date: Wed, 30 Jul 2008 22:22:20 +0200
Message-ID: <1217449342-20312-8-git-send-email-trenn@suse.de>
References: <1217449342-20312-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:48269 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756326AbYG3UWY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Jul 2008 16:22:24 -0400
In-Reply-To: <1217449342-20312-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, robert.moore@intel.com, Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/acpi/osl.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index bf42ef1..0841c07 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -729,8 +729,7 @@ acpi_status acpi_os_execute(acpi_execute_type type,
 	INIT_WORK(&dpc->work, acpi_os_execute_deferred);
 	queue = (type == OSL_NOTIFY_HANDLER) ? kacpi_notify_wq : kacpid_wq;
 	if (!queue_work(queue, &dpc->work)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-			  "Call to queue_work() failed.\n"));
+		printk(KERN_ERR "Call to queue_work() failed.\n");
 		status = AE_ERROR;
 		kfree(dpc);
 	}
-- 
1.5.4.5

