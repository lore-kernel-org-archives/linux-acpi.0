From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/3] ACPICA: Missing patches for 20121220 release.
Date: Fri, 11 Jan 2013 07:29:08 +0000 (UTC)
Message-ID: <cover.1357982088.git.lv.zheng@intel.com>
References: <cover.1356668530.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23372 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753669Ab3AKH3C (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Jan 2013 02:29:02 -0500
Date: Sat, 12 Jan 2013 23:28:50 +0800
In-Reply-To: <cover.1356668530.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rafael J Wysocki <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Rafael J Wysocki <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

This patch set is based on the ACPICA 20121220 release currently can be
found in the linux-next branch of linux-pm tree.
This patch set has stayed in the acpica-201212 branch of the ACPICA
release test tree for one days.
The source code differences between Linux and ACPICA can be summarized as
follows:
1. 1963 Lines (70.0 Kbytes) before applying the patch set;
2. 1796 Lines (64.8 Kbytes) after applying the patch set.

Please review.

Bob Moore (1):
  ACPICA: Source restructuring: split large files into 8 new files.

Lv Zheng (2):
  ACPICA: Cleanup table handler naming conflicts.
  ACPICA: Add new statistics interface.

 drivers/acpi/acpica/Makefile     |    8 +-
 drivers/acpi/acpica/acdebug.h    |   17 +
 drivers/acpi/acpica/acevents.h   |   21 +-
 drivers/acpi/acpica/acglobal.h   |    4 +-
 drivers/acpi/acpica/acnamesp.h   |   12 +
 drivers/acpi/acpica/acparser.h   |   23 +-
 drivers/acpi/acpica/acresrc.h    |    6 +-
 drivers/acpi/acpica/acutils.h    |   50 ++-
 drivers/acpi/acpica/dsmethod.c   |    1 +
 drivers/acpi/acpica/evhandler.c  |  529 ++++++++++++++++++++++++
 drivers/acpi/acpica/evregion.c   |  582 +++------------------------
 drivers/acpi/acpica/evsci.c      |    1 +
 drivers/acpi/acpica/nspredef.c   |  581 +-------------------------
 drivers/acpi/acpica/nsprepkg.c   |  621 ++++++++++++++++++++++++++++
 drivers/acpi/acpica/psloop.c     |  622 ----------------------------
 drivers/acpi/acpica/psobject.c   |  647 +++++++++++++++++++++++++++++
 drivers/acpi/acpica/psopcode.c   |  172 --------
 drivers/acpi/acpica/psopinfo.c   |  223 ++++++++++
 drivers/acpi/acpica/rsdump.c     |  409 +------------------
 drivers/acpi/acpica/rsdumpinfo.c |  454 +++++++++++++++++++++
 drivers/acpi/acpica/tbxface.c    |    4 +-
 drivers/acpi/acpica/utglobal.c   |   11 +
 drivers/acpi/acpica/utmisc.c     |  828 ++++----------------------------------
 drivers/acpi/acpica/utownerid.c  |  218 ++++++++++
 drivers/acpi/acpica/utstring.c   |  574 ++++++++++++++++++++++++++
 drivers/acpi/acpica/utxface.c    |   38 ++
 drivers/acpi/numa.c              |    2 +-
 drivers/acpi/tables.c            |    6 +-
 include/acpi/acconfig.h          |    1 +
 include/acpi/acpixf.h            |    6 +-
 include/acpi/actypes.h           |   12 +-
 include/linux/acpi.h             |   15 +-
 32 files changed, 3580 insertions(+), 3118 deletions(-)
 create mode 100644 drivers/acpi/acpica/evhandler.c
 create mode 100644 drivers/acpi/acpica/nsprepkg.c
 create mode 100644 drivers/acpi/acpica/psobject.c
 create mode 100644 drivers/acpi/acpica/psopinfo.c
 create mode 100644 drivers/acpi/acpica/rsdumpinfo.c
 create mode 100644 drivers/acpi/acpica/utownerid.c
 create mode 100644 drivers/acpi/acpica/utstring.c

-- 
1.7.10

