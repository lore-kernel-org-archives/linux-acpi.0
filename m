From: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: [GIT PULL] libnvdimm fixes for 4.8-rc2
Date: Fri, 12 Aug 2016 19:09:07 +0000
Message-ID: <1471028948.2946.21.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:42661 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbcHLTJK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 12 Aug 2016 15:09:10 -0400
Content-Language: en-US
Content-ID: <3EC8DD0F02A02347B6E3573CAA1A63D7@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi Linus, please pull from:

+AKA- git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm libnvdimm-fixes

...to receive:

- Fix for the nd+AF8-blk (NVDIMM Block Window Aperture) driver. +AKA-A spec
clarification requires the driver to mask off reserved bits in status
register. This is tagged for -stable back to the v4.2 kernel.

- Fix for a kernel crash in the nvdimm unit tests when module loading
is interrupted with SIGTERM. Tagged for -stable since validation
efforts external to Intel use the unit tests for qualifying backports.

- Add a new 'size' sysfs attribute for the BTT (NVDIMM Block
Translation Table) driver to make it symmetric with the other namespace
personality drivers (PFN and DAX) that provide a size attribute for
indicating how much namespace capacity is lost to metadata.

The BTT change arrived at the start of the merge window and has
appeared in a -next release. +AKA-It can technically wait for 4.9, but it
is small, fixes asymmetry in the libnvdimm-sysfs interface, and
something I would have squeezed into the v4.8 pull request had it
arrived a few days earlier.

---

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

+AKA- Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

+AKA- git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm libnvdimm-fixes

for you to fetch changes up to d8d378fa1a0c98ecb50ca52c9bf3bc14e25aa2d2:

+AKA- tools/testing/nvdimm: fix SIGTERM vs hotplug crash (2016-08-10 15:59:09 -0700)

----------------------------------------------------------------
Dan Williams (1):
+AKAAoACgAKAAoACg-tools/testing/nvdimm: fix SIGTERM vs hotplug crash

Ross Zwisler (1):
+AKAAoACgAKAAoACg-libnvdimm, nd+AF8-blk: mask off reserved status bits

Vishal Verma (1):
+AKAAoACgAKAAoACg-nvdimm, btt: add a size attribute for BTTs

+AKA-drivers/acpi/nfit/core.c+AKAAoACgAKAAoACgAKAAoACgAHwAoACg-3 +-+--
+AKA-drivers/nvdimm/btt.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAfACgAKA-1 +-
+AKA-drivers/nvdimm/btt+AF8-devs.c+AKAAoACgAKAAoACgAKAAoAB8- 20 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
+AKA-drivers/nvdimm/nd.h+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoAB8AKAAoA-1 +-
+AKA-tools/testing/nvdimm/test/nfit.c +AHwAoACg-2 +-+-
+AKA-5 files changed, 26 insertions(+-), 1 deletion(-)

commit 68202c9f0ad6e16ee806fbadbc5838d55fe5aa5c
Author: Ross Zwisler +ADw-ross.zwisler+AEA-linux.intel.com+AD4-
Date:+AKAAoACg-Fri Jul 29 14:59:12 2016 -0600

+AKAAoACgAKA-libnvdimm, nd+AF8-blk: mask off reserved status bits
+AKAAoACgAKA-
+AKAAoACgAKA-The +ACI-NVDIMM Block Window Driver Writer's Guide+ACI-:
+AKAAoACgAKA-
+AKAAoACgAKAAoACgAKAAoA-http://pmem.io/documents/NVDIMM+AF8-DriverWritersGuide-July-2016.pdf
+AKAAoACgAKA-
+AKAAoACgAKA-...defines the layout of the block window status register.+AKAAoA-For the July
+AKAAoACgAKA-2016 version of the spec linked to above, this happens in Figure 4 on
+AKAAoACgAKA-page 26.
+AKAAoACgAKA-
+AKAAoACgAKA-The only bits defined in this spec are bits 31, 5, 4, 2, 1 and 0.+AKAAoA-The
+AKAAoACgAKA-rest of the bits in the status register are reserved, and there is a
+AKAAoACgAKA-warning following the diagram that says:
+AKAAoACgAKA-
+AKAAoACgAKAAoACgAKAAoA-Note: The driver cannot assume the value of the RESERVED bits in the
+AKAAoACgAKAAoACgAKAAoA-status register are zero. These reserved bits need to be masked off, and
+AKAAoACgAKAAoACgAKAAoA-the driver must avoid checking the state of those bits.
+AKAAoACgAKA-
+AKAAoACgAKA-This change ensures that for hardware implementations that set these
+AKAAoACgAKA-reserved bits in the status register, the driver won't incorrectly fail the
+AKAAoACgAKA-block I/Os.
+AKAAoACgAKA-
+AKAAoACgAKA-Cc: +ADw-stable+AEA-vger.kernel.org+AD4- +ACM-v4.2+-
+AKAAoACgAKA-Reviewed-by: Lee, Chun-Yi +ADw-jlee+AEA-suse.com+AD4-
+AKAAoACgAKA-Signed-off-by: Ross Zwisler +ADw-ross.zwisler+AEA-linux.intel.com+AD4-
+AKAAoACgAKA-Signed-off-by: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-

