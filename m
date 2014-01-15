From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 3/3] ACPICA: acpidump: Update MAINTAINERS file to include tools folder for ACPI/ACPICA.
Date: Wed, 15 Jan 2014 12:04:24 +0800
Message-ID: <ef3f0c5688372f4187aafe53c07ce5f015244193.1389676901.git.lv.zheng@intel.com>
References: <cover.1376378577.git.lv.zheng@intel.com> <cover.1389676901.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16021 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751203AbaAOEEi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Jan 2014 23:04:38 -0500
In-Reply-To: <cover.1389676901.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

This patch updates MAINTAINERS file, adding tools/power/acpi for ACPI and
ACPICA.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 MAINTAINERS |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 31a0462..b8cae76 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -252,6 +252,7 @@ F:	Documentation/ABI/testing/sysfs-bus-acpi
 F:	drivers/pci/*acpi*
 F:	drivers/pci/*/*acpi*
 F:	drivers/pci/*/*/*acpi*
+F:	tools/power/acpi
 
 ACPI COMPONENT ARCHITECTURE (ACPICA)
 M:	Robert Moore <robert.moore@intel.com>
@@ -266,6 +267,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
 S:	Supported
 F:	drivers/acpi/acpica/
 F:	include/acpi/
+F:	tools/power/acpi/
 
 ACPI FAN DRIVER
 M:	Zhang Rui <rui.zhang@intel.com>
-- 
1.7.10

