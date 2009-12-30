From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/14] dell-wmi - fix condition to abort driver loading
Date: Wed, 30 Dec 2009 02:36:34 -0500
Message-ID: <487a42f0c4c3b8cd1e81353dce0d8668dce0b9a3.1262158495.git.len.brown@intel.com>
References: <1262158597-9597-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:64677 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbZL3X1K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2009 18:27:10 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KVH007CENT0HQT5@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 30 Dec 2009 17:27:08 -0600 (CST)
In-reply-to: <1262158597-9597-1-git-send-email-lenb@kernel.org>
In-reply-to: <51b0f1c2b8c32ee44ff01ef74599a1f17e4fc565.1262158495.git.len.brown@intel.com>
References: <51b0f1c2b8c32ee44ff01ef74599a1f17e4fc565.1262158495.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, Len Brown <len.brown@intel.com>

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

The commit 1fdd407f4e3f2ecb453954cbebb6c22491c61853 incorrectly made driver
abort loading when known GUID is present when it should have done exactly
the opposite.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/dell-wmi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index 500af8c..1b1dddb 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -330,7 +330,7 @@ static int __init dell_wmi_init(void)
 	int err;
 	acpi_status status;
 
-	if (wmi_has_guid(DELL_EVENT_GUID)) {
+	if (!wmi_has_guid(DELL_EVENT_GUID)) {
 		printk(KERN_WARNING "dell-wmi: No known WMI GUID found\n");
 		return -ENODEV;
 	}
-- 
1.6.0.6

