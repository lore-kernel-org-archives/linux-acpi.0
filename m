From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] Fix not loading acpi-cpufreq driver regression
Date: Mon, 25 Jun 2012 13:00:10 +0200
Message-ID: <201206251300.10957.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54968 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755791Ab2FYLAQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Jun 2012 07:00:16 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, stable@vger.kernel.org, wallak@free.fr, len.brown@intel.com, Jiri Slaby <jslaby@suse.cz>

ACPI processor: Only blindly return apic id 0 for real UP systems

This fixes a "not loading acpi-cpufreq driver" regression introduced
by git commit d640113fe80e45ebd4a5b4 on SMP systems where the processor
core with ACPI id zero is disabled
(typically should be the case because of hyperthreading).
The regression got spread through stable kernels.
On 3.0.X it got introduced via 3.0.18.

Such platforms may be rare, but do exist. This problem has been
observed on a:
HP Proliant BL280c G6 blade
This patch restricts the introduced workaround to platforms
with nr_cpu_ids <= 1.

Signed-off-by: Thomas Renninger <trenn@suse.de>

---
 drivers/acpi/processor_core.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux-3.0-SLE11-SP2/drivers/acpi/processor_core.c
===================================================================
--- linux-3.0-SLE11-SP2.orig/drivers/acpi/processor_core.c
+++ linux-3.0-SLE11-SP2/drivers/acpi/processor_core.c
@@ -201,10 +201,12 @@ int acpi_get_cpuid(acpi_handle handle, i
 		 *     Processor (CPU3, 0x03, 0x00000410, 0x06) {}
 		 * }
 		 *
-		 * Ignores apic_id and always return 0 for CPU0's handle.
+		 * Ignores apic_id and always returns 0 for the processor
+		 * handle with apic id 0 if nr_cpu_ids is 1.
+		 * This should be the case if SMP tables are not found.
 		 * Return -1 for other CPU's handle.
 		 */
-		if (acpi_id == 0)
+		if (nr_cpu_ids <= 1 && acpi_id == 0)
 			return acpi_id;
 		else
 			return apic_id;
