From: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: [GIT PULL] libnvdimm regression fix for 4.7-final
Date: Fri, 22 Jul 2016 21:09:34 +0000
Message-ID: <1469221772.2244.16.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:37731 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752662AbcGVVJh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Jul 2016 17:09:37 -0400
Content-Language: en-US
Content-ID: <15A181BF4EE4C549B2DCFA132FA2677C@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi Linus, please pull from:

+AKA- git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm libnvdimm-fixes

...to receive a regression fix for a problem that was introduced in
v4.7-rc6.

In 4.7-rc1 we introduced auto-probing for the ACPI DSM (device-
specific-method) format that the platform firmware implements for
nvdimm devices. We initially fixed a regression in probing the QEMU DSM
implementation by making acpi+AF8-check+AF8-dsm() tolerant of the way QEMU
reports the +ACI-0 DSMs supported+ACI- condition. However, that broke HPE
platforms since that tolerance caused the driver to mistakenly match
the 1-zero-byte response those platforms give to +ACI-unknown+ACI- commands.
Instead, we simply make the driver tolerant of not finding any
supported DSMs. +AKA-This has been tested to work with both QEMU and HPE
platforms.

This commit has appeared in a -next release with no reported issues.

The following changes since commit a99cde438de0c4c0cecc1d1af1a55a75b10bfdef:

+AKA- Linux 4.7-rc6 (2016-07-03 23:01:00 -0700)

are available in the git repository at:

+AKA- git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm libnvdimm-fixes

for you to fetch changes up to a72255983f12f31f0c8d8275fb1a781546cfacb7:

+AKA- nfit: make DIMM DSMs optional (2016-07-19 12:32:39 -0700)

----------------------------------------------------------------
Dan Williams (1):
+AKAAoACgAKAAoACg-nfit: make DIMM DSMs optional

+AKA-drivers/acpi/nfit.c+AKAAoAB8- 11 +-+-+-+-+-+------
+AKA-drivers/acpi/utils.c +AHwAoACg-6 +-+-+----
+AKA-2 files changed, 9 insertions(+-), 8 deletions(-)

commit a72255983f12f31f0c8d8275fb1a781546cfacb7
Author: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-
Date:+AKAAoACg-Tue Jul 19 12:32:39 2016 -0700

+AKAAoACgAKA-nfit: make DIMM DSMs optional
+AKAAoACgAKA-
+AKAAoACgAKA-Commit 4995734e973a +ACI-acpi, nfit: fix acpi+AF8-check+AF8-dsm() vs zero functions
+AKAAoACgAKA-implemented+ACI- attempted to fix a QEMU regression by supporting its usage
+AKAAoACgAKA-of a zero-mask as a valid response to a DSM-family probe request.
+AKAAoACgAKA-However, this behavior breaks HP platforms that return a zero-mask by
+AKAAoACgAKA-default causing the probe to misidentify the DSM-family.
+AKAAoACgAKA-
+AKAAoACgAKA-Instead, the QEMU regression can be fixed by simply not requiring the DSM
+AKAAoACgAKA-family to be identified.
+AKAAoACgAKA-
+AKAAoACgAKA-This effectively reverts commit 4995734e973a, and removes the DSM
+AKAAoACgAKA-requirement from the init path.
+AKAAoACgAKA-
+AKAAoACgAKA-Cc: +ACI-Rafael J. Wysocki+ACI- +ADw-rafael+AEA-kernel.org+AD4-
+AKAAoACgAKA-Cc: Xiao Guangrong +ADw-guangrong.xiao+AEA-linux.intel.com+AD4-
+AKAAoACgAKA-Cc: Linda Knippers +ADw-linda.knippers+AEA-hpe.com+AD4-
+AKAAoACgAKA-Fixes: 4995734e973a (+ACI-acpi, nfit: fix acpi+AF8-check+AF8-dsm() vs zero functions implemented+ACI-)
+AKAAoACgAKA-Reported-by: Jerry Hoemann +ADw-jerry.hoemann+AEA-hpe.com+AD4-
+AKAAoACgAKA-Tested-by: Jerry Hoemann +ADw-jerry.hoemann+AEA-hpe.com+AD4-
+AKAAoACgAKA-Signed-off-by: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-

diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
index ac6ddcc080d4..1f0e06065ae6 100644
--- a/drivers/acpi/nfit.c
+-+-+- b/drivers/acpi/nfit.c
+AEAAQA- -1131,11 +-1131,11 +AEAAQA- static int acpi+AF8-nfit+AF8-add+AF8-dimm(struct acpi+AF8-nfit+AF8-desc +ACo-acpi+AF8-desc,
+AKA-
+AKA-	/+ACo-
+AKA-	+AKAAKg- Until standardization materializes we need to consider up to 3
-	+AKAAKg- different command sets.+AKAAoA-Note, that checking for zero functions
-	+AKAAKg- tells us if any commands might be reachable through this uuid.
+-	+AKAAKg- different command sets.+AKAAoA-Note, that checking for function0 (bit0)
+-	+AKAAKg- tells us if any commands are reachable through this uuid.
+AKA-	+AKAAKg-/
+AKA-	for (i +AD0- NVDIMM+AF8-FAMILY+AF8-INTEL+ADs- i +ADwAPQ- NVDIMM+AF8-FAMILY+AF8-HPE2+ADs- i+-+-)
-		if (acpi+AF8-check+AF8-dsm(adev+AF8-dimm-+AD4-handle, to+AF8-nfit+AF8-uuid(i), 1, 0))
+-		if (acpi+AF8-check+AF8-dsm(adev+AF8-dimm-+AD4-handle, to+AF8-nfit+AF8-uuid(i), 1, 1))
+AKA-			break+ADs-
+AKA-
+AKA-	/+ACo- limit the supported commands to those that are publicly documented +ACo-/
+AEAAQA- -1151,9 +-1151,10 +AEAAQA- static int acpi+AF8-nfit+AF8-add+AF8-dimm(struct acpi+AF8-nfit+AF8-desc +ACo-acpi+AF8-desc,
+AKA-		if (disable+AF8-vendor+AF8-specific)
+AKA-			dsm+AF8-mask +ACYAPQ- +AH4-(1 +ADwAPA- 8)+ADs-
+AKA-	+AH0- else +AHs-
-		dev+AF8-err(dev, +ACI-unknown dimm command family+AFw-n+ACI-)+ADs-
+-		dev+AF8-dbg(dev, +ACI-unknown dimm command family+AFw-n+ACI-)+ADs-
+AKA-		nfit+AF8-mem-+AD4-family +AD0- -1+ADs-
-		return force+AF8-enable+AF8-dimms ? 0 : -ENODEV+ADs-
+-		/+ACo- DSMs are optional, continue loading the driver... +ACo-/
+-		return 0+ADs-
+AKA-	+AH0-
+AKA-
+AKA-	uuid +AD0- to+AF8-nfit+AF8-uuid(nfit+AF8-mem-+AD4-family)+ADs-
diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index b4de130f2d57..22c09952e177 100644
--- a/drivers/acpi/utils.c
+-+-+- b/drivers/acpi/utils.c
+AEAAQA- -680,6 +-680,9 +AEAAQA- bool acpi+AF8-check+AF8-dsm(acpi+AF8-handle handle, const u8 +ACo-uuid, u64 rev, u64 funcs)
+AKA-	u64 mask +AD0- 0+ADs-
+AKA-	union acpi+AF8-object +ACo-obj+ADs-
+AKA-
+-	if (funcs +AD0APQ- 0)
+-		return false+ADs-
+-
+AKA-	obj +AD0- acpi+AF8-evaluate+AF8-dsm(handle, uuid, rev, 0, NULL)+ADs-
+AKA-	if (+ACE-obj)
+AKA-		return false+ADs-
+AEAAQA- -692,9 +-695,6 +AEAAQA- bool acpi+AF8-check+AF8-dsm(acpi+AF8-handle handle, const u8 +ACo-uuid, u64 rev, u64 funcs)
+AKA-			mask +AHwAPQ- (((u64)obj-+AD4-buffer.pointer+AFs-i+AF0-) +ADwAPA- (i +ACo- 8))+ADs-
+AKA-	ACPI+AF8-FREE(obj)+ADs-
+AKA-
-	if (funcs +AD0APQ- 0)
-		return true+ADs-
-
+AKA-	/+ACo-
+AKA-	+AKAAKg- Bit 0 indicates whether there's support for any functions other than
+AKA-	+AKAAKg- function 0 for the specified UUID and revision.