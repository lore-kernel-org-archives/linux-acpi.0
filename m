From: Len Brown <lenb@kernel.org>
Subject: [PATCH 010/112] ACPI: Also autoload the bay driver, was forgotten...
Date: Thu,  7 Feb 2008 04:33:32 -0500
Message-ID: <17196d6e533a5c09ca57bf398099ffa3c13248b1.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:42392 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755210AbYBGJf2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:35:28 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bay.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/bay.c b/drivers/acpi/bay.c
index 6daf608..4777114 100644
--- a/drivers/acpi/bay.c
+++ b/drivers/acpi/bay.c
@@ -46,6 +46,12 @@ MODULE_LICENSE("GPL");
 	printk(KERN_DEBUG PREFIX "%s: %s\n", prefix, s); }
 static void bay_notify(acpi_handle handle, u32 event, void *data);
 
+static const struct acpi_device_id bay_device_ids[] = {
+	{"LNXIOBAY", 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, bay_device_ids);
+
 struct bay {
 	acpi_handle handle;
 	char *name;
-- 
1.5.4.23.gef5b9

