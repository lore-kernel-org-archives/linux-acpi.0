From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.21-rc5-git] make /proc/acpi/wakeup more useful
Date: Tue, 3 Apr 2007 17:41:42 -0700
Message-ID: <200704031741.42273.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S966220AbXDDBPR@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Linux ACPI list <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

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

--- g26.orig/drivers/acpi/sleep/proc.c	2007-04-03 16:27:22.000000000 -0700
+++ g26/drivers/acpi/sleep/proc.c	2007-04-03 16:43:26.000000000 -0700
@@ -360,21 +360,31 @@ acpi_system_wakeup_device_seq_show(struc
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
