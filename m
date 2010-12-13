From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH v2 0/8] Minimize ACPICA/linux GPE code divergence
Date: Mon, 13 Dec 2010 13:35:23 +0800
Message-ID: <1292218523.10384.81.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:8098 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738Ab0LMFax (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Dec 2010 00:30:53 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Bob Moore <robert.moore@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

Hi, Rafael

v2: split patches

(I know you have opinions on PATCH 3, but let me include it here now, we
can resolve it later)

We have ported below of your GPE patches into ACPICA code base.

0001-ACPI-ACPICA-Do-not-execute-_PRW-methods-during-initi.patch
0002-ACPI-ACPICA-Fail-acpi_gpe_wakeup-if-ACPI_GPE_CAN_WAK.patch
0003-ACPI-ACPICA-Simplify-acpi_ev_initialize_gpe_block.patch
0004-ACPI-ACPICA-Fix-reference-counting-problems-with-GPE.patch
0005-ACPI-ACPICA-Defer-enabling-of-runtime-GPEs-v3.patch

You can find the ACPICA port at,
http://git.moblin.org/cgit.cgi/acpica/commit/?id=3bc77e86ae03b3ceb7241f224053e399fb3f56b2

As the port, some changes were made, function and variable renamed, etc,
and new features were added, implicit notify, global event handler, etc.

These changes and new features introduce a lot of ACPICA/linux GPE code
divergence. So this series of patches is to minimize this type of
divergence.

[PATCH 1/8] ACPICA: Move GPE functions to new file evxfgpe.c
[PATCH 2/8] ACPICA: Rename some function and variable names
[PATCH 3/8] ACPICA: New GPE handler interface
[PATCH 4/8] ACPICA: Remove unused function declarations
[PATCH 5/8] ACPICA: Fix local variable mess in acpi_ev_asynch_execute_gpe_method
[PATCH 6/8] ACPICA: Implicit notify support
[PATCH 7/8] ACPICA: Global event handler
[PATCH 8/8] ACPICA: Misc comments to minimize code divergence

drivers/acpi/acpica/Makefile     |    2 +-
 drivers/acpi/acpica/acevents.h   |   21 +-
 drivers/acpi/acpica/acglobal.h   |    7 +-
 drivers/acpi/acpica/achware.h    |    2 +-
 drivers/acpi/acpica/aclocal.h    |   13 +-
 drivers/acpi/acpica/evevent.c    |   12 +-
 drivers/acpi/acpica/evgpe.c      |  265 ++++++++++-----
 drivers/acpi/acpica/evgpeblk.c   |   33 +-
 drivers/acpi/acpica/evgpeinit.c  |   25 ++-
 drivers/acpi/acpica/evgpeutil.c  |   39 +++
 drivers/acpi/acpica/evxface.c    |   77 ++++-
 drivers/acpi/acpica/evxfevnt.c   |  600 ----------------------------------
 drivers/acpi/acpica/evxfgpe.c    |  669 ++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/hwgpe.c      |   32 +-
 drivers/acpi/acpica/utglobal.c   |    3 +-
 drivers/acpi/dock.c              |    2 +-
 drivers/acpi/ec.c                |    3 +-
 drivers/acpi/scan.c              |    7 +-
 drivers/acpi/sysfs.c             |   19 +-
 drivers/acpi/wakeup.c            |    4 +-
 drivers/char/ipmi/ipmi_si_intf.c |    3 +-
 include/acpi/acpixf.h            |   18 +-
 include/acpi/actypes.h           |   54 ++-
 23 files changed, 1117 insertions(+), 793 deletions(-)

Thanks for any comments.

Lin Ming



