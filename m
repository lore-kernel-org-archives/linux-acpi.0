From: Len Brown <lenb@kernel.org>
Subject: [PATCH 26/26] PM: Make suspend_device() static
Date: Thu, 21 Feb 2008 04:38:11 -0500
Message-ID: <19e20c913bae2dd458b9fc42afab0c53f16562d1.1203586624.git.len.brown@intel.com>
References: <1203586691-1234-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:38020 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762688AbYBUJjT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 04:39:19 -0500
In-Reply-To: <1203586691-1234-1-git-send-email-lenb@kernel.org>
In-Reply-To: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203586624.git.len.brown@intel.com>
References: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203586624.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Adrian Bunk <bunk@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Adrian Bunk <bunk@kernel.org>

suspend_device() can become static.

Signed-off-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/base/power/main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index bdc03f7..a96ca86 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -415,7 +415,7 @@ EXPORT_SYMBOL_GPL(device_power_down);
  *	@dev:	Device.
  *	@state:	Power state device is entering.
  */
-int suspend_device(struct device *dev, pm_message_t state)
+static int suspend_device(struct device *dev, pm_message_t state)
 {
 	int error = 0;
 
-- 
1.5.4

