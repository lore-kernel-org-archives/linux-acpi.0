From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] cpuidle / ACPI: fix potential NULL pointer dereference
Date: Mon, 8 Oct 2012 08:40:42 +0800
Message-ID: <CAPgLHd-8SzCJHbi8sknFvBe11taoXS5z3MOkM=Jet-VD5z14tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:64157 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870Ab2JHAkn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Oct 2012 20:40:43 -0400
Received: by mail-qc0-f174.google.com with SMTP id d3so2471568qch.19
        for <linux-acpi@vger.kernel.org>; Sun, 07 Oct 2012 17:40:43 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: yongjun_wei@trendmicro.com.cn, linux-acpi@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

The dereference should be moved below the NULL test.

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/acpi/processor_idle.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 3655ab9..e8086c7 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1132,7 +1132,7 @@ static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
 int acpi_processor_hotplug(struct acpi_processor *pr)
 {
 	int ret = 0;
-	struct cpuidle_device *dev = per_cpu(acpi_cpuidle_device, pr->id);
+	struct cpuidle_device *dev;
 
 	if (disabled_by_idle_boot_param())
 		return 0;
@@ -1147,6 +1147,7 @@ int acpi_processor_hotplug(struct acpi_processor *pr)
 	if (!pr->flags.power_setup_done)
 		return -ENODEV;
 
+	dev = per_cpu(acpi_cpuidle_device, pr->id);
 	cpuidle_pause_and_lock();
 	cpuidle_disable_device(dev);
 	acpi_processor_get_power_info(pr);

