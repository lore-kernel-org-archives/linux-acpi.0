From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/3] ACPICA: acpidump: Enable tools Makefile to include acpi tools.
Date: Wed, 15 Jan 2014 12:04:17 +0800
Message-ID: <46fda8fa1c4f1970b13af38054ecab6d9d13bdcf.1389676901.git.lv.zheng@intel.com>
References: <cover.1376378577.git.lv.zheng@intel.com> <cover.1389676901.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:12902 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071AbaAOEEg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Jan 2014 23:04:36 -0500
In-Reply-To: <cover.1389676901.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

This patch enables ACPI tool build in the tools/Makefile, so that the ACPI
tools can be built/cleaned/installed along with other tools.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 tools/Makefile |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/Makefile b/tools/Makefile
index a9b0200..ecdc2f8 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -3,6 +3,7 @@ include scripts/Makefile.include
 help:
 	@echo 'Possible targets:'
 	@echo ''
+	@echo '  acpi       - ACPI tools'
 	@echo '  cgroup     - cgroup tools'
 	@echo '  cpupower   - a tool for all things x86 CPU power'
 	@echo '  firewire   - the userspace part of nosy, an IEEE-1394 traffic sniffer'
@@ -33,6 +34,9 @@ help:
 	@echo '    the respective build directory.'
 	@echo '  clean: a summary clean target to clean _all_ folders'
 
+acpi: FORCE
+	$(call descend,power/$@)
+
 cpupower: FORCE
 	$(call descend,power/$@)
 
@@ -54,6 +58,9 @@ turbostat x86_energy_perf_policy: FORCE
 tmon: FORCE
 	$(call descend,thermal/$@)
 
+acpi_install:
+	$(call descend,power/$(@:_install=),install)
+
 cpupower_install:
 	$(call descend,power/$(@:_install=),install)
 
@@ -69,11 +76,14 @@ turbostat_install x86_energy_perf_policy_install:
 tmon_install:
 	$(call descend,thermal/$(@:_install=),install)
 
-install: cgroup_install cpupower_install firewire_install lguest_install \
+install: acpi_install cgroup_install cpupower_install firewire_install lguest_install \
 		perf_install selftests_install turbostat_install usb_install \
 		virtio_install vm_install net_install x86_energy_perf_policy_install \
 	tmon
 
+acpi_clean:
+	$(call descend,power/acpi,clean)
+
 cpupower_clean:
 	$(call descend,power/cpupower,clean)
 
@@ -95,8 +105,8 @@ turbostat_clean x86_energy_perf_policy_clean:
 tmon_clean:
 	$(call descend,thermal/tmon,clean)
 
-clean: cgroup_clean cpupower_clean firewire_clean lguest_clean perf_clean \
-		selftests_clean turbostat_clean usb_clean virtio_clean \
+clean: acpi_clean cgroup_clean cpupower_clean firewire_clean lguest_clean \
+		perf_clean selftests_clean turbostat_clean usb_clean virtio_clean \
 		vm_clean net_clean x86_energy_perf_policy_clean tmon_clean
 
 .PHONY: FORCE
-- 
1.7.10

