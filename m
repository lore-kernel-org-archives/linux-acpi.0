From: Carlos Garnacho <carlosg@gnome.org>
Subject: [PATCH 1/5] thinkpad_acpi: Send uevent when SW_TABLET_MODE changes
Date: Tue, 17 Dec 2013 00:00:10 +0100
Message-ID: <1387234814-17716-2-git-send-email-carlosg@gnome.org>
References: <1387234814-17716-1-git-send-email-carlosg@gnome.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ea0-f181.google.com ([209.85.215.181]:38304 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161Ab3LPW7z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Dec 2013 17:59:55 -0500
Received: by mail-ea0-f181.google.com with SMTP id m10so2554084eaj.12
        for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2013 14:59:54 -0800 (PST)
Received: from sacarino.redhat.com (5ED2AFE7.cm-7-3c.dynamic.ziggo.nl. [94.210.175.231])
        by mx.google.com with ESMTPSA id e3sm47458159eeg.11.2013.12.16.14.59.53
        for <linux-acpi@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Dec 2013 14:59:54 -0800 (PST)
In-Reply-To: <1387234814-17716-1-git-send-email-carlosg@gnome.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This enables udev and userspace to react to those events without
having to explicitly poll()/select() on the device.

Signed-off-by: Carlos Garnacho <carlosg@gnome.org>
---
 drivers/platform/x86/thinkpad_acpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 58b0274..5003611 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -2251,6 +2251,8 @@ static void tpacpi_input_send_tabletsw(void)
 		input_sync(tpacpi_inputdev);
 
 		mutex_unlock(&tpacpi_inputdev_send_mutex);
+
+		kobject_uevent(&tpacpi_inputdev->dev.kobj, KOBJ_CHANGE);
 	}
 }
 
-- 
1.8.5.1

