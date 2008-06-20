From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/70] force offline the processor during hot-removal
Date: Fri, 20 Jun 2008 03:43:04 -0400
Message-ID: <3d5ed99657e93cd0453a187c478e663e6b6a3a8b.1213947349.git.len.brown@intel.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:49860 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbYFTHoV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:44:21 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K2R00E3J45T8510@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:44:18 -0500 (CDT)
In-reply-to: <1213947852-10924-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

The ACPI device node for the cpu has already been unregistered
when acpi_processor_handle_eject is called.
Thus we should offline the cpu and continue, rather than a failure here.
http://bugzilla.kernel.org/show_bug.cgi?id=9772

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_core.c |    6 +++---
 kernel/cpu.c                  |    1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index a825b43..3f90965 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -1016,9 +1016,9 @@ static acpi_status acpi_processor_hotadd_init(acpi_handle handle, int *p_cpu)
 
 static int acpi_processor_handle_eject(struct acpi_processor *pr)
 {
-	if (cpu_online(pr->id)) {
-		return (-EINVAL);
-	}
+	if (cpu_online(pr->id))
+		cpu_down(pr->id);
+
 	arch_unregister_cpu(pr->id);
 	acpi_unmap_lsapic(pr->id);
 	return (0);
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 2011ad8..380bce4 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -287,6 +287,7 @@ int cpu_down(unsigned int cpu)
 	cpu_maps_update_done();
 	return err;
 }
+EXPORT_SYMBOL(cpu_down);
 #endif /*CONFIG_HOTPLUG_CPU*/
 
 /* Requires cpu_add_remove_lock to be held */
-- 
1.5.6

