From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2] ACPI: ACPICA: Add non-linux host build support
Date: Tue, 11 Apr 2017 15:48:05 +0800
Message-ID: <073b839b705bba4477cdfaa1a76d526a0e69575c.1491896785.git.lv.zheng@intel.com>
References: <45fb52dc64ba477ae07c135aecd3b68394f5893b.1490930522.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:28205 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752347AbdDKHsL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Apr 2017 03:48:11 -0400
In-Reply-To: <45fb52dc64ba477ae07c135aecd3b68394f5893b.1490930522.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

_LINUX: used to detect a target build is a linux kernel/application.
__linux__: used to detect a build is on a linux hosts.

Thus we can see: if a linux kernel build is performed on environments other
than linux hosts, __linux__ may not be defined by the compiler and _LINUX
cannot cover linux kernel resident ACPICA files, as it's only defined in
<linux/acpi.h> and hence only allows non ACPICA kernel files to correctly
include aclinux.h.
As a conclusion, we don't actually support such build.

This patch adds -D_LINUX for ACPICA files so that kernel builds on any
hosts can use unified _LINUX as a linux kernel target indication to
correctly include aclinux.h.

Tested-by: Al Stone <ahs3@redhat.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index 32d93ed..dea6530 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -2,7 +2,7 @@
 # Makefile for ACPICA Core interpreter
 #
 
-ccflags-y			:= -Os -DBUILDING_ACPICA
+ccflags-y			:= -Os -D_LINUX -DBUILDING_ACPICA
 ccflags-$(CONFIG_ACPI_DEBUG)	+= -DACPI_DEBUG_OUTPUT
 
 # use acpi.o to put all files here into acpi.o modparam namespace
-- 
2.7.4

