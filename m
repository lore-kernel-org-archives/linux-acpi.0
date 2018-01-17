From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/3] x86/platform/intel-mid: Add special handling of ACPI HW reduced platforms
Date: Wed, 17 Jan 2018 19:34:09 +0200
Message-ID: <20180117173409.88136-3-andriy.shevchenko@linux.intel.com>
References: <20180117173409.88136-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117173409.88136-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

When switching to ACPI HW reduced platforms we still want to initialize timers.
Override acpi_reduced_hw_init() to achieve that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/platform/intel-mid/intel-mid.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
index 2c67bae6bb53..51bf2f6c9e97 100644
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -13,6 +13,7 @@
 
 #define pr_fmt(fmt) "intel_mid: " fmt
 
+#include <linux/acpi.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
@@ -172,6 +173,14 @@ static unsigned char intel_mid_get_nmi_reason(void)
 	return 0;
 }
 
+void __init acpi_reduced_hw_init(void)
+{
+	/*
+	 * Do nothing for now as everything needed done in
+	 * x86_intel_mid_early_setup() below.
+	 */
+}
+
 /*
  * Moorestown specific x86_init function overrides and early setup
  * calls.
-- 
2.15.1
