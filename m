From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 0/3] nfit, libnvdimm, pmem: clear poison support
Date: Tue, 08 Mar 2016 14:47:13 -0800
Message-ID: <20160308224713.16298.33547.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: Vishal Verma <vishal.l.verma@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-acpi@vger.kernel.org, Ross Zwisler <ross.zwisler@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPI 6.1 introduces the ability to send "clear error" commands to the
ACPI0012:00 device representing the root of an "nvdimm bus".

Similar to relocating a bad block on a disk, this support clears
media errors in response to a write.

---

Dan Williams (3):
      nfit, libnvdimm: clear poison command support
      libnvdimm, pmem: fix kmap_atomic() leak in error path
      libnvdimm, pmem: clear poison on write


 arch/x86/include/asm/pmem.h      |    5 +++
 drivers/acpi/nfit.c              |   12 ++++++-
 drivers/nvdimm/bus.c             |   65 ++++++++++++++++++++++++++++++++++++++
 drivers/nvdimm/nd.h              |    2 +
 drivers/nvdimm/pmem.c            |   40 ++++++++++++++++++++---
 include/linux/pmem.h             |   19 +++++++++++
 include/uapi/linux/ndctl.h       |   13 ++++++++
 tools/testing/nvdimm/test/nfit.c |   29 +++++++++++++++++
 8 files changed, 179 insertions(+), 6 deletions(-)
