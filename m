From: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: [GIT PULL] libnvdimm for 4.6
Date: Tue, 15 Mar 2016 18:48:40 +0000
Message-ID: <1458067720.11591.17.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35690 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbcCOSsl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Mar 2016 14:48:41 -0400
Content-Language: en-US
Content-ID: <CA3EC3C74616C44084C847AF12C1C5C0@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "mingo@kernel.org" <mingo@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "toshi.kani@hpe.com" <toshi.kani@hpe.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi Linus, please pull from...

+AKA- git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-4.6

...to receive the libnvdimm update for 4.6.

This has appeared in -next with no reported issues, and a test merge
with latest master passes the regression tests. +AKA-Note that this
includes development that was based on the tip/core/resources branch
which you merged yesterday. +AKA-The post merge diffstat is cleaner than
the 6e2452dff444..libnvdimm-for-4.6 diffstat that +ACI-git request-pull+ACI-
picked.

+AKA-arch/x86/include/asm/pmem.h+AKAAoACgAKAAoACgAHwAoACgAKA-5 +-
+AKA-drivers/acpi/nfit.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoAB8- 798 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+---------------
+AKA-drivers/acpi/nfit.h+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoAB8AKAAoA-30 +--
+AKA-drivers/nvdimm/blk.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfACgAKA-18 +--
+AKA-drivers/nvdimm/btt.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfACgAKA-19 +--
+AKA-drivers/nvdimm/bus.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfA- 131 +-+-+-+-+-+-+---
+AKA-drivers/nvdimm/core.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAHw- 110 +-+-+-+-+----
+AKA-drivers/nvdimm/dimm+AF8-devs.c+AKAAoACgAKAAoACgAKAAfACgAKAAoA-6 +--
+AKA-drivers/nvdimm/namespace+AF8-devs.c+AKAAoAB8AKAAoACg-7 +-
+AKA-drivers/nvdimm/nd.h+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoAB8AKAAoACg-4 +-
+AKA-drivers/nvdimm/pfn.h+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfACgAKA-23 +--
+AKA-drivers/nvdimm/pfn+AF8-devs.c+AKAAoACgAKAAoACgAKAAoAB8AKAAoA-61 +-+-+-+-
+AKA-drivers/nvdimm/pmem.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAHw- 219 +-+-+-+-+-+-+-+-+-+-+-----
+AKA-drivers/nvdimm/region.c+AKAAoACgAKAAoACgAKAAoACgAKAAfACgAKA-12 +-
+AKA-include/linux/ioport.h+AKAAoACgAKAAoACgAKAAoACgAKAAoAB8AKAAoACg-1 +-
+AKA-include/linux/libnvdimm.h+AKAAoACgAKAAoACgAKAAoAB8AKAAoACg-5 +--
+AKA-include/linux/nd.h+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAHwAoACgAKA-7 +-
+AKA-include/linux/pmem.h+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfACgAKA-19 +-+-
+AKA-include/uapi/linux/ndctl.h+AKAAoACgAKAAoACgAKAAfACgAKA-13 +-
+AKA-kernel/resource.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfACgAKA-60 +-+-+--
+AKA-tools/testing/nvdimm/test/nfit.c +AHw- 285 +-+-+-+-+-+-+-+-+-+-+-+-+-+------
+AKA-21 files changed, 1394 insertions(+-), 439 deletions(-)

The following changes since commit 6e2452dff4441e3dc24d415c8b2cda8a3ba52116:

+AKA- nfit: Continue init even if ARS commands are unimplemented (2016-03-04 16:46:13 -0800)

are available in the git repository at:

+AKA- git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-4.6

for you to fetch changes up to 489011652a2d5555901def04c24d68874e8ba9a1:

+AKA- Merge branch 'for-4.6/pfn' into libnvdimm-for-next (2016-03-09 17:15:43 -0800)

----------------------------------------------------------------
libnvdimm for 4.6

1/ Asynchronous address range scrub:
Given the capacities of next generation persistent memory devices a
scrub operation to find all poison may take 10s of seconds.+AKAAoA-We want
this scrub work to be done asynchronously with the rest of system
initialization, so we move it out of line from the NFIT probing, i.e.
acpi+AF8-nfit+AF8-add().

2/ Clear poison:
ACPI 6.1 introduces the ability to send +ACI-clear error+ACI- commands to the
ACPI0012:00 device representing the root of an +ACI-nvdimm bus+ACI-.+AKAAoA-Similar to
relocating a bad block on a disk, this support clears media errors in
response to a write.

