From: al.stone@linaro.org
Subject: [PATCH v2 4/6] ACPI: ARM: exclude DMI calls
Date: Thu, 21 Nov 2013 17:41:53 -0700
Message-ID: <1385080915-23430-5-git-send-email-al.stone@linaro.org>
References: <1385080915-23430-1-git-send-email-al.stone@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:43151 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755202Ab3KVAmN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Nov 2013 19:42:13 -0500
Received: by mail-pa0-f45.google.com with SMTP id fb1so538680pad.32
        for <linux-acpi@vger.kernel.org>; Thu, 21 Nov 2013 16:42:13 -0800 (PST)
In-Reply-To: <1385080915-23430-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linaro-acpi@lists.linaro.org, patches@linaro.org, linaro-kernel@lists.linaro.org, Al Stone <al.stone@linaro.org>

From: Al Stone <al.stone@linaro.org>

Modified #ifdef so that DMI is not used on ARM platforms which
are currently implementing ACPI reduced HW mode.

Signed-off-by: Al Stone <al.stone@linaro.org>
---
 include/linux/dmi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dmi.h b/include/linux/dmi.h
index f820f0a..a03deb8 100644
--- a/include/linux/dmi.h
+++ b/include/linux/dmi.h
@@ -83,7 +83,7 @@ struct dmi_device {
 	void *device_data;	/* Type specific data */
 };
 
-#ifdef CONFIG_DMI
+#if IS_ENABLED(CONFIG_DMI) && !IS_ENABLED(CONFIG_ACPI_REDUCED_HARDWARE)
 
 struct dmi_dev_onboard {
 	struct dmi_device dev;
-- 
1.8.3.1

