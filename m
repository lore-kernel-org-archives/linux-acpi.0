From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 1/1] thermal: cpu cooling: allow module builds
Date: Wed, 14 Nov 2012 11:23:30 -0400
Message-ID: <1352906610-549-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49377 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161133Ab2KNPYB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Nov 2012 10:24:01 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: amit.kachhap@linaro.org
Cc: rui.zhang@intel.com, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, eballetbo@gmail.com, Eduardo Valentin <eduardo.valentin@ti.com>

As thermal drivers can be built as modules and also
the thermal framework itself, building cpu cooling
only as built-in can cause linking errors. For instance:
* Generic Thermal sysfs driver
*
Generic Thermal sysfs driver (THERMAL) [M/n/y/?] m
  generic cpu cooling support (CPU_THERMAL) [N/y/?] (NEW) y

with the following drive:
CONFIG_OMAP_BANDGAP=m

generates:
ERROR: "cpufreq_cooling_unregister" [drivers/staging/omap-thermal/omap-thermal.ko] undefined!
ERROR: "cpufreq_cooling_register" [drivers/staging/omap-thermal/omap-thermal.ko] undefined!

This patch changes cpu cooling driver to allow it
to be built as module.

Reported-by: Enric Balletbo i Serra <eballetbo@gmail.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/thermal/Kconfig     |    2 +-
 include/linux/cpu_cooling.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index e1cb6bd..3b03c8b 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -20,7 +20,7 @@ config THERMAL_HWMON
 	default y
 
 config CPU_THERMAL
-	bool "generic cpu cooling support"
+	tristate "generic cpu cooling support"
 	depends on THERMAL && CPU_FREQ
 	select CPU_FREQ_TABLE
 	help
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index b30cc79c..40b4ef5 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -29,7 +29,7 @@
 #define CPUFREQ_COOLING_START		0
 #define CPUFREQ_COOLING_STOP		1
 
-#ifdef CONFIG_CPU_THERMAL
+#if defined(CONFIG_CPU_THERMAL) || defined(CONFIG_CPU_THERMAL_MODULE)
 /**
  * cpufreq_cooling_register - function to create cpufreq cooling device.
  * @clip_cpus: cpumask of cpus where the frequency constraints will happen
-- 
1.7.7.1.488.ge8e1c

