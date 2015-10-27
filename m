From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v3 0/2] Hotplug support for libnvdimm
Date: Tue, 27 Oct 2015 16:58:25 -0600
Message-ID: <1445986707-15395-1-git-send-email-vishal.l.verma@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8291 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754216AbbJ0W6q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Oct 2015 18:58:46 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>, Elliott Robert <elliott@hpe.com>, Toshi Kani <toshi.kani@hpe.com>

This series adds support for hotplug of NVDIMMs. Upon hotplug, the ACPI
core calls the .notify callback we register. From this, we evaluate the
_FIT method which returns an updated NFIT. This is scanned for any new
tables, and any new regions found from it are registered and made
available for use.

The series is tested with nfit_test (tools/testing/nvdimm) only, which
means the parts of getting a notification from the acpi core, and calling
_FIT are untested.

Changes from v2->v3:
 - in acpi_nfit_init, splice off the old contents if to a "prev" list and
   only check for duplicates when "prev" is not empty (Dan)
 - in acpi_nfit_init, error out if tables are found to be deleted
 - locking changes: Use device_lock for .add and .notify. Check if
   dev->driver is valid during notify to protect against a prior
   removal (Dan)
 - Change IS_ERR_OR_NULL to IS_ERR for acpi_nfit_desc_init (Dan)
 - nfit_test: for the hot-plug DIMM, add a flush hint table too for
   completeness

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

 drivers/acpi/nfit.c              | 307 +++++++++++++++++++++++++++++++--------
 drivers/acpi/nfit.h              |   2 +
 tools/testing/nvdimm/test/nfit.c | 164 ++++++++++++++++++++-
 3 files changed, 413 insertions(+), 60 deletions(-)

-- 
2.4.3

