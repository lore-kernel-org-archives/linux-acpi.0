From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH 2/3] ACPI, APEI, ERST, Prevent erst_dbg from loading if ERST is disabled
Date: Tue, 28 Jun 2011 09:13:53 +0800
Message-ID: <1309223634-12248-3-git-send-email-ying.huang@intel.com>
References: <1309223634-12248-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:58020 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755858Ab1F1BOB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Jun 2011 21:14:01 -0400
In-Reply-To: <1309223634-12248-1-git-send-email-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, ying.huang@intel.com, linux-acpi@vger.kernel.org

erst_dbg module can not work with ERST is disabled.  So disable module
loading to provide clearer information to user.

Signed-off-by: Huang Ying <ying.huang@intel.com>
---
 drivers/acpi/apei/erst-dbg.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/acpi/apei/erst-dbg.c
+++ b/drivers/acpi/apei/erst-dbg.c
@@ -213,6 +213,10 @@ static struct miscdevice erst_dbg_dev =
 
 static __init int erst_dbg_init(void)
 {
+	if (erst_disable) {
+		pr_info(ERST_DBG_PFX "ERST support is disabled.\n");
+		return -ENODEV;
+	}
 	return misc_register(&erst_dbg_dev);
 }
 
