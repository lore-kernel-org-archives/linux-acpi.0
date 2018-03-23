From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.4 12/97] ACPI/processor: Fix error handling in __acpi_processor_start()
Date: Fri, 23 Mar 2018 10:53:59 +0100
Message-ID: <20180323094158.171665105@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Sebastian Siewior <bigeasy@linutronix.de>, Lai Jiangshan <jiangshanlai@gmail.com>, linux-acpi@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, Tejun Heo <tj@kernel.org>, "David S. Miller" <davem@davemloft.net>, Len Brown <lenb@kernel.org>, Sasha Levin <alexander.levin@microsoft.com>
List-Id: linux-acpi@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>


[ Upstream commit a5cbdf693a60d5b86d4d21dfedd90f17754eb273 ]

When acpi_install_notify_handler() fails the cooling device stays
registered and the sysfs files created via acpi_pss_perf_init() are
leaked and the function returns success.

Undo acpi_pss_perf_init() and return a proper error code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sebastian Siewior <bigeasy@linutronix.de>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-acpi@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Tejun Heo <tj@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Len Brown <lenb@kernel.org>
Link: http://lkml.kernel.org/r/20170412201042.695499645@linutronix.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/processor_driver.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -259,6 +259,9 @@ static int __acpi_processor_start(struct
 	if (ACPI_SUCCESS(status))
 		return 0;
 
+	result = -ENODEV;
+	acpi_pss_perf_exit(pr, device);
+
 err_power_exit:
 	acpi_processor_power_exit(pr);
 	return result;
