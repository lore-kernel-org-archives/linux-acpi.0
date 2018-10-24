From: "Williams, Dan J" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [GIT PULL] libnvdimm for 4.20
Date: Wed, 24 Oct 2018 23:45:54 +0000
Message-ID: <47580ee876c884c91fdb8c29791257cf715facfa.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Language: en-US
Content-ID: <AF22FDF13B095F4B8774C951FE46689C-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: "torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-4.20

...to receive the libnvdimm updates for this cycle. No interactions
with other trees this time around. There are updates to the core to
improve driver initialization time, and updates to the 'nfit' driver
for fixing ARS corner cases and exposing some more hardware attributes
to userspace. It has all been in -next for a few releases now with no
reported issues.

---

The following changes since commit 7876320f88802b22d4e2daf7eb027dd14175a0f8:

  Linux 4.19-rc4 (2018-09-16 11:52:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-4.20

for you to fetch changes up to 594861215c834e4b59a30d4b794f6372717bc197:

  acpi, nfit: Further restrict userspace ARS start requests (2018-10-17 14:02:32 -0700)

----------------------------------------------------------------
libnvdimm for 4.20

* Improve the efficiency and performance of reading nvdimm-namespace
  labels. Reduce the amount of label data read at driver load time by a
  few orders of magnitude. Reduce heavyweight call-outs to
  platform-firmware routines.

* Handle media errors located in the 'struct page' array stored on a
  persistent memory namespace. Let the kernel clear these errors rather
  than an awkward userspace workaround.

* Fix Address Range Scrub (ARS) completion tracking. Correct occasions
  where the kernel indicates completion of ARS before submission.

* Fix asynchronous device registration reference counting.

* Add support for reporting an nvdimm dirty-shutdown-count via sysfs.

* Fix various small libnvdimm core and uapi issues.

----------------------------------------------------------------
Alexander Duyck (7):
      libnvdimm: Hold reference on parent while scheduling async init
      libnvdimm: Set device node in nd_device_register
      nvdimm: Sanity check labeloff
      nvdimm: Clarify comment in sizeof_namespace_index
      nvdimm: Remove empty if statement
      nvdimm: Split label init out from the logic for getting config data
      nvdimm: Use namespace index data to reduce number of label reads needed

Dan Williams (9):
      libnvdimm, region: Fail badblocks listing for inactive regions
      libnvdimm, pmem: Fix badblocks population for 'raw' namespaces
      libnvdimm, dimm: Maximize label transfer size
      libnvdimm, label: Fix sparse warning
      acpi, nfit: Introduce nfit_mem flags
      acpi, nfit: Collect shutdown status
      tools/testing/nvdimm: Populate dirty shutdown data
      acpi, nfit: Fix Address Range Scrub completion tracking
      acpi, nfit: Further restrict userspace ARS start requests

David Howells (2):
      UAPI: ndctl: Fix g++-unsupported initialisation in headers
      UAPI: ndctl: Remove use of PAGE_SIZE

GuangZhe Fu (1):
      libnvdimm, namespace: Drop the repeat assignment for variable dev->parent

Pankaj Gupta (1):
      libnvdimm: remove duplicate include

Vishal Verma (1):
      libnvdimm, pfn: during init, clear errors in the metadata area

 drivers/acpi/nfit/core.c              | 297 +++++++++++++++++++++++-----------
 drivers/acpi/nfit/intel.h             |  38 +++++
 drivers/acpi/nfit/nfit.h              |  21 ++-
 drivers/nvdimm/bus.c                  |  20 ++-
 drivers/nvdimm/dimm.c                 |   6 +-
 drivers/nvdimm/dimm_devs.c            |  60 +++----
 drivers/nvdimm/label.c                | 144 ++++++++++++++++-
 drivers/nvdimm/label.h                |   4 +-
 drivers/nvdimm/namespace_devs.c       |   1 -
 drivers/nvdimm/nd-core.h              |   1 -
 drivers/nvdimm/nd.h                   |   2 +
 drivers/nvdimm/pfn_devs.c             |  61 ++++++-
 drivers/nvdimm/pmem.c                 |   4 +-
 drivers/nvdimm/region_devs.c          |  11 +-
 include/linux/ndctl.h                 |  22 +++
 include/uapi/linux/ndctl.h            |  52 +++---
 tools/testing/nvdimm/Kbuild           |   1 +
 tools/testing/nvdimm/acpi_nfit_test.c |   8 +
 tools/testing/nvdimm/test/nfit.c      |   4 +-
 tools/testing/nvdimm/test/nfit_test.h |  24 ---
 20 files changed, 564 insertions(+), 217 deletions(-)
 create mode 100644 drivers/acpi/nfit/intel.h
 create mode 100644 include/linux/ndctl.h
