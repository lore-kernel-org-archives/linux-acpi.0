From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] X86 acpi_cpufreq: Do not use request_module for autoloading
Date: Fri, 11 May 2012 17:52:24 +0200
Message-ID: <201205111752.24508.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: cpufreq@vger.kernel.org, tittiatcoke@gmail.com, mjg59@srcf.ucam.org, andi@firstfloor.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

X86 acpi_cpufreq: Do not use request_module for autoloading

The idea to check for needed cpufreq functions in ACPI processor object is
a good (perfect) one, but using request_module in processor.ko
has bad side-effects:
It opens a hidden dependency: acpi-cpufreq.ko must be accessable when
processor.ko is loaded (which is not the case if the latter gets loaded
in initrd where the other one might not be present).
Also I guess calling modprobe userspace from inside the kernel
(comments indicate that is what happens), is considered an ugly workaround
if nothing else works.

Therefore try to load acpi-cpufreq on all CPUs with EST (Enhanced Speed Step)
cpu feature flag.
This may result in trying to load acpi-cpufreq on some machines which do
not have cpufreq ACPI functions (which should be a BIOS bug then), but this
does not hurt. acpi-cpufreq should always be the preferred cpufreq driver
for EST capable CPUs.
I am not 100% sure about VIA machines also exposing ACPI cpufreq functions.
I could imagine they also have this CPU id feature set and everything is fine.
In fact I have such a CPU at home, but trying it out is time intensive.
As autoloading is a new feature, there cannot be regressions and if a non
Intel CPU shows up that needs this driver as well, it can easily be added by
another matching X86 model/family/feature line.

References: https://bugzilla.novell.com/show_bug.cgi?id=756085

Signed-off-by: Thomas Renninger <trenn@suse.de>
Tested-by: tittiatcoke@gmail.com

---
 drivers/acpi/processor_driver.c  |    1 -
 drivers/acpi/processor_perflib.c |   22 ----------------------
 drivers/cpufreq/acpi-cpufreq.c   |    7 +++++++
 include/acpi/processor.h         |    1 -
 4 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 0734086..9863bc2 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -474,7 +474,6 @@ static __ref int acpi_processor_start(struct acpi_processor *pr)
 
 #ifdef CONFIG_CPU_FREQ
 	acpi_processor_ppc_has_changed(pr, 0);
-	acpi_processor_load_module(pr);
 #endif
 	acpi_processor_get_throttling_info(pr);
 	acpi_processor_get_limit_in.git/patches/acpi_cpufreq_autoload/x86_acpi_cpufreq_autoload.patchfo(pr);
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 0af48a8..85b3237 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -240,28 +240,6 @@ void acpi_processor_ppc_exit(void)
 	acpi_processor_ppc_status &= ~PPC_REGISTERED;
 }
 
-/*
- * Do a quick check if the systems looks like it should use ACPI
- * cpufreq. We look at a _PCT method being available, but don't
- * do a whole lot of sanity checks.
- */
-void acpi_processor_load_module(struct acpi_processor *pr)
-{
-	static int requested;
-	acpi_status status = 0;
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-
-	if (!arch_has_acpi_pdc() || requested)
-		return;
-	status = acpi_evaluate_object(pr->handle, "_PCT", NULL, &buffer);
-	if (!ACPI_FAILURE(status)) {
-		printk(KERN_INFO PREFIX "Requesting acpi_cpufreq\n");
-		request_module_nowait("acpi_cpufreq");
-		requested = 1;
-	}
-	kfree(buffer.pointer);
-}
-
 static int acpi_processor_get_performance_control(struct acpi_processor *pr)
 {
 	int result = 0;
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 56c6c6b..c7b8174 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -66,6 +66,13 @@ struct acpi_cpufreq_data {
 	unsigned int cpu_feature;
 };
 
+static const struct x86_cpu_id acpi_cpufreq_ids[] = {
+	/* Enhanced Speed Step */
+	X86_FEATURE_MATCH(X86_FEATURE_EST),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, acpi_cpufreq_ids);
+
 static DEFINE_PER_CPU(struct acpi_cpufreq_data *, acfreq_data);
 
 /* acpi_perf_data is a pointer to percpu data. */
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 9d65047..8cf7e98 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -225,7 +225,6 @@ struct acpi_processor_errata {
 	} piix4;
 };
 
-extern void acpi_processor_load_module(struct acpi_processor *pr);
 extern int acpi_processor_preregister_performance(struct
 						  acpi_processor_performance
 						  __percpu *performance);
