From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 0/3] ACPICA/ACPI: clean up power button event management
	during resume
Date: Fri, 19 Jun 2009 14:57:47 -0600
Message-ID: <20090619205713.30130.79530.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:47296 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbZFSU5p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jun 2009 16:57:45 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bob Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

This mini-series moves a little resume-path code from the host OS
(Linux in this case) into the ACPI CA.

When resuming, OSPM must clear GPEs and power button events to prevent
taking spurious events when interrupts are enabled.  Linux currently
clears these events itself, but this series adds code to do it in the
ACPICA (in acpi_leave_sleep_state_prep(), which is already supposed to
be called before enabling interrupts).  This should be safe without
any host OS changes.

The last patch takes out the event clearing from Linux and obviously
depends on the previous ACPICA patches.  It's safe to drop this one
(no harm in clearing the events twice).  I can easily post it again
later.

---

Bjorn Helgaas (3):
      ACPICA: Use fixed event wrappers to enable/disable/clear
      ACPICA: Clear GPEs and power button events during wakeup
      ACPI: remove clearing of events on resume, now that ACPI CA does it


 drivers/acpi/acpica/evevent.c |   13 +++----------
 drivers/acpi/acpica/hwsleep.c |   24 +++++++-----------------
 drivers/acpi/sleep.c          |   14 --------------
 3 files changed, 10 insertions(+), 41 deletions(-)

-- 
Bjorn
