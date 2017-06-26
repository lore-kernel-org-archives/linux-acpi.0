From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/2] ACPI / LPSS: Remove lpss_iosf_enter_d3_state()
Date: Mon, 26 Jun 2017 23:57:00 +0200
Message-ID: <20170626215700.14445-2-hdegoede@redhat.com>
References: <20170626215700.14445-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751439AbdFZV5E (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Jun 2017 17:57:04 -0400
In-Reply-To: <20170626215700.14445-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org

If lpss_iosf_enter_d3_state() hits the code path where it actually
puts the DMA controllers into D3, then, at least on Bay Trail, the LPSS
PWM controller will stop working / gets stuck. After this happening the
PWM controller's control reg will always reads 0x00010000 and writes
seem to be ignored.

Note that the chances of this code-path actually being hit are actually
very low. On Bay Trail devices with an AXP288 PMIC and on any Cherry Trail
device, the I2C controller connected to the PMIC has (runtime) suspend
disabled, so the condition of all LPSS and SCC devices being in D3 will
never happen.

Even on Bay Trail devices with another PMIC testing has shown that
lpss_iosf_enter_d3_state() will only put the DMA controllers in D3 during
early boot when not all devices have been initialized yet, which is enough
to get the PWM controller stuck, while not resulting in any significant
power saving as this only happens during boot.

So in practice lpss_iosf_enter_d3_state() is almost always a no-op and
when it is not, it is causing problems. Therefor this commit simply
removes it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_lpss.c | 61 +-----------------------------------------------
 1 file changed, 1 insertion(+), 60 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 51feee309b13..8ea8c0988381 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -762,51 +762,6 @@ static int acpi_lpss_resume_early(struct device *dev)
 
 static DEFINE_MUTEX(lpss_iosf_mutex);
 
-static void lpss_iosf_enter_d3_state(void)
-{
-	u32 value1 = 0;
-	u32 mask1 = LPSS_GPIODEF0_DMA_D3_MASK | LPSS_GPIODEF0_DMA_LLP;
-	u32 value2 = LPSS_PMCSR_D3hot;
-	u32 mask2 = LPSS_PMCSR_Dx_MASK;
-	/*
-	 * PMC provides an information about actual status of the LPSS devices.
-	 * Here we read the values related to LPSS power island, i.e. LPSS
-	 * devices, excluding both LPSS DMA controllers, along with SCC domain.
-	 */
-	u32 func_dis, d3_sts_0, pmc_status, pmc_mask = 0xfe000ffe;
-	int ret;
-
-	ret = pmc_atom_read(PMC_FUNC_DIS, &func_dis);
-	if (ret)
-		return;
-
-	mutex_lock(&lpss_iosf_mutex);
-
-	ret = pmc_atom_read(PMC_D3_STS_0, &d3_sts_0);
-	if (ret)
-		goto exit;
-
-	/*
-	 * Get the status of entire LPSS power island per device basis.
-	 * Shutdown both LPSS DMA controllers if and only if all other devices
-	 * are already in D3hot.
-	 */
-	pmc_status = (~(d3_sts_0 | func_dis)) & pmc_mask;
-	if (pmc_status)
-		goto exit;
-
-	iosf_mbi_modify(LPSS_IOSF_UNIT_LPIO1, MBI_CFG_WRITE,
-			LPSS_IOSF_PMCSR, value2, mask2);
-
-	iosf_mbi_modify(LPSS_IOSF_UNIT_LPIO2, MBI_CFG_WRITE,
-			LPSS_IOSF_PMCSR, value2, mask2);
-
-	iosf_mbi_modify(LPSS_IOSF_UNIT_LPIOEP, MBI_CR_WRITE,
-			LPSS_IOSF_GPIODEF0, value1, mask1);
-exit:
-	mutex_unlock(&lpss_iosf_mutex);
-}
-
 static void lpss_iosf_exit_d3_state(void)
 {
 	u32 value1 = LPSS_GPIODEF0_DMA1_D3 | LPSS_GPIODEF0_DMA2_D3 |
@@ -841,17 +796,7 @@ static int acpi_lpss_runtime_suspend(struct device *dev)
 	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
 		acpi_lpss_save_ctx(dev, pdata);
 
-	ret = acpi_dev_runtime_suspend(dev);
-
-	/*
-	 * This call must be last in the sequence, otherwise PMC will return
-	 * wrong status for devices being about to be powered off. See
-	 * lpss_iosf_enter_d3_state() for further information.
-	 */
-	if (lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
-		lpss_iosf_enter_d3_state();
-
-	return ret;
+	return acpi_dev_runtime_suspend(dev);
 }
 
 static int acpi_lpss_runtime_resume(struct device *dev)
@@ -859,10 +804,6 @@ static int acpi_lpss_runtime_resume(struct device *dev)
 	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
 	int ret;
 
-	/*
-	 * This call is kept first to be in symmetry with
-	 * acpi_lpss_runtime_suspend() one.
-	 */
 	if (lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
 		lpss_iosf_exit_d3_state();
 
-- 
2.13.0

