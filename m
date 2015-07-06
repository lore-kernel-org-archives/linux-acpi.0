From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 5/5] x86: pmc_atom: place it under arch/x86/platform/atom
Date: Mon,  6 Jul 2015 17:29:04 +0300
Message-ID: <1436192944-56496-6-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1436192944-56496-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436192944-56496-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, Aubrey Li <aubrey.li@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Kumar P, Mahesh" <mahesh.kumar.p@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

This is specific driver for Intel Atom SoCs like BayTrail and Braswell. Let's
move it to dedicated folder and alleviate a arch/x86/kernel burden.

There is no functional change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/Makefile                      | 1 -
 arch/x86/platform/atom/Makefile               | 3 ++-
 arch/x86/{kernel => platform/atom}/pmc_atom.c | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/x86/{kernel => platform/atom}/pmc_atom.c (100%)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 0f15af4..81db53b 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -108,7 +108,6 @@ obj-$(CONFIG_EFI)			+= sysfb_efi.o
 obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o
 obj-$(CONFIG_TRACING)			+= tracepoint.o
 obj-$(CONFIG_IOSF_MBI)			+= iosf_mbi.o
-obj-$(CONFIG_PMC_ATOM)			+= pmc_atom.o
 
 ###
 # 64 bit specific files
diff --git a/arch/x86/platform/atom/Makefile b/arch/x86/platform/atom/Makefile
index 0a3a40c..40983f5 100644
--- a/arch/x86/platform/atom/Makefile
+++ b/arch/x86/platform/atom/Makefile
@@ -1 +1,2 @@
-obj-$(CONFIG_PUNIT_ATOM_DEBUG) += punit_atom_debug.o
+obj-$(CONFIG_PMC_ATOM)		+= pmc_atom.o
+obj-$(CONFIG_PUNIT_ATOM_DEBUG)	+= punit_atom_debug.o
diff --git a/arch/x86/kernel/pmc_atom.c b/arch/x86/platform/atom/pmc_atom.c
similarity index 100%
rename from arch/x86/kernel/pmc_atom.c
rename to arch/x86/platform/atom/pmc_atom.c
-- 
2.1.4
