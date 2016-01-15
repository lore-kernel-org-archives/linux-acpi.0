From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 0/3] misc badblocks/poison list cleanup
Date: Thu, 14 Jan 2016 18:31:53 -0700
Message-ID: <1452821516-26788-1-git-send-email-vishal.l.verma@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:21756 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150AbcAOBcF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Jan 2016 20:32:05 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: Vishal Verma <vishal.l.verma@intel.com>, linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Linda Knippers <linda.knippers@hpe.com>

Some incremental patches:

Patch 1 re-adds checks for absence of a valid badblocks struct in the
badblocks API

Patch 2 moves ARS calls from the nfit driver to core

Patch 3 changes the status checking for ARS_START and ARS_STATUS from
using magic numbers to enums.

Vishal Verma (3):
  badblocks: add null checks for bb in the badblocks api
  libnvdimm, nfit: move nvdimm poison search to core
  libnvdimm: use enums for ARS statuses

 block/badblocks.c         |  21 +++--
 drivers/acpi/nfit.c       | 198 +---------------------------------------------
 drivers/nvdimm/core.c     | 197 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/nvdimm/nd-core.h  |  13 +++
 include/linux/libnvdimm.h |   3 +-
 5 files changed, 227 insertions(+), 205 deletions(-)

-- 
2.5.0

