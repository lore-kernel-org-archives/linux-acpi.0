From: Carlos Garnacho <carlosg@gnome.org>
Subject: [PATCH 4/5] classmate-laptop: Send uevent when SW_TABLET_MODE changes
Date: Tue, 17 Dec 2013 00:00:13 +0100
Message-ID: <1387234814-17716-5-git-send-email-carlosg@gnome.org>
References: <1387234814-17716-1-git-send-email-carlosg@gnome.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:46686 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168Ab3LPW76 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Dec 2013 17:59:58 -0500
Received: by mail-ee0-f50.google.com with SMTP id c41so2511203eek.23
        for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2013 14:59:57 -0800 (PST)
Received: from sacarino.redhat.com (5ED2AFE7.cm-7-3c.dynamic.ziggo.nl. [94.210.175.231])
        by mx.google.com with ESMTPSA id e3sm47458159eeg.11.2013.12.16.14.59.56
        for <linux-acpi@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Dec 2013 14:59:57 -0800 (PST)
In-Reply-To: <1387234814-17716-1-git-send-email-carlosg@gnome.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This enables udev and userspace to react to those events without
having to explicitly poll()/select() on the device.

Signed-off-by: Carlos Garnacho <carlosg@gnome.org>
---
 drivers/platform/x86/classmate-laptop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index 6dfa8d3..6329a0d 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -728,6 +728,7 @@ static void cmpc_tablet_handler(struct acpi_device *dev, u32 event)
 		if (ACPI_SUCCESS(cmpc_get_tablet(dev->handle, &val))) {
 			input_report_switch(inputdev, SW_TABLET_MODE, !val);
 			input_sync(inputdev);
+			kobject_uevent(&inputdev->dev.kobj, KOBJ_CHANGE);
 		}
 	}
 }
@@ -744,6 +745,7 @@ static void cmpc_tablet_idev_init(struct input_dev *inputdev)
 	if (ACPI_SUCCESS(cmpc_get_tablet(acpi->handle, &val))) {
 		input_report_switch(inputdev, SW_TABLET_MODE, !val);
 		input_sync(inputdev);
+		kobject_uevent(&inputdev->dev.kobj, KOBJ_CHANGE);
 	}
 }
 
-- 
1.8.5.1

