From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/2] dell-wmi - properly handle errors returned by
	wmi_install_notify_handler()
Date: Tue, 29 Dec 2009 00:34:14 -0800
Message-ID: <20091229083226.13097.22110.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:35997 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbZL2IeT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Dec 2009 03:34:19 -0500
Received: by pzk1 with SMTP id 1so3332698pzk.33
        for <linux-acpi@vger.kernel.org>; Tue, 29 Dec 2009 00:34:18 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, Paul Rolland <rol@as2917.net>

wmi_install_notify_handler() retruns ACPI error codes instead of standard
Exxxx error codes and they should not be propagated unchanged to the upper
layers.

Reported-by: Paul Rolland <rol@as2917.net>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/platform/x86/dell-wmi.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index ff67a78..79bb1f1 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -265,6 +265,7 @@ static void __init find_hk_type(const struct dmi_header *dm, void *dummy)
 
 static int __init dell_wmi_init(void)
 {
+	acpi_status status;
 	int err;
 
 	if (!wmi_has_guid(DELL_EVENT_GUID)) {
@@ -279,12 +280,12 @@ static int __init dell_wmi_init(void)
 	if (err)
 		return err;
 
-	err = wmi_install_notify_handler(DELL_EVENT_GUID,
-					 dell_wmi_notify, NULL);
-	if (err) {
+	status = wmi_install_notify_handler(DELL_EVENT_GUID,
+					    dell_wmi_notify, NULL);
+	if (!ACPI_SUCCESS(status)) {
 		dell_wmi_input_destroy();
-		pr_err("Unable to register notify handler - %d\n", err);
-		return err;
+		pr_err("Unable to register notify handler - %d\n", status);
+		return -EIO;
 	}
 
 	return 0;

