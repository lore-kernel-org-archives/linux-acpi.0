From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH 9/9] ACPI, APEI, ERST, Prevent erst_dbg from loading if ERST is disabled
Date: Tue, 17 May 2011 16:08:39 +0800
Message-ID: <1305619719-7480-10-git-send-email-ying.huang@intel.com>
References: <1305619719-7480-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:18452 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752227Ab1EQIJD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 May 2011 04:09:03 -0400
In-Reply-To: <1305619719-7480-1-git-send-email-ying.huang@intel.com>
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
 
