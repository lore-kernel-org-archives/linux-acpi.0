From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v4 10/13] ACPI: Make EC debugfs depend on X86 || IA64 in Kconfig
Date: Fri, 27 Jun 2014 11:49:33 +0800
Message-ID: <1403840976-7456-11-git-send-email-hanjun.guo@linaro.org>
References: <1403840976-7456-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403840976-7456-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, rric@kernel.org, Grant Likely <grant.likely@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Mark Rutland <mark.rutland@arm.com>, Charles.Garcia-Tobin@arm.com, lorenzo.pieralisi@arm.com, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

Since EC (Embedded controller) needs SCI for the interupt which
is not available on ARM64, make the EC debugfs depend on X86 || IA64
only in the Kconfig file.

Reviewed-by: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 0e6f72d..7de5e3f 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -69,6 +69,7 @@ config ACPI_PROCFS_POWER
 
 config ACPI_EC_DEBUGFS
 	tristate "EC read/write access through /sys/kernel/debug/ec"
+	depends on X86 || IA64
 	default n
 	help
 	  Say N to disable Embedded Controller /sys/kernel/debug interface
-- 
1.7.9.5
