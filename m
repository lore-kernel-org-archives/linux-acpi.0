From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/10] ACPI: Add NULL pointer check in acpi_bus_start
Date: Tue, 16 Feb 2010 04:46:03 -0500
Message-ID: <d2f6650a950dadd20667a04a9dc785f240d43695.1266313501.git.len.brown@intel.com>
References: <1266313570-6490-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:57945 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762Ab0BPJqQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2010 04:46:16 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KXX003AXHT300W0@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 16 Feb 2010 03:46:15 -0600 (CST)
In-reply-to: <1266313570-6490-1-git-send-email-lenb@kernel.org>
In-reply-to: <0406ad336c066190770cbf350b552d608e43ed09.1266313501.git.len.brown@intel.com>
References: <0406ad336c066190770cbf350b552d608e43ed09.1266313501.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, stable@kernel.org, Len Brown <len.brown@intel.com>

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
1.6.0.6

