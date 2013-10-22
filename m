From: <brandon.anderson@amd.com>
Subject: [RFC PATCH 3/3] ACPI: Hack clock names to get prototype running
Date: Mon, 21 Oct 2013 19:33:49 -0500
Message-ID: <1382402029-13381-4-git-send-email-brandon.anderson@amd.com>
References: <1382402029-13381-1-git-send-email-brandon.anderson@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-db8lp0187.outbound.messaging.microsoft.com ([213.199.154.187]:12159
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752238Ab3JVAe7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Oct 2013 20:34:59 -0400
In-Reply-To: <1382402029-13381-1-git-send-email-brandon.anderson@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, rjw@sisk.pl, naresh.bhat@linaro.org, hanjun.guo@linaro.org, graeme.gregory@linaro.org, Suravee.Suthikulpanit@amd.com, Brandon Anderson <brandon.anderson@amd.com>

From: Brandon Anderson <brandon.anderson@amd.com>

!!! For prototyping use only, not intended for final implementation !!!

Manually label the first fixed-clock as 'apb_pclk', and then manually register this clock with each device being registered. The amba subsystem and drivers require this clock when probing the device. This code will not be required once ACPI clock info is integrated into drivers/amba/acpi.c


Signed-off-by: Brandon Anderson <brandon.anderson@amd.com>
---
 drivers/amba/acpi.c          |   14 ++++++++++++--
 drivers/clk/clk-fixed-rate.c |   15 +++++++++++++--
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/amba/acpi.c b/drivers/amba/acpi.c
index 04efcbd..822000e 100644
--- a/drivers/amba/acpi.c
+++ b/drivers/amba/acpi.c
@@ -52,8 +52,18 @@ static int acpi_amba_add_resource(struct acpi_resource *ares, void *data)
 
 static void acpi_amba_register_clk(struct acpi_device *adev) 
 {
-	/* TODO: Retrieve clock details from ACPI and register the appropriate
-	   clock under this device for amba subsystem and drivers to reference */
+	/* HACK: re-register the first clock under this device so that other
+	   subsystems will find it */
+	struct clk *clk = clk_get_sys("LINA0008:00", "apb_pclk");
+
+	if (!IS_ERR(clk)) {
+		/* for amba_get_enable_pclk() */
+		clk_register_clkdev(clk, "apb_pclk", dev_name(&adev->dev));
+		/* for pl011 driver call to devm_get_clk() */
+		clk_register_clkdev(clk, NULL, dev_name(&adev->dev));
+	} else {
+		pr_debug("%s: cannot look up clock\n", __func__);
+	}
 }
 
 /* acpi_amba_add_device()
diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
index 226cefb..015002a 100644
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -111,6 +111,8 @@ static int fixed_clk_probe_acpi(struct platform_device *pdev) {
 	struct clk *clk = ERR_PTR(-ENODEV);
 	unsigned long long rate = 0;
 	acpi_status status;
+	static int clk_idx = 0;
+	char *dt_clk_name = NULL;
 
 	/* there is a corresponding FREQ method under fixed clock object */
 	status = acpi_evaluate_integer(ACPI_HANDLE(&pdev->dev), "FREQ",
@@ -123,11 +125,20 @@ static int fixed_clk_probe_acpi(struct platform_device *pdev) {
 	if (IS_ERR(clk))
 		return -ENODEV;
 
+	/* HACK: label the first clock as 'apb_pclk' */
+	if (clk_idx++ == 0) {
+		dt_clk_name = "apb_pclk";
+	}
+
+	pr_debug("%s: register '%s' as '%s'\n", __FUNCTION__, dev_name(&pdev->dev),
+			dt_clk_name == NULL ? "<unknown>" : dt_clk_name);
+
 	/*
 	 * if we don't register the clk here, we can't get the clk
 	 * for AMBA bus when CONFIG_OF=n
 	 */
-	return clk_register_clkdev(clk, NULL, dev_name(&pdev->dev)); }
+	return clk_register_clkdev(clk, dt_clk_name, dev_name(&pdev->dev));
+}
 #else 
 static inline int fixed_clk_probe_acpi(struct platform_device *pdev) {
 	return -ENODEV;
@@ -174,5 +185,5 @@ static int __init fixed_clk_init(void)
  * fixed clock will used for AMBA bus, UART and etc, so it should be
  * initialized early enough.
  */
-subsys_initcall(fixed_clk_init);
+postcore_initcall(fixed_clk_init);
 #endif
-- 
1.7.9.5


