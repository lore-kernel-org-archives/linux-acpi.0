From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v4 0/6] BTT error clearing rework
Date: Wed, 26 Jul 2017 17:35:40 -0600
Message-ID: <20170726233546.29052-1-vishal.l.verma@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:49250 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751441AbdGZXhn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Jul 2017 19:37:43 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Jeff Moyer <jmoyer@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Toshi Kani <toshi.kani@hpe.com>, Vishal Verma <vishal.l.verma@intel.com>

Changes in v4:
 - move the deadlock fix to before enabling the BTT error clear paths (Dan)
 - No need for an error lock per freelist entry, just have one per arena (Dan)

Changes in v3:
 - Change the dynamically allocated (during IO) zerobuf to the kernel's
   ZERO_PAGE for error clearing (patch 5) (Dan).
 - Move the NOIO fixes a level down into nvdimm_clear_poison since both
   btt and pmem poison clearing goes through that (Dan).

Changes in v2:
 - Drop the ACPI allocation change patch. Instead use
   memalloc_noio_{save,restore} to set the GFP_NOIO flag around anything
   that can be expected to call into ACPI for clearing errors. (Rafael, Dan).

Clearing errors or badblocks during a BTT write requires sending an ACPI
DSM, which means potentially sleeping. Since a BTT IO happens in atomic
context (preemption disabled, spinlocks may be held), we cannot perform
error clearing in the course of an IO. Due to this error clearing for
BTT IOs has hitherto been disabled.

This series fixes these problems by moving the error clearing out of
the atomic sections in the BTT.

Also fix a potential deadlock that can occur while clearing errors
from either BTT or pmem due to memory allocations in the IO path.


Vishal Verma (6):
  btt: fix a missed NVDIMM_IO_ATOMIC case in the write path
  btt: refactor map entry operations with macros
  btt: ensure that flags were also unchanged during a map_read
  btt: cache sector_size in arena_info
  libnvdimm: fix potential deadlock while clearing errors
  libnvdimm, btt: rework error clearing

 drivers/nvdimm/btt.c   | 116 +++++++++++++++++++++++++++++++++++++++++--------
 drivers/nvdimm/btt.h   |  11 +++++
 drivers/nvdimm/bus.c   |   6 +++
 drivers/nvdimm/claim.c |   9 +---
 4 files changed, 117 insertions(+), 25 deletions(-)

-- 
2.9.3

