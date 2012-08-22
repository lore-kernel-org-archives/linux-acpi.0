From: Feng Tang <feng.tang@intel.com>
Subject: [PATCH 2/2] usb-acpi: Comply with the ACPI API change
Date: Wed, 22 Aug 2012 14:24:36 +0800
Message-ID: <1345616676-30915-2-git-send-email-feng.tang@intel.com>
References: <1345616676-30915-1-git-send-email-feng.tang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50132 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752109Ab2HVGaG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Aug 2012 02:30:06 -0400
In-Reply-To: <1345616676-30915-1-git-send-email-feng.tang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com, linux-acpi@vger.kernel.org
Cc: mjg@redhat.com, tianyu.lan@intel.com, gregkh@linuxfoundation.org, Feng Tang <feng.tang@intel.com>, Bob Moore <robert.moore@intel.com>

acpi_get_physical_device_location()'s 2nd argument has been changed
in ACPI implementaion, so need a follow-on change in
usb_acpi_check_pld().

Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Cc: Matthew Garrett <mjg@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/usb/core/usb-acpi.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index 8947b20..ce45f55 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -52,18 +52,19 @@ out:
 static int usb_acpi_check_pld(struct usb_device *udev, acpi_handle handle)
 {
 	acpi_status status;
-	struct acpi_pld pld;
+	struct acpi_pld_info *pld;
 
 	status = acpi_get_physical_device_location(handle, &pld);
 
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	if (pld.user_visible)
+	if (pld->user_visible)
 		udev->removable = USB_DEVICE_REMOVABLE;
 	else
 		udev->removable = USB_DEVICE_FIXED;
 
+	ACPI_FREE(pld);
 	return 0;
 }
 
-- 
1.7.1

