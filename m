From: yakui_zhao <yakui.zhao@intel.com>
Subject: [Resend] [PATCH]: ACPI: Rename ACPI processor device bus ID
Date: Sun, 31 May 2009 10:31:51 +0800
Message-ID: <1243737111.3634.168.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:56995 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752524AbZEaCaG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 30 May 2009 22:30:06 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

From: Zhao Yakui <yakui.zhao@intel.com

On some boxes several processors use the same processor bus id.
But they are located in different scope. For example:
	\_SB.SCK0.CPU0
	\_SB.SCK1.CPU0
	As they use the same bus id, it can't be registered when
registering proc I/F. It causes that the ACPI processor driver can't
be bound with the processor device.
	
Rename the processor device bus id. And the new bus id will be 
generated as the following format:
	CPU+ CPU ID
	
For example: If the cpu ID is 5, then the bus ID will be "CPU5".
	If the CPU ID is 10, then the bus ID will be "CPUA".

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/processor_core.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_core.c	2009-05-27 08:38:44.000000000 +0800
+++ linux-2.6/drivers/acpi/processor_core.c	2009-05-31 10:21:21.000000000 +0800
@@ -649,7 +649,16 @@
 			return -ENODEV;
 		}
 	}
-
+	/*
+	 * On some boxes several processors use the same processor bus id.
+	 * But they are located in different scope. For example:
+	 * \_SB.SCK0.CPU0
+	 * \_SB.SCK1.CPU0
+	 * Rename the processor device bus id. And the new bus id will be
+	 * generated as the following format:
+	 * CPU+CPU ID.
+	 */
+	sprintf(acpi_device_bid(device), "CPU%X", pr->id);
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Processor [%d:%d]\n", pr->id,
 			  pr->acpi_id));
 


