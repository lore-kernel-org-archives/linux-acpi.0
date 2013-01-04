From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 6/6] ACPI / PM: Consolidate suspend-specific and hibernate-specific code
Date: Fri, 04 Jan 2013 23:04:23 +0100
Message-ID: <22254228.kgHDl5ggU0@vostro.rjw.lan>
References: <2311196.icSMDvAsYg@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2311196.icSMDvAsYg@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Huang Ying <ying.huang@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move some suspend-specific and hibernate-specific code from
acpi_sleep_init() into separate functions to get rid of explicit
#ifdefs in acpi_sleep_init().  Use pr_info() to start and pr_cont()
to continue printing the supported ACPI sleep states line.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/sleep.c |   87 +++++++++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 36 deletions(-)

Index: linux/drivers/acpi/sleep.c
===================================================================
--- linux.orig/drivers/acpi/sleep.c
+++ linux/drivers/acpi/sleep.c
@@ -579,7 +579,28 @@ static const struct platform_suspend_ops
 	.end = acpi_pm_end,
 	.recover = acpi_pm_finish,
 };
-#endif /* CONFIG_SUSPEND */
+
+static void acpi_sleep_suspend_setup(void)
+{
+	int i;
+
+	for (i = ACPI_STATE_S1; i < ACPI_STATE_S4; i++) {
+		acpi_status status;
+		u8 type_a, type_b;
+
+		status = acpi_get_sleep_type_data(i, &type_a, &type_b);
+		if (ACPI_SUCCESS(status)) {
+			sleep_states[i] = 1;
+			pr_cont(" S%d", i);
+		}
+	}
+
+	suspend_set_ops(old_suspend_ordering ?
+		&acpi_suspend_ops_old : &acpi_suspend_ops);
+}
+#else /* !CONFIG_SUSPEND */
+static inline void acpi_sleep_suspend_setup(void) {}
+#endif /* !CONFIG_SUSPEND */
 
 #ifdef CONFIG_HIBERNATION
 static unsigned long s4_hardware_signature;
@@ -700,7 +721,30 @@ static const struct platform_hibernation
 	.restore_cleanup = acpi_pm_thaw,
 	.recover = acpi_pm_finish,
 };
-#endif /* CONFIG_HIBERNATION */
+
+static void acpi_sleep_hibernate_setup(void)
+{
+	acpi_status status;
+	u8 type_a, type_b;
+
+	status = acpi_get_sleep_type_data(ACPI_STATE_S4, &type_a, &type_b);
+	if (ACPI_FAILURE(status))
+		return;
+
+	hibernation_set_ops(old_suspend_ordering ?
+			&acpi_hibernation_ops_old : &acpi_hibernation_ops);
+	sleep_states[ACPI_STATE_S4] = 1;
+	pr_cont(KERN_CONT " S4");
+	if (nosigcheck)
+		return;
+
+	acpi_get_table(ACPI_SIG_FACS, 1, (struct acpi_table_header **)&facs);
+	if (facs)
+		s4_hardware_signature = facs->hardware_signature;
+}
+#else /* !CONFIG_HIBERNATION */
+static inline void acpi_sleep_hibernate_setup(void) {}
+#endif /* !CONFIG_HIBERNATION */
 
 int acpi_suspend(u32 acpi_state)
 {
@@ -736,9 +780,6 @@ int __init acpi_sleep_init(void)
 {
 	acpi_status status;
 	u8 type_a, type_b;
-#ifdef CONFIG_SUSPEND
-	int i = 0;
-#endif
 
 	if (acpi_disabled)
 		return 0;
@@ -746,45 +787,19 @@ int __init acpi_sleep_init(void)
 	acpi_sleep_dmi_check();
 
 	sleep_states[ACPI_STATE_S0] = 1;
-	printk(KERN_INFO PREFIX "(supports S0");
-
-#ifdef CONFIG_SUSPEND
-	for (i = ACPI_STATE_S1; i < ACPI_STATE_S4; i++) {
-		status = acpi_get_sleep_type_data(i, &type_a, &type_b);
-		if (ACPI_SUCCESS(status)) {
-			sleep_states[i] = 1;
-			printk(KERN_CONT " S%d", i);
-		}
-	}
+	pr_info(PREFIX "(supports S0");
 
-	suspend_set_ops(old_suspend_ordering ?
-		&acpi_suspend_ops_old : &acpi_suspend_ops);
-#endif
+	acpi_sleep_suspend_setup();
+	acpi_sleep_hibernate_setup();
 
-#ifdef CONFIG_HIBERNATION
-	status = acpi_get_sleep_type_data(ACPI_STATE_S4, &type_a, &type_b);
-	if (ACPI_SUCCESS(status)) {
-		hibernation_set_ops(old_suspend_ordering ?
-			&acpi_hibernation_ops_old : &acpi_hibernation_ops);
-		sleep_states[ACPI_STATE_S4] = 1;
-		printk(KERN_CONT " S4");
-		if (!nosigcheck) {
-			acpi_get_table(ACPI_SIG_FACS, 1,
-				(struct acpi_table_header **)&facs);
-			if (facs)
-				s4_hardware_signature =
-					facs->hardware_signature;
-		}
-	}
-#endif
 	status = acpi_get_sleep_type_data(ACPI_STATE_S5, &type_a, &type_b);
 	if (ACPI_SUCCESS(status)) {
 		sleep_states[ACPI_STATE_S5] = 1;
-		printk(KERN_CONT " S5");
+		pr_cont(" S5");
 		pm_power_off_prepare = acpi_power_off_prepare;
 		pm_power_off = acpi_power_off;
 	}
-	printk(KERN_CONT ")\n");
+	pr_cont(")\n");
 	/*
 	 * Register the tts_notifier to reboot notifier list so that the _TTS
 	 * object can also be evaluated when the system enters S5.
