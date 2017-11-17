From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 00/15] ACPICA release 20171110
Date: Fri, 17 Nov 2017 15:42:15 -0800
Message-ID: <20171117234230.913-1-erik.schmauss@intel.com>
References: <erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39431 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759888AbdKQXqb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Nov 2017 18:46:31 -0500
In-Reply-To: <erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Erik Schmauss <erik.schmauss@intel.com>

This series comes from the 20171110 release of ACPICA.
This set of patches is meant to be applied on top of the 20170929
release of ACPICA.

Bob Moore (10):
  ACPICA: Use local 64-bit divide support for string conversions
  ACPICA: Update output from ACPI_EXCEPTION macro
  ACPICA: Add an additional error message for EC timeouts
  ACPICA: Enhance error messages from namespace create/lookup operations
  ACPICA: ACPI 6.0A: Changes to the NFIT ACPI table
  ACPICA: Small typo fix, no functional change.
  ACPICA: Debugger: add "background" command for method execution
  ACPICA: Update mutex error messages, no functional change
  ACPICA: Update linkage for get mutex name interface
  ACPICA: Update version to 20171110

Colin Ian King (1):
  ACPICA: Trivial fix to spelling mistake in comment

Erik Schmauss (2):
  ACPICA: ACPICA: style edits to utility function output, no functional
    change
  ACPICA: Namespace: fix memory leak from building prefixed pathname

Hanjun Guo (1):
  ACPICA: iasl: Add SMMUv3 device ID mapping index support

Jeremy Linton (1):
  ACPICA: ACPI 6.2: Additional PPTT flags

 drivers/acpi/acpica/acdebug.h    |   4 ++
 drivers/acpi/acpica/aclocal.h    |  13 ++--
 drivers/acpi/acpica/acmacros.h   |   2 +-
 drivers/acpi/acpica/acnamesp.h   |   3 +
 drivers/acpi/acpica/acutils.h    |  19 +++--
 drivers/acpi/acpica/dbexec.c     | 110 ++++++++++++++++++++++++++++-
 drivers/acpi/acpica/dbinput.c    | 145 +++++++++++++++++++++----------------
 drivers/acpi/acpica/dsfield.c    |  28 +++++---
 drivers/acpi/acpica/dsobject.c   |   4 +-
 drivers/acpi/acpica/dsutils.c    |   3 +-
 drivers/acpi/acpica/dswload.c    |   6 +-
 drivers/acpi/acpica/dswload2.c   |  13 ++--
 drivers/acpi/acpica/evregion.c   |  10 +++
 drivers/acpi/acpica/nsconvert.c  |   3 +-
 drivers/acpi/acpica/nsnames.c    | 149 +++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/psargs.c     |   2 +-
 drivers/acpi/acpica/utdecode.c   |  11 +--
 drivers/acpi/acpica/uterror.c    |  73 +++++++++++++++++++
 drivers/acpi/acpica/utmutex.c    |   9 +--
 drivers/acpi/acpica/utstrsuppt.c |  35 +++++----
 drivers/acpi/acpica/uttrack.c    |   2 +-
 drivers/acpi/acpica/utxferror.c  |   8 +--
 include/acpi/acpixf.h            |   2 +-
 include/acpi/actbl1.h            |  84 +++++++++++++++++++++-
 include/acpi/actbl2.h            |   1 +
 25 files changed, 611 insertions(+), 128 deletions(-)

-- 
2.13.6

