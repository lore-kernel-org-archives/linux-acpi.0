From: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: [GIT PULL] libnvdimm fixes for 4.6-rc7
Date: Thu, 5 May 2016 23:37:06 +0000
Message-ID: <1462491421.29583.9.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:60884 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755416AbcEEXhY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 May 2016 19:37:24 -0400
Content-Language: en-US
Content-ID: <A607F884E418B943B338F3D79A079D8D@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi Linus, please pull from:

+AKA- git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm libnvdimm-fixes

...to receive:

1/ A fix for the persistent memory 'struct page' driver. +AKA-The
implementation overlooked the fact that pages are allocated in 2MB
units leading to -ENOMEM when establishing some configurations. +AKA-It's
tagged for -stable as the problem was introduced with the initial
implementation in 4.5.

2/ The new +ACI-error status translation+ACI- routine, introduced with the 4.6
updates to the nfit driver, missed a necessary path in acpi+AF8-nfit+AF8-ctl().
+AKA-End result is that we are falsely assuming commands complete
successfully when the embedded status says otherwise.

Full changelog and diff below, these have received a positive build
notification from the kbuild robot over 107 configs.
---

The following changes since commit 02da2d72174c61988eb4456b53f405e3ebdebce4:

+AKA- Linux 4.6-rc5 (2016-04-24 16:17:05 -0700)

are available in the git repository at:

+AKA- git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm libnvdimm-fixes

for you to fetch changes up to 2eea65829dc6c20dccbe79726fd0f3fe7f8aa43b:

+AKA- nfit: fix translation of command status results (2016-05-02 09:11:53 -0700)

----------------------------------------------------------------
Dan Williams (2):
+AKAAoACgAKAAoACg-libnvdimm, pfn: fix memmap reservation sizing
+AKAAoACgAKAAoACg-nfit: fix translation of command status results

+AKA-drivers/acpi/nfit.c+AKAAoACgAHwAoACg-5 +-+-+-+--
+AKA-drivers/nvdimm/pmem.c +AHw- 13 +-+-+-+-+-+-+-+-+-+----
+AKA-2 files changed, 14 insertions(+-), 4 deletions(-)


commit 658922e57b847bb7112aa67f6441b6bbc6554412
Author: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-
Date:+AKAAoACg-Sat Apr 30 13:07:06 2016 -0700

