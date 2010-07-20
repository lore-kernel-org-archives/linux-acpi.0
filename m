From: akpm@linux-foundation.org
Subject: [patch 01/26] hp-wmi: return -ENODEV if BIOS does not export any supported hp wmi guid
Date: Tue, 20 Jul 2010 15:19:29 -0700
Message-ID: <201007202219.o6KMJT5v020994@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40036 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932156Ab0GTWUV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jul 2010 18:20:21 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, trenn@suse.de, axel.lin@gmail.com, len.brown@intel.com, mjg@redhat.com

From: Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
Cc: Matthew Garrett <mjg@redhat.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Axel Lin <axel.lin@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/hp-wmi.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff -puN drivers/platform/x86/hp-wmi.c~hp-wmi-return-enodev-if-bios-does-not-export-any-supported-hp-wmi-guid drivers/platform/x86/hp-wmi.c
--- a/drivers/platform/x86/hp-wmi.c~hp-wmi-return-enodev-if-bios-does-not-export-any-supported-hp-wmi-guid
+++ a/drivers/platform/x86/hp-wmi.c
@@ -711,8 +711,10 @@ static int hp_wmi_resume_handler(struct 
 static int __init hp_wmi_init(void)
 {
 	int err;
+	int event_capable = wmi_has_guid(HPWMI_EVENT_GUID);
+	int bios_capable = wmi_has_guid(HPWMI_BIOS_GUID);
 
-	if (wmi_has_guid(HPWMI_EVENT_GUID)) {
+	if (event_capable) {
 		err = wmi_install_notify_handler(HPWMI_EVENT_GUID,
 						 hp_wmi_notify, NULL);
 		if (ACPI_FAILURE(err))
@@ -724,7 +726,7 @@ static int __init hp_wmi_init(void)
 		}
 	}
 
-	if (wmi_has_guid(HPWMI_BIOS_GUID)) {
+	if (bios_capable) {
 		err = platform_driver_register(&hp_wmi_driver);
 		if (err)
 			goto err_driver_reg;
@@ -738,6 +740,9 @@ static int __init hp_wmi_init(void)
 			goto err_device_add;
 	}
 
+	if (!bios_capable && !event_capable)
+		return -ENODEV;
+
 	return 0;
 
 err_device_add:
_
