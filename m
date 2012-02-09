From: Tang Liang <liang.tang@oracle.com>
Subject: [PATCH 4/5] Xen efi: Add xen efi enabled detect
Date: Thu,  9 Feb 2012 11:33:36 +0800
Message-ID: <1328758416-24305-1-git-send-email-liang.tang@oracle.com>
References: <1328758250-23989-1-git-send-email-liang.tang@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1328758250-23989-1-git-send-email-liang.tang@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mjg59@srcf.ucam.org, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, konrad.wilk@oracle.com
Cc: liang.tang@oracle.com
List-Id: linux-acpi@vger.kernel.org

We need to use hypercall to detect the xen efi enabled or not.
If xen efi enable is set,replace the efi public function to xen efi public
function and set efi_enabled to 1 in the function efi_probe;

Signed-off-by: Tang Liang <liang.tang@oracle.com>
Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/xen/enlighten.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 12eb07b..92982c1 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -31,6 +31,7 @@
 #include <linux/pci.h>
 #include <linux/gfp.h>
 #include <linux/memblock.h>
+#include <linux/efi.h>
 
 #include <xen/xen.h>
 #include <xen/interface/xen.h>
@@ -1282,6 +1283,8 @@ asmlinkage void __init xen_start_kernel(void)
 
 	xen_setup_runstate_info(0);
 
+	if (xen_initial_domain())
+		xen_efi_probe();
 	/* Start the world */
 #ifdef CONFIG_X86_32
 	i386_start_kernel();
-- 
1.7.7.5
