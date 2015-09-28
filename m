From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v4 6/9] acpi/gsi: Select OF_DYNAMIC when ACPI_GENERIC_GSI is selected
Date: Mon, 28 Sep 2015 17:42:59 +0100
Message-ID: <1443458582-7497-7-git-send-email-marc.zyngier@arm.com>
References: <1443458582-7497-1-git-send-email-marc.zyngier@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443458582-7497-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Graeme Gregory <graeme@xora.org.uk>, Jake Oshins <jakeo@microsoft.com>
List-Id: linux-acpi@vger.kernel.org

As we're now dynamically creating device nodes to identify
irqdomains, it is necessary to enable CONFIG_OF_DYNAMIC, enabling
the use of of_node_alloc().

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/acpi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 5d1015c..8bbfe0b 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -49,6 +49,7 @@ config ARCH_MIGHT_HAVE_ACPI_PDC
 	bool
 
 config ACPI_GENERIC_GSI
+	select OF_DYNAMIC
 	bool
 
 config ACPI_SYSTEM_POWER_STATES_SUPPORT
-- 
2.1.4
