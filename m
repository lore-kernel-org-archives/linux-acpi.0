From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 00/10] ACPI: remove several initcalls
Date: Tue, 24 Mar 2009 16:49:33 -0600
Message-ID: <20090324224834.1262.65260.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:35492 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753541AbZCXWtf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Mar 2009 18:49:35 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Li Shaohua <shaohua.li@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>Li Shaohua <shaohua.li@intel.com>, Zhao Yakui <yakui.zhao@intel.com>

These patches change several ACPI initcalls to explicit calls.
This removes dependencies on link order and makes the code
clearer.

Comments welcome.

---

Bjorn Helgaas (10):
      ACPI: tidy up makefile
      ACPI: call acpi_wakeup_device_init() explicitly rather than as initcall
      ACPI: call acpi_sleep_proc_init() explicitly rather than as initcall
      ACPI: call init_acpi_device_notify() explicitly rather than as initcall
      ACPI: call acpi_debug_init() explicitly rather than as initcall
      ACPI: call acpi_system_init() explicitly rather than as initcall
      ACPI: call acpi_power_init() explicitly rather than as initcall
      ACPI: call acpi_ec_init() explicitly rather than as initcall
      ACPI: call acpi_scan_init() explicitly rather than as initcall
      ACPI: skip DMI power state check when ACPI disabled


 drivers/acpi/Makefile   |    8 ++------
 drivers/acpi/bus.c      |   13 +++++++++++++
 drivers/acpi/debug.c    |   14 ++++++--------
 drivers/acpi/ec.c       |    7 +------
 drivers/acpi/glue.c     |    6 +-----
 drivers/acpi/internal.h |   21 ++++++++++++++++++++-
 drivers/acpi/power.c    |    8 +-------
 drivers/acpi/proc.c     |    7 +------
 drivers/acpi/scan.c     |    9 +--------
 drivers/acpi/system.c   |    9 ++-------
 drivers/acpi/wakeup.c   |    7 +------
 11 files changed, 49 insertions(+), 60 deletions(-)
