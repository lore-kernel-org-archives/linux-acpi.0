From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] platform/x86: intel-hid: Wake up Dell Latitude 7275 from suspend-to-idle
Date: Fri, 28 Jul 2017 02:06:36 +0200
Message-ID: <7313224.XbtxUoJtXM@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58782 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751524AbdG1AOi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 Jul 2017 20:14:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: platform-drivers-x86@vger.kernel.org
Cc: Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, =?ISO-8859-1?Q?J=E9r=F4me?= de Bretagne <jerome.debretagne@gmail.com>, Mario Limonciello <mario.limonciello@dell.com>, Alex Hung <alex.hung@canonical.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

On Dell Latitude 7275 the 5-button array is not exposed in the
ACPI tables, but still notifies are sent to the Intel HID device
object (device ID INT33D5) in response to power button actions while
suspended to idle.  However, they are currently ignored as the
intel-hid driver is not prepared to take care of them.

As a result, power button wakeup from suspend-to-idle doesn't work
on this platform, but suspend-to-idle is the only reliable suspend
variant on it (the S3 implementation in the platform firmware turns
out to be broken), so it would be good to handle it properly.

For this reason, add an upfront check against the power button press
event (0xCE) to notify_handler() in the wakeup mode which allows it
to catch the power button wakeup notification on the affected
platform (even though priv->array is NULL on it) and should not
change the behavior on platforms with priv->array present (because
priv->array contains the event in question in those cases).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=196115
Tested-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/intel-hid.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/platform/x86/intel-hid.c
===================================================================
--- linux-pm.orig/drivers/platform/x86/intel-hid.c
+++ linux-pm/drivers/platform/x86/intel-hid.c
@@ -203,15 +203,26 @@ static void notify_handler(acpi_handle h
 	acpi_status status;
 
 	if (priv->wakeup_mode) {
+		/*
+		 * Needed for wakeup from suspend-to-idle to work on some
+		 * platforms that don't expose the 5-button array, but still
+		 * send notifies with the power button event code to this
+		 * device object on power button actions while suspended.
+		 */
+		if (event == 0xce)
+			goto wakeup;
+
 		/* Wake up on 5-button array events only. */
 		if (event == 0xc0 || !priv->array)
 			return;
 
-		if (sparse_keymap_entry_from_scancode(priv->array, event))
-			pm_wakeup_hard_event(&device->dev);
-		else
+		if (!sparse_keymap_entry_from_scancode(priv->array, event)) {
 			dev_info(&device->dev, "unknown event 0x%x\n", event);
+			return;
+		}
 
+wakeup:
+		pm_wakeup_hard_event(&device->dev);
 		return;
 	}
 

