From: Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH] ACPI: processor: use dev_dbg() instead of dev_warn() when CPPC probe failed
Date: Wed, 26 Jul 2017 18:40:12 +0800
Message-ID: <1501065612-45769-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([45.249.212.187]:10277 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbdGZKrU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Jul 2017 06:47:20 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Alexey Klimov <alexey.klimov@arm.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Hanjun Guo <hanjun.guo@linaro.org>

_CPC is a optinal object for processor device so it's
fine for processor devices in DSDT without CPPC data,
but when booting the system with CPPC enabled in the
kernel but without its support in the firmware, I got
lots of warnings on a 64 core system:

[    6.346016] acpi ACPI0007:00: CPPC data invalid or not present
[    6.346028] acpi ACPI0007:01: CPPC data invalid or not present
[    6.346039] acpi ACPI0007:02: CPPC data invalid or not present
[    6.346050] acpi ACPI0007:03: CPPC data invalid or not present
[    6.346063] acpi ACPI0007:04: CPPC data invalid or not present
...
[    6.346737] acpi ACPI0007:3f: CPPC data invalid or not present

This isn't much useful and a little bit noise, so
switch the dev_warn() to dev_dbg().

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Alexey Klimov <alexey.klimov@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/processor_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 591d1dd..9d6aff2 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -237,7 +237,7 @@ static int __acpi_processor_start(struct acpi_device *device)
 
 	result = acpi_cppc_processor_probe(pr);
 	if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
-		dev_warn(&device->dev, "CPPC data invalid or not present\n");
+		dev_dbg(&device->dev, "CPPC data invalid or not present\n");
 
 	if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
 		acpi_processor_power_init(pr);
-- 
1.7.12.4

