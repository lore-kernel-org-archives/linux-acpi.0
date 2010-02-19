From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2.6.32.stable] ACPI: Add NULL pointer check in acpi_bus_start
Date: Thu, 18 Feb 2010 23:35:33 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002182330140.17638@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:36665 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab0BSEfq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Feb 2010 23:35:46 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KY2006T2NFAH8K2@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 18 Feb 2010 22:35:37 -0600 (CST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stable@kernel.org
Cc: linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>

upstream d2f6650a950dadd20667a04a9dc785f240d43695
From: Thomas Renninger <trenn@suse.de>

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
Acked-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: stable@kernel.org
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index ff9f622..8044583 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1357,6 +1357,9 @@ int acpi_bus_start(struct acpi_device *device)
 {
 	struct acpi_bus_ops ops;
 
+	if (!device)
+		return -EINVAL;
+
 	memset(&ops, 0, sizeof(ops));
 	ops.acpi_op_start = 1;
 
-- 
1.7.0.17.g7e5eb

