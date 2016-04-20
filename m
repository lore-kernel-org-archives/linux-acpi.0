From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH] ACPI / APD: Remove CLK_IS_ROOT
Date: Tue, 19 Apr 2016 18:27:46 -0700
Message-ID: <1461115666-30906-1-git-send-email-sboyd@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:32895 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754123AbcDTB1t (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Apr 2016 21:27:49 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Ken Xue <Ken.Xue@amd.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

This flag is a no-op now (see commit 47b0eeb3dc8a "clk: Deprecate
CLK_IS_ROOT", 2016-02-02) so remove it.

Cc: Ken Xue <Ken.Xue@amd.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/acpi/acpi_apd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index f245bf35bedb..1daf9c46df8e 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -62,8 +62,7 @@ static int acpi_apd_setup(struct apd_private_data *pdata)
 	if (dev_desc->fixed_clk_rate) {
 		clk = clk_register_fixed_rate(&pdata->adev->dev,
 					dev_name(&pdata->adev->dev),
-					NULL, CLK_IS_ROOT,
-					dev_desc->fixed_clk_rate);
+					NULL, 0, dev_desc->fixed_clk_rate);
 		clk_register_clkdev(clk, NULL, dev_name(&pdata->adev->dev));
 		pdata->clk = clk;
 	}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

