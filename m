From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/2] hp-wmi - properly handle errors returned by
	wmi_install_notify_handler()
Date: Tue, 29 Dec 2009 00:34:25 -0800
Message-ID: <20091229083420.13097.75563.stgit@localhost.localdomain>
References: <20091229083226.13097.22110.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:35997 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbZL2Ie1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Dec 2009 03:34:27 -0500
Received: by mail-pz0-f171.google.com with SMTP id 1so3332698pzk.33
        for <linux-acpi@vger.kernel.org>; Tue, 29 Dec 2009 00:34:27 -0800 (PST)
In-Reply-To: <20091229083226.13097.22110.stgit@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, Paul Rolland <rol@as2917.net>

wmi_install_notify_handler() retruns ACPI error codes instead of standard
Exxxx error codes so let's test the error condition properly.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/platform/x86/hp-wmi.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index 1d8a073..88458f3 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -589,12 +589,13 @@ static int hp_wmi_resume_handler(struct device *device)
 
 static int __init hp_wmi_init(void)
 {
+	acpi_status status;
 	int err;
 
 	if (wmi_has_guid(HPWMI_EVENT_GUID)) {
-		err = wmi_install_notify_handler(HPWMI_EVENT_GUID,
-						 hp_wmi_notify, NULL);
-		if (!err)
+		status = wmi_install_notify_handler(HPWMI_EVENT_GUID,
+						    hp_wmi_notify, NULL);
+		if (ACPI_SUCCESS(status))
 			hp_wmi_input_setup();
 	}
 

