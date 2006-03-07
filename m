From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: [PATCH] naming memory hotplug's phys_device take2 [2/3] name memory
 hot-added by acpi
Date: Tue, 7 Mar 2006 16:01:43 +0900
Message-ID: <20060307160143.5850ee4b.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:4588 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1752026AbWCGHCS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Mar 2006 02:02:18 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Dave Hansen <haveblue@us.ibm.com>, LHMS <lhms-devel@lists.sourceforge.net>, Greg KH <greg@kroah.com>, ACPI <linux-acpi@vger.kernel.org>

This patch work with "changing phys_device from int to string" patch.
This exports acpi object name in dsdt to memory hotplug control sysfs.

Signed-Off-By: KAMEZAWA Hiroyu <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.16-rc5-mm2/drivers/acpi/acpi_memhotplug.c
===================================================================
--- linux-2.6.16-rc5-mm2.orig/drivers/acpi/acpi_memhotplug.c	2006-03-07 15:12:01.000000000 +0900
+++ linux-2.6.16-rc5-mm2/drivers/acpi/acpi_memhotplug.c	2006-03-07 15:28:08.000000000 +0900
@@ -1,3 +1,4 @@
+
 /*
  * Copyright (C) 2004 Intel Corporation <naveen.b.s@intel.com>
  *
@@ -30,6 +31,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/memory_hotplug.h>
+#include <linux/memory.h>
 #include <acpi/acpi_drivers.h>
 
 #define ACPI_MEMORY_DEVICE_COMPONENT		0x08000000UL
@@ -178,6 +180,22 @@
 	return_VALUE(0);
 }
 
+static int acpi_memory_device_export_name(struct acpi_memory_device *mem_device)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	acpi_status result;
+	int ret;
+
+	result = acpi_get_name(mem_device->handle, ACPI_FULL_PATHNAME, &buffer);
+	if (ACPI_FAILURE(result))
+		return result;
+	ret = memory_device_export_name(mem_device->start_addr,
+				mem_device->start_addr + mem_device->length,
+				buffer.pointer);
+	acpi_os_free(buffer.pointer);
+	return_VALUE(ret);
+}
+
 static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 {
 	int result;
@@ -203,6 +221,11 @@
 		return result;
 	}
 
+	/*
+	 * export ACPI memory object name from sysfs's memory object
+	 */
+	result = acpi_memory_device_export_name(mem_device);
+
 	return result;
 }
 