+AKAAoACgAKA-libnvdimm, pfn: fix memmap reservation sizing
+AKAAoACgAKA-
+AKAAoACgAKA-When configuring a pfn-device instance to allocate the memmap array it
+AKAAoACgAKA-needs to account for the fact that vmemmap+AF8-populate+AF8-hugepages()
+AKAAoACgAKA-allocates struct page blocks in HPAGE+AF8-SIZE chunks.+AKAAoA-We need to align the
+AKAAoACgAKA-reserved area size to 2MB otherwise arch+AF8-add+AF8-memory() runs out of memory
+AKAAoACgAKA-while establishing the memmap:
+AKAAoACgAKA-
+AKAAoACgAKAAoA-WARNING: CPU: 0 PID: 496 at arch/x86/mm/init+AF8-64.c:704 arch+AF8-add+AF8-memory+-0xe7/0xf0
+AKAAoACgAKAAoABb-..+AF0-
+AKAAoACgAKAAoA-Call Trace:
+AKAAoACgAKAAoACgAFsAPA-ffffffff8148bdb3+AD4AXQ- dump+AF8-stack+-0x85/0xc2
+AKAAoACgAKAAoACgAFsAPA-ffffffff810a749b+AD4AXQ- +AF8AXw-warn+-0xcb/0xf0
+AKAAoACgAKAAoACgAFsAPA-ffffffff810a75cd+AD4AXQ- warn+AF8-slowpath+AF8-null+-0x1d/0x20
+AKAAoACgAKAAoACgAFsAPA-ffffffff8106a497+AD4AXQ- arch+AF8-add+AF8-memory+-0xe7/0xf0
+AKAAoACgAKAAoACgAFsAPA-ffffffff811d2097+AD4AXQ- devm+AF8-memremap+AF8-pages+-0x287/0x450
+AKAAoACgAKAAoACgAFsAPA-ffffffff811d1ffa+AD4AXQ- ? devm+AF8-memremap+AF8-pages+-0x1ea/0x450
+AKAAoACgAKAAoACgAFsAPA-ffffffffa0000298+AD4AXQ- +AF8AXw-wrap+AF8-devm+AF8-memremap+AF8-pages+-0x58/0x70 +AFs-nfit+AF8-test+AF8-iomap+AF0-
+AKAAoACgAKAAoACgAFsAPA-ffffffffa0047a58+AD4AXQ- pmem+AF8-attach+AF8-disk+-0x318/0x420 +AFs-nd+AF8-pmem+AF0-
+AKAAoACgAKAAoACgAFsAPA-ffffffffa0047bcf+AD4AXQ- nd+AF8-pmem+AF8-probe+-0x6f/0x90 +AFs-nd+AF8-pmem+AF0-
+AKAAoACgAKAAoACgAFsAPA-ffffffffa0009469+AD4AXQ- nvdimm+AF8-bus+AF8-probe+-0x69/0x110 +AFs-libnvdimm+AF0-
+AKAAoACgAKAAoABb-..+AF0-
+AKAAoACgAKAAoACg-ndbus0: nd+AF8-pmem.probe(pfn3.0) +AD0- -12
+AKAAoACgAKAAoA-nd+AF8-pmem: probe of pfn3.0 failed with error -12
+AKAAoACgAKA-libndctl: ndctl+AF8-pfn+AF8-enable: pfn3.0: failed to enable
+AKAAoACgAKA-
+AKAAoACgAKA-Reported-by: Namratha Kothapalli +ADw-namratha.n.kothapalli+AEA-intel.com+AD4-
+AKAAoACgAKA-Cc: +ADw-stable+AEA-vger.kernel.org+AD4-
+AKAAoACgAKA-Signed-off-by: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index f798899338ed..5101f3ab4f29 100644
--- a/drivers/nvdimm/pmem.c
+-+-+- b/drivers/nvdimm/pmem.c
+AEAAQA- -397,10 +-397,17 +AEAAQA- static int nd+AF8-pfn+AF8-init(struct nd+AF8-pfn +ACo-nd+AF8-pfn)
+AKA-	+AKAAKg-/
+AKA-	start +-+AD0- start+AF8-pad+ADs-
+AKA-	npfns +AD0- (pmem-+AD4-size - start+AF8-pad - end+AF8-trunc - SZ+AF8-8K) / SZ+AF8-4K+ADs-
-	if (nd+AF8-pfn-+AD4-mode +AD0APQ- PFN+AF8-MODE+AF8-PMEM)
-		offset +AD0- ALIGN(start +- SZ+AF8-8K +- 64 +ACo- npfns, nd+AF8-pfn-+AD4-align)
+-	if (nd+AF8-pfn-+AD4-mode +AD0APQ- PFN+AF8-MODE+AF8-PMEM) +AHs-
+-		unsigned long memmap+AF8-size+ADs-
+-
+-		/+ACo-
+-		+AKAAKg- vmemmap+AF8-populate+AF8-hugepages() allocates the memmap array in
+-		+AKAAKg- HPAGE+AF8-SIZE chunks.
+-		+AKAAKg-/
+-		memmap+AF8-size +AD0- ALIGN(64 +ACo- npfns, HPAGE+AF8-SIZE)+ADs-
+-		offset +AD0- ALIGN(start +- SZ+AF8-8K +- memmap+AF8-size, nd+AF8-pfn-+AD4-align)
+AKA-			- start+ADs-
-	else if (nd+AF8-pfn-+AD4-mode +AD0APQ- PFN+AF8-MODE+AF8-RAM)
+-	+AH0- else if (nd+AF8-pfn-+AD4-mode +AD0APQ- PFN+AF8-MODE+AF8-RAM)
+AKA-		offset +AD0- ALIGN(start +- SZ+AF8-8K, nd+AF8-pfn-+AD4-align) - start+ADs-
+AKA-	else
+AKA-		goto err+ADs-

commit 2eea65829dc6c20dccbe79726fd0f3fe7f8aa43b
Author: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-
Date:+AKAAoACg-Mon May 2 09:11:53 2016 -0700

+AKAAoACgAKA-nfit: fix translation of command status results
+AKAAoACgAKA-
+AKAAoACgAKA-When transportation of the command completes successfully, it indicates
+AKAAoACgAKA-that the 'status' result is valid.+AKAAoA-Fix the missed checking and
+AKAAoACgAKA-translation of the status field at the end of acpi+AF8-nfit+AF8-ctl().
+AKAAoACgAKA-Otherwise, we fail to handle reported errors and assume commands
+AKAAoACgAKA-complete successfully.
+AKAAoACgAKA-
+AKAAoACgAKA-Reported-by: Linda Knippers +ADw-linda.knippers+AEA-hpe.com+AD4-
+AKAAoACgAKA-Reviewed-by: Johannes Thumshirn +ADw-jthumshirn+AEA-suse.de+AD4-
+AKAAoACgAKA-Signed-off-by: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-

diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
index d0f35e63640b..63cc9dbe4f3b 100644
--- a/drivers/acpi/nfit.c
+-+-+- b/drivers/acpi/nfit.c
+AEAAQA- -287,8 +-287,11 +AEAAQA- static int acpi+AF8-nfit+AF8-ctl(struct nvdimm+AF8-bus+AF8-descriptor +ACo-nd+AF8-desc,
+AKA-					offset)+ADs-
+AKA-			rc +AD0- -ENXIO+ADs-
+AKA-		+AH0-
-	+AH0- else
+-	+AH0- else +AHs-
+AKA-		rc +AD0- 0+ADs-
+-		if (cmd+AF8-rc)
+-			+ACo-cmd+AF8-rc +AD0- xlat+AF8-status(buf, cmd)+ADs-
+-	+AH0-
+AKA-
+AKA- out:
+AKA-	ACPI+AF8-FREE(out+AF8-obj)+ADs