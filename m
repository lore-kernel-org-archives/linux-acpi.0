From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH] ACPI: Fix potential NULL pointer dereference in acpi_processor_add()
Date: Thu, 23 May 2013 20:44:26 +0800
Message-ID: <519E0F2A.4070602@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39008 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758245Ab3EWMo4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 May 2013 08:44:56 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so2861710pbb.19
        for <linux-acpi@vger.kernel.org>; Thu, 23 May 2013 05:44:55 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org

In acpi_processor_add(), get_cpu_device() will return NULL sometimes,
although the chances are small, I think it should be fixed.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/processor_driver.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index bec717f..dd64f23 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -579,6 +579,10 @@ static int __cpuinit acpi_processor_add(struct acpi_device
*device)
        per_cpu(processors, pr->id) = pr;

        dev = get_cpu_device(pr->id);
+       if (!dev) {
+               result = -ENODEV;
+               goto err_clear_processor;
+       }
        if (sysfs_create_link(&device->dev.kobj, &dev->kobj, "sysdev")) {
                result = -EFAULT;
                goto err_clear_processor;
-- 
1.7.1
