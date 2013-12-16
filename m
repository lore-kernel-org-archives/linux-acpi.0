From: Carlos Garnacho <carlosg@gnome.org>
Subject: [PATCH 5/5] fujitsu-tablet: Send uevent when SW_TABLET_MODE changes
Date: Tue, 17 Dec 2013 00:00:14 +0100
Message-ID: <1387234814-17716-6-git-send-email-carlosg@gnome.org>
References: <1387234814-17716-1-git-send-email-carlosg@gnome.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ea0-f182.google.com ([209.85.215.182]:59653 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173Ab3LPW77 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Dec 2013 17:59:59 -0500
Received: by mail-ea0-f182.google.com with SMTP id a15so2554071eae.13
        for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2013 14:59:58 -0800 (PST)
Received: from sacarino.redhat.com (5ED2AFE7.cm-7-3c.dynamic.ziggo.nl. [94.210.175.231])
        by mx.google.com with ESMTPSA id e3sm47458159eeg.11.2013.12.16.14.59.57
        for <linux-acpi@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Dec 2013 14:59:58 -0800 (PST)
In-Reply-To: <1387234814-17716-1-git-send-email-carlosg@gnome.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This enables udev and userspace to react to those events without
having to explicitly poll()/select() on the device.

Signed-off-by: Carlos Garnacho <carlosg@gnome.org>
---
 drivers/platform/x86/fujitsu-tablet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/fujitsu-tablet.c b/drivers/platform/x86/fujitsu-tablet.c
index 570926c..935fb4e 100644
--- a/drivers/platform/x86/fujitsu-tablet.c
+++ b/drivers/platform/x86/fujitsu-tablet.c
@@ -178,6 +178,7 @@ static void fujitsu_send_state(void)
 	input_report_switch(fujitsu.idev, SW_DOCK, dock);
 	input_report_switch(fujitsu.idev, SW_TABLET_MODE, tablet_mode);
 	input_sync(fujitsu.idev);
+	kobject_uevent(&fujitsu.idev->dev.kobj, KOBJ_CHANGE);
 }
 
 static void fujitsu_reset(void)
-- 
1.8.5.1

