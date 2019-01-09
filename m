From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/3] x86/cpu: Introduce INTEL_CPU_FAM*_NODATA() helper macros
Date: Wed,  9 Jan 2019 18:57:52 +0200
Message-ID: <20190109165754.90072-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

These macros are often used by the drivers and we have already a lot of
duplication as ICPU() macro across them.

Provide a generic x86 macro for users.

This adds no driver data variants.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/intel-family.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 25b28760fada..afd70055a750 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -86,10 +86,16 @@
 	.family		= _family,				\
 	.model		= _model,				\
 	.feature	= X86_FEATURE_ANY,			\
-	.driver_data	= (kernel_ulong_t)&_driver_data		\
+	.driver_data	= (kernel_ulong_t)_driver_data		\
 }
 
 #define INTEL_CPU_FAM6(_model, _driver_data)			\
-	INTEL_CPU_FAM_ANY(6, INTEL_FAM6_##_model, _driver_data)
+	INTEL_CPU_FAM_ANY(6, INTEL_FAM6_##_model, &_driver_data)
+
+#define INTEL_CPU_FAM_ANY_NODATA(_family, _model)		\
+	INTEL_CPU_FAM_ANY(_family, _model, 0)
+
+#define INTEL_CPU_FAM6_NODATA(_model)				\
+	INTEL_CPU_FAM_ANY_NODATA(6, INTEL_FAM6_##_model)
 
 #endif /* _ASM_X86_INTEL_FAMILY_H */
-- 
2.20.1
