From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 3/5] x86: pmc-atom: remove unused macro
Date: Wed, 14 Jan 2015 18:39:33 +0200
Message-ID: <1421253575-22509-4-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1421253575-22509-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421253575-22509-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, Aubrey Li <aubrey.li@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Kumar P, Mahesh" <mahesh.kumar.p@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

DRIVER_NAME seems unused. This patch just removes it. There is no functional
change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/pmc_atom.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/pmc_atom.c b/arch/x86/kernel/pmc_atom.c
index 1dd6c62..6b62f55 100644
--- a/arch/x86/kernel/pmc_atom.c
+++ b/arch/x86/kernel/pmc_atom.c
@@ -25,8 +25,6 @@
 
 #include <asm/pmc_atom.h>
 
-#define	DRIVER_NAME	KBUILD_MODNAME
-
 struct pmc_dev {
 	u32 base_addr;
 	void __iomem *regmap;
-- 
2.1.4
