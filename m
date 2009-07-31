From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 08/19] ACPI: use device_type rather than comparing HID
Date: Fri, 31 Jul 2009 15:37:14 -0600
Message-ID: <20090731213714.29930.80577.stgit@bob.kio>
References: <20090731213501.29930.39957.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:45097 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160AbZGaVhP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Jul 2009 17:37:15 -0400
In-Reply-To: <20090731213501.29930.39957.stgit@bob.kio>
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
index b386589..f563360 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -374,15 +374,13 @@ static acpi_status acpi_device_notify_fixed(void *data)
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
@@ -400,10 +398,10 @@ static int acpi_device_install_notify_handler(struct acpi_device *device)
 
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

