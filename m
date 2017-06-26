From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/2] ACPI / LPSS: Call lpss_iosf_exit_d3_state on device activate
Date: Mon, 26 Jun 2017 23:56:59 +0200
Message-ID: <20170626215700.14445-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43668 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751439AbdFZV5D (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Jun 2017 17:57:03 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org

The purpose of lpss_iosf_exit_d3_state is to ensure that the LPSS DMA
controllers are in D0 and will not automatically power-down.

Since we do not know what the state is when activating a device, we
should call lpss_iosf_exit_d3_state on activate too.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_lpss.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 43f376aa7adc..51feee309b13 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -97,6 +97,8 @@ struct lpss_private_data {
 	u32 prv_reg_ctx[LPSS_PRV_REG_COUNT];
 };
 
+static void lpss_iosf_exit_d3_state(void);
+
 /* LPSS run time quirks */
 static unsigned int lpss_quirks;
 
@@ -682,6 +684,9 @@ static int acpi_lpss_activate(struct device *dev)
 	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
 	int ret;
 
+	if (lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
+		lpss_iosf_exit_d3_state();
+
 	ret = acpi_dev_runtime_resume(dev);
 	if (ret)
 		return ret;
-- 
2.13.0

