From: Tang Liang <liang.tang@oracle.com>
Subject: [PATCH 4/5V2] Xen efi: Add xen efi enabled detect
Date: Thu, 23 Feb 2012 17:14:00 +0800
Message-ID: <1329988440-27004-1-git-send-email-liang.tang@oracle.com>
References: <1329988283-26722-1-git-send-email-liang.tang@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <1329988283-26722-1-git-send-email-liang.tang@oracle.com>
List-Unsubscribe: <http://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <http://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Sender: xen-devel-bounces@lists.xen.org
Errors-To: xen-devel-bounces@lists.xen.org
To: mjg59@srcf.ucam.org, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, konrad.wilk@oracle.com, JBeulich@suse.com
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
