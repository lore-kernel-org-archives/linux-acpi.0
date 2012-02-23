From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 1/3] xen/setup/pm/acpi: Remove the call to boot_option_idle_override.
Date: Thu, 23 Feb 2012 17:31:08 -0500
Message-ID: <1330036270-20015-2-git-send-email-konrad.wilk@oracle.com>
References: <1330036270-20015-1-git-send-email-konrad.wilk@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1330036270-20015-1-git-send-email-konrad.wilk@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ke.yu@intel.com, kevin.tian@intel.com, JBeulich@novell.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org
Cc: xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: linux-acpi@vger.kernel.org

We needed that call in the past to force the kernel to use
default_idle (which called safe_halt, which called xen_safe_halt).

But set_pm_idle_to_default() does now that, so there is no need
to use this boot option operand.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/xen/setup.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index e03c636..1236623 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -420,7 +420,6 @@ void __init xen_arch_setup(void)
 	boot_cpu_data.hlt_works_ok = 1;
 #endif
 	disable_cpuidle();
-	boot_option_idle_override = IDLE_HALT;
 	WARN_ON(set_pm_idle_to_default());
 	fiddle_vdso();
 }
-- 
1.7.9.48.g85da4d
