From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/8] ACPI: add AC/DC notifier
Date: Thu, 15 Oct 2009 00:59:36 -0400
Message-ID: <68b92b567c0c5e6f4d0b264d438f97ee5ccbdccc.1255582742.git.len.brown@intel.com>
References: <1255582783-16088-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:37803 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbZJOFAk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Oct 2009 01:00:40 -0400
Received: from localhost.localdomain ([74.104.150.83])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KRJ00LH8HVOX1Y2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 14 Oct 2009 23:59:54 -0500 (CDT)
In-reply-to: <1255582783-16088-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mark Langsdorf <mark.langsdorf@amd.com>, Len Brown <len.brown@intel.com>

From: Mark Langsdorf <mark.langsdorf@amd.com>

Add an ACPI event notifier for AC/DC connect/disconnect events.

Signed-off-by: Mark Langsdorf <mark.langsdorf@amd.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ac.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 98b9690..b6ed60b 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -245,6 +245,7 @@ static void acpi_ac_notify(struct acpi_device *device, u32 event)
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
 						  dev_name(&device->dev), event,
 						  (u32) ac->state);
+		acpi_notifier_call_chain(device, event, (u32) ac->state);
 #ifdef CONFIG_ACPI_SYSFS_POWER
 		kobject_uevent(&ac->charger.dev->kobj, KOBJ_CHANGE);
 #endif
-- 
1.6.0.6

