From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/3] PM: Make suspend_device() static
Date: Sun, 3 Feb 2008 22:55:18 +0100
Message-ID: <200802032255.19835.rjw@sisk.pl>
References: <200802032252.04852.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41730 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751425AbYBCWCo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 3 Feb 2008 17:02:44 -0500
In-Reply-To: <200802032252.04852.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Greg KH <greg@kroah.com>, Adrian Bunk <bunk@kernel.org>

From: Adrian Bunk <bunk@kernel.org>

suspend_device() can become static.

Signed-off-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
344fcfcea0df8cbaa83e10d7e66b826ead67290b 
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 200ed5f..cfcc54f 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -414,7 +414,7 @@ EXPORT_SYMBOL_GPL(device_power_down);
  *	@dev:	Device.
  *	@state:	Power state device is entering.
  */
-int suspend_device(struct device *dev, pm_message_t state)
+static int suspend_device(struct device *dev, pm_message_t state)
 {
 	int error = 0;
 



