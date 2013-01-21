From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH v6 3/8] PM/Qos: Expose dev_pm_qos_flags symbol
Date: Mon, 21 Jan 2013 22:18:02 +0800
Message-ID: <1358777887-2656-4-git-send-email-tianyu.lan@intel.com>
References: <1358777887-2656-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50635 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753566Ab3AUOUj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jan 2013 09:20:39 -0500
In-Reply-To: <1358777887-2656-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gregkh@linuxfoundation.org, lenb@kernel.org, sarah.a.sharp@linux.intel.com, stern@rowland.harvard.edu, rjw@sisk.pl, oneukum@suse.de
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, Lan Tianyu <tianyu.lan@intel.com>

The dev_pm_qos_flags() will be used in the usb core which could be
compiled as a module. This patch is to export it.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/base/power/qos.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index d213495..3d4d1f8 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -91,6 +91,7 @@ enum pm_qos_flags_status dev_pm_qos_flags(struct device *dev, s32 mask)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(dev_pm_qos_flags);
 
 /**
  * __dev_pm_qos_read_value - Get PM QoS constraint for a given device.
-- 
1.7.9.5

