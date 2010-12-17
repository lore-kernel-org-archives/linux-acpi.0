From: Len Brown <lenb@kernel.org>
Subject: Re: acpi_battery_init() boot speed
Date: Fri, 17 Dec 2010 03:46:12 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1012170341160.20940@x980>
References: <alpine.LFD.2.00.1012150308260.4878@x980>
 <20101215030054.0aae9e1e@infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:60784 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413Ab0LQIqP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Dec 2010 03:46:15 -0500
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LDK00BHKDP2UJ14@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 17 Dec 2010 02:46:15 -0600 (CST)
In-reply-to: <20101215030054.0aae9e1e@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-acpi@vger.kernel.org

> wonder if the code could do just enough to register the device, and
> do everything else in the background?

or do it later on demand...

This patch reduces acpi_battery_init() time
on the Lenovo S10-3 from 901,603 usec to 657 usec.

AFAICT, the battery monitor etc worked fine.

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 95649d3..79e8ba3 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -943,7 +943,6 @@ static int acpi_battery_add(struct acpi_device *device)
 	if (ACPI_SUCCESS(acpi_get_handle(battery->device->handle,
 			"_BIX", &handle)))
 		set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
-	acpi_battery_update(battery);
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	result = acpi_battery_add_fs(device);
 #endif



