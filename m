From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/3] x86/platform/intel-mid: Move PCI initialization to arch_init()
Date: Wed, 17 Jan 2018 19:34:08 +0200
Message-ID: <20180117173409.88136-2-andriy.shevchenko@linux.intel.com>
References: <20180117173409.88136-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117173409.88136-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPI redefines x86_init.pci.init when enabled. Though we still need special
treatment for MID platforms.

Move our specific callback to x86_init.pci.arch_init() and, by calling
acpi_noirq_set(), take back a control over IRQ assignment.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/pci/intel_mid_pci.c            | 1 +
 arch/x86/platform/intel-mid/intel-mid.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index 511921045312..43867bc85368 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -300,6 +300,7 @@ int __init intel_mid_pci_init(void)
 	pci_root_ops = intel_mid_pci_ops;
 	pci_soc_mode = 1;
 	/* Continue with standard init */
+	acpi_noirq_set();
 	return 1;
 }
 
diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
index 86676cec99a1..2c67bae6bb53 100644
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -194,7 +194,7 @@ void __init x86_intel_mid_early_setup(void)
 	x86_platform.calibrate_tsc = intel_mid_calibrate_tsc;
 	x86_platform.get_nmi_reason = intel_mid_get_nmi_reason;
 
-	x86_init.pci.init = intel_mid_pci_init;
+	x86_init.pci.arch_init = intel_mid_pci_init;
 	x86_init.pci.fixup_irqs = x86_init_noop;
 
 	legacy_pic = &null_legacy_pic;
-- 
2.15.1
