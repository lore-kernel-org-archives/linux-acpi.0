From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 0/7] libnvdimm: acpi updates and a revert
Date: Fri, 14 Apr 2017 14:57:05 -0700
Message-ID: <149220702552.36563.10552898152402020832.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:5754 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752089AbdDNWCu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Apr 2017 18:02:50 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: Linda Knippers <linda.knippers@hpe.com>, Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Toshi Kani <toshi.kani@hpe.com>, linux-acpi@vger.kernel.org

Changes since v1:
* moved the rename of nfit_mem_dcr_init() to __nfit_mem_init() to "acpi,
  nfit: support 'map failed' dimms"
* added "acpi, nfit: collate health state flags"
* added "tools/testing/nvdimm: fix nfit_test shutdown crashes"

---

With Dave's recent fix [1], we can restore error clearing for btt i/o in
4.12.

ACPI 6.1 introduced new health state flags. Beyond reflecting them in
the dimmX/flags sysfs attribute we also need to handle the deeper
implications of the ACPI_NFIT_MEM_MAP_FAILED flag which changes
assumptions on how the driver discovers dimms. In the "map failed" case
there may missing or no SPA entries associated with a dimm. Those dimms
should still be registered with libnvdimm so that the error state can be
communicated and recovery attempted.

[1]: https://patchwork.kernel.org/patch/9680035/

---

Dan Williams (7):
      Revert "libnvdimm: band aid btt vs clear poison locking"
      acpi, nfit: add support for acpi 6.1 dimm state flags
      tools/testing/nvdimm: test acpi 6.1 health state flags
      acpi, nfit: support "map failed" dimms
      acpi, nfit: collate health state flags
      acpi, nfit: limit ->flush_probe() to initialization work
      tools/testing/nvdimm: fix nfit_test shutdown crashes


 drivers/acpi/nfit/core.c         |   82 +++++++++++++++++++++++++++++++-------
 drivers/acpi/nfit/nfit.h         |    3 +
 drivers/nvdimm/claim.c           |   10 -----
 tools/testing/nvdimm/test/nfit.c |   50 +++++++++++++++++++++--
 4 files changed, 115 insertions(+), 30 deletions(-)
