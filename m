From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 07/13] ACPI/processor: Fix error handling in
 __acpi_processor_start()
Date: Wed, 12 Apr 2017 22:07:33 +0200
Message-ID: <20170412201042.695499645@linutronix.de>
References: <20170412200726.941336635@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:35446 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755575AbdDLUUr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Apr 2017 16:20:47 -0400
Content-Disposition: inline;
 filename=ACPI-processor--Fix-error-handling-in-__acpi_processor_start--.patch
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Sebastian Siewior <bigeasy@linutronix.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David S. Miller" <davem@davemloft.net>, Fenghua Yu <fenghua.yu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, Lai Jiangshan <jiangshanlai@gmail.com>, Len Brown <lenb@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tejun Heo <tj@kernel.org>, Tony Luck <tony.luck@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-acpi@vger.kernel.org

When acpi_install_notify_handler() fails the cooling device stays
registered and the sysfs files created via acpi_pss_perf_init() are
leaked and the function returns success.

Undo acpi_pss_perf_init() and return a proper error code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/processor_driver.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -251,6 +251,9 @@ static int __acpi_processor_start(struct
 	if (ACPI_SUCCESS(status))
 		return 0;
 
+	result = -ENODEV;
+	acpi_pss_perf_exit(pr, device);
+
 err_power_exit:
 	acpi_processor_power_exit(pr);
 	return result;


