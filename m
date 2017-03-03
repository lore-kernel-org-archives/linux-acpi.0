From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [GIT PULL] libnvdimm fixes for 4.11-rc1
Date: Fri, 3 Mar 2017 14:00:49 -0800
Message-ID: <CAPcyv4iQKk18wMCDLhCrfTgn7mAEL6k9hYLGFAmEvWUeBR5qLw@mail.gmail.com>
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
To: "torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm libnvdimm-fixes

...to receive a fix and regression test case for nvdimm namespace
label compatibility.

Details:
An "nvdimm namespace label" is metadata on an nvdimm that provisions
dimm capacity into a "namespace" that can host a block device /
dax-filesytem, or a device-dax character device. A namespace is an
object that other operating environment and platform firmware needs to
comprehend for capabilities like booting from an nvdimm. The label
metadata contains a checksum that Linux was not calculating correctly
leading to other environments rejecting the Linux label.

These have received a build success notification from the kbuild
robot, and a positive test result from Nick who reported the problem.

---

The following changes since commit c470abd4fde40ea6a0846a2beab642a578c0b8cd:

  Linux 4.10 (2017-02-19 14:34:00 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm libnvdimm-fixes

for you to fetch changes up to 86ef58a4e35e8fa66afb5898cf6dec6a3bb29f67:

  nfit, libnvdimm: fix interleave set cookie calculation (2017-03-01
00:49:42 -0800)

----------------------------------------------------------------
Dan Williams (2):
      tools/testing/nvdimm: make iset cookie predictable
      nfit, libnvdimm: fix interleave set cookie calculation

 drivers/acpi/nfit/core.c         | 16 +++++++++++++++-
 drivers/nvdimm/namespace_devs.c  | 18 ++++++++++++++----
 drivers/nvdimm/nd.h              |  1 +
 drivers/nvdimm/region_devs.c     |  9 +++++++++
 include/linux/libnvdimm.h        |  2 ++
 tools/testing/nvdimm/test/nfit.c | 14 +++++++-------
 6 files changed, 48 insertions(+), 12 deletions(-)

commit 86ef58a4e35e8fa66afb5898cf6dec6a3bb29f67
Author: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Tue Feb 28 18:32:48 2017 -0800

    nfit, libnvdimm: fix interleave set cookie calculation

    The interleave-set cookie is a sum that sanity checks the composition of
    an interleave set has not changed from when the namespace was initially
    created.  The checksum is calculated by sorting the DIMMs by their
    location in the interleave-set. The comparison for the sort must be
    64-bit wide, not byte-by-byte as performed by memcmp() in the broken
    case.

    Fix the implementation to accept correct cookie values in addition to
    the Linux "memcmp" order cookies, but only allow correct cookies to be
    generated going forward. It does mean that namespaces created by
    third-party-tooling, or created by newer kernels with this fix, will not
    validate on older kernels. However, there are a couple mitigating
    conditions:

        1/ platforms with namespace-label capable NVDIMMs are not widely
           available.

        2/ interleave-sets with a single-dimm are by definition not affected
           (nothing to sort). This covers the QEMU-KVM NVDIMM emulation case.

    The cookie stored in the namespace label will be fixed by any write the
    namespace label, the most straightforward way to achieve this is to
    write to the "alt_name" attribute of a namespace in sysfs.

    Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
    Fixes: eaf961536e16 ("libnvdimm, nfit: add interleave-set
state-tracking infrastructure")
    Reported-by: Nicholas Moulin <nicholas.w.moulin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
    Tested-by: Nicholas Moulin <nicholas.w.moulin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
    Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

commit df06a2d57711a1472ced72207373eeb6422d4721
Author: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date:   Wed Mar 1 00:03:37 2017 -0800

    tools/testing/nvdimm: make iset cookie predictable

    For testing changes to the iset cookie algorithm we need a value that is
    constant from run-to-run.

    Stop including dynamic data in the emulated region_offset values. Also,
    pick values that sort in a different order depending on whether the
    comparison is a memcmp() of two 8-byte arrays or subtraction of two
    64-bit values.

    Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
