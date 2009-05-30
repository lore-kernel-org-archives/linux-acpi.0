From: Len Brown <lenb@kernel.org>
Subject: [PATCH 61/65] ACPI: video: DMI workaround broken Acer 5315 BIOS
 enabling display brightness
Date: Fri, 29 May 2009 21:42:39 -0400
Message-ID: <93bcece20ef87c29548ec7e66532f1018572cea0.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:12944 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbZFATPL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Jun 2009 15:15:11 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKK00CTONRZ4VT6@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 01 Jun 2009 13:09:36 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

http://bugzilla.kernel.org/show_bug.cgi?id=13121

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index ee45e76..6d897bb 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -578,6 +578,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "eMachines E510"),
 		},
 	},
+	{
+	 .callback = video_set_bqc_offset,
+	 .ident = "Acer Aspire 5315",
+	 .matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR, "Acer"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5315"),
+		},
+	},
 	{}
 };
 
-- 
1.6.0.6

