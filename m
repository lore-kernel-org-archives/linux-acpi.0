From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2 0/2] Hotplug support for libnvdimm
Date: Wed, 14 Oct 2015 17:04:24 -0600
Message-ID: <1444863866-19173-1-git-send-email-vishal.l.verma@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:42898 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753988AbbJNXEl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Oct 2015 19:04:41 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Toshi Kani <toshi.kani@hpe.com>, Elliott Robert <elliott@hpe.com>, Vishal Verma <vishal.l.verma@intel.com>

This series adds support for hotplug of NVDIMMs. Upon hotplug, the ACPI
core calls the .notify callback we register. From this, we evaluate the
_FIT method which returns an updated NFIT. This is scanned for any new
tables, and any new regions found from it are registered and made
available for use.

The series is tested with nfit_test (tools/testing/nvdimm) only, which
means the parts of getting a notification from the acpi core, and calling
_FIT are untested.

Changes from v1->v2:
 - If a 0-length header is found in the nfit (patch 1), also spew a
   warning (Jeff)
 - Don't make a new acpi_evaluate_fit helper - open code a call to
   acpi_evaluate_object in nfit.c (Dan/Rafael)
 - Remove a warning for duplicate DCRs (Toshi)
 - Add an init_lock to protect the notify handler from racing with an
   'add' or 'remove' (Dan)
 - The only NVDIMM in a system *could* potentially come from a hotplug,
   esp in the virtualization case. Refactor how acpi_nfit_desc is
   initialized to account for this. For the same reason, don't fail when
   a valid NFIT is not found at driver load time. A by-product of this
   change is that we need to initialize lists and mutexes manually in
   nfit test. (Dan)
 - Remove acpi_nfit_merge (added in v1) as it is now essentially
   the same as acpi_nfit_init
 - Reword the commit message for patch 2/2 to say 'hot add' instead of
   hotplug, making it clearer that hot removal support is not being added


Vishal Verma (2):
  nfit: in acpi_nfit_init, break on a 0-length table
  acpi: nfit: Add support for hot-add

 drivers/acpi/nfit.c              | 203 +++++++++++++++++++++++++++++----------
 drivers/acpi/nfit.h              |   2 +
 tools/testing/nvdimm/test/nfit.c | 156 +++++++++++++++++++++++++++++-
 3 files changed, 310 insertions(+), 51 deletions(-)

-- 
2.4.3

