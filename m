From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 11/21] ACPI: processor: Convert to hotplug state machine
Date: Tue,  6 Sep 2016 19:04:47 +0200
Message-ID: <20160906170457.32393-12-bigeasy@linutronix.de>
References: <20160906170457.32393-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160906170457.32393-1-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, rt@linutronix.de, tglx@linutronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Install the callbacks via the state machine.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/acpi/processor_driver.c     | 89 +++++++++++++++++++--------------=
----
 drivers/acpi/processor_throttling.c |  4 +-
 include/acpi/processor.h            |  4 +-
 include/linux/cpuhotplug.h          |  1 +
 4 files changed, 51 insertions(+), 47 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_drive=
r.c
index 0553aeebb228..13e5ac415abf 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -110,55 +110,46 @@ static void acpi_processor_notify(acpi_handle handle,=
 u32 event, void *data)
=20
 static int __acpi_processor_start(struct acpi_device *device);
=20
-static int acpi_cpu_soft_notify(struct notifier_block *nfb,
-					  unsigned long action, void *hcpu)
+static int acpi_soft_cpu_online(unsigned int cpu)
 {
-	unsigned int cpu =3D (unsigned long)hcpu;
 	struct acpi_processor *pr =3D per_cpu(processors, cpu);
 	struct acpi_device *device;
-	action &=3D ~CPU_TASKS_FROZEN;
-
-	switch (action) {
-	case CPU_ONLINE:
-	case CPU_DEAD:
-		break;
-	default:
-		return NOTIFY_DONE;
-	}
=20
 	if (!pr || acpi_bus_get_device(pr->handle, &device))
-		return NOTIFY_DONE;
+		return 0;
+	/*
+	 * CPU got physically hotplugged and onlined for the first time:
+	 * Initialize missing things.
+	 */
+	if (pr->flags.need_hotplug_init) {
+		int ret;
=20
-	if (action =3D=3D CPU_ONLINE) {
-		/*
-		 * CPU got physically hotplugged and onlined for the first time:
-		 * Initialize missing things.
-		 */
-		if (pr->flags.need_hotplug_init) {
-			int ret;
-
-			pr_info("Will online and init hotplugged CPU: %d\n",
-				pr->id);
-			pr->flags.need_hotplug_init =3D 0;
-			ret =3D __acpi_processor_start(device);
-			WARN(ret, "Failed to start CPU: %d\n", pr->id);
-		} else {
-			/* Normal CPU soft online event. */
-			acpi_processor_ppc_has_changed(pr, 0);
-			acpi_processor_hotplug(pr);
-			acpi_processor_reevaluate_tstate(pr, action);
-			acpi_processor_tstate_has_changed(pr);
-		}
-	} else if (action =3D=3D CPU_DEAD) {
-		/* Invalidate flag.throttling after the CPU is offline. */
-		acpi_processor_reevaluate_tstate(pr, action);
+		pr_info("Will online and init hotplugged CPU: %d\n",
+			pr->id);
+		pr->flags.need_hotplug_init =3D 0;
+		ret =3D __acpi_processor_start(device);
+		WARN(ret, "Failed to start CPU: %d\n", pr->id);
+	} else {
+		/* Normal CPU soft online event. */
+		acpi_processor_ppc_has_changed(pr, 0);
+		acpi_processor_hotplug(pr);
+		acpi_processor_reevaluate_tstate(pr, false);
+		acpi_processor_tstate_has_changed(pr);
 	}
-	return NOTIFY_OK;
+	return 0;
 }
=20
-static struct notifier_block acpi_cpu_notifier =3D {
-	    .notifier_call =3D acpi_cpu_soft_notify,
-};
+static int acpi_soft_cpu_dead(unsigned int cpu)
+{
+	struct acpi_processor *pr =3D per_cpu(processors, cpu);
+	struct acpi_device *device;
+
+	if (!pr || acpi_bus_get_device(pr->handle, &device))
+		return 0;
+
+	acpi_processor_reevaluate_tstate(pr, true);
+	return 0;
+}
=20
 #ifdef CONFIG_ACPI_CPU_FREQ_PSS
 static int acpi_pss_perf_init(struct acpi_processor *pr,
@@ -303,7 +294,7 @@ static int acpi_processor_stop(struct device *dev)
  * This is needed for the powernow-k8 driver, that works even without
  * ACPI, but needs symbols from this driver
  */
-
+static enum cpuhp_state hp_online;
 static int __init acpi_processor_driver_init(void)
 {
 	int result =3D 0;
@@ -315,11 +306,22 @@ static int __init acpi_processor_driver_init(void)
 	if (result < 0)
 		return result;
=20
-	register_hotcpu_notifier(&acpi_cpu_notifier);
+	result =3D cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+					   "acpi/cpu-drv:online",
+					   acpi_soft_cpu_online, NULL);
+	if (result < 0)
+		goto err;
+	hp_online =3D result;
+	cpuhp_setup_state_nocalls(CPUHP_ACPI_CPUDRV_DEAD, "acpi/cpu-drv:dead",
+				  NULL, acpi_soft_cpu_dead);
+
 	acpi_thermal_cpufreq_init();
 	acpi_processor_ppc_init();
 	acpi_processor_throttling_init();
 	return 0;
+err:
+	driver_unregister(&acpi_processor_driver);
+	return result;
 }
=20
 static void __exit acpi_processor_driver_exit(void)
@@ -329,7 +331,8 @@ static void __exit acpi_processor_driver_exit(void)
=20
 	acpi_processor_ppc_exit();
 	acpi_thermal_cpufreq_exit();
-	unregister_hotcpu_notifier(&acpi_cpu_notifier);
+	cpuhp_remove_state_nocalls(hp_online);
+	cpuhp_remove_state_nocalls(CPUHP_ACPI_CPUDRV_DEAD);
 	driver_unregister(&acpi_processor_driver);
 }
