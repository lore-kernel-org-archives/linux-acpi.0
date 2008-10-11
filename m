From: Len Brown <lenb@kernel.org>
Subject: [PATCH 81/85] ACPI system: Debug interface used for error message
 cleanup
Date: Sat, 11 Oct 2008 02:36:41 -0400
Message-ID: <1accf0f884731a879e62c019604928180a72b163.1223706853.git.len.brown@intel.com>
References: <1223707005-26864-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:40791 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803AbYJKGhi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Oct 2008 02:37:38 -0400
In-reply-to: <1223707005-26864-1-git-send-email-lenb@kernel.org>
In-reply-to: <1d80ebdb81444701024ad9b9f026516561496a43.1223706853.git.len.brown@intel.com>
References: <1d80ebdb81444701024ad9b9f026516561496a43.1223706853.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Andi Kleen <ak@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/system.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/system.c b/drivers/acpi/system.c
index 91dec44..58a1d89 100644
--- a/drivers/acpi/system.c
+++ b/drivers/acpi/system.c
@@ -387,8 +387,8 @@ static ssize_t counter_set(struct kobject *kobj,
 		goto end;
 
 	if (!(all_counters[index].flags & ACPI_EVENT_VALID)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
-			"Can not change Invalid GPE/Fixed Event status\n"));
+		printk(KERN_WARNING
+		       "Can not change Invalid GPE/Fixed Event status\n");
 		return -EINVAL;
 	}
 
-- 
1.5.5.1

