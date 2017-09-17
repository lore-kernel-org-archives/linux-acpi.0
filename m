From: =?UTF-8?q?J=C3=A9r=C3=B4me=20de=20Bretagne?=
        <jerome.debretagne@gmail.com>
Subject: [PATCH] platform/x86: intel-hid: Power button suspend on Dell Latitude 7275
Date: Mon, 18 Sep 2017 00:57:12 +0200
Message-ID: <20170917225712.12136-1-jerome.debretagne@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36759 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbdIQW6F (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 17 Sep 2017 18:58:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: platform-driver-x86@vger.kernel.org
Cc: Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andy.shevchenko@gmail.com>, Mario Limonciello <mario.limonciello@dell.com>, Alex Hung <alex.hung@canonical.com>

From: Jérôme de Bretagne <jerome.debretagne@gmail.com>

On Dell Latitude 7275 the 5-button array is not exposed in the
ACPI tables, but still notifies are sent to the Intel HID device
object (device ID INT33D5) in response to power button actions.
They were ignored as the intel-hid driver was not prepared to
take care of them until recently.

Power button wakeup from suspend-to-idle was added in:
635173a17b03 ("intel-hid: Wake up Dell Latitude 7275 from
suspend-to-idle"). However power button suspend doesn't work
yet on this platform so it would be good to add it also.

On the affected platform (for which priv->array is NULL), add
a new upfront check against the power button press notification
(0xCE) to notify_handler(), outside the wakeup mode this time,
which allows to report the power button press event and
trigger the suspend. Also catch and ignore the corresponding
power button release notification (0xCF) to stop it from being
reported as an "unknown event" in the logs.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=196115
Tested-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
---
 drivers/platform/x86/intel-hid.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
index a782c78e7c63..b19f8dcf9d8c 100644
--- a/drivers/platform/x86/intel-hid.c
+++ b/drivers/platform/x86/intel-hid.c
@@ -226,6 +226,22 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
 		return;
 	}
 
+	/*
+	 * Needed for suspend to work on some platforms that don't expose
+	 * the 5-button array, but still send notifies with power button
+	 * event code to this device object on power button actions.
+	 *
+	 * Report the power button press; catch and ignore the button release.
+	 */
+	if (!priv->array) {
+		if (event == 0xce) {
+			input_report_key(priv->input_dev, KEY_POWER, 1);
+			input_sync(priv->input_dev);
+			return;
+		} else if (event == 0xcf)
+			return;
+	}
+
 	/* 0xC0 is for HID events, other values are for 5 button array */
 	if (event != 0xc0) {
 		if (!priv->array ||
