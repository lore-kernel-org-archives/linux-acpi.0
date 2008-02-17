From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH] acer-wmi - Rename mail LED correctly & remove hardcoded colour
Date: Sun, 17 Feb 2008 10:50:29 +0000
Message-ID: <20080217105028.1699.94887.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:38591 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753459AbYBQKuq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 17 Feb 2008 05:50:46 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

The mail LED name for acer-wmi currently hardcodes in the colour as green.
This is wrong, since many of the newer laptops now come with an orange
LED, and we have no way of telling what colour is used on a given system.

Also, rename the mail LED to be inline with the current recommendations of
the LED class documentation.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
---

 Documentation/laptops/acer-wmi.txt |    2 +-
 drivers/misc/acer-wmi.c            |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


diff --git a/Documentation/laptops/acer-wmi.txt b/Documentation/laptops/acer-wmi.txt
index b066963..a346c86 100644
--- a/Documentation/laptops/acer-wmi.txt
+++ b/Documentation/laptops/acer-wmi.txt
@@ -169,7 +169,7 @@ can be added to acer-wmi.
 
 The LED is exposed through the LED subsystem, and can be found in:
 
-/sys/devices/platform/acer-wmi/leds/acer-mail:green/
+/sys/devices/platform/acer-wmi/leds/acer-wmi::mail/
 
 The mail LED is autodetected, so if you don't have one, the LED device won't
 be registered.
diff --git a/drivers/misc/acer-wmi.c b/drivers/misc/acer-wmi.c
index 74d12b4..e85d96f 100644
--- a/drivers/misc/acer-wmi.c
+++ b/drivers/misc/acer-wmi.c
@@ -761,7 +761,7 @@ enum led_brightness value)
 }
 
 static struct led_classdev mail_led = {
-	.name = "acer-mail:green",
+	.name = "acer-wmi::mail",
 	.brightness_set = mail_led_set,
 };
 

