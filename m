From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 0/6] BTT error clearing rework
Date: Fri, 14 Jul 2017 16:11:42 -0600
Message-ID: <20170714221148.11232-1-vishal.l.verma@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:17627 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751035AbdGNWN2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Jul 2017 18:13:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Jeff Moyer <jmoyer@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Toshi Kani <toshi.kani@hpe.com>, Vishal Verma <vishal.l.verma@intel.com>

Clearing errors or badblocks during a BTT write requires sending an ACPI
DSM, which means potentially sleeping. Since a BTT IO happens in atomic
context (preemption disabled, spinlocks may be held), we cannot perform
error clearing in the course of an IO. Due to this error clearing for
BTT IOs has hitherto been disabled.

This series fixes these problems by moving the error clearing out of
the atomic sections in the BTT.

Patch 5 makes a core ACPI change and I would like some views on it
from the ACPI guys - does the problem make sense, and is this the right
approach to solve it?


Vishal Verma (6):
  btt: fix a missed NVDIMM_IO_ATOMIC case in the write path
  btt: refactor map entry operations with macros
  btt: ensure that flags were also unchanged during a map_read
  btt: cache sector_size in arena_info
  acpi: change memory allocations to GFP_NOIO
  libnvdimm, btt: rework error clearing

 drivers/nvdimm/btt.c              | 111 ++++++++++++++++++++++++++++++++------
 drivers/nvdimm/btt.h              |  11 ++++
 drivers/nvdimm/claim.c            |   9 +---
 include/acpi/platform/aclinuxex.h |   6 +--
 4 files changed, 109 insertions(+), 28 deletions(-)

-- 
2.9.3

