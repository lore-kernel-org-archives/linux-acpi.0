From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/37] ACPI: thinkpad-acpi: make room for more features in tp_features bitfield
Date: Wed, 10 Oct 2007 01:06:17 -0400
Message-ID: <1191992804-14965-11-git-send-email-lenb@kernel.org>
References: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:20396 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750981AbXJJFGw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Oct 2007 01:06:52 -0400
In-Reply-To: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Message-Id: <4b2fe7e2a79727104e549a89a32b4aae26521861.1191992584.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Increase tp_features to 32 bits.  It is too close to running out of room.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.h |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 082a1cb..fa64ded 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -233,22 +233,22 @@ struct ibm_init_struct {
 
 static struct {
 #ifdef CONFIG_THINKPAD_ACPI_BAY
-	u16 bay_status:1;
-	u16 bay_eject:1;
-	u16 bay_status2:1;
-	u16 bay_eject2:1;
+	u32 bay_status:1;
+	u32 bay_eject:1;
+	u32 bay_status2:1;
+	u32 bay_eject2:1;
 #endif
-	u16 bluetooth:1;
-	u16 hotkey:1;
-	u16 hotkey_mask:1;
-	u16 hotkey_wlsw:1;
-	u16 light:1;
-	u16 light_status:1;
-	u16 wan:1;
-	u16 fan_ctrl_status_undef:1;
-	u16 input_device_registered:1;
-	u16 platform_drv_registered:1;
-	u16 platform_drv_attrs_registered:1;
+	u32 bluetooth:1;
+	u32 hotkey:1;
+	u32 hotkey_mask:1;
+	u32 hotkey_wlsw:1;
+	u32 light:1;
+	u32 light_status:1;
+	u32 wan:1;
+	u32 fan_ctrl_status_undef:1;
+	u32 input_device_registered:1;
+	u32 platform_drv_registered:1;
+	u32 platform_drv_attrs_registered:1;
 } tp_features;
 
 struct thinkpad_id_data {
-- 
1.5.3.4.206.g58ba4
