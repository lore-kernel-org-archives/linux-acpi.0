From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2.6.36.stable] ACPI: install ACPI table handler before any
 dynamic tables being loaded
Date: Mon, 01 Nov 2010 23:09:11 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1011012306250.14926@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:35653 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754203Ab0KBDJc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Nov 2010 23:09:32 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LB800LBKM3DMDC0@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 01 Nov 2010 22:09:19 -0500 (CDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stable@kernel.org
Cc: linux-acpi@vger.kernel.org


From: Zhang Rui <rui.zhang@intel.com>

upstream b1d248d96c71665c79befb81207f38f894c7c082

ACPI table sysfs I/F is broken by commit

78f1699659963fff97975df44db6d5dbe7218e55
Author: Alex Chiang <achiang@hp.com>
Date:   Sun Dec 20 12:19:09 2009 -0700
    ACPI: processor: call _PDC early

because dynamic SSDT tables may be loaded in _PDC,
before installing the ACPI table handler.
As a result, the sysfs I/F of these dynamic tables are
located at  /sys/firmware/acpi/tables instead of
/sys/firmware/acpi/tables/dynamic, which is not true.

Invoke acpi_sysfs_init() before acpi_early_processor_set_pdc(),
so that the table handler is installed before any dynamic tables loaded.

https://bugzilla.kernel.org/show_bug.cgi?id=21142

CC: Dennis Jansen <dennis.jansen@web.de>
CC: Alex Chiang <achiang@hp.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 310e3b9..d68bd61 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -935,6 +935,12 @@ static int __init acpi_bus_init(void)
 		goto error1;
 	}
 
+	/*
+	 * _PDC control method may load dynamic SSDT tables,
+	 * and we need to install the table handler before that.
+	 */
+	acpi_sysfs_init();
+
 	acpi_early_processor_set_pdc();
 
 	/*
@@ -1026,7 +1032,6 @@ static int __init acpi_init(void)
 	acpi_scan_init();
 	acpi_ec_init();
 	acpi_power_init();
-	acpi_sysfs_init();
 	acpi_debugfs_init();
 	acpi_sleep_proc_init();
 	acpi_wakeup_device_init();
-- 
1.7.3.2.146.gca209

