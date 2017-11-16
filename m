From: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: [GIT PULL] libnvdimm for 4.15
Date: Thu, 16 Nov 2017 22:12:06 +0000
Message-ID: <1510870318.21471.1.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:3712 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934119AbdKPWMJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 Nov 2017 17:12:09 -0500
Content-Language: en-US
Content-ID: <27B6A8EF285ED5469889A7E658CD8BD0@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-4.15

...to receive the libnvdimm and dax update for 4.15.

Save for a few late fixes, all of these commits have shipped in -next
releases since before the merge window opened, and 0day has given a
build success notification. The MAP+AF8-SYNC work included some re-
factoring of dax+AF8-insert+AF8-mapping(), to break out a common
dax+AF8-iomap+AF8-pfn() helper, that collided with other small changes in
fs/dax.c. A suggested merge resolution for that collision and a few
other minor collisions is included below after the diffstat.

The ext4 touches came from Jan, and the xfs touches have Darrick's
reviewed-by. An xfstest for the MAP+AF8-SYNC feature +AFs-1+AF0- has been through a
few round of reviews and is on track to be merged. The final policy of
how MAP+AF8-SHARED+AF8-VALIDATE and MAP+AF8-SYNC flags behave was discussed by you
and Jan here: +AFs-2+AF0-.

+AFs-1+AF0-: https://lists.01.org/pipermail/linux-nvdimm/2017-October/012974.ht
ml
+AFs-2+AF0-: https://lists.01.org/pipermail/linux-nvdimm/2017-October/012894.ht
ml

---

