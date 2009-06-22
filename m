From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 5/5] ACPI: video: DMI workaround broken Acer 7720 BIOS enabling display brightness
Date: Mon, 22 Jun 2009 11:31:18 +0800
Message-ID: <1245641478-31805-5-git-send-email-rui.zhang@intel.com>
References: <n>
 <1245641478-31805-1-git-send-email-rui.zhang@intel.com>
 <1245641478-31805-2-git-send-email-rui.zhang@intel.com>
 <1245641478-31805-3-git-send-email-rui.zhang@intel.com>
 <1245641478-31805-4-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56781 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753357AbZFVDaf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 21 Jun 2009 23:30:35 -0400
In-Reply-To: <1245641478-31805-4-git-send-email-rui.zhang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

http://bugzilla.kernel.org/show_bug.cgi?id=13121

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 9de143a..1914de5 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -586,6 +586,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5315"),
 		},
 	},
+	{
+	 .callback = video_set_bqc_offset,
+	 .ident = "Acer Aspire 7720",
+	 .matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR, "Acer"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 7720"),
+		},
+	},
 	{}
 };
 
-- 
1.5.4.4

