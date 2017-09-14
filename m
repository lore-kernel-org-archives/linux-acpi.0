From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 2/6] ACPI: Enable PPTT support on ARM64
Date: Thu, 14 Sep 2017 13:49:14 -0500
Message-ID: <20170914184918.20406-10-jeremy.linton@arm.com>
References: <20170914184918.20406-1-jeremy.linton@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39628 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751746AbdINSte (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Sep 2017 14:49:34 -0400
In-Reply-To: <20170914184918.20406-1-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, wangxiongfeng2@huawei.com, hanjun.guo@linaro.org, jhugo@codeaurora.org, john.garry@huawei.com, austinwc@codeaurora.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, Jeremy Linton <jeremy.linton@arm.com>

Now that we have a PPTT parser, in preparation for its use
on arm64, lets build it.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/Kconfig         | 1 +
 drivers/acpi/Makefile      | 1 +
 drivers/acpi/arm64/Kconfig | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0df64a6a56d4..68c9d1289735 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -7,6 +7,7 @@ config ARM64
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ACPI_MCFG if ACPI
 	select ACPI_SPCR_TABLE if ACPI
+	select ACPI_PPTT if ACPI
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 90265ab4437a..c92a0c937551 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -85,6 +85,7 @@ obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
 obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
 obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
+obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
 
 # processor has its own "processor." module_param namespace
 processor-y			:= processor_driver.o
diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
index 5a6f80fce0d6..74b855a669ea 100644
--- a/drivers/acpi/arm64/Kconfig
+++ b/drivers/acpi/arm64/Kconfig
@@ -7,3 +7,6 @@ config ACPI_IORT
 
 config ACPI_GTDT
 	bool
+
+config ACPI_PPTT
+	bool
\ No newline at end of file
-- 
2.13.5

