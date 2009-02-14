From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 4/4] acer-wmi: Fix acpi video detection
Date: Sat, 14 Feb 2009 09:54:04 +0000
Message-ID: <20090214095404.18550.42478.stgit@localhost>
References: <20090214095342.18550.24339.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:33145 "EHLO
	pegasus." rhost-flags-OK-OK-FAIL-FAIL) by vger.kernel.org with ESMTP
	id S1751328AbZBNKNS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Feb 2009 05:13:18 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pegasus. (8.14.3/8.13.8) with ESMTP id n1E9s4M8018642
	for <linux-acpi@vger.kernel.org>; Sat, 14 Feb 2009 09:54:04 GMT
In-Reply-To: <20090214095342.18550.24339.stgit@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

From: Robert Jarzmik <rjarzmik@free.fr>

Acer WMI video driver can be used if _no_ acpi video
driver is found, not the opposite.

Signed-off-by: Robert Jarzmik <rjarzmik@free.fr>
Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
---

 drivers/platform/x86/acer-wmi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 94c9f91..6bcca61 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1297,7 +1297,7 @@ static int __init acer_wmi_init(void)
 
 	set_quirks();
 
-	if (!acpi_video_backlight_support() && has_cap(ACER_CAP_BRIGHTNESS)) {
+	if (acpi_video_backlight_support() && has_cap(ACER_CAP_BRIGHTNESS)) {
 		interface->capability &= ~ACER_CAP_BRIGHTNESS;
 		printk(ACER_INFO "Brightness must be controlled by "
 		       "generic video driver\n");