The following changes since commit 8a5776a5f49812d29fe4b2d0a2d71675c3facf3f:

  Linux 4.14-rc4 (2017-10-08 20:53:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-4.15

for you to fetch changes up to 4247f24c23589bcc3bc3490515ef8c9497e9ae55:

  Merge branch 'for-4.15/dax' into libnvdimm-for-next (2017-11-15 16:56:11 -0800)

----------------------------------------------------------------
libnvdimm for 4.15

+ACo- Introduce MAP+AF8-SYNC and MAP+AF8-SHARED+AF8-VALIDATE, a mechanism to enable
 'userspace flush' of persistent memory updates via filesystem-dax
  mappings. It arranges for any filesystem metadata updates that may be
  required to satisfy a write fault to also be flushed (+ACI-on disk+ACI-) before
  the kernel returns to userspace from the fault handler. Effectively
  every write-fault that dirties metadata completes an fsync() before
  returning from the fault handler. The new MAP+AF8-SHARED+AF8-VALIDATE mapping
  type guarantees that the MAP+AF8-SYNC flag is validated as supported by the
  filesystem's -+AD4-mmap() file operation.

+ACo- Add support for the standard ACPI 6.2 label access methods that
  replace the NVDIMM+AF8-FAMILY+AF8-INTEL (vendor specific) label methods. This
  enables interoperability with environments that only implement the
  standardized methods.

+ACo- Add support for the ACPI 6.2 NVDIMM media error injection methods.

+ACo- Add support for the NVDIMM+AF8-FAMILY+AF8-INTEL v1.6 DIMM commands for latch
  last shutdown status, firmware update, SMART error injection, and
  SMART alarm threshold control.

+ACo- Cleanup physical address information disclosures to be root-only.

+ACo- Fix revalidation of the DIMM +ACI-locked label area+ACI- status to support
  dynamic unlock of the label area.

+ACo- Expand unit test infrastructure to mock the ACPI 6.2 Translate SPA
  (system-physical-address) command and error injection commands.

Acknowledgements that came after the commits were pushed to -next:

957ac8c421ad dax: fix PMD faults on zero-length files
Reviewed-by: Ross Zwisler +ADw-ross.zwisler+AEA-linux.intel.com+AD4-

a39e596baa07 xfs: support for synchronous DAX faults
Reviewed-by: Darrick J. Wong +ADw-darrick.wong+AEA-oracle.com+AD4-

7b565c9f965b xfs: Implement xfs+AF8-filemap+AF8-pfn+AF8-mkwrite() using +AF8AXw-xfs+AF8-filemap+AF8-fault()
Reviewed-by: Darrick J. Wong +ADw-darrick.wong+AEA-oracle.com+AD4-

----------------------------------------------------------------
Arvind Yadav (1):
      dax: pr+AF8-err() strings should end with newlines

Christoph Hellwig (1):
      xfs: support for synchronous DAX faults

Colin Ian King (1):
      libnvdimm, namespace: make a couple of functions static

Dan Williams (18):
      libnvdimm, dimm: clear 'locked' status on successful DIMM enable
      libnvdimm, region : make 'resource' attribute only readable by root
      libnvdimm, namespace: make 'resource' attribute only readable by root
      libnvdimm, pfn: make 'resource' attribute only readable by root
      libnvdimm, namespace: fix label initialization to use valid seq numbers
      acpi, nfit: add support for the +AF8-LSI, +AF8-LSR, and +AF8-LSW label methods
      libnvdimm: introduce 'flags' attribute for DIMM 'lock' and 'alias' status
      acpi, nfit: hide unknown commands from nmemX/commands
      acpi, nfit: add support for NVDIMM+AF8-FAMILY+AF8-INTEL v1.6 DSMs
      mm: introduce MAP+AF8-SHARED+AF8-VALIDATE, a mechanism to safely define new mmap flags
      acpi, nfit: validate commands against the device type
      tools/testing/nvdimm: unit test clear-error commands
      fs, dax: unify IOMAP+AF8-F+AF8-DIRTY read vs write handling policy in the dax core
      dax: quiet bdev+AF8-dax+AF8-supported()
      brd: remove dax support
      dax: stop requiring a live device for dax+AF8-flush()
      acpi, nfit: add 'Enable Latch System Shutdown Status' command support
      Merge branch 'for-4.15/dax' into libnvdimm-for-next

Dave Jiang (2):
      libnvdimm: move poison list functions to a new 'badrange' file
      nfit+AF8-test: add error injection DSMs

Jan Kara (17):
      mm: Handle 0 flags in +AF8-calc+AF8-vm+AF8-trans() macro
      mm: Remove VM+AF8-FAULT+AF8-HWPOISON+AF8-LARGE+AF8-MASK
      dax: Simplify arguments of dax+AF8-insert+AF8-mapping()
      dax: Factor out getting of pfn out of iomap
      dax: Create local variable for VMA in dax+AF8-iomap+AF8-pte+AF8-fault()
      dax: Create local variable for vmf-+AD4-flags +ACY- FAULT+AF8-FLAG+AF8-WRITE test
      dax: Inline dax+AF8-insert+AF8-mapping() into the callsite
      dax: Inline dax+AF8-pmd+AF8-insert+AF8-mapping() into the callsite
      dax: Fix comment describing dax+AF8-iomap+AF8-fault()
      dax: Allow dax+AF8-iomap+AF8-fault() to return pfn
      dax: Allow tuning whether dax+AF8-insert+AF8-mapping+AF8-entry() dirties entry
      mm: Define MAP+AF8-SYNC and VM+AF8-SYNC flags
      dax, iomap: Add support for synchronous faults
      dax: Implement dax+AF8-finish+AF8-sync+AF8-fault()
      ext4: Simplify error handling in ext4+AF8-dax+AF8-huge+AF8-fault()
      ext4: Support for synchronous DAX faults
      xfs: Implement xfs+AF8-filemap+AF8-pfn+AF8-mkwrite() using +AF8AXw-xfs+AF8-filemap+AF8-fault()

Jeff Moyer (1):
      dax: fix PMD faults on zero-length files

Mikulas Patocka (1):
      dax: fix general protection fault in dax+AF8-alloc+AF8-inode

Ross Zwisler (2):
      MAINTAINERS: Add entry for device DAX
      dev/dax: fix uninitialized variable build warning

Vishal Verma (3):
      libnvdimm, badrange: remove a WARN for list+AF8-empty
      nfit+AF8-test: when clearing poison, also remove badrange entries
      tools/testing/nvdimm: stricter bounds checking for error injection commands

Yasunori Goto (3):
      nfit+AF8-test Make private definitions to command emulation
      acpi nfit: Enable to show what feature is supported via ND+AF8-CMD+AF8-CALL for nfit+AF8-test
      acpi nfit: nfit+AF8-test supports translate SPA

 MAINTAINERS                                  +AHw-   8 +--
 arch/alpha/include/uapi/asm/mman.h           +AHw-   1 +-
 arch/mips/include/uapi/asm/mman.h            +AHw-   1 +-
 arch/parisc/include/uapi/asm/mman.h          +AHw-   1 +-
 arch/xtensa/include/uapi/asm/mman.h          +AHw-   1 +-
 drivers/acpi/nfit/core.c                     +AHw- 274 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+--
 drivers/acpi/nfit/mce.c                      +AHw-   2 +--
 drivers/acpi/nfit/nfit.h                     +AHw-  37 +-+-+--
 drivers/block/Kconfig                        +AHw-  12 -
 drivers/block/brd.c                          +AHw-  65 ------
 drivers/dax/device.c                         +AHw-   3 +--
 drivers/dax/super.c                          +AHw-  14 +--
 drivers/nvdimm/Makefile                      +AHw-   1 +-
 drivers/nvdimm/badrange.c                    +AHw- 293 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
 drivers/nvdimm/bus.c                         +AHw-  24 +--
 drivers/nvdimm/core.c                        +AHw- 260 +----------------------
 drivers/nvdimm/dimm.c                        +AHw-   3 +-
 drivers/nvdimm/dimm+AF8-devs.c                   +AHw-  19 +-+-
 drivers/nvdimm/label.c                       +AHw-   2 +--
 drivers/nvdimm/namespace+AF8-devs.c              +AHw-   6 +--
 drivers/nvdimm/nd-core.h                     +AHw-   3 +--
 drivers/nvdimm/nd.h                          +AHw-   7 +--
 drivers/nvdimm/pfn+AF8-devs.c                    +AHw-   8 +-
 drivers/nvdimm/region+AF8-devs.c                 +AHw-   8 +--
 fs/dax.c                                     +AHw- 319 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+----------
 fs/ext2/file.c                               +AHw-   2 +--
 fs/ext4/file.c                               +AHw-  26 +-+--
 fs/ext4/inode.c                              +AHw-  15 +-+-
 fs/jbd2/journal.c                            +AHw-  17 +-+-
 fs/proc/task+AF8-mmu.c                           +AHw-   1 +-
 fs/xfs/xfs+AF8-file.c                            +AHw-  44 +-+---
 fs/xfs/xfs+AF8-iomap.c                           +AHw-   5 +-
 fs/xfs/xfs+AF8-trace.h                           +AHw-   2 -
 include/linux/dax.h                          +AHw-   4 +--
 include/linux/fs.h                           +AHw-   1 +-
 include/linux/iomap.h                        +AHw-   5 +-
 include/linux/jbd2.h                         +AHw-   1 +-
 include/linux/libnvdimm.h                    +AHw-  21 +--
 include/linux/mm.h                           +AHw-   9 +--
 include/linux/mman.h                         +AHw-  48 +-+-+--
 include/trace/events/fs+AF8-dax.h                +AHw-   3 +--
 include/uapi/asm-generic/mman-common.h       +AHw-   1 +-
 include/uapi/asm-generic/mman.h              +AHw-   1 +-
 mm/mmap.c                                    +AHw-  15 +-+-
 tools/include/uapi/asm-generic/mman-common.h +AHw-   1 +-
 tools/testing/nvdimm/Kbuild                  +AHw-   1 +-
 tools/testing/nvdimm/test/nfit.c             +AHw- 319 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+----
 tools/testing/nvdimm/test/nfit+AF8-test.h        +AHw-  52 +-+-+-+-+-
 48 files changed, 1406 insertions(+-), 560 deletions(-)
 create mode 100644 drivers/nvdimm/badrange.c

---

commit 82f3359eb04e3a3b5d23655eee58d31a1b17c902
Merge: 18c83d2c0390 4247f24c2358
Author: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-
Date:   Thu Nov 16 13:20:35 2017 -0800

    Merge branch 'libnvdimm-for-next' into test

diff --cc drivers/block/brd.c
index 588360d79fca,b2391bbd7e5a..8028a3a7e7fd
--- a/drivers/block/brd.c
+-+-+- b/drivers/block/brd.c
+AEAAQABA- -20,12 -20,6 +-20,7 +AEAAQABA-
  +ACM-include +ADw-linux/radix-tree.h+AD4-
  +ACM-include +ADw-linux/fs.h+AD4-
  +ACM-include +ADw-linux/slab.h+AD4-
 +-+ACM-include +ADw-linux/backing-dev.h+AD4-
- +ACM-ifdef CONFIG+AF8-BLK+AF8-DEV+AF8-RAM+AF8-DAX
- +ACM-include +ADw-linux/pfn+AF8-t.h+AD4-
- +ACM-include +ADw-linux/dax.h+AD4-
- +ACM-include +ADw-linux/uio.h+AD4-
- +ACM-endif
  
  +ACM-include +ADw-linux/uaccess.h+AD4-
  
+AEAAQABA- -449,23 -401,9 +-401,10 +AEAAQABA- static struct brd+AF8-device +ACo-brd+AF8-alloc(in
  	disk-+AD4-flags		+AD0- GENHD+AF8-FL+AF8-EXT+AF8-DEVT+ADs-
  	sprintf(disk-+AD4-disk+AF8-name, +ACI-ram+ACU-d+ACI-, i)+ADs-
  	set+AF8-capacity(disk, rd+AF8-size +ACo- 2)+ADs-
 +-	disk-+AD4-queue-+AD4-backing+AF8-dev+AF8-info-+AD4-capabilities +AHwAPQ- BDI+AF8-CAP+AF8-SYNCHRONOUS+AF8-IO+ADs-
  
- +ACM-ifdef CONFIG+AF8-BLK+AF8-DEV+AF8-RAM+AF8-DAX
- 	queue+AF8-flag+AF8-set+AF8-unlocked(QUEUE+AF8-FLAG+AF8-DAX, brd-+AD4-brd+AF8-queue)+ADs-
- 	brd-+AD4-dax+AF8-dev +AD0- alloc+AF8-dax(brd, disk-+AD4-disk+AF8-name, +ACY-brd+AF8-dax+AF8-ops)+ADs-
- 	if (+ACE-brd-+AD4-dax+AF8-dev)
- 		goto out+AF8-free+AF8-inode+ADs-
- +ACM-endif
- 
- 
  	return brd+ADs-
  
- +ACM-ifdef CONFIG+AF8-BLK+AF8-DEV+AF8-RAM+AF8-DAX
- out+AF8-free+AF8-inode:
- 	kill+AF8-dax(brd-+AD4-dax+AF8-dev)+ADs-
- 	put+AF8-dax(brd-+AD4-dax+AF8-dev)+ADs-
- +ACM-endif
  out+AF8-free+AF8-queue:
  	blk+AF8-cleanup+AF8-queue(brd-+AD4-brd+AF8-queue)+ADs-
  out+AF8-free+AF8-dev:
diff --cc fs/dax.c
index 3652b26a0048,f757cd0e2d07..95981591977a
--- a/fs/dax.c
+-+-+- b/fs/dax.c
+AEAAQABA- -825,38 -820,42 +-825,42 +AEAAQABA- out
  +AH0-
  EXPORT+AF8-SYMBOL+AF8-GPL(dax+AF8-writeback+AF8-mapping+AF8-range)+ADs-
  
- static int dax+AF8-insert+AF8-mapping(struct address+AF8-space +ACo-mapping,
- 		struct block+AF8-device +ACo-bdev, struct dax+AF8-device +ACo-dax+AF8-dev,
- 		sector+AF8-t sector, size+AF8-t size, void +ACo-entry,
- 		struct vm+AF8-area+AF8-struct +ACo-vma, struct vm+AF8-fault +ACo-vmf)
+- static sector+AF8-t dax+AF8-iomap+AF8-sector(struct iomap +ACo-iomap, loff+AF8-t pos)
  +AHs-
- 	unsigned long vaddr +AD0- vmf-+AD4-address+ADs-
- 	void +ACo-ret, +ACo-kaddr+ADs-
 -	return iomap-+AD4-blkno +- (((pos +ACY- PAGE+AF8-MASK) - iomap-+AD4-offset) +AD4APg- 9)+ADs-
+-+-	return (iomap-+AD4-addr +- (pos +ACY- PAGE+AF8-MASK) - iomap-+AD4-offset) +AD4APg- 9+ADs-
+- +AH0-
+- 
+- static int dax+AF8-iomap+AF8-pfn(struct iomap +ACo-iomap, loff+AF8-t pos, size+AF8-t size,
+- 			 pfn+AF8-t +ACo-pfnp)
+- +AHs-
+- 	const sector+AF8-t sector +AD0- dax+AF8-iomap+AF8-sector(iomap, pos)+ADs-
  	pgoff+AF8-t pgoff+ADs-
+- 	void +ACo-kaddr+ADs-
  	int id, rc+ADs-
- 	pfn+AF8-t pfn+ADs-
+- 	long length+ADs-
  
- 	rc +AD0- bdev+AF8-dax+AF8-pgoff(bdev, sector, size, +ACY-pgoff)+ADs-
+- 	rc +AD0- bdev+AF8-dax+AF8-pgoff(iomap-+AD4-bdev, sector, size, +ACY-pgoff)+ADs-
  	if (rc)
  		return rc+ADs-
- 
  	id +AD0- dax+AF8-read+AF8-lock()+ADs-
- 	rc +AD0- dax+AF8-direct+AF8-access(dax+AF8-dev, pgoff, PHYS+AF8-PFN(size), +ACY-kaddr, +ACY-pfn)+ADs-
- 	if (rc +ADw- 0) +AHs-
- 		dax+AF8-read+AF8-unlock(id)+ADs-
- 		return rc+ADs-
+- 	length +AD0- dax+AF8-direct+AF8-access(iomap-+AD4-dax+AF8-dev, pgoff, PHYS+AF8-PFN(size),
+- 				   +ACY-kaddr, pfnp)+ADs-
+- 	if (length +ADw- 0) +AHs-
+- 		rc +AD0- length+ADs-
+- 		goto out+ADs-
  	+AH0-
+- 	rc +AD0- -EINVAL+ADs-
+- 	if (PFN+AF8-PHYS(length) +ADw- size)
+- 		goto out+ADs-
+- 	if (pfn+AF8-t+AF8-to+AF8-pfn(+ACo-pfnp) +ACY- (PHYS+AF8-PFN(size)-1))
+- 		goto out+ADs-
+- 	/+ACo- For larger pages we need devmap +ACo-/
+- 	if (length +AD4- 1 +ACYAJg- +ACE-pfn+AF8-t+AF8-devmap(+ACo-pfnp))
+- 		goto out+ADs-
+- 	rc +AD0- 0+ADs-
+- out:
  	dax+AF8-read+AF8-unlock(id)+ADs-
- 
- 	ret +AD0- dax+AF8-insert+AF8-mapping+AF8-entry(mapping, vmf, entry, sector, 0)+ADs-
- 	if (IS+AF8-ERR(ret))
- 		return PTR+AF8-ERR(ret)+ADs-
- 
- 	trace+AF8-dax+AF8-insert+AF8-mapping(mapping-+AD4-host, vmf, ret)+ADs-
- 	if (vmf-+AD4-flags +ACY- FAULT+AF8-FLAG+AF8-WRITE)
- 		return vm+AF8-insert+AF8-mixed+AF8-mkwrite(vma, vaddr, pfn)+ADs-
- 	else
- 		return vm+AF8-insert+AF8-mixed(vma, vaddr, pfn)+ADs-
+- 	return rc+ADs-
  +AH0-
  
  /+ACo-
diff --cc fs/ext4/inode.c
index 8d2b582fb141,ee4d907a4251..0992d76f7ab1
--- a/fs/ext4/inode.c
+-+-+- b/fs/ext4/inode.c
+AEAAQABA- -3384,6 -3393,20 +-3384,19 +AEAAQABA- static int ext4+AF8-releasepage(struct pag
  		return try+AF8-to+AF8-free+AF8-buffers(page)+ADs-
  +AH0-
  
 -+ACM-ifdef CONFIG+AF8-FS+AF8-DAX
+- static bool ext4+AF8-inode+AF8-datasync+AF8-dirty(struct inode +ACo-inode)
+- +AHs-
+- 	journal+AF8-t +ACo-journal +AD0- EXT4+AF8-SB(inode-+AD4-i+AF8-sb)-+AD4-s+AF8-journal+ADs-
+- 
+- 	if (journal)
+- 		return +ACE-jbd2+AF8-transaction+AF8-committed(journal,
+- 					EXT4+AF8-I(inode)-+AD4-i+AF8-datasync+AF8-tid)+ADs-
+- 	/+ACo- Any metadata buffers to write? +ACo-/
+- 	if (+ACE-list+AF8-empty(+ACY-inode-+AD4-i+AF8-mapping-+AD4-private+AF8-list))
+- 		return true+ADs-
+- 	return inode-+AD4-i+AF8-state +ACY- I+AF8-DIRTY+AF8-DATASYNC+ADs-
+- +AH0-
+- 
  static int ext4+AF8-iomap+AF8-begin(struct inode +ACo-inode, loff+AF8-t offset, loff+AF8-t length,
  			    unsigned flags, struct iomap +ACo-iomap)
  +AHs-
diff --cc include/linux/iomap.h
index ca10767ab73d,73e3b7085dbe..d187cf7c4757
--- a/include/linux/iomap.h
+-+-+- b/include/linux/iomap.h
+AEAAQABA- -22,8 -21,12 +-22,13 +AEAAQABA- struct vm+AF8-fault
  /+ACo-
   +ACo- Flags for all iomap mappings:
   +ACo-/
 -+ACM-define IOMAP+AF8-F+AF8-NEW	0x01	/+ACo- blocks have been newly allocated +ACo-/
 +-+ACM-define IOMAP+AF8-F+AF8-NEW		0x01	/+ACo- blocks have been newly allocated +ACo-/
 +-+ACM-define IOMAP+AF8-F+AF8-BOUNDARY	0x02	/+ACo- mapping ends at metadata boundary +ACo-/
+- /+ACo-
+-  +ACo- IOMAP+AF8-F+AF8-DIRTY indicates the inode has uncommitted metadata needed to access
+-  +ACo- written data and requires fdatasync to commit them to persistent storage.
+-  +ACo-/
 -+ACM-define IOMAP+AF8-F+AF8-DIRTY	0x02
+-+-+ACM-define IOMAP+AF8-F+AF8-DIRTY		0x04
  
  /+ACo-
   +ACo- Flags that only need to be reported for IOMAP+AF8-REPORT requests: