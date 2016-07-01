From: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: [GIT PULL] libnvdimm fixes for 4.7-rc6
Date: Fri, 1 Jul 2016 01:01:35 +0000
Message-ID: <1467334896.11105.19.camel__30486.3700330772$1467334962$gmane$org@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <E9234A9C728CC14C86DE8F2E0E189082@intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Linus, please pull from:

+AKA- git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm libnvdimm-fixes

...to receive:

1/ Two regression fixes since v4.6: +AKA-one for the byte order of a sysfs
attribute (bz121161) and another for QEMU 2.6's NVDIMM +AF8-DSM (ACPI
Device Specific Method) implementation that gets tripped up by new
auto-probing behavior in the NFIT driver.

2/ A fix tagged for -stable that stops the kernel from
clobbering/ignoring changes to the configuration of a 'pfn' instance
(+ACI-struct page+ACI- driver). +AKA-For example changing the alignment from 2M to
1G may silently revert to 2M if that value is currently stored on
media.

3/ A fix from Eric for an xfstests failure in dax. +AKA-It is not currently
tagged for -stable since it requires an 8-exabyte file system to
trigger, and there appear to be no user visible side effects.

The following changes since commit 33688abb2802ff3a230bd2441f765477b94cc89e:

+AKA- Linux 4.7-rc4 (2016-06-19 21:30:02 -0700)

are available in the git repository at:

+AKA- git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm libnvdimm-fixes

for you to fetch changes up to 1bcbf42d2732b3fdaa8559b0dfc91567769e23c8:

+AKA- nfit: fix format interface code byte order (2016-06-29 11:19:32 -0700)

----------------------------------------------------------------
Dan Williams (3):
+AKAAoACgAKAAoACg-libnvdimm, pfn, dax: fix initialization vs autodetect for mode +- alignment
+AKAAoACgAKAAoACg-acpi, nfit: fix acpi+AF8-check+AF8-dsm() vs zero functions implemented
+AKAAoACgAKAAoACg-nfit: fix format interface code byte order

Eric Sandeen (1):
+AKAAoACgAKAAoACg-dax: fix offset overflow in dax+AF8-io

+AKA-drivers/acpi/nfit.c+AKAAoACgAKAAoACgAKAAfA- 12 +-+-+-+-+-------
+AKA-drivers/acpi/nfit.h+AKAAoACgAKAAoACgAKAAfA- 10 +-+-+-+-+------
+AKA-drivers/acpi/utils.c+AKAAoACgAKAAoACgAHwAoACg-6 +-+-+----
+AKA-drivers/nvdimm/pfn+AF8-devs.c +AHw- 51 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-----------
+AKA-fs/dax.c+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAKAAoACgAHwAoACg-7 +-+-+-+-+-+--
+AKA-5 files changed, 60 insertions(+-), 26 deletions(-)

commit 1ee6667cd8d183b2fed12f97285f184431d2caf9
Author: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-
Date:+AKAAoACg-Thu Jun 23 17:50:39 2016 -0700

+AKAAoACgAKA-libnvdimm, pfn, dax: fix initialization vs autodetect for mode +- alignment
+AKAAoACgAKA-
+AKAAoACgAKA-The updated ndctl unit tests discovered that if a pfn configuration with
+AKAAoACgAKA-a 4K alignment is read from the namespace, that alignment will be
+AKAAoACgAKA-ignored in favor of the default 2M alignment.+AKAAoA-The result is that the
+AKAAoACgAKA-configuration will fail initialization with a message like:
+AKAAoACgAKA-
+AKAAoACgAKAAoACgAKAAoA-dax6.1: bad offset: 0x22000 dax disabled align: 0x200000
+AKAAoACgAKA-
+AKAAoACgAKA-Fix this by allowing the alignment read from the info block to override
+AKAAoACgAKA-the default which is 2M not 0 in the autodetect path.+AKAAoA-This also fixes a
+AKAAoACgAKA-similar problem with the mode and alignment settings silently being
+AKAAoACgAKA-overwritten by the kernel when userspace has changed it.+AKAAoA-We now will
+AKAAoACgAKA-either overwrite the info block if userspace changes the uuid or fail
+AKAAoACgAKA-and warn if a live setting disagrees with the info block.
+AKAAoACgAKA-
+AKAAoACgAKA-Cc: +ADw-stable+AEA-vger.kernel.org+AD4-
+AKAAoACgAKA-Cc: Micah Parrish +ADw-micah.parrish+AEA-hpe.com+AD4-
+AKAAoACgAKA-Cc: Toshi Kani +ADw-toshi.kani+AEA-hpe.com+AD4-
+AKAAoACgAKA-Signed-off-by: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-

