From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 3/4] acer-wmi: Unmark as 'experimental'
Date: Sat, 14 Feb 2009 09:53:59 +0000
Message-ID: <20090214095358.18550.94399.stgit@localhost>
References: <20090214095342.18550.24339.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:33145 "EHLO
	pegasus." rhost-flags-OK-OK-FAIL-FAIL) by vger.kernel.org with ESMTP
	id S1750972AbZBNKNP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Feb 2009 05:13:15 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pegasus. (8.14.3/8.13.8) with ESMTP id n1E9rxBH018626
	for <linux-acpi@vger.kernel.org>; Sat, 14 Feb 2009 09:53:59 GMT
In-Reply-To: <20090214095342.18550.24339.stgit@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This driver has been around and used long enough that we can drop the
'experimental'.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
---

 drivers/platform/x86/Kconfig |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)


diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 7192f0a..92a529c 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -15,8 +15,7 @@ menuconfig X86_PLATFORM_DEVICES
 if X86_PLATFORM_DEVICES
 
 config ACER_WMI
-	tristate "Acer WMI Laptop Extras (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	tristate "Acer WMI Laptop Extras"
 	depends on ACPI
 	depends on LEDS_CLASS
 	depends on NEW_LEDS

