From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 0/5] libnvdimm: acpi updates and a revert
Date: Fri, 14 Apr 2017 09:58:11 -0700
Message-ID: <149218909065.3926.1234846095650907678.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43896 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751463AbdDNRDz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Apr 2017 13:03:55 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: Linda Knippers <linda.knippers@hpe.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>, vishal.l.verma@intel.com

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

Dan Williams (5):
      Revert "libnvdimm: band aid btt vs clear poison locking"
      acpi, nfit: add support for acpi 6.1 dimm state flags
      tools/testing/nvdimm: test acpi 6.1 health state flags
      acpi, nfit: support "map failed" dimms
      acpi, nfit: limit ->flush_probe() to initialization work


 drivers/acpi/nfit/core.c         |   61 +++++++++++++++++++++++++++++++-------
 drivers/acpi/nfit/nfit.h         |    1 +
 drivers/nvdimm/claim.c           |   10 +-----
 tools/testing/nvdimm/test/nfit.c |   40 +++++++++++++++++++++++--
 4 files changed, 88 insertions(+), 24 deletions(-)
