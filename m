From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 08/13] ACPI/processor: Replace racy task affinity logic.
Date: Wed, 12 Apr 2017 22:07:34 +0200
Message-ID: <20170412201042.785920903@linutronix.de>
References: <20170412200726.941336635@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:35448 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755623AbdDLUUw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Apr 2017 16:20:52 -0400
Content-Disposition: inline; filename=ACPI-processor--Use-work_on_cpu--.patch
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Sebastian Siewior <bigeasy@linutronix.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David S. Miller" <davem@davemloft.net>, Fenghua Yu <fenghua.yu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, Lai Jiangshan <jiangshanlai@gmail.com>, Len Brown <lenb@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tejun Heo <tj@kernel.org>, Tony Luck <tony.luck@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-acpi@vger.kernel.org

acpi_processor_get_throttling() requires to invoke the getter function on
the target CPU. This is achieved by temporarily setting the affinity of the
calling user space thread to the requested CPU and reset it to the original
affinity afterwards.

That's racy vs. CPU hotplug and concurrent affinity settings for that
thread resulting in code executing on the wrong CPU and overwriting the
new affinity setting.

acpi_processor_get_throttling() is invoked in two ways:

1) The CPU online callback, which is already running on the target CPU and
   obviously protected against hotplug and not affected by affinity
   settings.

2) The ACPI driver probe function, which is not protected against hotplug
   during modprobe.

Switch it over to work_on_cpu() and protect the probe function against CPU
hotplug.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/processor_driver.c     |    7 ++++++-
 drivers/acpi/processor_throttling.c |   31 +++++++++++++------------------
 2 files changed, 19 insertions(+), 19 deletions(-)

--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -262,11 +262,16 @@ static int __acpi_processor_start(struct
 static int acpi_processor_start(struct device *dev)
 {
 	struct acpi_device *device = ACPI_COMPANION(dev);
+	int ret;
 
 	if (!device)
 		return -ENODEV;
 
-	return __acpi_processor_start(device);
+	/* Protect against concurrent CPU hotplug operations */
+	get_online_cpus();
+	ret = __acpi_processor_start(device);
+	put_online_cpus();
+	return ret;
 }
 
 static int acpi_processor_stop(struct device *dev)
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -901,36 +901,31 @@ static int acpi_processor_get_throttling
 	return 0;
 }
 
-static int acpi_processor_get_throttling(struct acpi_processor *pr)
+static long __acpi_processor_get_throttling(void *data)
 {
-	cpumask_var_t saved_mask;
-	int ret;
+	struct acpi_processor *pr = data;
+
+	return pr->throttling.acpi_processor_get_throttling(pr);
+}
 
+static int acpi_processor_get_throttling(struct acpi_processor *pr)
+{
 	if (!pr)
 		return -EINVAL;
 
 	if (!pr->flags.throttling)
 		return -ENODEV;
 
-	if (!alloc_cpumask_var(&saved_mask, GFP_KERNEL))
-		return -ENOMEM;
-
 	/*
-	 * Migrate task to the cpu pointed by pr.
+	 * This is either called from the CPU hotplug callback of
+	 * processor_driver or via the ACPI probe function. In the latter
+	 * case the CPU is not guaranteed to be online. Both call sites are
+	 * protected against CPU hotplug.
 	 */
-	cpumask_copy(saved_mask, &current->cpus_allowed);
-	/* FIXME: use work_on_cpu() */
-	if (set_cpus_allowed_ptr(current, cpumask_of(pr->id))) {
-		/* Can't migrate to the target pr->id CPU. Exit */
-		free_cpumask_var(saved_mask);
+	if (!cpu_online(pr->id))
 		return -ENODEV;
-	}
-	ret = pr->throttling.acpi_processor_get_throttling(pr);
-	/* restore the previous state */
-	set_cpus_allowed_ptr(current, saved_mask);
-	free_cpumask_var(saved_mask);
 
-	return ret;
+	return work_on_cpu(pr->id, __acpi_processor_get_throttling, pr);
 }
 
 static int acpi_processor_get_fadt_info(struct acpi_processor *pr)