=20
diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_t=
hrottling.c
index c72e64893d03..d51ca1c05619 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -375,11 +375,11 @@ int acpi_processor_tstate_has_changed(struct acpi_pro=
cessor *pr)
  *	3. TSD domain
  */
 void acpi_processor_reevaluate_tstate(struct acpi_processor *pr,
-					unsigned long action)
+					bool is_dead)
 {
 	int result =3D 0;
=20
-	if (action =3D=3D CPU_DEAD) {
+	if (is_dead) {
 		/* When one CPU is offline, the T-state throttling
 		 * will be invalidated.
 		 */
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index bfe6b2e10f3a..f3db11c24654 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -359,7 +359,7 @@ extern int acpi_processor_set_throttling(struct acpi_pr=
ocessor *pr,
  * onlined/offlined. In such case the flags.throttling will be updated.
  */
 extern void acpi_processor_reevaluate_tstate(struct acpi_processor *pr,
-			unsigned long action);
+			bool is_dead);
 extern const struct file_operations acpi_processor_throttling_fops;
 extern void acpi_processor_throttling_init(void);
 #else
@@ -380,7 +380,7 @@ static inline int acpi_processor_set_throttling(struct =
acpi_processor *pr,
 }
=20
 static inline void acpi_processor_reevaluate_tstate(struct acpi_processor =
*pr,
-			unsigned long action) {}
+			bool is_dead) {}
=20
 static inline void acpi_processor_throttling_init(void) {}
 #endif	/* CONFIG_ACPI_CPU_FREQ_PSS */
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 73a4daf08c04..0c33668d1626 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -25,6 +25,7 @@ enum cpuhp_state {
 	CPUHP_IRQ_POLL_DEAD,
 	CPUHP_BLOCK_SOFTIRQ_DEAD,
 	CPUHP_VIRT_SCSI_DEAD,
+	CPUHP_ACPI_CPUDRV_DEAD,
 	CPUHP_WORKQUEUE_PREP,
 	CPUHP_POWER_NUMA_PREPARE,
 	CPUHP_HRTIMERS_PREPARE,
--=20
2.9.3
