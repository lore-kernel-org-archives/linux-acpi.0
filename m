From: Tony Luck <tony.luck@intel.com>
Subject: [RFC PATCH 0/4] Teach EDAC driver about NVDIMMs
Date: Thu, 30 Nov 2017 12:40:38 -0800
Message-ID: <cover.1512070562.git.tony.luck@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10155 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750923AbdK3Ukm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 30 Nov 2017 15:40:42 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-edac@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>, Jean Delvare <jdelvare@suse.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, Lv Zheng <lv.zheng@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Aristeu Rozanski <aris@redhat.com>

A Skylake server may have some DIMM slots filled with NVDIMMs
instead of normal DDR4 DIMMs. These are enumerated differently
by the memory controller.

Sadly there isn't an easy way to just peek at some memory controller
register to find the size of these DIMMs, so we have to rely on the
NFIT and SMBIOS tables to get that information.

This series only tackles the topology function of the EDAC
driver.  A later series of patches will fix the address translation
parts so that errors in NVDIMMs will be reported correctly.

It's marked "RFC" because it depends on the new ACPCIA version 20171110
which has only just made it to Rafael's tree.

Some of you may only care about some of the parts that touch code you
maintain, but I copied you on all four because you might like to see
the bigger picture.

Tony Luck (4):
  acpi, nfit: Add function to look up nvdimm device and provide SMBIOS
    handle
  firmware: dmi: Add function to look up a handle and return DIMM size
  edac: Add new memory type for non-volatile DIMMs
  EDAC, skx_edac: Detect non-volatile DIMMs

 drivers/acpi/nfit/core.c     | 27 +++++++++++++++++++++
 drivers/edac/Kconfig         |  2 ++
 drivers/edac/edac_mc.c       |  1 +
 drivers/edac/edac_mc_sysfs.c |  3 ++-
 drivers/edac/skx_edac.c      | 56 ++++++++++++++++++++++++++++++++++++++++----
 drivers/firmware/dmi_scan.c  | 29 +++++++++++++++++++++++
 include/acpi/nfit.h          | 19 +++++++++++++++
 include/linux/dmi.h          |  2 ++
 include/linux/edac.h         |  3 +++
 9 files changed, 136 insertions(+), 6 deletions(-)
 create mode 100644 include/acpi/nfit.h


base-commit: 3fc70f8be59950ee2deecefdddb68be19b8cddd1
-- 
2.14.1

