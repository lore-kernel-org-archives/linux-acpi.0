From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 00/12] ACPICA 20171215
Date: Wed,  3 Jan 2018 15:06:19 -0800
Message-ID: <20180103230631.15939-1-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:43368 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751014AbeACXHi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Jan 2018 18:07:38 -0500
In-Reply-To: <erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Erik Schmauss <erik.schmauss@intel.com>

The following are the linuxized patches for ACPICA version 20171215

Bob Moore (8):
  ACPICA: Debug output, no functional change
  ACPICA: Update for a few debug output statements
  ACPICA: Fix a regression in the acpi_evaluate_object_type interface
  ACPICA: Cleanup the global variables and update comments. No
    functional change
  ACPICA: Create and deploy safe version of strncpy. No functional
    change
  ACPICA: Rename a global variable, no functional change
  ACPICA: Fix a couple memory leaks during package object resolution
  ACPICA: Update version to 20171215

Erik Schmauss (3):
  ACPICA: Debugger: fix slight indentation issue
  ACPICA: DT compiler: prevent error if optional field at the end of
    table is not present
  ACPICA: trivial style fix, no functional change

Mario Limonciello (1):
  ACPICA: Recognize the Windows 10 version 1607 and 1703 OSI strings

 drivers/acpi/acpica/acglobal.h  | 82 ++++++++++++++---------------------------
 drivers/acpi/acpica/acutils.h   |  2 +
 drivers/acpi/acpica/dbfileio.c  |  4 +-
 drivers/acpi/acpica/dspkginit.c | 21 +++++++----
 drivers/acpi/acpica/exdump.c    | 11 +++---
 drivers/acpi/acpica/hwvalid.c   | 14 +++----
 drivers/acpi/acpica/nsxfeval.c  |  9 +++--
 drivers/acpi/acpica/psutils.c   | 10 +++--
 drivers/acpi/acpica/utdebug.c   | 18 ++++++++-
 drivers/acpi/acpica/utnonansi.c |  9 +++++
 drivers/acpi/acpica/utosi.c     |  2 +
 drivers/acpi/acpica/uttrack.c   |  4 +-
 include/acpi/acexcep.h          |  6 ++-
 include/acpi/acpixf.h           |  2 +-
 include/acpi/actypes.h          |  2 +
 15 files changed, 104 insertions(+), 92 deletions(-)

-- 
2.14.3