commit abe8b4e3cef88b8202641d63f5ad58141b970b0f
Author: Vishal Verma +ADw-vishal.l.verma+AEA-intel.com+AD4-
Date:+AKAAoACg-Wed Jul 27 16:38:59 2016 -0600

+AKAAoACgAKA-nvdimm, btt: add a size attribute for BTTs
+AKAAoACgAKA-
+AKAAoACgAKA-To be consistent with other namespaces, expose a 'size' attribute for
+AKAAoACgAKA-BTT devices also.
+AKAAoACgAKA-
+AKAAoACgAKA-Cc: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-
+AKAAoACgAKA-Reported-by: Linda Knippers +ADw-linda.knippers+AEA-hpe.com+AD4-
+AKAAoACgAKA-Signed-off-by: Vishal Verma +ADw-vishal.l.verma+AEA-intel.com+AD4-
+AKAAoACgAKA-Signed-off-by: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-

commit d8d378fa1a0c98ecb50ca52c9bf3bc14e25aa2d2
Author: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-
Date:+AKAAoACg-Wed Aug 10 15:59:09 2016 -0700

+AKAAoACgAKA-tools/testing/nvdimm: fix SIGTERM vs hotplug crash
+AKAAoACgAKA-
+AKAAoACgAKA-The unit tests crash when hotplug races the previous probe. This race
+AKAAoACgAKA-requires that the loading of the nfit+AF8-test module be terminated with
+AKAAoACgAKA-SIGTERM, and the module to be unloaded while the ars scan is still
+AKAAoACgAKA-running.
+AKAAoACgAKA-
+AKAAoACgAKA-In contrast to the normal nfit driver, the unit test calls
+AKAAoACgAKA-acpi+AF8-nfit+AF8-init() twice to simulate hotplug, whereas the nominal case
+AKAAoACgAKA-goes through the acpi+AF8-nfit+AF8-notify() event handler.+AKAAoA-The
+AKAAoACgAKA-acpi+AF8-nfit+AF8-notify() path is careful to flush the previous region
+AKAAoACgAKA-registration before servicing the hotplug event. The unit test was
+AKAAoACgAKA-missing this guarantee.
+AKAAoACgAKA-
+AKAAoACgAKAAoA-BUG: unable to handle kernel NULL pointer dereference at+AKAAoACgAKAAoACgAKAAoACgAKAAoA-(null)
+AKAAoACgAKAAoA-IP: +AFsAPA-ffffffff810cdce7+AD4AXQ- pwq+AF8-activate+AF8-delayed+AF8-work+-0x47/0x170
+AKAAoACgAKAAoABb-..+AF0-
+AKAAoACgAKAAoA-Call Trace:
+AKAAoACgAKAAoACgAFsAPA-ffffffff810ce186+AD4AXQ- pwq+AF8-dec+AF8-nr+AF8-in+AF8-flight+-0x66/0xa0
+AKAAoACgAKAAoACgAFsAPA-ffffffff810ce490+AD4AXQ- process+AF8-one+AF8-work+-0x2d0/0x680
+AKAAoACgAKAAoACgAFsAPA-ffffffff810ce331+AD4AXQ- ? process+AF8-one+AF8-work+-0x171/0x680
+AKAAoACgAKAAoACgAFsAPA-ffffffff810ce88e+AD4AXQ- worker+AF8-thread+-0x4e/0x480
+AKAAoACgAKAAoACgAFsAPA-ffffffff810ce840+AD4AXQ- ? process+AF8-one+AF8-work+-0x680/0x680
+AKAAoACgAKAAoACgAFsAPA-ffffffff810ce840+AD4AXQ- ? process+AF8-one+AF8-work+-0x680/0x680
+AKAAoACgAKAAoACgAFsAPA-ffffffff810d5343+AD4AXQ- kthread+-0xf3/0x110
+AKAAoACgAKAAoACgAFsAPA-ffffffff8199846f+AD4AXQ- ret+AF8-from+AF8-fork+-0x1f/0x40
+AKAAoACgAKAAoACgAFsAPA-ffffffff810d5250+AD4AXQ- ? kthread+AF8-create+AF8-on+AF8-node+-0x230/0x230
+AKAAoACgAKA-
+AKAAoACgAKA-Cc: +ADw-stable+AEA-vger.kernel.org+AD4-
+AKAAoACgAKA-Signed-off-by: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4