3/ Persistent memory resource tracking:
A persistent memory range may be designated as simply +ACI-reserved+ACI- by
platform firmware in the efi/e820 memory map.+AKAAoA-Later when the NFIT
driver loads it discovers that the range is +ACI-Persistent Memory+ACI-.+AKAAoA-The
NFIT bus driver inserts a resource to advertise that +ACI-persistent+ACI-
attribute in the system resource tree for /proc/iomem and
kernel-internal usages.

4/ Miscellaneous cleanups and fixes:
Workaround section misaligned pmem ranges when allocating a struct page
memmap, fix handling of the read-only case in the ioctl path, and clean
up block device major number allocation.

----------------------------------------------------------------
Dan Williams (18):
+AKAAoACgAKAAoACg-nfit, tools/testing/nvdimm: add format interface code definitions
+AKAAoACgAKAAoACg-nfit, tools/testing/nvdimm: test multiple control regions per-dimm
+AKAAoACgAKAAoACg-libnvdimm, nfit: centralize command status translation
+AKAAoACgAKAAoACg-libnvdimm: protect nvdimm+AF8Aew-bus+AHw-namespace+AH0AXw-add+AF8-poison() with nvdimm+AF8-bus+AF8-lock()
+AKAAoACgAKAAoACg-libnvdimm: async notification support
+AKAAoACgAKAAoACg-nfit, tools/testing/nvdimm: unify common init for acpi+AF8-nfit+AF8-desc
+AKAAoACgAKAAoACg-nfit, libnvdimm: async region scrub workqueue
+AKAAoACgAKAAoACg-nfit: scrub and register regions in a workqueue
+AKAAoACgAKAAoACg-nfit: disable userspace initiated ars during scrub
+AKAAoACgAKAAoACg-tools/testing/nvdimm: expand ars unit testing
+AKAAoACgAKAAoACg-libnvdimm, pmem: fix 'pfn' support for section-misaligned namespaces
+AKAAoACgAKAAoACg-libnvdimm, pmem: adjust for section collisions with 'System RAM'
+AKAAoACgAKAAoACg-libnvdimm, pfn: 'resource'-address and 'size' attributes for pfn devices
+AKAAoACgAKAAoACg-nfit, libnvdimm: clear poison command support
+AKAAoACgAKAAoACg-libnvdimm, pmem: fix ia64 build, use PHYS+AF8-PFN
+AKAAoACgAKAAoACg-libnvdimm, pmem: fix kmap+AF8-atomic() leak in error path
+AKAAoACgAKAAoACg-libnvdimm, pmem: clear poison on write
+AKAAoACgAKAAoACg-Merge branch 'for-4.6/pfn' into libnvdimm-for-next

Jerry Hoemann (2):
+AKAAoACgAKAAoACg-libnvdimm: Clean-up access mode check.
+AKAAoACgAKAAoACg-libnvdimm: Fix security issue with DSM IOCTL.

NeilBrown (3):
+AKAAoACgAKAAoACg-pmem: don't allocate unused major device number
+AKAAoACgAKAAoACg-nvdimm/blk: don't allocate unused major device number
+AKAAoACgAKAAoACg-nvdimm/btt: don't allocate unused major device number

Toshi Kani (4):
+AKAAoACgAKAAoACg-resource: Change +AF8AXw-request+AF8-region to inherit from immediate parent
+AKAAoACgAKAAoACg-resource: Add remove+AF8-resource interface
+AKAAoACgAKAAoACg-resource: Export insert+AF8-resource and remove+AF8-resource
+AKAAoACgAKAAoACg-ACPI: Change NFIT driver to insert new resource

