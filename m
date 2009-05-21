From: yakui_zhao <yakui.zhao@intel.com>
Subject: [PATCH]: ACPI: Change the array size from 5 to 8 for acpi_bus_id
Date: Thu, 21 May 2009 16:25:35 +0800
Message-ID: <1242894335.8523.61.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:12674 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757AbZEUIYR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 May 2009 04:24:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

From: Zhao Yakui <yaui.zhao@intel.com>

In fact the following three bytes can't be used when the following data
type is unsigned long or unsigned long long.

Change the array size from 5 to 8 for the acpi_bus_id.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 include/acpi/acpi_bus.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/include/acpi/acpi_bus.h
===================================================================
--- linux-2.6.orig/include/acpi/acpi_bus.h	2009-04-20 09:13:42.000000000 +0800
+++ linux-2.6/include/acpi/acpi_bus.h	2009-05-21 16:18:25.000000000 +0800
@@ -168,7 +168,7 @@
 
 /* Plug and Play */
 
-typedef char acpi_bus_id[5];
+typedef char acpi_bus_id[8];
 typedef unsigned long acpi_bus_address;
 typedef char acpi_hardware_id[15];
 typedef char acpi_unique_id[9];


