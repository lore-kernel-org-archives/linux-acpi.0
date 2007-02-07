From: Len Brown <lenb@kernel.org>
Subject: [PATCH 27/140] ACPI: add a Kconfig option for ACPI procfs interface
Date: Wed,  7 Feb 2007 13:50:41 -0500
Message-ID: <11708744101300-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:45778 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422742AbXBGSxe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:53:34 -0500
In-Reply-To: <11708744093818-git-send-email-lenb@kernel.org>
Message-Id: <b981c591891dc8885de36498d38fa8d8a5481069.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Add a kconfig option CONFIG_ACPI_PROCFS to make procfs interface
a configurable attribute of ACPI.

No procfs interface is actually deprecated,
and no sysfs interface is added in this patch.

CONGI_ACPI_PROCFS is used to mark procfs interface as deprecated
once the same function is duplicated in sysfs.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/feature-removal-schedule.txt |    9 +++++++++
 drivers/acpi/Kconfig                       |   10 ++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 30f3c8c..9bc3752 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -256,3 +256,12 @@ Why:	Speedstep-centrino driver with ACPI hooks and acpi-cpufreq driver are
 Who:	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
 
 ---------------------------
+
+What:	ACPI procfs interface
+When:	July 2007
+Why:	After ACPI sysfs conversion, ACPI attributes will be duplicated
+	in sysfs and the ACPI procfs interface should be removed.
+Who:	Zhang Rui <rui.zhang@intel.com>
+
+---------------------------
+
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 0f9d4be..1f82ceb 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -77,6 +77,16 @@ config ACPI_SLEEP_PROC_SLEEP
 	  Create /proc/acpi/sleep
 	  Deprecated by /sys/power/state
 
+config ACPI_PROCFS
+	bool "Procfs interface (deprecated)"
+	depends on ACPI
+	default y
+	---help---
+	  Procfs interface for ACPI is made optional for back-compatible.
+	  As the same functions are duplicated in sysfs interface
+	  and this proc interface will be removed some time later,
+	  it's marked as deprecated.
+
 config ACPI_AC
 	tristate "AC Adapter"
 	depends on X86
-- 
1.5.0.rc3.39.gec804
