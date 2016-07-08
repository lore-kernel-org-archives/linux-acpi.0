From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v9 7/7] ACPI : enable ACPI_PROCESSOR_IDLE on ARM64
Date: Fri,  8 Jul 2016 18:07:58 +0100
Message-ID: <1467997678-7107-8-git-send-email-sudeep.holla@arm.com>
References: <1467997678-7107-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44610 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932927AbcGHRI3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Jul 2016 13:08:29 -0400
In-Reply-To: <1467997678-7107-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI List <linux-acpi@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Vikas Sajjan <vikas.cha.sajjan@hpe.com>, Sunil <sunil.vl@hpe.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Prashanth Prakash <pprakash@codeaurora.org>, Al Stone <al.stone@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, LKML <linux-kernel@vger.kernel.org>, ALKML <linux-arm-kernel@lists.infradead.org>

Now that ACPI processor idle driver supports LPI(Low Power Idle), lets
enable ACPI_PROCESSOR_IDLE for ARM64 too.

This patch just removes the IA64 and X86 dependency on ACPI_PROCESSOR_IDLE

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 1358fb7d7a68..d74275c0f374 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -238,7 +238,7 @@ config ACPI_CPPC_LIB
 config ACPI_PROCESSOR
 	tristate "Processor"
 	depends on X86 || IA64 || ARM64
-	select ACPI_PROCESSOR_IDLE if X86 || IA64
+	select ACPI_PROCESSOR_IDLE
 	select ACPI_CPU_FREQ_PSS if X86 || IA64
 	default y
 	help
-- 
2.7.4

