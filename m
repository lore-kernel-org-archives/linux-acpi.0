From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 0/3] misc updates for Address Range Scrub
Date: Fri, 30 Sep 2016 17:19:28 -0600
Message-ID: <1475277571-10152-1-git-send-email-vishal.l.verma@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:60543 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751036AbcI3XUT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Sep 2016 19:20:19 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Linda Knippers <linda.knippers@hpe.com>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Vishal Verma <vishal.l.verma@intel.com>

Changes in v3:
- Rename MCE_SCRUB* to HW_ERROR_SCRUB* (Dan)
- Make the default scrub_mode '0' so it doesn't have to be set
  explicitly (Dan)


Changes in v2:
- Change the 'scrub' attribute to only show the number of completed scrubs,
  and start a new one ondemand. (Dan)
- Add a new attribute 'hw_error_scrub' which controls whether or not a full
  scrub will run on hardware memory errors. (Dan)

Patch 1 changes the default behaviour on machine check exceptions to
just adding the error address to badblocks accounting instead of starting
a full ARS. The old behaviour can be enabled via sysfs.

Patch 2 and 3 fix a problem where stale badblocks could show up after an
on-demand ARS or an MCE triggered scrub, or even a namespace disable/enable
cycle because when clearing poison, we didn't clear the internal
nvdimm_bus->poison_list.


Vishal Verma (3):
  nfit: don't start a full scrub by default for an MCE
  pmem: reduce kmap_atomic sections to the memcpys only
  libnvdimm: clear the internal poison_list when clearing badblocks

 drivers/acpi/nfit/core.c  | 53 ++++++++++++++++++++++++++++++++++
 drivers/acpi/nfit/mce.c   | 24 ++++++++++++----
 drivers/acpi/nfit/nfit.h  |  6 ++++
 drivers/nvdimm/bus.c      |  2 ++
 drivers/nvdimm/core.c     | 73 ++++++++++++++++++++++++++++++++++++++++++++---
 drivers/nvdimm/pmem.c     | 28 ++++++++++++++----
 include/linux/libnvdimm.h |  2 ++
 7 files changed, 174 insertions(+), 14 deletions(-)

-- 
2.7.4

