From: Len Brown <lenb@kernel.org>
Subject: [PATCH 014/171] MIPS Alchemy: Crapectomy after removal of pm_send_all calls.
Date: Tue, 29 Apr 2008 04:44:05 -0400
Message-ID: <99bda83e8b3140b7e81572a5aabc7dedb455b272.1209457069.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:28120 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755256AbYD2Iox (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 04:44:53 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Ralf Baechle <ralf@linux-mips.org>

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/mips/au1000/common/power.c |   20 --------------------
 1 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/arch/mips/au1000/common/power.c b/arch/mips/au1000/common/power.c
index a9f7f63..725a52f 100644
--- a/arch/mips/au1000/common/power.c
+++ b/arch/mips/au1000/common/power.c
@@ -283,18 +283,6 @@ static int pm_do_sleep(ctl_table * ctl, int write, struct file *file,
 	return 0;
 }
 
-static int pm_do_suspend(ctl_table * ctl, int write, struct file *file,
-			 void __user *buffer, size_t * len, loff_t *ppos)
-{
-	if (!write) {
-		*len = 0;
-	} else {
-		suspend_mode = 1;
-	}
-	return 0;
-}
-
-
 static int pm_do_freq(ctl_table * ctl, int write, struct file *file,
 		      void __user *buffer, size_t * len, loff_t *ppos)
 {
@@ -408,14 +396,6 @@ static int pm_do_freq(ctl_table * ctl, int write, struct file *file,
 
 static struct ctl_table pm_table[] = {
 	{
-		.ctl_name 	= CTL_UNNUMBERED,
-		.procname	= "suspend",
-		.data		= NULL,
-		.maxlen		= 0,
-		.mode		= 0600,
-		.proc_handler	= &pm_do_suspend
-	},
-	{
 		.ctl_name	= CTL_UNNUMBERED,
 		.procname	= "sleep",
 		.data		= NULL,
-- 
1.5.5.1.99.gf0ec4

