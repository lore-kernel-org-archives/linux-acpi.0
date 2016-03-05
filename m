From: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: [GIT PULL] libnvdimm, nfit: fix for 4.5-rc7
Date: Sat, 5 Mar 2016 01:07:51 +0000
Message-ID: <1457140067.17242.11.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:52566 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755567AbcCEBHy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Mar 2016 20:07:54 -0500
Content-Language: en-US
Content-ID: <6F184B1EDD20654388FB444C71D8DB15@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi Linus, please pull from:

+AKA- git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm libnvdimm-fixes

...to receive one straggling fix for NVDIMM support.

The KVM/QEMU enabling for NVDIMMs has recently reached the point where
it is able to accept some ACPI +AF8-DSM requests from a guest VM. +AKA-However
they immediately found that the 4.5-rc kernel is unusable because the
kernel's 'nfit' driver fails to load upon seeing a valid +ACI-not
supported+ACI- response from the virtual BIOS for an address range scrub
command.

It is not mandatory that a platform implement address range scrubbing,
so this fix from Vishal properly treats the +ACI-not supported+ACI- response as
+ACI-skip scrubbing and continue loading the driver+ACI-.

The following changes since commit fc77dbd34c5c99bce46d40a2491937c3bcbd10af:

+AKA- Linux 4.5-rc6 (2016-02-28 08:41:20 -0800)

are available in the git repository at:

+AKA- git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm libnvdimm-fixes

for you to fetch changes up to 6e2452dff4441e3dc24d415c8b2cda8a3ba52116:

+AKA- nfit: Continue init even if ARS commands are unimplemented (2016-03-04 16:46:13 -0800)

----------------------------------------------------------------
Vishal Verma (1):
+AKAAoACgAKAAoACg-nfit: Continue init even if ARS commands are unimplemented

+AKA-drivers/acpi/nfit.c +AHw- 15 +-+-+-+-+-+-+-+-+-+-+-----
+AKA-1 file changed, 11 insertions(+-), 4 deletions(-)

commit 6e2452dff4441e3dc24d415c8b2cda8a3ba52116
Author: Vishal Verma +ADw-vishal.l.verma+AEA-intel.com+AD4-
Date:+AKAAoACg-Thu Mar 3 15:39:41 2016 -0700

+AKAAoACgAKA-nfit: Continue init even if ARS commands are unimplemented
+AKAAoACgAKA-
+AKAAoACgAKA-If firmware doesn't implement any of the ARS commands, take that to
+AKAAoACgAKA-mean that ARS is unsupported, and continue to initialize regions without
+AKAAoACgAKA-bad block lists. We cannot make the assumption that ARS commands will be
+AKAAoACgAKA-unconditionally supported on all NVDIMMs.
+AKAAoACgAKA-
+AKAAoACgAKA-Reported-by: Haozhong Zhang +ADw-haozhong.zhang+AEA-intel.com+AD4-
+AKAAoACgAKA-Signed-off-by: Vishal Verma +ADw-vishal.l.verma+AEA-intel.com+AD4-
+AKAAoACgAKA-Acked-by: Xiao Guangrong +ADw-guangrong.xiao+AEA-linux.intel.com+AD4-
+AKAAoACgAKA-Tested-by: Haozhong Zhang +ADw-haozhong.zhang+AEA-intel.com+AD4-
+AKAAoACgAKA-Signed-off-by: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-

diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
index fb53db187854..35947ac87644 100644
--- a/drivers/acpi/nfit.c
+-+-+- b/drivers/acpi/nfit.c
+AEAAQA- -1590,14 +-1590,21 +AEAAQA- static int acpi+AF8-nfit+AF8-find+AF8-poison(struct acpi+AF8-nfit+AF8-desc +ACo-acpi+AF8-desc,
+AKA-	start +AD0- ndr+AF8-desc-+AD4-res-+AD4-start+ADs-
+AKA-	len +AD0- ndr+AF8-desc-+AD4-res-+AD4-end - ndr+AF8-desc-+AD4-res-+AD4-start +- 1+ADs-
+AKA-
+-	/+ACo-
+-	+AKAAKg- If ARS is unimplemented, unsupported, or if the 'Persistent Memory
+-	+AKAAKg- Scrub' flag in extended status is not set, skip this but continue
+-	+AKAAKg- initialization
+-	+AKAAKg-/
+AKA-	rc +AD0- ars+AF8-get+AF8-cap(nd+AF8-desc, ars+AF8-cap, start, len)+ADs-
+-	if (rc +AD0APQ- -ENOTTY) +AHs-
+-		dev+AF8-dbg(acpi+AF8-desc-+AD4-dev,
+-			+ACI-Address Range Scrub is not implemented, won't create an error list+AFw-n+ACI-)+ADs-
+-		rc +AD0- 0+ADs-
+-		goto out+ADs-
+-	+AH0-
+AKA-	if (rc)
+AKA-		goto out+ADs-
+AKA-
-	/+ACo-
-	+AKAAKg- If ARS is unsupported, or if the 'Persistent Memory Scrub' flag in
-	+AKAAKg- extended status is not set, skip this but continue initialization
-	+AKAAKg-/
+AKA-	if ((ars+AF8-cap-+AD4-status +ACY- 0xffff) +AHwAfA-
+AKA-		+ACE-(ars+AF8-cap-+AD4-status +AD4APg- 16 +ACY- ND+AF8-ARS+AF8-PERSISTENT)) +AHs-
+AKA-		dev+AF8-warn(acpi+AF8-desc-+AD4-dev,