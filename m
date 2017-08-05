From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [RFC 4/4] ACPI: Enable PPTT support on ARM64
Date: Fri,  4 Aug 2017 19:11:59 -0500
Message-ID: <20170805001159.12769-5-jeremy.linton@arm.com>
References: <20170805001159.12769-1-jeremy.linton@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753381AbdHEAMD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Aug 2017 20:12:03 -0400
In-Reply-To: <20170805001159.12769-1-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-acpi@vger.kernel.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, will.deacon@arm.com, catalin.marinas@arm.com

Now that we have a parser, and arm64 has appropriate
hooks in place to utilize it, lets enable PPTT
parsing in the arm64 ACPI build.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/acpi/arm64/Kconfig  | 3 +++
 drivers/acpi/arm64/Makefile | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
index 5a6f80f..74b855a 100644
--- a/drivers/acpi/arm64/Kconfig
+++ b/drivers/acpi/arm64/Kconfig
@@ -7,3 +7,6 @@ config ACPI_IORT
 
 config ACPI_GTDT
 	bool
+
+config ACPI_PPTT
+	bool
\ No newline at end of file
diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index 1017def..b6dee6b 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_ACPI_IORT) 	+= iort.o
 obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
+obj-$(CONFIG_ACPI_GTDT) 	+= pptt.o
-- 
2.9.4

