From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 2/3] acer-wmi: Cleanup the failure cleanup handling
Date: Sat, 04 Apr 2009 09:12:54 +0100
Message-ID: <20090404081254.9812.8913.stgit@localhost>
References: <20090404081243.9812.3769.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:37592 "EHLO
	pegasus." rhost-flags-OK-OK-FAIL-FAIL) by vger.kernel.org with ESMTP
	id S1754119AbZDDIUm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 4 Apr 2009 04:20:42 -0400
In-Reply-To: <20090404081243.9812.3769.stgit@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

From: Andy Whitcroft <apw@canonical.com>

Cleanup the failure cleanup handling for brightness and email led.

[cc: Split out from another patch]

Signed-off-by: Andy Whitcroft <apw@canonical.com>
Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
---

 drivers/platform/x86/acer-wmi.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)


diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 61d02f9..bfba6f7 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1138,11 +1138,17 @@ static int __devinit acer_platform_probe(struct platform_device *device)
 	}
 
 	err = acer_rfkill_init(&device->dev);
+	if (err)
+		goto error_rfkill;
 
 	return err;
 
+error_rfkill:
+	if (has_cap(ACER_CAP_BRIGHTNESS))
+		acer_backlight_exit();
 error_brightness:
-	acer_led_exit();
+	if (has_cap(ACER_CAP_MAILLED))
+		acer_led_exit();
 error_mailled:
 	return err;
 }

