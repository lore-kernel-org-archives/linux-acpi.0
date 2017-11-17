From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 00/11] ACPICA release 20170929
Date: Fri, 17 Nov 2017 15:40:13 -0800
Message-ID: <20171117234024.833-1-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:53935 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161767AbdKQXpE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 18:45:04 -0500
In-Reply-To: <erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Erik Schmauss <erik.schmauss@intel.com>

This series of patches are from the 20170929 release of ACPICA.
This set is meant to be applied on top of the 20170831 ACPICA release.

Bob Moore (4):
  ACPICA: Rename AE_AML_INFINITE_LOOP exception
  ACPICA: Tools: Deploy -vd option (build date/time) across all tools
  ACPICA: iASL/Tools: Add support for PDTT,SDEV,TPM2 ACPI tables
  ACPICA: Update version to 20170929

Colin Ian King (1):
  ACPICA: Avoid null pointer dereference on Op.

Erik Schmauss (3):
  ACPICA: Disassembler: reset parser_state's Aml pointer when parsing
    bad externals
  ACPICA: disassembler: getting rid of error message
  ACPICA: iASL: change processing of external op namespace nodes for
    correctness

Jung-uk Kim (1):
  ACPICA: Fix an off-by-one error in acpi_get_timer_duration().

Lv Zheng (2):
  ACPICA: Dispatcher: Introduce timeout mechanism for infinite loop
    detection
  ACPICA: Utilities: Cleanup style issue for bit clearing

 drivers/acpi/acpica/acapps.h             |  3 ++
 drivers/acpi/acpica/aclocal.h            |  2 +-
 drivers/acpi/acpica/dscontrol.c          | 18 ++++----
 drivers/acpi/acpica/hwtimer.c            | 29 ++++++------
 drivers/acpi/acpica/nsaccess.c           | 13 +++---
 drivers/acpi/acpica/nssearch.c           |  1 +
 drivers/acpi/acpica/psobject.c           | 10 +----
 drivers/acpi/acpica/psutils.c            |  6 +--
 drivers/acpi/acpica/utinit.c             |  1 -
 drivers/acpi/acpica/utmath.c             |  4 +-
 include/acpi/acconfig.h                  |  4 +-
 include/acpi/acexcep.h                   |  6 +--
 include/acpi/acpixf.h                    |  6 +--
 include/acpi/actbl1.h                    | 77 +++++++++++++++++++++++++++++---
 include/acpi/actbl2.h                    | 14 +++++-
 include/acpi/actypes.h                   |  2 +
 tools/power/acpi/tools/acpidump/apmain.c | 28 ++++++++++--
 17 files changed, 160 insertions(+), 64 deletions(-)

-- 
2.13.6

