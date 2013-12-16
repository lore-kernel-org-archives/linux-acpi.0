From: Carlos Garnacho <carlosg@gnome.org>
Subject: [PATCH 3/5] xo15-ebook: Send uevent when SW_TABLET_MODE changes
Date: Tue, 17 Dec 2013 00:00:12 +0100
Message-ID: <1387234814-17716-4-git-send-email-carlosg@gnome.org>
References: <1387234814-17716-1-git-send-email-carlosg@gnome.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ea0-f178.google.com ([209.85.215.178]:38839 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165Ab3LPW75 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Dec 2013 17:59:57 -0500
Received: by mail-ea0-f178.google.com with SMTP id d10so2517717eaj.23
        for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2013 14:59:56 -0800 (PST)
Received: from sacarino.redhat.com (5ED2AFE7.cm-7-3c.dynamic.ziggo.nl. [94.210.175.231])
        by mx.google.com with ESMTPSA id e3sm47458159eeg.11.2013.12.16.14.59.55
        for <linux-acpi@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Dec 2013 14:59:56 -0800 (PST)
In-Reply-To: <1387234814-17716-1-git-send-email-carlosg@gnome.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This enables udev and userspace to react to those events without
having to explicitly poll()/select() on the device.

Signed-off-by: Carlos Garnacho <carlosg@gnome.org>
---
 drivers/platform/x86/xo15-ebook.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/xo15-ebook.c b/drivers/platform/x86/xo15-ebook.c
index 4b1377b..2deaaa7 100644
--- a/drivers/platform/x86/xo15-ebook.c
+++ b/drivers/platform/x86/xo15-ebook.c
@@ -60,6 +60,7 @@ static int ebook_send_state(struct acpi_device *device)
 	/* input layer checks if event is redundant */
 	input_report_switch(button->input, SW_TABLET_MODE, !state);
 	input_sync(button->input);
+	kobject_uevent(&button->input->dev.kobj, KOBJ_CHANGE);
 	return 0;
 }
 
-- 
1.8.5.1

