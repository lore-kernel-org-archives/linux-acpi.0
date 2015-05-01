From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH] drivers: acpi: make ACPI_PROCFS_POWER X86 only
Date: Fri,  1 May 2015 11:27:01 +0100
Message-ID: <1430476021-12247-1-git-send-email-lorenzo.pieralisi@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37728 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270AbbEAK1C (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 May 2015 06:27:02 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Lan Tianyu <tianyu.lan@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

The ACPI procfs power interface is initialized by compilation units
that are only selectable on X86 platforms. Since its usage is
deprecated and it cannot even be used on platforms other than X86
it should be compiled in only on X86 platforms.

This patch makes CONFIG_ACPI_PROCFS_POWER dependent on X86, so
that other architectures are prevented from compiling it in for
no purpose.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Lan Tianyu <tianyu.lan@intel.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
---
Lan, Rafael,

I do not see any reason why this option is allowed to be selected
on platforms other than X86, so let's make it X86 only. Please let
me know what you think, thanks.

Lorenzo

 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ab2cbb5..16da185 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -62,7 +62,7 @@ config ACPI_SLEEP
 
 config ACPI_PROCFS_POWER
 	bool "Deprecated power /proc/acpi directories"
-	depends on PROC_FS
+	depends on X86 && PROC_FS
 	help
 	  For backwards compatibility, this option allows
           deprecated power /proc/acpi/ directories to exist, even when
-- 
2.2.1