commit 4995734e973a2c2e9c6f6413cbad9913fc4df0dc
Author: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-
Date:+AKAAoACg-Fri Jun 24 09:07:39 2016 -0700

+AKAAoACgAKA-acpi, nfit: fix acpi+AF8-check+AF8-dsm() vs zero functions implemented
+AKAAoACgAKA-
+AKAAoACgAKA-QEMU 2.6 implements nascent support for nvdimm DSMs. Depending on
+AKAAoACgAKA-configuration it may only implement the function0 dsm to indicate that
+AKAAoACgAKA-no other DSMs are available. Commit 31eca76ba2fc +ACI-nfit, libnvdimm:
+AKAAoACgAKA-limited/whitelisted dimm command marshaling mechanism+ACI- breaks QEMU, but
+AKAAoACgAKA-QEMU is spec compliant.+AKAAoA-Per the spec the way to indicate that no
+AKAAoACgAKA-functions are supported is:
+AKAAoACgAKA-
+AKAAoACgAKAAoACgAKAAoA-If Function Index is zero, the return is a buffer containing one bit
+AKAAoACgAKAAoACgAKAAoA-for each function index, starting with zero. Bit 0 indicates whether
+AKAAoACgAKAAoACgAKAAoA-there is support for any functions other than function 0 for the
+AKAAoACgAKAAoACgAKAAoA-specified UUID and Revision ID. If set to zero, no functions are
+AKAAoACgAKAAoACgAKAAoA-supported (other than function zero) for the specified UUID and
+AKAAoACgAKAAoACgAKAAoA-Revision ID.
+AKAAoACgAKA-
+AKAAoACgAKA-Update the nfit driver to determine the family (interface UUID) without
+AKAAoACgAKA-requiring the implementation to define any other functions, i.e.
+AKAAoACgAKA-short-circuit acpi+AF8-check+AF8-dsm() to succeed per the spec.+AKAAoA-The nfit driver
+AKAAoACgAKA-appears to be the only user passing funcs+AD0APQ-0 to acpi+AF8-check+AF8-dsm(), so
+AKAAoACgAKA-this behavior change of the common routine should be limited to the
+AKAAoACgAKA-probing done by the nfit driver.
+AKAAoACgAKA-
+AKAAoACgAKA-Cc: Len Brown +ADw-lenb+AEA-kernel.org+AD4-
+AKAAoACgAKA-Cc: Jerry Hoemann +ADw-jerry.hoemann+AEA-hpe.com+AD4-
+AKAAoACgAKA-Acked-by: +ACI-Rafael J. Wysocki+ACI- +ADw-rafael+AEA-kernel.org+AD4-
+AKAAoACgAKA-Fixes: 31eca76ba2fc (+ACI-nfit, libnvdimm: limited/whitelisted dimm command marshaling mechanism+ACI-)
+AKAAoACgAKA-Reported-by: Xiao Guangrong +ADw-guangrong.xiao+AEA-linux.intel.com+AD4-
+AKAAoACgAKA-Tested-by: Xiao Guangrong +ADw-guangrong.xiao+AEA-linux.intel.com+AD4-
+AKAAoACgAKA-Signed-off-by: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-

commit 023954351fae0e34ba247cff4d798c98290b20a4
Author: Eric Sandeen +ADw-sandeen+AEA-redhat.com+AD4-
Date:+AKAAoACg-Thu Jun 23 16:54:46 2016 -0500

