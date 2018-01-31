From: Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v3 0/4] add support for platform persistence capabilities
Date: Tue, 30 Jan 2018 17:01:07 -0700
Message-ID: <151735668391.34477.11820724492631561208.stgit@djiang5-desk3.ch.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60530 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754252AbeAaABJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 Jan 2018 19:01:09 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dan.j.williams@intel.com, ross.zwisler@linux.intel.com
Cc: linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org

ACPI 6.2a provides an NFIT sub-table that informs if the platform has
auto CPU flush and memory flush on unexpected power loss events. This series
propogates those attributes to nd_region and add sysfs attribute to show
those capabilities.

v3:
Addressed Ross's comments
- fixed mask calculation for platform cap
- fixed nfit_test nfit_buf size calcuation
- fixed offset for test data structure

v2:
Per Dan's comments
- Added ADR cap flags propogation
- Added sysfs attribute

---

Dave Jiang (4):
      acpi: nfit: Add support for detect platform CPU cache flush on power loss
      acpi: nfit: add persistent memory control flag for nd_region
      libnvdimm: expose platform persistence attribute for nd_region
      nfit-test: Add platform cap support from ACPI 6.2a to test


 drivers/acpi/nfit/core.c         |   23 +++++++++++++++++++++++
 drivers/acpi/nfit/nfit.h         |    1 +
 drivers/nvdimm/pmem.c            |    4 +++-
 drivers/nvdimm/region_devs.c     |   13 +++++++++++++
 include/linux/libnvdimm.h        |   11 +++++++++++
 tools/testing/nvdimm/test/nfit.c |   14 ++++++++++++--
 6 files changed, 63 insertions(+), 3 deletions(-)

--
