From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/3] ACPI: hp-wmi,
 msi-wmi: clarify that wmi_install_notify_handler() returns an acpi_status
Date: Sat, 26 Dec 2009 23:15:37 -0500
Message-ID: <a17dcc78df671570020235c0efae7a4c6eced9f5.1261887124.git.len.brown@intel.com>
References: <1261887338-29981-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:35262 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbZL0EQO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Dec 2009 23:16:14 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KVA004WSMIUJPM3@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 26 Dec 2009 22:16:09 -0600 (CST)
In-reply-to: <1261887338-29981-1-git-send-email-lenb@kernel.org>
In-reply-to: <51b0f1c2b8c32ee44ff01ef74599a1f17e4fc565.1261887124.git.len.brown@intel.com>
References: <51b0f1c2b8c32ee44ff01ef74599a1f17e4fc565.1261887124.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mjg@redhat.com, carlos@strangeworlds.co.uk, anisse@astier.eu, linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Emphasize that that wmi_install_notify_handler() returns an acpi_status
rather than -errno by by testing ACPI_SUCCESS(), ACPI_FAILURE().

No functional change in this patch, but this confusion caused a bug in dell-wmi.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/hp-wmi.c  |    2 +-
 drivers/platform/x86/msi-wmi.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index 8781d8f..18bf741 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -581,7 +581,7 @@ static int __init hp_wmi_init(void)
 	if (wmi_has_guid(HPWMI_EVENT_GUID)) {
 		err = wmi_install_notify_handler(HPWMI_EVENT_GUID,
 						 hp_wmi_notify, NULL);
-		if (!err)
+		if (ACPI_SUCCESS(err))
 			hp_wmi_input_setup();
 	}
 
diff --git a/drivers/platform/x86/msi-wmi.c b/drivers/platform/x86/msi-wmi.c
index 7f77f90..f746c67 100644
--- a/drivers/platform/x86/msi-wmi.c
+++ b/drivers/platform/x86/msi-wmi.c
@@ -236,7 +236,7 @@ static int __init msi_wmi_init(void)
 	}
 	err = wmi_install_notify_handler(MSIWMI_EVENT_GUID,
 			msi_wmi_notify, NULL);
-	if (err)
+	if (ACPI_FAILURE(err))
 		return -EINVAL;
 
 	err = msi_wmi_input_setup();
-- 
1.6.0.6