+AKAAoACgAKA-dax: fix offset overflow in dax+AF8-io
+AKAAoACgAKA-
+AKAAoACgAKA-This isn't functionally apparent for some reason, but
+AKAAoACgAKA-when we test io at extreme offsets at the end of the loff+AF8-t
+AKAAoACgAKA-rang, such as in fstests xfs/071, the calculation of
+AKAAoACgAKAAIg-max+ACI- in dax+AF8-io() can be wrong due to pos +- size overflowing.
+AKAAoACgAKA-
+AKAAoACgAKA-For example,
+AKAAoACgAKA-
+AKAAoACgAKAAIw- xfs+AF8-io -c +ACI-pwrite 9223372036854771712 512+ACI- /mnt/test/file
+AKAAoACgAKA-
+AKAAoACgAKA-enters dax+AF8-io with:
+AKAAoACgAKA-
+AKAAoACgAKA-start 0x7ffffffffffff000
+AKAAoACgAKA-end+AKAAoACg-0x7ffffffffffff200
+AKAAoACgAKA-
+AKAAoACgAKA-and the rounded up +ACI-size+ACI- variable is 0x1000.+AKAAoA-This yields:
+AKAAoACgAKA-
+AKAAoACgAKA-pos +- size 0x8000000000000000 (overflows loff+AF8-t)
+AKAAoACgAKAAoACgAKAAoACgAKAAoA-end 0x7ffffffffffff200
+AKAAoACgAKA-
+AKAAoACgAKA-Due to the overflow, the min() function picks the wrong
+AKAAoACgAKA-value for the +ACI-max+ACI- variable, and when we send (max - pos)
+AKAAoACgAKA-into i.e. copy+AF8-from+AF8-iter+AF8-pmem() it is also the wrong value.
+AKAAoACgAKA-
+AKAAoACgAKA-This somehow(tm) gets magically absorbed without incident,
+AKAAoACgAKA-probably because iter-+AD4-count is correct.+AKAAoA-But it seems best
+AKAAoACgAKA-to fix it up properly by comparing the two values as
+AKAAoACgAKA-unsigned.
+AKAAoACgAKA-
+AKAAoACgAKA-Signed-off-by: Eric Sandeen +ADw-sandeen+AEA-redhat.com+AD4-
+AKAAoACgAKA-Signed-off-by: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-

commit 1bcbf42d2732b3fdaa8559b0dfc91567769e23c8
Author: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-
Date:+AKAAoACg-Wed Jun 29 11:19:32 2016 -0700

+AKAAoACgAKA-nfit: fix format interface code byte order
+AKAAoACgAKA-
+AKAAoACgAKA-Per JEDEC Annex L Release 3 the SPD data is:
+AKAAoACgAKA-
+AKAAoACgAKA-Bits 9+AH4-5 00 000 +AD0- Function Undefined
+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKA-00 001 +AD0- Byte addressable energy backed
+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKA-00 010 +AD0- Block addressed
+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKA-00 011 +AD0- Byte addressable, no energy backed
+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKA-All other codes reserved
+AKAAoACgAKA-Bits 4+AH4-0 0 0000 +AD0- Proprietary interface
+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKA-0 0001 +AD0- Standard interface 1
+AKAAoACgAKAAoACgAKAAoACgAKAAoACgAKA-All other codes reserved+ADs- see Definitions of Functions
+AKAAoACgAKA-
+AKAAoACgAKA-...and per the ACPI 6.1 spec:
+AKAAoACgAKA-
+AKAAoACgAKAAoACgAKAAoA-byte0: Bits 4+AH4-0 (0 or 1)
+AKAAoACgAKAAoACgAKAAoA-byte1: Bits 9+AH4-5 (1, 2, or 3)
+AKAAoACgAKA-
+AKAAoACgAKA-...so a format interface code displayed as 0x301 should be stored in the
+AKAAoACgAKA-nfit as (0x1, 0x3), little-endian.
+AKAAoACgAKA-
+AKAAoACgAKA-Cc: Toshi Kani +ADw-toshi.kani+AEA-hpe.com+AD4-
+AKAAoACgAKA-Cc: Rafael J. Wysocki +ADw-rjw+AEA-rjwysocki.net+AD4-
+AKAAoACgAKA-Cc: Robert Moore +ADw-robert.moore+AEA-intel.com+AD4-
+AKAAoACgAKA-Cc: Robert Elliott +ADw-elliott+AEA-hpe.com+AD4-
+AKAAoACgAKA-Link: https://bugzilla.kernel.org/show+AF8-bug.cgi?id+AD0-121161
+AKAAoACgAKA-Fixes: 30ec5fd464d5 (+ACI-nfit: fix format interface code byte order per ACPI6.1+ACI-)
+AKAAoACgAKA-Fixes: 5ad9a7fde07a (+ACI-acpi/nfit: Update nfit driver to comply with ACPI 6.1+ACI-)
+AKAAoACgAKA-Reported-by: Kristin Jacque +ADw-kristin.jacque+AEA-intel.com+AD4-
+AKAAoACgAKA-Signed-off-by: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4