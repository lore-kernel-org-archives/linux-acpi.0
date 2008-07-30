From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 9/9] ACPI system: Debug interface used for error message cleanup
Date: Wed, 30 Jul 2008 22:22:22 +0200
Message-ID: <1217449342-20312-10-git-send-email-trenn@suse.de>
References: <1217449342-20312-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:49444 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756779AbYG3UW0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Jul 2008 16:22:26 -0400
In-Reply-To: <1217449342-20312-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, robert.moore@intel.com, Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/acpi/system.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/system.c b/drivers/acpi/system.c
index d8e3f15..d007793 100644
--- a/drivers/acpi/system.c
+++ b/drivers/acpi/system.c
@@ -386,8 +386,8 @@ static ssize_t counter_set(struct kobject *kobj,
 		goto end;
 
 	if (!(all_counters[index].flags & ACPI_EVENT_VALID)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
-			"Can not change Invalid GPE/Fixed Event status\n"));
+		printk(KERN_WARN
+		       "Can not change Invalid GPE/Fixed Event status\n");
 		return -EINVAL;
 	}
 
-- 
1.5.4.5

