From: Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 2/2] arch_timer: acpi: add hisi timer erratum data
Date: Tue, 24 Jan 2017 18:39:51 +0800
Message-ID: <1485254391-51551-3-git-send-email-guohanjun@huawei.com>
References: <1485254391-51551-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:28109 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbdAXKor (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jan 2017 05:44:47 -0500
In-Reply-To: <1485254391-51551-1-git-send-email-guohanjun@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Fu Wei <fu.wei@linaro.org>, Ding Tianhong <dingtianhong@huawei.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, Hanjun Guo <hanjun.guo@linaro.org>

From: Hanjun Guo <hanjun.guo@linaro.org>

Add hisilicon timer specific erratum fixes.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 80d6f76..3e62a09 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1156,10 +1156,32 @@ struct gtdt_arch_timer_fixup {
 	void *context;
 };
 
+#ifdef CONFIG_HISILICON_ERRATUM_161010101
+static void __init hisi_erratum_workaroud_enable(void *context)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ool_workarounds); i++) {
+		if (!strcmp(context, ool_workarounds[i].id)) {
+			timer_unstable_counter_workaround = &ool_workarounds[i];
+			static_branch_enable(&arch_timer_read_ool_enabled);
+			pr_info("arch_timer: Enabling workaround for %s\n",
+				timer_unstable_counter_workaround->id);
+			break;
+		}
+	}
+}
+#endif
+
 /* note: this needs to be updated according to the doc of OEM ID
  * and TABLE ID for different board.
  */
 static struct gtdt_arch_timer_fixup arch_timer_quirks[] __initdata = {
+#ifdef CONFIG_HISILICON_ERRATUM_161010101
+	{"HISI  ", "HIP05   ", 0, &hisi_erratum_workaroud_enable, "hisilicon,erratum-161010101"},
+	{"HISI  ", "HIP06   ", 0, &hisi_erratum_workaroud_enable, "hisilicon,erratum-161010101"},
+	{"HISI  ", "HIP07   ", 0, &hisi_erratum_workaroud_enable, "hisilicon,erratum-161010101"},
+#endif
 };
 
 static void __init arch_timer_acpi_quirks_handler(char *oem_id,
-- 
1.7.12.4

