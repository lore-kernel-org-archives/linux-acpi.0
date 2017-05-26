From: David Arcari <darcari@redhat.com>
Subject: [PATCH] cpufreq: cpufreq_register_driver should return -ENODEV if init fails
Date: Fri, 26 May 2017 11:37:31 -0400
Message-ID: <1495813051-146077-1-git-send-email-darcari@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S943745AbdEZPhm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 26 May 2017 11:37:42 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: David Arcari <darcari@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>

For a driver that does not set the CPUFREQ_STICKY flag, if all of the
->init() calls fail, cpufreq_register_driver() should return an error.
This will prevent the driver from loading.

Fixes: ce1bcfe94db8 ("cpufreq: check cpufreq_policy_list instead of scanning policies for all CPUs")

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: David Arcari <darcari@redhat.com>
---
 drivers/cpufreq/cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0e3f649..26b643d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2468,6 +2468,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 	if (!(cpufreq_driver->flags & CPUFREQ_STICKY) &&
 	    list_empty(&cpufreq_policy_list)) {
 		/* if all ->init() calls failed, unregister */
+		ret = -ENODEV;
 		pr_debug("%s: No CPU initialized for driver %s\n", __func__,
 			 driver_data->name);
 		goto err_if_unreg;
-- 
1.8.3.1

