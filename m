From: "Williams, Dan J" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [GIT PULL] libnvdimm fixes for 4.17-rc2
Date: Sun, 22 Apr 2018 00:17:25 +0000
Message-ID: <1524356236.26036.13.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Language: en-US
Content-ID: <07665B705A136D459F8F248D670F4E73-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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

Hi Linus, please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm libnvdimm-fixes

...to receive, a regression fix, new unit test infrastructure and a
build fix.

* The regression fix addresses support for the new NVDIMM label storage
area access commands (_LSI, _LSR, and _LSW). The Intel specific version
of these commands communicated the "Device Locked" status on the label-
storage-information command. However, these new commands (standardized
in ACPI 6.2) communicate the "Device Locked" status on the label-
storage-read command, and the driver was missing the indication.
Reading from locked persistent memory is similar to reading unmapped
PCI memory space, returns all 1's.

* Unit test infrastructure is added to regression test the "Device
Locked" detection failure.

* A build fix is included to allow the "of_pmem" driver to be built as
a module and translate an Open Firmware described device to its local
numa node.

---

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm libnvdimm-fixes

for you to fetch changes up to c5794510d7b5f210f05531ff9e82432cf7244367:

  MAINTAINERS: Add backup maintainers for libnvdimm and DAX (2018-04-19 15:22:50 -0700)

----------------------------------------------------------------
Dan Williams (6):
      libnvdimm, dimm: handle EACCES failures from label reads
      tools/testing/nvdimm: allow custom error code injection
      tools/testing/nvdimm: support nfit_test_dimm attributes under nfit_test.1
      tools/testing/nvdimm: fix missing newline in nfit_test_dimm 'handle' attribute
      tools/testing/nvdimm: enable labels for nfit_test.1 dimms
      Revert "libnvdimm, of_pmem: workaround OF_NUMA=n build error"

Dave Jiang (2):
      device-dax: allow MAP_SYNC to succeed
      MAINTAINERS: Add backup maintainers for libnvdimm and DAX

Rob Herring (1):
      libnvdimm, of_pmem: use dev_to_node() instead of of_node_to_nid()

 MAINTAINERS                      | 15 +++++++
 drivers/dax/device.c             |  2 +
 drivers/nvdimm/Kconfig           |  3 +-
 drivers/nvdimm/dimm_devs.c       | 22 ++++++-----
 drivers/nvdimm/of_pmem.c         |  2 +-
 tools/testing/nvdimm/test/nfit.c | 84 +++++++++++++++++++++++++++++++---------
 6 files changed, 96 insertions(+), 32 deletions(-)
