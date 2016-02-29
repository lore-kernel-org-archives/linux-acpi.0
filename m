From: Eric Engestrom <eric.engestrom@imgtec.com>
Subject: [PATCH] acpi: remove left over dead code
Date: Mon, 29 Feb 2016 16:27:04 +0000
Message-ID: <1456763224-32409-1-git-send-email-eric.engestrom@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:20238 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955AbcB2Q1B (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Feb 2016 11:27:01 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Eric Engestrom <eric.engestrom@imgtec.com>

39fe394d05be43481ceac8b3db19dfd5189097f6 ("ACPI video: remove deprecated
procfs I/F") removed everything that would've used this variable.

Signed-off-by: Eric Engestrom <eric.engestrom@imgtec.com>
---
 drivers/acpi/acpi_video.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index a76f8be..4361bc9 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -218,13 +218,6 @@ struct acpi_video_device {
 	struct thermal_cooling_device *cooling_dev;
 };
 
-static const char device_decode[][30] = {
-	"motherboard VGA device",
-	"PCI VGA device",
-	"AGP VGA device",
-	"UNKNOWN",
-};
-
 static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data);
 static void acpi_video_device_rebind(struct acpi_video_bus *video);
 static void acpi_video_device_bind(struct acpi_video_bus *video,
-- 
2.7.1

