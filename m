From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 00/17] replace pcommit with ADR or directed flushing
Date: Sat, 09 Jul 2016 20:24:29 -0700
Message-ID: <146812106839.32932.2870621200867047059.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Cc: Xiao Guangrong <guangrong.xiao-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnaldo Carvalho de Melo <acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Shishkin <alexander.shishkin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Josh Poimboeuf <jpoimboe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, hch-jcswGhMUV9g@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Changes since v1 [1]:

1/ Move flush address data from nvdimm_drvdata to nd_region_data (Greg,
   Toshi)

2/ Add more detail to cover letter and patch descriptions (Linda, Jeff)

3/ Account for s/REQ_FLUSH/REQ_PREFLUSH/ rename pending in -next.

4/ Add a directed flush at pmem ->remove() and ->shutdown() time.

[1]: https://lists.01.org/pipermail/linux-nvdimm/2016-June/005897.html

---

The pcommit instruction, which has not shipped on any product, is
deprecated. Instead, the expectation is that platforms implement either
ADR, or provide one or more flush addresses per nvdimm. ADR
(Asynchronous DRAM Refresh) flushes data in posted write buffers to the
memory controller on a power-fail event. Flush addresses are defined in
ACPI 6.x as an NVDIMM Firmware Interface Table (NFIT) sub-structure:
"Flush Hint Address Structure". A flush hint is an mmio address that
when written and fenced assures that all previous posted writes
targeting a given dimm have been flushed to media.

Code paths that previously called wmb_pmem() instead must arrange for a
flush request to be sent to the pmem driver. Towards this end, the pmem
driver is converted to advertise itself as having a write cache to
indicate to a filesystem that a flush request must occur before writes
are guaranteed to be on media.  See "[PATCH v2 08/17] libnvdimm:
introduce nvdimm_flush() and nvdimm_has_flush()" for details.

---

Dan Williams (17):
      nfit: always associate flush hints
      nfit: don't override return value of nfit_mem_init
      libnvdimm: introduce devm_nvdimm_memremap(), convert nfit_spa_map() users
      libnvdimm, nfit: remove nfit_spa_map() infrastructure
      libnvdimm, nfit: move flush hint mapping to region-device driver-data
      tools/testing/nvdimm: simulate multiple flush hints per-dimm
      libnvdimm: keep region data alive over namespace removal
      libnvdimm: introduce nvdimm_flush() and nvdimm_has_flush()
      libnvdimm: cycle flush hints
      libnvdimm, pmem: use REQ_FUA, REQ_FLUSH for nvdimm_flush()
      libnvdimm, pmem: flush posted-write queues on shutdown
      fs/dax: remove wmb_pmem()
      libnvdimm, pmem: use nvdimm_flush() for namespace I/O writes
      pmem: kill wmb_pmem()
      Revert "KVM: x86: add pcommit support"
      x86/insn: remove pcommit
      pmem: kill __pmem address space


 Documentation/filesystems/Locking                  |    2 
 arch/powerpc/sysdev/axonram.c                      |    4 
 arch/x86/include/asm/cpufeatures.h                 |    1 
 arch/x86/include/asm/pmem.h                        |   77 ++-----
 arch/x86/include/asm/special_insns.h               |   46 ----
 arch/x86/include/asm/vmx.h                         |    1 
 arch/x86/include/uapi/asm/vmx.h                    |    4 
 arch/x86/kvm/cpuid.c                               |    2 
 arch/x86/kvm/cpuid.h                               |    8 -
 arch/x86/kvm/vmx.c                                 |   32 ---
 arch/x86/lib/x86-opcode-map.txt                    |    2 
 drivers/acpi/nfit.c                                |  230 +++-----------------
 drivers/acpi/nfit.h                                |   25 --
 drivers/block/brd.c                                |    4 
 drivers/nvdimm/bus.c                               |   16 +
 drivers/nvdimm/claim.c                             |    2 
 drivers/nvdimm/core.c                              |  122 +++++++++++
 drivers/nvdimm/dimm_devs.c                         |    5 
 drivers/nvdimm/nd-core.h                           |    4 
 drivers/nvdimm/nd.h                                |   10 +
 drivers/nvdimm/pmem.c                              |   59 ++++-
 drivers/nvdimm/pmem.h                              |    4 
 drivers/nvdimm/region.c                            |   19 +-
 drivers/nvdimm/region_devs.c                       |  148 ++++++++++++-
 drivers/s390/block/dcssblk.c                       |    6 -
 fs/dax.c                                           |   13 -
 include/linux/blkdev.h                             |    6 -
 include/linux/compiler.h                           |    2 
 include/linux/libnvdimm.h                          |   16 +
 include/linux/nd.h                                 |    3 
 include/linux/pmem.h                               |  117 ++--------
 scripts/checkpatch.pl                              |    1 
 tools/objtool/arch/x86/insn/x86-opcode-map.txt     |    2 
 tools/perf/arch/x86/tests/insn-x86-dat-32.c        |    2 
 tools/perf/arch/x86/tests/insn-x86-dat-64.c        |    2 
 tools/perf/arch/x86/tests/insn-x86-dat-src.c       |    4 
 .../perf/util/intel-pt-decoder/x86-opcode-map.txt  |    2 
 tools/testing/nvdimm/pmem-dax.c                    |    2 
 tools/testing/nvdimm/test/nfit.c                   |   55 +++--
 39 files changed, 505 insertions(+), 555 deletions(-)
