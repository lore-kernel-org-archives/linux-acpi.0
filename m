From: Len Brown <len.brown@intel.com>
Subject: [PATCH 082/105] ACPI: make /proc/acpi/wakeup more useful
Date: Sun, 29 Apr 2007 00:51:22 -0400
Message-ID: <11778223802796-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
 <1177822310688-git-send-email-len.brown@intel.com>
 <11778223112050-git-send-email-len.brown@intel.com>
 <11778223122850-git-send-email-len.brown@intel.com>
 <11778223131932-git-send-email-len.brown@intel.com>
 <11778223143898-git-send-email-len.brown@intel.com>
 <11778223151972-git-send-email-len.brown@intel.com>
 <11778223152006-git-send-email-len.brown@intel.com>
 <11778223161614-git-send-email-len.brown@intel.com>
 <11778223173663-git-send-email-len.brown@intel.com>
 <11778223183783-git-send-email-len.brown@intel.com>
 <11778223192706-git-send-email-len.brown@intel.com>
 <11778223201940-git-send-email-len.brown@intel.com>
 <11778223212414-git-send-email-len.brown@intel.com>
 <11778223211710-git-send-email-len.brown@intel.com>
 <11778223222525-git-send-email-len.brown@intel.com>
 <11778223233885-git-send-email-len.brown@intel.com>
 <1177822324973-git-send-email-len.brown@intel.com>
 <11778223251849-git-send-email-len.brown@intel.com>
 <1177822326583-git-send-email-len.brown@intel.com>
 <11778223273782-git-send-email-len.brown@intel.com>
 <11778223282154-git-send-email-len.brown@intel.com>
 <11778223282215-git-send-email-len.brown@intel.com>
 <11778223304019-git-send-email-len.brown@intel.com>
 <1177822331727-git-send-email-len.brown@intel.com>
 <117782233197-git-send-email-len.brown@intel.com>
 <11778223331858-git-send-email-len.brown@intel.com>
 <11778223353919-git-send-email-len.brown@intel.com>
 <1177822337332-git-send-email-len.brown@intel.com>
 <11778223382880-git-send-email-len.brown@intel.com>
 <11778223392178-git-send-email-len.brown@intel.com>
 <11778223401417-git-send-email-len.brown@intel.com>
 <11778223411658-git-send-email-len.brown@intel.com>
 <11778223412672-git-send-email-len.brown@intel.com>
 <11778223423-git-send-email-len.brown@intel.com>
 <1177822343712-git-send-email-len.brown@intel.com>
 <11778223442065-git-send-email-len.brown@intel.com>
 <11778223452843-git-send-email-len.brown@intel.com>
 <11778223461282-git-send-email-len.brown@intel.com>
 <11778223472316-git-send-email-len.brown@intel.com>
 <1177822347845-git-send-email-len.brown@intel.com>
 <1177822348546-git-send-email-len.brown@intel.com>
 <11778223493327-git-send-email-len.brown@intel.com>
 <11778223502745-git-send-email-len.brown@intel.com>
 <11778223512990-git-send-email-len.brown@intel.com>
 <1177822352591-git-send-email-len.brown@intel.com>
 <11778223532461-git-send-email-len.brown@intel.com>
 <11778223544100-git-send-email-len.brown@intel.com>
 <11778223553521-git-send-email-len.brown@intel.com>
 <11778223551720-git-send-email-len.brown@intel.com>
 <11778223562656-git-send-email-len.brown@intel.com>
 <11778223571390-git-send-email-len.brown@intel.com>
 <11778223581484-git-send-email-len.brown@intel.com>
 <11778223593048-git-send-email-len.brown@intel.com>
 <11778223602019-git-send-email-len.brown@intel.com>
 <11778223612093-git-send-email-len.brown@intel.com>
 <117782236226-git-send-email-len.brown@intel.com>
 <11778223624095-git-send-email-len.brown@intel.com>
 <11778223633408-git-send-email-len.brown@intel.com>
 <1177822364262-git-send-email-len.brown@intel.com>
 <11778223653391-git-send-email-len.brown@intel.com>
 <11778223663850-git-send-email-len.brown@intel.com>
 <11778223673988-git-send-email-len.brown@intel.com>
 <1177822368767-git-send-email-len.brown@intel.com>
 <1177822368793-git-send-email-len.brown@intel.com>
 <11778223692377-git-send-email-len.brown@intel.com>
 <1177822370442-git-send-email-len.brown@intel.com>
 <1177822371935-git-send-email-len.brown@intel.com>
 <11778223721984-git-send-email-len.brown@intel.com>
 <11778223732286-git-send-email-len.brown@intel.com>
 <11778223733679-git-send-email-len.brown@intel.com>
 <11778223741-git-send-email-len.brown@intel.com>
 <11778223752175-git-send-email-len.brown@intel.com>
 <1177822376123-git-send-email-len.brown@intel.com>
 <11778223771048-git-send-email-len.brown@intel.com>
 <11778223782086-git-send-email-len.brown@intel.com>
 <11778223792074-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18569 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756180AbXD2ExC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:53:02 -0400
