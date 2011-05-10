From: Huang Ying <ying.huang@intel.com>
Subject: [RFC, BUGFIX] ACPI, APEI, ERST, Prevent erst_dbg from loading if ERST is disabled
Date: Tue, 10 May 2011 15:41:10 +0800
Message-ID: <1305013270-5651-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48412 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754715Ab1EJHlP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 May 2011 03:41:15 -0400
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
 
