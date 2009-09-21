From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v3 06/17] ACPI: use device_type rather than comparing HID
Date: Mon, 21 Sep 2009 13:29:15 -0600
Message-ID: <20090921192915.21322.85677.stgit@bob.kio>
References: <20090921192656.21322.23072.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:16520 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbZIUT3L (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Sep 2009 15:29:11 -0400
In-Reply-To: <20090921192656.21322.23072.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Check the acpi_device device_type rather than the HID.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/scan.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index c73681b..c8e867b 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -378,15 +378,13 @@ static acpi_status acpi_device_notify_fixed(void *data)
 static int acpi_device_install_notify_handler(struct acpi_device *device)
 {
 	acpi_status status;
-	char *hid;
 
-	hid = acpi_device_hid(device);
-	if (!strcmp(hid, ACPI_BUTTON_HID_POWERF))
+	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON)
 		status =
 		    acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
 						     acpi_device_notify_fixed,
 						     device);
-	else if (!strcmp(hid, ACPI_BUTTON_HID_SLEEPF))
+	else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON)
 		status =
 		    acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
 						     acpi_device_notify_fixed,
@@ -404,10 +402,10 @@ static int acpi_device_install_notify_handler(struct acpi_device *device)
 
 static void acpi_device_remove_notify_handler(struct acpi_device *device)
 {
-	if (!strcmp(acpi_device_hid(device), ACPI_BUTTON_HID_POWERF))
+	if (device->device_type == ACPI_BUS_TYPE_POWER_BUTTON)
 		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
 						acpi_device_notify_fixed);
-	else if (!strcmp(acpi_device_hid(device), ACPI_BUTTON_HID_SLEEPF))
+	else if (device->device_type == ACPI_BUS_TYPE_SLEEP_BUTTON)
 		acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
 						acpi_device_notify_fixed);
 	else

