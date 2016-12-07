From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 0/5] acpi, nfit: acpi_nfit_ctl() corner case fixes + tests
Date: Tue, 06 Dec 2016 16:39:20 -0800
Message-ID: <148107115997.25138.3445497812509173966.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13877 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750960AbcLGAna (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Dec 2016 19:43:30 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: Vishal Verma <vishal.l.verma@intel.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-acpi@vger.kernel.org

>From [PATCH 5/5] tools/testing/nvdimm: unit test acpi_nfit_ctl():
---

A recent flurry of bug discoveries in the nfit driver's DSM marshalling
routine has highlighted the fact that we do not have unit test coverage
for this routine. Add a self-test of acpi_nfit_ctl() routine before
probing the "nfit_test.0" device. This mocks stimulus to acpi_nfit_ctl()
and if any of the tests fail "nfit_test.0" will be unavailable causing
the rest of the tests to not run / fail.
    
This unit test will also be a place to land reproductions of quirky
BIOS behavior discovered in the field and ensure the kernel does not
regress against implementations it has seen in practice.

---

The problems addressed in this round of fixes date are concentrated
around the variable-length output from the ARS (Address Range Scrub)
Status command, and the proper handling of per-command extended status
values.

They are urgent as improper handling of ARS commands can lead to a
platform that fails to boot. If there are media errors in the boot path
on a platform that does not support machine-check recovery we rely on
the ARS to inform the pmem driver which address ranges may trigger a
machine-check when read.

---

Dan Williams (4):
      acpi, nfit, libnvdimm: fix / harden ars_status output length handling
      acpi, nfit: validate ars_status output buffer size
      acpi, nfit: fix bus vs dimm confusion in xlat_status
      tools/testing/nvdimm: unit test acpi_nfit_ctl()

Vishal Verma (1):
      acpi, nfit: fix extended status translations for ACPI DSMs


 drivers/acpi/nfit/core.c              |   54 +++++---
 drivers/acpi/nfit/nfit.h              |    2 
 drivers/nvdimm/bus.c                  |   25 +++
 include/linux/libnvdimm.h             |    2 
 tools/testing/nvdimm/Kbuild           |    1 
 tools/testing/nvdimm/test/iomap.c     |   23 +++
 tools/testing/nvdimm/test/nfit.c      |  236 ++++++++++++++++++++++++++++++++-
 tools/testing/nvdimm/test/nfit_test.h |    8 +
 8 files changed, 324 insertions(+), 27 deletions(-)
