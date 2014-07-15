From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 0/9] ACPICA: Improve GPE handling model.
Date: Tue, 15 Jul 2014 11:07:10 +0800
Message-ID: <cover.1405306438.git.lv.zheng@intel.com>
References: <cover.1403060601.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:42180 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757258AbaGODHZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Jul 2014 23:07:25 -0400
In-Reply-To: <cover.1403060601.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patchset enables the ideal GPE handling model. The ideal GPE handling
model should be able to handle the following cases:

   1. When upper layers (the users of the driver) submit requests to the
      drivers, it means they care about the underlying hardware. For this
      case, acpi_enable_gpe() should be invoked. When the reference count
      is increased from 0 to 1, driver enables the hardware IRQ. And
      acpi_disable_gpe() is used as the reversal when the users have
      completed the submitted requests.
   2. Driver may temporarily disables the IRQ and wants to re-enable it
      later, this case is normally used in order to prevent IRQ storm.
      When a driver cannot fully solve the condition that triggered the IRQ
      in the IRQ context, in order not to trigger IRQ storm, driver has to
      disable IRQ and re-enables it in the deferred execution environment
      - which should be in a task context. The acpi_set_gpe() API should be
      used exactly for this purpose.

The reason why this model hasn't been enabled for the current Linux ACPI
drivers is:
  In ACPICA, the same GPE lock is held while invoking the GPE handler
  callback, it's thus impossible to invoke GPE APIs in the GPE handler
  because the APIs require to hold the GPE lock. The recursive locking
  leads to dead locks. This is a simple design defect, callbacks should
  always be invoked in a lockless environment, normally in Linux, this is
  achieved by RCU locking, and in ACPICA, we achieve this using reference
  counting.

After fixing the above bug and doing necessary cleanups in the ACPICA GPE
handling code, we now can enable this ideal GPE handling model for the EC
driver to implement "commands flushing" and "storm prevention" (the EC
driver enabling is not included in this patchset).

The refined patches are passed the runtime/suspend tests carried out on the
following platforms with EC driver enhanced:
  "Dell Inspiron Mini 1010" - i386 kernel
  "Dell Latitude 6430u" - x86_64 kernel

Lv Zheng (9):
  ACPICA: Events: Reduce indent divergences of events files.
  ACPICA: Events: Fix an issue that GPE APIs cannot be invoked in
    atomic context.
  ACPICA: Events: Fix an issue that GPE APIs cannot be invoked in
    deferred handlers.
  ACPICA: Events: Introduce acpi_set_gpe()/acpi_finish_gpe() to reduce
    divergences.
  ACPICA: Events: Fix an issue that acpi_set_gpe() cannot
    unconditionally enable GPEs.
  ACPICA: Events: Fix an issue that status of GPEs are unexpectedly
    cleared.
  ACPICA: Events: Fix an issue that originally_enabled check is not
    paired.
  ACPICA: Events: Add a flag to disable internal auto GPE clearing.
  ACPI: Update interrupt handler to honor new ACPI_REENABLE_GPE bit.

 drivers/acpi/acpica/acevents.h |    1 +
 drivers/acpi/acpica/aclocal.h  |    5 +-
 drivers/acpi/acpica/evgpe.c    |  136 +++++++++++++++++++++-------------------
 drivers/acpi/acpica/evxface.c  |   41 ++++++++----
 drivers/acpi/acpica/evxfgpe.c  |  105 +++++++++++++++++++++++++++++++
 drivers/acpi/osl.c             |    2 +-
 include/acpi/actypes.h         |   16 ++---
 7 files changed, 219 insertions(+), 87 deletions(-)

-- 
1.7.10

