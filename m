From: Len Brown <lenb@kernel.org>
Subject: [PATCH 35/65] ACPI: increase size of acpi_bus_id[]
Date: Fri, 29 May 2009 21:42:13 -0400
Message-ID: <94140c22f63604c0b41f97c671cce5938756875d.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:61730 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756248AbZE3Bm5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:42:57 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00J1OORJXEP2@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:55 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yaui.zhao@intel.com>, Zhao Yakui <yakui.zhao@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yaui.zhao@intel.com>

Previously [5], now [8].

sprintf(acpi_device_bid(device), "CPU%X", cpu_id)
now looks better on systems with more than 0xFF processors.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acpi_bus.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index c34b110..0be2410 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -168,7 +168,7 @@ struct acpi_device_dir {
 
 /* Plug and Play */
 
-typedef char acpi_bus_id[5];
+typedef char acpi_bus_id[8];
 typedef unsigned long acpi_bus_address;
 typedef char acpi_hardware_id[15];
 typedef char acpi_unique_id[9];
-- 
1.6.0.6

