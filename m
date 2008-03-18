From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH] ACPI : Disable the device's ability to wake the sleeping
	system in the boot phase
Date: Tue, 18 Mar 2008 09:03:26 +0800
Message-ID: <1205802206.4085.5.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28362 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752606AbYCRBQ0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Mar 2008 21:16:26 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Subject: ACPI : Disable the device's ability to wake the sleeping system in the boot phase
>From : Zhao Yakui <yakui.zhao@intel.com>

In some machines some GPE is shared by several ACPI devices, for example:
sleep button, keyboard, mouse. At the same time one of them is 
non-wake(runtime) device and the other are wake devices. In such case OSPM
should disable the device's ability to wake the sleeping system in the boot 
phase.Otherwise there will be ACPI interrupt flood triggered by the GPE input.

http://bugzilla.kernel.org/show_bug.cgi?id=9781
http://bugzilla.kernel.org/show_bug.cgi?id=10224

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Zhang Rui  <rui.zhang@intel.com>

---
 drivers/acpi/scan.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c
+++ linux-2.6/drivers/acpi/scan.c
@@ -712,6 +712,9 @@ static int acpi_bus_get_wakeup_device_fl
 	kfree(buffer.pointer);
 
 	device->wakeup.flags.valid = 1;
+#ifdef CONFIG_ACPI_POWER
+	acpi_disable_wakeup_device_power(device);
+#endif
 	/* Power button, Lid switch always enable wakeup */
 	if (!acpi_match_device_ids(device, button_device_ids))
 		device->wakeup.flags.run_wake = 1;


