From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 2/3] ACPI: Update the backlight state when we change brightness
Date: Mon, 13 Jul 2009 21:41:24 +0100
Message-ID: <1247517685-7719-2-git-send-email-mjg@redhat.com>
References: <1247517685-7719-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:58754 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725AbZGMUlf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Jul 2009 16:41:35 -0400
In-Reply-To: <1247517685-7719-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, rpurdie@rpsys.net, lenb@kernel.org, rui.zhang@intel.com, corentincj@iksaif.net, Matthew Garrett <mjg@redhat.com>

Trigger a status update when we change the brightness in the driver, thus
allowing userspace to present appropriate UI.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/video.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 8851315..d7219f6 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1960,6 +1960,8 @@ acpi_video_switch_brightness(struct acpi_video_device *device, int event)
 
 	result = acpi_video_device_lcd_set_level(device, level_next);
 
+	backlight_force_update(device->backlight);
+
 out:
 	if (result)
 		printk(KERN_ERR PREFIX "Failed to switch the brightness\n");
-- 
1.6.2.5

