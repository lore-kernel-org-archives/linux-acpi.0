From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/10] ACPI, i915: blacklist Clevo M5x0N bad_lid state
Date: Tue, 16 Feb 2010 04:46:10 -0500
Message-ID: <1379d2fef0ec07c7027a5e89036025ce761470c8.1266313501.git.len.brown@intel.com>
References: <1266313570-6490-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:64369 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933229Ab0BPUtd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2010 15:49:33 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KXY00875CHM7KT4@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 16 Feb 2010 14:49:13 -0600 (CST)
In-reply-to: <1266313570-6490-1-git-send-email-lenb@kernel.org>
In-reply-to: <0406ad336c066190770cbf350b552d608e43ed09.1266313501.git.len.brown@intel.com>
References: <0406ad336c066190770cbf350b552d608e43ed09.1266313501.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Wrong Lid state reported.
Need to blacklist this machine for LVDS detection.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/gpu/drm/i915/intel_lvds.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_lvds.c b/drivers/gpu/drm/i915/intel_lvds.c
index b1d0acb..c2e8a45 100644
--- a/drivers/gpu/drm/i915/intel_lvds.c
+++ b/drivers/gpu/drm/i915/intel_lvds.c
@@ -636,6 +636,13 @@ static const struct dmi_system_id bad_lid_status[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "PC-81005"),
 		},
 	},
+	{
+		.ident = "Clevo M5x0N",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "CLEVO Co."),
+			DMI_MATCH(DMI_BOARD_NAME, "M5x0N"),
+		},
+	},
 	{ }
 };
 
-- 
1.6.0.6

