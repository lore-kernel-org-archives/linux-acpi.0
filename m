From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 0/3] Hotplug support for libnvdimm
Date: Wed,  7 Oct 2015 15:49:34 -0600
Message-ID: <1444254577-23744-1-git-send-email-vishal.l.verma@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:54372 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753851AbbJGVt7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Oct 2015 17:49:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org

This series adds support for hotplug of NVDIMMs. Upon hotplug, the ACPI
core calls the .notify callback we register. From this, we evaluate the
_FIT method which returns an updated NFIT. This is scanned for any new
tables, and any new regions found from it are registered and made
available for use.

The series is tested with nfit_test (tools/testing/nvdimm) only, which
means the parts of getting a notification from the acpi core, and calling
_FIT are untested.

Dan/Rafael, I have a couple of 'TODO' comments in patch 3, where I wasn't
sure of what we should do - if you have any suggestions, let me know.

Vishal Verma (3):
  nfit: in acpi_nfit_init, break on a 0-length table
  acpi: add a utility function for evaluating _FIT
  acpi: nfit: Add support for hotplug

 drivers/acpi/nfit.c              | 139 +++++++++++++++++++++++++++++++++----
 drivers/acpi/nfit.h              |   2 +
 drivers/acpi/utils.c             |  23 +++++++
 include/acpi/acpi_bus.h          |   1 +
 tools/testing/nvdimm/test/nfit.c | 144 ++++++++++++++++++++++++++++++++++++++-
 5 files changed, 294 insertions(+), 15 deletions(-)

-- 
2.4.3

