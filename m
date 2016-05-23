From: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: [GIT PULL] libnvdimm for 4.7
Date: Mon, 23 May 2016 00:01:14 +0000
Message-ID: <1463961667.16105.17.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44304 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752623AbcEWABR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 22 May 2016 20:01:17 -0400
Content-Language: en-US
Content-ID: <5359A05357EAF24798623025949F5B77@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi Linus, please pull from:

+AKA- git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-4.7

...to receive the device driver related nvdimm topic branches for 4.7.

The bulk of this update was stabilized before the merge window and
appeared in -next. +AKA-The +ACI-device dax+ACI- implementation was revised this
week in response to review feedback, and to address failures detected
by the recently expanded ndctl unit test suite.

Not included in this pull request are two dax topic branches (dax error
handling, and dax radix-tree locking). +AKA-These topics were deferred to
get a few more days of -next integration testing, and to coordinate a
branch baseline with Ted and the ext4 tree. +AKA-Vishal and Ross will send
the error handling and locking topics respectively in the next few
days.

This branch has received a positive build result from the kbuild robot
across 226 configs.

The following changes since commit 1b8d2afde54fade94339f573c4e05644f9ae9866:

+AKA- libnvdimm, pfn: fix ARCH+AD0-alpha allmodconfig build failure (2016-05-06 10:20:10 -0700)

are available in the git repository at:

+AKA- git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-4.7

for you to fetch changes up to 36092ee8ba695fce023b2118ececa6c2a56b1331:

+AKA- Merge branch 'for-4.7/dax' into libnvdimm-for-next (2016-05-21 12:33:04 -0700)

----------------------------------------------------------------
libnvdimm for 4.7

1/ Device DAX for persistent memory:
+AKAAoACg-Device DAX is the device-centric analogue of Filesystem DAX
+AKAAoACg-(CONFIG+AF8-FS+AF8-DAX).+AKAAoA-It allows memory ranges to be allocated and mapped
+AKAAoACg-without need of an intervening file system.+AKAAoA-Device DAX is strict,
+AKAAoACg-precise and predictable.+AKAAoA-Specifically this interface:

+AKAAoACg-a) Guarantees fault granularity with respect to a given page size
+AKAAoACgAKAAoACg-(pte, pmd, or pud) set at configuration time.

+AKAAoACg-b) Enforces deterministic behavior by being strict about what fault
+AKAAoACgAKAAoACg-scenarios are supported.

+AKAAoACg-Persistent memory is the first target, but the mechanism is also
+AKAAoACg-targeted for exclusive allocations of performance/feature differentiated
+AKAAoACg-memory ranges.

2/ Support for the HPE DSM (device specific method) command formats.
+AKAAoACg-This enables management of these first generation devices until a
+AKAAoACg-unified DSM specification materializes.

3/ Further ACPI 6.1 compliance with support for the common dimm
+AKAAoACg-identifier format.

4/ Various fixes and cleanups across the subsystem.

----------------------------------------------------------------
Dan Williams (40):
+AKAAoACgAKAAoACg-libnvdimm, nfit: report multiple interface codes per-dimm
+AKAAoACgAKAAoACg-libnvdimm, test: add mock SMART data payload
+AKAAoACgAKAAoACg-libnvdimm, pmem: kill pmem-+AD4-ndns
+AKAAoACgAKAAoACg-libnvdimm, pfn, convert nd+AF8-pfn+AF8-probe() to devm
+AKAAoACgAKAAoACg-libnvdimm, btt, convert nd+AF8-btt+AF8-probe() to devm
+AKAAoACgAKAAoACg-libnvdimm, btt: add btt startup debug
+AKAAoACgAKAAoACg-libnvdimm, blk: use devm+AF8-add+AF8-action to release bdev resources
+AKAAoACgAKAAoACg-libnvdimm, blk: use -+AD4-queuedata for driver private data
+AKAAoACgAKAAoACg-libnvdimm, pmem: use -+AD4-queuedata for driver private data
+AKAAoACgAKAAoACg-libnvdimm, blk: quiet i/o error reporting
+AKAAoACgAKAAoACg-libnvdimm, blk: move i/o infrastructure to nd+AF8-namespace+AF8-blk
+AKAAoACgAKAAoACg-libnvdimm, pmem: use devm+AF8-add+AF8-action to release bdev resources
+AKAAoACgAKAAoACg-libnvdimm, pmem: clean up resource print / request
+AKAAoACgAKAAoACg-libnvdimm, pmem, pfn: make pmem+AF8-rw+AF8-bytes generic and refactor pfn setup
+AKAAoACgAKAAoACg-libnvdimm, pmem, pfn: move pfn setup to the core
+AKAAoACgAKAAoACg-libnvdimm, pmem: kill -+AD4-pmem+AF8-queue and -+AD4-pmem+AF8-disk
+AKAAoACgAKAAoACg-libnvdimm: cleanup nvdimm+AF8-namespace+AF8-common+AF8-probe(), kill 'host'
+AKAAoACgAKAAoACg-nfit, libnvdimm: clarify +ACI-commands+ACI- vs +ACIAXw-DSMs+ACI-
+AKAAoACgAKAAoACg-nfit, libnvdimm: limited/whitelisted dimm command marshaling mechanism
+AKAAoACgAKAAoACg-nfit: fix format interface code byte order per ACPI6.1
+AKAAoACgAKAAoACg-nfit: export subsystem ids as attributes
+AKAAoACgAKAAoACg-nfit: disable vendor specific commands
+AKAAoACgAKAAoACg-tools/testing/nvdimm: ND+AF8-CMD+AF8-CALL support
+AKAAoACgAKAAoACg-nfit: add sysfs dimm 'family' and 'dsm+AF8-mask' attributes
+AKAAoACgAKAAoACg-libnvdimm, dax: introduce device-dax infrastructure
+AKAAoACgAKAAoACg-libnvdimm, dax: reserve space to store labels for device-dax
+AKAAoACgAKAAoACg-libnvdimm, dax: record the specified alignment of a dax-device instance
+AKAAoACgAKAAoACg-libnvdimm: stop requiring a driver -+AD4-remove() method
+AKAAoACgAKAAoACg-Merge branch 'for-4.7/dax' into libnvdimm-for-next
+AKAAoACgAKAAoACg-Merge branch 'for-4.7/libnvdimm' into libnvdimm-for-next
+AKAAoACgAKAAoACg-Merge branch 'for-4.7/dsm' into libnvdimm-for-next
+AKAAoACgAKAAoACg-Merge branch 'for-4.7/acpi6.1' into libnvdimm-for-next
+AKAAoACgAKAAoACg-/dev/dax, pmem: direct access to persistent memory
+AKAAoACgAKAAoACg-/dev/dax, core: file operations and dax-mmap
+AKAAoACgAKAAoACg-Revert +ACI-block: enable dax for raw block devices+ACI-
+AKAAoACgAKAAoACg-libnvdimm: release ida resources
+AKAAoACgAKAAoACg-libnvdimm, dax: autodetect support
+AKAAoACgAKAAoACg-libnvdimm, dax: fix alignment validation
+AKAAoACgAKAAoACg-libnvdimm, dax: fix deletion
+AKAAoACgAKAAoACg-Merge branch 'for-4.7/dax' into libnvdimm-for-next

Jerry Hoemann (2):
+AKAAoACgAKAAoACg-acpi: widen acpi+AF8-evaluate+AF8-dsm() revision and function-index arguments
+AKAAoACgAKAAoACg-libnvdimm: increase max envelope size for ioctl

Lee, Chun-Yi (1):
+AKAAoACgAKAAoACg-libnvdimm, nfit: Use ACPI+AF8-SIG+AF8-NFIT instead of hard coded string

Toshi Kani (2):
+AKAAoACgAKAAoACg-acpi/nfit: Update nfit driver to comply with ACPI 6.1
+AKAAoACgAKAAoACg-acpi/nfit: Add sysfs +ACI-id+ACI- for NVDIMM ID

+AKA-block/ioctl.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoAB8AKAAoA-32 ---
+AKA-drivers/Kconfig+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAHwAoACgAKA-2 +-
+AKA-drivers/Makefile+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoAB8AKAAoACg-1 +-
+AKA-drivers/acpi/nfit.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoAB8- 282 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+----
+AKA-drivers/acpi/nfit.h+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoAB8AKAAoA-31 +-+--
+AKA-drivers/acpi/utils.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfACgAKAAoA-4 +--
+AKA-drivers/dax/Kconfig+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoAB8AKAAoA-26 +-+-+-
+AKA-drivers/dax/Makefile+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfACgAKAAoA-4 +-
+AKA-drivers/dax/dax.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfA- 575 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
+AKA-drivers/dax/dax.h+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfACgAKA-24 +-+-+-
+AKA-drivers/dax/pmem.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAHw- 158 +-+-+-+-+-+-+-+-+-+-+-+-+-+-
+AKA-drivers/nvdimm/Kconfig+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoAB8AKAAoA-13 +-+-
+AKA-drivers/nvdimm/Makefile+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfACgAKAAoA-1 +-
+AKA-drivers/nvdimm/blk.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfA- 208 +-+-+-+-+-+-+-+-+----------
+AKA-drivers/nvdimm/btt.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfACgAKA-26 +-+--
+AKA-drivers/nvdimm/btt+AF8-devs.c+AKAAoACgAKAAoACgAKAAoACgAKAAoAB8AKAAoA-24 +---
+AKA-drivers/nvdimm/bus.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfACgAKA-63 +-+-+-+-+--
+AKA-drivers/nvdimm/claim.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoAB8AKAAoA-86 +-+-+-+-+-+-+--
+AKA-drivers/nvdimm/core.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAHwAoACgAKA-5 +--
+AKA-drivers/nvdimm/dax+AF8-devs.c+AKAAoACgAKAAoACgAKAAoACgAKAAoAB8- 134 +-+-+-+-+-+-+-+-+-+-+-+-
+AKA-drivers/nvdimm/dimm+AF8-devs.c+AKAAoACgAKAAoACgAKAAoACgAKAAfACgAKA-23 +--
+AKA-drivers/nvdimm/namespace+AF8-devs.c+AKAAoACgAKAAoAB8AKAAoA-38 +-+---
+AKA-drivers/nvdimm/nd-core.h+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAHwAoACgAKA-6 +--
+AKA-drivers/nvdimm/nd.h+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoAB8AKAAoA-83 +-+-+-+-+-+-+--
+AKA-drivers/nvdimm/pfn.h+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfACgAKAAoA-5 +--
+AKA-drivers/nvdimm/pfn+AF8-devs.c+AKAAoACgAKAAoACgAKAAoACgAKAAoAB8- 315 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+------
+AKA-drivers/nvdimm/pmem.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAHw- 493 +-+-+-+-+-+-+-+-+-+----------------------------------
+AKA-drivers/nvdimm/region.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfACgAKAAoA-2 +-
+AKA-drivers/nvdimm/region+AF8-devs.c+AKAAoACgAKAAoACgAKAAoAB8AKAAoA-34 +-+-+-
+AKA-fs/block+AF8-dev.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfACgAKA-96 +-+-+-------
+AKA-include/acpi/acpi+AF8-bus.h+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfACgAKAAoA-6 +--
+AKA-include/linux/fs.h+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAHwAoACgAKA-8 -
+AKA-include/linux/libnvdimm.h+AKAAoACgAKAAoACgAKAAoACgAKAAoAB8AKAAoACg-7 +--
+AKA-include/linux/nd.h+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAHwAoACg-11 +--
+AKA-include/uapi/linux/fs.h+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfACgAKAAoA-1 -
+AKA-include/uapi/linux/ndctl.h+AKAAoACgAKAAoACgAKAAoACgAKAAfACgAKA-80 +-+-+-+-+-+--
+AKA-mm/huge+AF8-memory.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoAB8AKAAoACg-1 +-
+AKA-mm/hugetlb.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAHwAoACgAKA-1 +-
+AKA-tools/testing/nvdimm/Kbuild+AKAAoACgAKAAoACgAKAAoACgAHwAoACg-11 +-
+AKA-tools/testing/nvdimm/config+AF8-check.c +AHwAoACgAKA-2 +-
+AKA-tools/testing/nvdimm/test/iomap.c+AKAAoACgAHwAoACg-27 +-+--
+AKA-tools/testing/nvdimm/test/nfit.c+AKAAoACgAKAAfACgAKA-90 +-+-+-+-+-+---
+AKA-42 files changed, 2252 insertions(+-), 787 deletions(-)