From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 14/20] Irqchip / gic: Set as default domain so we can access from ACPI
Date: Fri, 17 Jan 2014 20:25:08 +0800
Message-ID: <1389961514-13562-15-git-send-email-hanjun.guo@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org, Charles.Garcia-Tobin@arm.com, Hanjun Guo <hanjun.guo@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>
List-Id: linux-acpi@vger.kernel.org

Only one GIC is supported in ACPI 5.0, even cascade GIC is not supported.

So if we set the GIC as the default domain then we can access it for IRQ
mapping within the ACPI code.

Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-gic.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 341c601..40fde7b 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -963,6 +963,13 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 		register_cpu_notifier(&gic_cpu_notifier);
 #endif
 		set_handle_irq(gic_handle_irq);
+
+		/*
+		 * do not set default host for GIC domain multi-times.
+		 * FIXME: This probably needs revisited when multi GICs
+		 * supported
+		 */
+		irq_set_default_host(gic->domain);
 	}
 
 	gic_chip.flags |= gic_arch_extn.flags;
-- 
1.7.9.5
