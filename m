From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 0/6] nfit, address-range-scrub: rework and fixes
Date: Mon, 02 Apr 2018 21:46:01 -0700
Message-ID: <152273076087.38372.4803377088477706610.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: Dave Jiang <dave.jiang@intel.com>, stable@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>, Vishal Verma <vishal.l.verma@intel.com>, linux-acpi@vger.kernel.orgdave.jiang@intel.comvishal.l.verma@intel.com
List-Id: linux-acpi@vger.kernel.org

Given the fact that ARS can take 10s to 100s of seconds it is not
feasible to wait for ARS completion before publishing persistent memory
namespaces. Instead convert the ARS implementation to perform a short
ARS for critical errors, ones that caused a previous system reset,
before registering namespaces. Finally, arrange for all long ARS
operations to run in the background and populate the badblock lists at
run time.

While developing this rework a handful of cleanups and fixes also fell
out.

---

Dan Williams (6):
      nfit: fix region registration vs block-data-window ranges
      nfit, address-range-scrub: fix scrub in-progress reporting
      libnvdimm: add an api to cast a 'struct nd_region' to its 'struct device'
      nfit, address-range-scrub: introduce nfit_spa->ars_state
      nfit, address-range-scrub: rework and simplify ARS state machine
      nfit, address-range-scrub: add module option to skip initial ars


 drivers/acpi/nfit/core.c     |  443 ++++++++++++++++++------------------------
 drivers/acpi/nfit/nfit.h     |   13 +
 drivers/nvdimm/nd.h          |    1 
 drivers/nvdimm/region_devs.c |    8 +
 include/linux/libnvdimm.h    |    1 
 5 files changed, 213 insertions(+), 253 deletions(-)
