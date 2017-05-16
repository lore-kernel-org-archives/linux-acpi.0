From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 07/17] ACPI: Adjust system_state check
Date: Tue, 16 May 2017 20:42:38 +0200
Message-ID: <20170516184735.446455652@linutronix.de>
References: <20170516184231.564888231@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:41315 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753193AbdEPSxE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2017 14:53:04 -0400
Content-Disposition: inline; filename=ACPI--Adjust-system_state-check.patch
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

To enable smp_processor_id() and might_sleep() debug checks earlier, it's
required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.

Make the decision whether a pci root is hotplugged depend on SYSTEM_RUNNING
instead of !SYSTEM_BOOTING. It makes no sense to cover states greater than
SYSTEM_RUNNING as there are not hotplug events on reboot and poweroff.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/pci_root.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -523,7 +523,7 @@ static int acpi_pci_root_add(struct acpi
 	struct acpi_pci_root *root;
 	acpi_handle handle = device->handle;
 	int no_aspm = 0;
-	bool hotadd = system_state != SYSTEM_BOOTING;
+	bool hotadd = system_state == SYSTEM_RUNNING;
 
 	root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
 	if (!root)


