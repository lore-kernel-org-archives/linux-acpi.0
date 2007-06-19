From: "Andreas Herrmann" <andreas.herrmann3@amd.com>
Subject: [PATCH 6/12] acpi: fix compile warnings
Date: Wed, 20 Jun 2007 00:50:11 +0200
Message-ID: <20070619225011.GH5193@alberich.amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-blu.frontbridge.com ([65.55.251.16]:54615 "EHLO
	outbound8-blu-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760760AbXFSWwX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Jun 2007 18:52:23 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Fix compile warnings:

 drivers/acpi/bus.c: In function 'acpi_bus_get_power':
 drivers/acpi/bus.c:162: warning: implicit declaration of function 'acpi_power_get_inferred_state'
 drivers/acpi/bus.c: In function 'acpi_bus_set_power':
 drivers/acpi/bus.c:232: warning: implicit declaration of function 'acpi_power_transition'

Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
---
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index b4a9ea5..e01dca1 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -43,6 +43,8 @@ ACPI_MODULE_NAME("bus");
 #ifdef	CONFIG_X86
 extern void __init acpi_pic_sci_set_trigger(unsigned int irq, u16 trigger);
 #endif
+extern int acpi_power_get_inferred_state(struct acpi_device *);
+extern int acpi_power_transition(struct acpi_device *, int);
 
 struct acpi_device *acpi_root;
 struct proc_dir_entry *acpi_root_dir;