In-Reply-To: <11778223792074-git-send-email-len.brown@intel.com>
Message-Id: <8aa55591bfea25c441117e82711cbfd7c274250a.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>, David Brownell <dbrownell@users.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: David Brownell <david-b@pacbell.net>

This updates /proc/acpi/wakeup to be more informative, primarily by showing
the sysfs node associated with each wakeup-enabled device.  Example:

	Device	S-state	  Status   Sysfs node
	PCI0	  S4	 disabled  no-bus:pci0000:00
	PS2M	  S4	 disabled  pnp:00:05
	PS2K	  S4	 disabled  pnp:00:06
	UAR1	  S4	 disabled  pnp:00:08
	USB1	  S3	 disabled  pci:0000:00:03.0
	USB2	  S3	 disabled  pci:0000:00:03.1
	USB3	  S3	 disabled
	USB4	  S3	 disabled  pci:0000:00:03.3
	S139	  S4	 disabled
	LAN	  S4	 disabled  pci:0000:00:04.0
	MDM	  S4	 disabled
	AUD	  S4	 disabled  pci:0000:00:02.7
	SLPB	  S4	*enabled

Eventually this file should be removed, but until then it's almost the only
way we have to tell how the relevant ACPI tables are broken (and cope).  In
that example, two devices don't actually exist (USB3, S139), one can't issue
wakeup events (PCI0), and two seem harmlessly (?) confused (MDM and AUD are
the same PCI device, but it's the _modem_ that does wake-on-ring).

In particular, we need to be sure driver model nodes are properly hooked
up before we can get rid of this ACPI-only interface for wakeup events.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sleep/proc.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/sleep/proc.c b/drivers/acpi/sleep/proc.c
index ccc11b3..2d912b7 100644
--- a/drivers/acpi/sleep/proc.c
+++ b/drivers/acpi/sleep/proc.c
@@ -350,21 +350,31 @@ acpi_system_wakeup_device_seq_show(struct seq_file *seq, void *offset)
 {
 	struct list_head *node, *next;
 
-	seq_printf(seq, "Device	Sleep state	Status\n");
+	seq_printf(seq, "Device\tS-state\t  Status   Sysfs node\n");
 
 	spin_lock(&acpi_device_lock);
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
 		struct acpi_device *dev =
 		    container_of(node, struct acpi_device, wakeup_list);
+		struct device *ldev;
 
 		if (!dev->wakeup.flags.valid)
 			continue;
 		spin_unlock(&acpi_device_lock);
-		seq_printf(seq, "%4s	%4d		%s%8s\n",
+
+		ldev = acpi_get_physical_device(dev->handle);
+		seq_printf(seq, "%s\t  S%d\t%c%-8s  ",
 			   dev->pnp.bus_id,
 			   (u32) dev->wakeup.sleep_state,
-			   dev->wakeup.flags.run_wake ? "*" : "",
+			   dev->wakeup.flags.run_wake ? '*' : ' ',
 			   dev->wakeup.state.enabled ? "enabled" : "disabled");
+		if (ldev)
+			seq_printf(seq, "%s:%s",
+				ldev->bus ? ldev->bus->name : "no-bus",
+				ldev->bus_id);
+		seq_printf(seq, "\n");
+		put_device(ldev);
+
 		spin_lock(&acpi_device_lock);
 	}
 	spin_unlock(&acpi_device_lock);
-- 
1.5.2.rc0.34.gda94
