From: yakui_zhao <yakui.zhao@intel.com>
Subject: [PATCH]: ACPI: Rename ACPI processor device bus ID
Date: Wed, 24 Jun 2009 11:46:44 +0800
Message-ID: <1245815204.7266.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50552 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751881AbZFXDpg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Jun 2009 23:45:36 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

From: Zhao Yakui <yakui.zhao@intel.com

On some boxes several processors use the same processor bus id.
But they are located in different scope. For example:
	\_SB.SCK0.CPU0
	\_SB.SCK1.CPU0
As they use the same bus id, OS will complain the following kernel OOPS 
when registering proc I/F.
    >------------[ cut here ]------------
WARNING: at fs/proc/generic.c:590 proc_register+0x148/0x180()
Hardware name: Sunrise Ridge
proc_dir_entry 'processor/CPU0' already registered
Modules linked in: processor(+) thermal_sys hwmon
Pid: 255, comm: modprobe Tainted: G        W  2.6.30-rc3MASHLEY #1
Call Trace:
 [<ffffffff8023f7ef>] warn_slowpath+0xb1/0xe5
 [<ffffffff8036243b>] ? ida_get_new_above+0x190/0x1b1
 [<ffffffff803625a8>] ? idr_pre_get+0x5f/0x75
 [<ffffffff8030b2f6>] proc_register+0x148/0x180
 [<ffffffff8030b4ff>] proc_mkdir_mode+0x3d/0x52
 [<ffffffff8030b525>] proc_mkdir+0x11/0x13
 [<ffffffffa0014b89>] acpi_processor_start+0x755/0x9bc [processor]

	
Rename the processor device bus id. And the new bus id will be 
generated as the following format:
	CPU+ CPU ID
	
For example: If the cpu ID is 5, then the bus ID will be "CPU5".
	If the CPU ID is 10, then the bus ID will be "CPUA".

http://bugzilla.kernel.org/show_bug.cgi?id=13612

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/processor_core.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_core.c	2009-06-24 11:24:53.000000000 +0800
+++ linux-2.6/drivers/acpi/processor_core.c	2009-06-24 11:25:06.000000000 +0800
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
 


