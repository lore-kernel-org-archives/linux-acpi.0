From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH] acer-wmi: Remove LED colour comment from documentation
Date: Sat, 19 Apr 2008 19:46:29 +0100
Message-ID: <20080419184628.1809.32286.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:35485 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754902AbYDSTFY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 Apr 2008 15:05:24 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

This should have been removed when the colour was removed from the LED
device name.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
---

 Documentation/laptops/acer-wmi.txt |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)


diff --git a/Documentation/laptops/acer-wmi.txt b/Documentation/laptops/acer-wmi.txt
index 23df051..956efb6 100644
--- a/Documentation/laptops/acer-wmi.txt
+++ b/Documentation/laptops/acer-wmi.txt
@@ -174,8 +174,6 @@ The LED is exposed through the LED subsystem, and can be found in:
 The mail LED is autodetected, so if you don't have one, the LED device won't
 be registered.
 
-If you have a mail LED that is not green, please report this to me.
-
 Backlight
 *********
 

