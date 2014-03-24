From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/5] ACPICA: Merge auto-serialization support to reduce source code differences between Linux and ACPICA upstream.
Date: Mon, 24 Mar 2014 14:48:26 +0800
Message-ID: <cover.1395638745.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:22505 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751957AbaCXGsn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Mar 2014 02:48:43 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

The auto-serialization feature is introduced in ACPICA 20140214 release, it
is reverted due to the new bug reports.
The feature fixes a compliance issue between the ACPICA interpreter and the
de-facto implementation.  Users are encouraged to use this feature to
provide the feedbacks.

This series re-orders the patches to implement the feature so that it can
be marked out by reverting the last patch in this series when new problems
are detected.
This series can also reduce the source code differences between Linux and
ACPICA upstream.

Bob Moore (2):
  ACPICA: Add auto-serialization support for ill-behaved control
    methods.
  ACPICA: Ignore sync_level for methods that have been auto-serialized.

Lv Zheng (3):
  ACPICA: Remove global option to serialize all control methods.
  ACPICA: Add additional named objects for the auto-serialize method
    scan.
  ACPICA: Enable auto-serialization as a default kernel behavior.

 Documentation/kernel-parameters.txt |   10 ++-
 drivers/acpi/acpica/acdispat.h      |   13 +--
 drivers/acpi/acpica/acglobal.h      |   11 +--
 drivers/acpi/acpica/acinterp.h      |    4 -
 drivers/acpi/acpica/acobject.h      |    3 +-
 drivers/acpi/acpica/acstruct.h      |    3 +
 drivers/acpi/acpica/dsinit.c        |   59 ++++++++++---
 drivers/acpi/acpica/dsmethod.c      |  156 +++++++++++++++++++++++++++++++++--
 drivers/acpi/acpica/dswload.c       |   16 ++++
 drivers/acpi/acpica/exsystem.c      |   12 +--
 drivers/acpi/acpica/exutils.c       |   80 +++---------------
 drivers/acpi/acpica/nsinit.c        |    5 +-
 drivers/acpi/acpica/nsload.c        |    4 +-
 drivers/acpi/acpica/psloop.c        |    4 +
 drivers/acpi/acpica/psobject.c      |    7 +-
 drivers/acpi/osl.c                  |   16 ++--
 include/acpi/acpixf.h               |    2 +-
 17 files changed, 281 insertions(+), 124 deletions(-)

-- 
1.7.10

