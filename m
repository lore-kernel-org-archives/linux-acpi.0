From: Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V4 06/23] XEN / PCI: Remove the dependence on arch x86 when
 PCI_MMCONFIG=y
Date: Thu,  4 Feb 2016 18:28:44 +0100
Message-ID: <1454606941-9523-7-git-send-email-tn@semihalf.com>
References: <1454606941-9523-1-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1454606941-9523-1-git-send-email-tn@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org, jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
Cc: jchandra@broadcom.com, jcm@redhat.com, linaro-acpi@lists.linaro.org, linux-pci@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, robert.richter@caviumnetworks.com, Suravee.Suthikulpanit@amd.com, msalter@redhat.com, wangyijing@huawei.com, Tomasz Nowicki <tn@semihalf.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, mw@semihalf.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

In drivers/xen/pci.c, there are arch x86 dependent codes when
CONFIG_PCI_MMCONFIG is enabled, since CONFIG_PCI_MMCONFIG
depends on ACPI, so this will prevent XEN PCI running on other
architectures using ACPI with PCI_MMCONFIG enabled (such as ARM64).

Fortunatly, it can be sloved in a simple way. In drivers/xen/pci.c,
the only x86 dependent code is if ((pci_probe & PCI_PROBE_MMCONF) == 0),
and it's defined in asm/pci_x86.h, the code means that
if the PCI resource is not probed in PCI_PROBE_MMCONF way, just
ingnore the xen mcfg init. Actually this is duplicate, because
if PCI resource is not probed in PCI_PROBE_MMCONF way, the
pci_mmconfig_list will be empty, and the if (list_empty())
after it will do the same job.

So just remove the arch related code and the head file, this
will be no functional change for x86, and also makes xen/pci.c
usable for other architectures.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Stefano Stabellini <Stefano.Stabellini@eu.citrix.com>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
Tested-by: Duc Dang <dhdang@apm.com>
Tested-by: Dongdong Liu <liudongdong3@huawei.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
Tested-by: Sinan Kaya <okaya@codeaurora.org>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 drivers/xen/pci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/xen/pci.c b/drivers/xen/pci.c
index 6785ebb..9a8dbe3 100644
--- a/drivers/xen/pci.c
+++ b/drivers/xen/pci.c
@@ -28,9 +28,6 @@
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
 #include "../pci/pci.h"
-#ifdef CONFIG_PCI_MMCONFIG
-#include <asm/pci_x86.h>
-#endif
 
 static bool __read_mostly pci_seg_supported = true;
 
@@ -222,9 +219,6 @@ static int __init xen_mcfg_late(void)
 	if (!xen_initial_domain())
 		return 0;
 
-	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
-		return 0;
-
 	if (list_empty(&pci_mmcfg_list))
 		return 0;
 
-- 
1.9.1
