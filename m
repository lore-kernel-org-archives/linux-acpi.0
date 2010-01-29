From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/2] ACPI: Add NULL pointer check in acpi_bus_start
Date: Fri, 29 Jan 2010 17:48:51 +0100
Message-ID: <201001291748.51320.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34230 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479Ab0A2Qsw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 29 Jan 2010 11:48:52 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, kristen.c.accardi@intel.com

If acpi_bus_add does not return a device and it's passed
to acpi_bus_start, bad things will happen:


BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
IP: [<ffffffff8128402d>] acpi_bus_start+0x14/0x24
...
[<ffffffffa008977a>] acpiphp_bus_add+0xba/0x130 [acpiphp]
[<ffffffffa008aa72>] enable_device+0x132/0x2ff [acpiphp]
[<ffffffffa0089b68>] acpiphp_enable_slot+0xb8/0x130 [acpiphp]
[<ffffffffa0089df7>] handle_hotplug_event_func+0x87/0x190 [acpiphp]


Next patch would make this NULL pointer check obsolete, but
better having one more than one missing...

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: bjorn.helgaas@hp.com
CC: lenb@kernel.org
CC: linux-acpi@vger.kernel.org
CC: kristen.c.accardi@intel.com
CC: stable@kernel.org

---
 drivers/acpi/scan.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6.32-SLE11-SP1/drivers/acpi/scan.c
===================================================================
--- linux-2.6.32-SLE11-SP1.orig/drivers/acpi/scan.c
+++ linux-2.6.32-SLE11-SP1/drivers/acpi/scan.c
@@ -1382,6 +1382,9 @@ int acpi_bus_start(struct acpi_device *d
 {
 	struct acpi_bus_ops ops;
 
+	if (!device)
+		return -EINVAL;
+
 	memset(&ops, 0, sizeof(ops));
 	ops.acpi_op_start = 1;
 
