From: Carlos Garnacho <carlosg@gnome.org>
Subject: [PATCH 2/5] hp-wmi: Send uevent when SW_TABLET_MODE changes
Date: Tue, 17 Dec 2013 00:00:11 +0100
Message-ID: <1387234814-17716-3-git-send-email-carlosg@gnome.org>
References: <1387234814-17716-1-git-send-email-carlosg@gnome.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ea0-f180.google.com ([209.85.215.180]:36003 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161Ab3LPW74 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Dec 2013 17:59:56 -0500
Received: by mail-ea0-f180.google.com with SMTP id f15so2563466eak.39
        for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2013 14:59:55 -0800 (PST)
Received: from sacarino.redhat.com (5ED2AFE7.cm-7-3c.dynamic.ziggo.nl. [94.210.175.231])
        by mx.google.com with ESMTPSA id e3sm47458159eeg.11.2013.12.16.14.59.54
        for <linux-acpi@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Dec 2013 14:59:55 -0800 (PST)
In-Reply-To: <1387234814-17716-1-git-send-email-carlosg@gnome.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This enables udev and userspace to react to those events without
having to explicitly poll()/select() on the device.

Signed-off-by: Carlos Garnacho <carlosg@gnome.org>
---
 drivers/platform/x86/hp-wmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index 8ba8956..d5428ea 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -554,6 +554,7 @@ static void hp_wmi_notify(u32 value, void *context)
 		input_report_switch(hp_wmi_input_dev, SW_TABLET_MODE,
 				    hp_wmi_tablet_state());
 		input_sync(hp_wmi_input_dev);
+		kobject_uevent(&hp_wmi_input_dev->dev.kobj, KOBJ_CHANGE);
 		break;
 	case HPWMI_PARK_HDD:
 		break;
@@ -647,6 +648,7 @@ static int __init hp_wmi_input_setup(void)
 	input_report_switch(hp_wmi_input_dev, SW_TABLET_MODE,
 			    hp_wmi_tablet_state());
 	input_sync(hp_wmi_input_dev);
+	kobject_uevent(&hp_wmi_input_dev->dev.kobj, KOBJ_CHANGE);
 
 	status = wmi_install_notify_handler(HPWMI_EVENT_GUID, hp_wmi_notify, NULL);
 	if (ACPI_FAILURE(status)) {
@@ -955,6 +957,7 @@ static int hp_wmi_resume_handler(struct device *device)
 		input_report_switch(hp_wmi_input_dev, SW_TABLET_MODE,
 				    hp_wmi_tablet_state());
 		input_sync(hp_wmi_input_dev);
+		kobject_uevent(&hp_wmi_input_dev->dev.kobj, KOBJ_CHANGE);
 	}
 
 	if (rfkill2_count)
-- 
1.8.5.1

