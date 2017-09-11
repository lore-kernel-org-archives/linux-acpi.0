From: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: [GIT PULL] libnvdimm for 4.14
Date: Mon, 11 Sep 2017 17:17:41 +0000
Message-ID: <1505150259.20229.2.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <C27A9237A90A5E48ADA2FDD8AD728BB7@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-4.14

...to receive:

A rework of media error handling in the BTT driver and other updates.
It has appeared in a few -next releases and collected some late-
breaking build-error and warning fixups as a result. There are no known
merge conflicts, and the touches to fs/ have reviewed-by tags.

---

The following changes since commit 14ccee78fc82f5512908f4424f541549a5705b89:

  Linux 4.13-rc6 (2017-08-20 14:13:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-4.14

for you to fetch changes up to 04c3c982fcc0151ed3574d7ae4f1e62278054d72:

  libnvdimm, btt: fix format string warnings (2017-09-09 11:31:39 -0700)

----------------------------------------------------------------
libnvdimm for 4.14

+ACo- Media error handling support in the Block Translation Table (BTT)
  driver is reworked to address sleeping-while-atomic locking and
  memory-allocation-context conflicts.

+ACo- The dax+AF8-device lookup overhead for xfs and ext4 is moved out of the
  iomap hot-path to a mount-time lookup.

+ACo- A new 'ecc+AF8-unit+AF8-size' sysfs attribute is added to advertise the
  read-modify-write boundary property of a persistent memory range.

+ACo- Preparatory fix-ups for arm and powerpc pmem support are included
  along with other miscellaneous fixes.

----------------------------------------------------------------
Christophe Jaillet (1):
      libnvdimm, btt: check memory allocation failure

Colin Ian King (1):
      ext4: fix null pointer dereference on sbi

Dan Williams (13):
      nfit, libnvdimm, region: export 'position' in mapping info
      nfit: cleanup long de-reference chains in acpi+AF8-nfit+AF8-init+AF8-interleave+AF8-set
      libnvdimm: rename nd+AF8-sector+AF8-size+AF8Aew-show,store+AH0- to nd+AF8-size+AF8-select+AF8Aew-show,store+AH0-
      libnvdimm, pfn, dax: limit namespace alignments to the supported set
      libnvdimm, label: fix index block size calculation
      dax: introduce a fs+AF8-dax+AF8-get+AF8-by+AF8-bdev() helper
      xfs: perform dax+AF8-device lookup at mount
      ext2: perform dax+AF8-device lookup at mount
      ext4: perform dax+AF8-device lookup at mount
      libnvdimm, nfit: export an 'ecc+AF8-unit+AF8-size' sysfs attribute
      libnvdimm: fix integer overflow static analysis warning
      Merge branch 'for-4.14/fs' into libnvdimm-for-next
      dax: fix FS+AF8-DAX+AD0-n BLOCK+AD0-y compilation

Meng Xu (1):
      libnvdimm, nfit: move the check on nd+AF8-reserved2 to the endpoint

Oliver O'Halloran (2):
      libnvdimm: Stop using HPAGE+AF8-SIZE
      libnvdimm, pfn, dax: show supported dax/pfn region alignments in sysfs

Randy Dunlap (1):
      libnvdimm, btt: fix format string warnings

Robin Murphy (1):
      libnvdimm, nd+AF8-blk: remove mmio+AF8-flush+AF8-range()

Vishal Verma (7):
      libnvdimm, btt: fix a missed NVDIMM+AF8-IO+AF8-ATOMIC case in the write path
      libnvdimm, btt: refactor map entry operations with macros
      libnvdimm, btt: ensure that flags were also unchanged during a map+AF8-read
      libnvdimm, btt: cache sector+AF8-size in arena+AF8-info
      libnvdimm: fix potential deadlock while clearing errors
      libnvdimm, btt: rework error clearing
      libnvdimm, btt: clean up warning and error messages

 arch/x86/Kconfig                  +AHw-   1 -
 arch/x86/include/asm/cacheflush.h +AHw-   2 -
 drivers/acpi/nfit/Kconfig         +AHw-   2 +--
 drivers/acpi/nfit/core.c          +AHw-  50 +-+-+-+-+-+-+-+---
 drivers/dax/super.c               +AHw-  12 +-+-+-
 drivers/nvdimm/btt.c              +AHw- 197 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+---------
 drivers/nvdimm/btt.h              +AHw-  11 +-+-+-
 drivers/nvdimm/btt+AF8-devs.c         +AHw-   4 +--
 drivers/nvdimm/bus.c              +AHw-  27 +-+-+----
 drivers/nvdimm/claim.c            +AHw-   9 +--
 drivers/nvdimm/core.c             +AHw-  10 +--
 drivers/nvdimm/label.c            +AHw-  30 +-+-+----
 drivers/nvdimm/namespace+AF8-devs.c   +AHw-   6 +--
 drivers/nvdimm/nd.h               +AHw-  16 +-+-+--
 drivers/nvdimm/pfn+AF8-devs.c         +AHw-  53 +-+-+-+-+-+-----
 drivers/nvdimm/pmem.h             +AHw-  14 ---
 drivers/nvdimm/region+AF8-devs.c      +AHw-   6 +--
 fs/ext2/ext2.h                    +AHw-   1 +-
 fs/ext2/inode.c                   +AHw-  11 +---
 fs/ext2/super.c                   +AHw-   4 +-
 fs/ext4/ext4.h                    +AHw-   1 +-
 fs/ext4/inode.c                   +AHw-  11 +---
 fs/ext4/super.c                   +AHw-   4 +-
 fs/xfs/xfs+AF8-aops.c                 +AHw-  13 +-+-+-
 fs/xfs/xfs+AF8-aops.h                 +AHw-   1 +-
 fs/xfs/xfs+AF8-buf.c                  +AHw-   4 +--
 fs/xfs/xfs+AF8-buf.h                  +AHw-   3 +--
 fs/xfs/xfs+AF8-iomap.c                +AHw-  10 +--
 fs/xfs/xfs+AF8-super.c                +AHw-  25 +-+-+-+--
 include/linux/dax.h               +AHw-   6 +-+-
 include/linux/libnvdimm.h         +AHw-  16 +-+-+-+-
 lib/Kconfig                       +AHw-   3 -
 tools/testing/nvdimm/test/nfit.c  +AHw-   4 +--
 33 files changed, 397 insertions(+-), 170 deletions(-)