+AKA-arch/arm/kernel/setup.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAHwAoACgAKA-6 +--
+AKA-arch/arm/plat-samsung/pm-check.c+AKAAoACgAHwAoACgAKA-4 +--
+AKA-arch/arm64/kernel/setup.c+AKAAoACgAKAAoACgAKAAoACgAKAAfACgAKAAoA-6 +--
+AKA-arch/avr32/kernel/setup.c+AKAAoACgAKAAoACgAKAAoACgAKAAfACgAKAAoA-6 +--
+AKA-arch/ia64/kernel/efi.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfACgAKA-13 +--
+AKA-arch/ia64/kernel/setup.c+AKAAoACgAKAAoACgAKAAoACgAKAAoAB8AKAAoACg-6 +--
+AKA-arch/m32r/kernel/setup.c+AKAAoACgAKAAoACgAKAAoACgAKAAoAB8AKAAoACg-4 +--
+AKA-arch/mips/kernel/setup.c+AKAAoACgAKAAoACgAKAAoACgAKAAoAB8AKAAoA-10 +--
+AKA-arch/parisc/mm/init.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoAB8AKAAoACg-6 +--
+AKA-arch/powerpc/mm/mem.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoAB8AKAAoACg-2 +--
+AKA-arch/s390/kernel/setup.c+AKAAoACgAKAAoACgAKAAoACgAKAAoAB8AKAAoACg-8 +--
+AKA-arch/score/kernel/setup.c+AKAAoACgAKAAoACgAKAAoACgAKAAfACgAKAAoA-2 +--
+AKA-arch/sh/kernel/setup.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfACgAKAAoA-8 +--
+AKA-arch/sparc/mm/init+AF8-64.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAHwAoACgAKA-8 +--
+AKA-arch/tile/kernel/setup.c+AKAAoACgAKAAoACgAKAAoACgAKAAoAB8AKAAoA-11 +--
+AKA-arch/unicore32/kernel/setup.c+AKAAoACgAKAAoACgAHwAoACgAKA-6 +--
+AKA-arch/x86/include/asm/pmem.h+AKAAoACgAKAAoACgAKAAoAB8AKAAoACg-5 +-
+AKA-arch/x86/kernel/crash.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAHwAoACg-41 +--
+AKA-arch/x86/kernel/e820.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfACgAKA-38 +--
+AKA-arch/x86/kernel/pmem.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfACgAKAAoA-4 +--
+AKA-arch/x86/kernel/setup.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAHwAoACgAKA-6 +--
+AKA-drivers/acpi/acpi+AF8-platform.c+AKAAoACgAKAAoACgAKAAfACgAKAAoA-2 +--
+AKA-drivers/acpi/apei/einj.c+AKAAoACgAKAAoACgAKAAoACgAKAAoAB8AKAAoA-15 +--
+AKA-drivers/acpi/nfit.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfA- 798 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-----------
+AKA-drivers/acpi/nfit.h+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfACgAKA-30 +--
+AKA-drivers/nvdimm/blk.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAHwAoACg-18 +--
+AKA-drivers/nvdimm/btt.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAHwAoACg-19 +--
+AKA-drivers/nvdimm/bus.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAHw- 131 +-+-+-+-+--
+AKA-drivers/nvdimm/core.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoAB8- 110 +-+-+---
+AKA-drivers/nvdimm/dimm+AF8-devs.c+AKAAoACgAKAAoACgAKAAoACgAHwAoACgAKA-6 +--
+AKA-drivers/nvdimm/e820.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoAB8AKAAoACg-2 +--
+AKA-drivers/nvdimm/namespace+AF8-devs.c+AKAAoACgAKAAfACgAKAAoA-7 +-
+AKA-drivers/nvdimm/nd.h+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfACgAKAAoA-4 +-
+AKA-drivers/nvdimm/pfn.h+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAHwAoACg-23 +--
+AKA-drivers/nvdimm/pfn+AF8-devs.c+AKAAoACgAKAAoACgAKAAoACgAKAAfACgAKA-61 +-+-+-
+AKA-drivers/nvdimm/pmem.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoAB8- 219 +-+-+-+-+-+-+----
+AKA-drivers/nvdimm/region.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAHwAoACg-12 +-
+AKA-drivers/parisc/eisa+AF8-enumerator.c+AKAAoACgAHwAoACgAKA-4 +--
+AKA-drivers/rapidio/rio.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoAB8AKAAoACg-8 +--
+AKA-drivers/sh/superhyway/superhyway.c +AHwAoACgAKA-2 +--
+AKA-drivers/xen/balloon.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoAB8AKAAoACg-2 +--
+AKA-include/linux/ioport.h+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfACgAKA-34 +--
+AKA-include/linux/libnvdimm.h+AKAAoACgAKAAoACgAKAAoACgAKAAfACgAKAAoA-5 +--
+AKA-include/linux/mm.h+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoAB8AKAAoACg-3 +--
+AKA-include/linux/nd.h+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoAB8AKAAoACg-7 +-
+AKA-include/linux/pmem.h+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAHwAoACg-19 +-
+AKA-include/uapi/linux/ndctl.h+AKAAoACgAKAAoACgAKAAoACgAHwAoACg-13 +-
+AKA-kernel/kexec+AF8-core.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfACgAKAAoA-8 +--
+AKA-kernel/kexec+AF8-file.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfACgAKAAoA-8 +--
+AKA-kernel/memremap.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAHwAoACg-13 +--
+AKA-kernel/resource.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAHw- 149 +-+-+-+-+---
+AKA-mm/memory+AF8-hotplug.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfACgAKAAoA-2 +--
+AKA-tools/testing/nvdimm/test/nfit.c+AKAAoACgAHw- 285 +-+-+-+-+-+-+-+-+-+----
+AKA-53 files changed, 1623 insertions(+-), 596 deletions(-)