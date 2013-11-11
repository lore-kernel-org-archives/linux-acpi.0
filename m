From: Brandon Anderson <brandon.anderson@amd.com>
Subject: [PATCH 1/4] ACPI/ARM: Load fixed-clk module early
Date: Mon, 11 Nov 2013 11:16:07 -0600
Message-ID: <1384190170-8707-2-git-send-email-brandon.anderson@amd.com>
References: <1384190170-8707-1-git-send-email-brandon.anderson@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-db9lp0249.outbound.messaging.microsoft.com ([213.199.154.249]:12311
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754516Ab3KKRRM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Nov 2013 12:17:12 -0500
In-Reply-To: <1384190170-8707-1-git-send-email-brandon.anderson@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ssg.sos.patches@amd.com, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org
Cc: Brandon Anderson <brandon.anderson@amd.com>

An AMBA device will be probed once two things have occured: 1) ACPI has
registered a device, and 2) the driver has registered itself as an AMBA
driver. Since several drivers register themselves very early on, the
probe will happen as soon as ACPI registers the device. If a device
depends on a clock, the clock must be probed before ACPI registers the
device. This means that the clock definition must be encountered first in the
DSDT file, and the clock driver must already be loaded when this happens.

There are other potential solutions, with this solution registering the clock
driver very early in the boot process to avoid changes to other drivers.


Signed-off-by: Brandon Anderson <brandon.anderson@amd.com>
---
 drivers/clk/clk-fixed-rate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
index 226cefb..778291e 100644
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -174,5 +174,5 @@ static int __init fixed_clk_init(void)
  * fixed clock will used for AMBA bus, UART and etc, so it should be
  * initialized early enough.
  */
-subsys_initcall(fixed_clk_init);
+postcore_initcall(fixed_clk_init);
 #endif
-- 
1.7.9.5


