From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI video: no warning message if "acpi_backlight=vendor"
	is used
Date: Mon, 13 Jul 2009 10:33:24 +0800
Message-ID: <1247452404.15520.202.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:29145 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752099AbZGMCcn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Jul 2009 22:32:43 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>


AML code always sends notifications to ACPI video device,
even if we disable the ACPI backlight control by using
boot option "acpi_backlight=vendor".

In this case we should not print any warning message.
http://bugzilla.kernel.org/show_bug.cgi?id=13671#c14

Sigend-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -1948,6 +1948,10 @@ acpi_video_switch_brightness(struct acpi
 	unsigned long long level_current, level_next;
 	int result = -EINVAL;
 
+	/* no warning message if acpi_backlight=vendor is used */
+	if (!acpi_video_backlight_support())
+		return 0;
+
 	if (!device->brightness)
 		goto out;
 


