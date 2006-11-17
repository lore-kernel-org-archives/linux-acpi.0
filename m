From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] make drivers/acpi/ec.c:ec_ecdt
Date: Fri, 17 Nov 2006 02:19:39 +0100
Message-ID: <20061117011939.GR31879@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:57864 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1424866AbWKQBTk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Nov 2006 20:19:40 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

This patch makes the needlessly global "ec_ecdt" static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm2/drivers/acpi/ec.c.old	2006-11-16 23:07:31.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/acpi/ec.c	2006-11-16 23:08:45.000000000 +0100
@@ -84,25 +84,25 @@
 	.name = ACPI_EC_DRIVER_NAME,
 	.class = ACPI_EC_CLASS,
 	.ids = ACPI_EC_HID,
 	.ops = {
 		.add = acpi_ec_add,
 		.remove = acpi_ec_remove,
 		.start = acpi_ec_start,
 		.stop = acpi_ec_stop,
 		},
 };
 
 /* If we find an EC via the ECDT, we need to keep a ptr to its context */
-struct acpi_ec {
+static struct acpi_ec {
 	acpi_handle handle;
 	unsigned long uid;
 	unsigned long gpe_bit;
 	unsigned long command_addr;
 	unsigned long data_addr;
 	unsigned long global_lock;
 	struct semaphore sem;
 	unsigned int expect_event;
 	atomic_t leaving_burst;	/* 0 : No, 1 : Yes, 2: abort */
 	wait_queue_head_t wait;
 } *ec_ecdt;
 

