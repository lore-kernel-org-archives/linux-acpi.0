From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI: ignore invalid acpi device resources
Date: Thu, 27 Feb 2014 11:32:41 +0800
Message-ID: <1393471961.2637.1.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51469 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754612AbaB0Dcn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Feb 2014 22:32:43 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

>From f49c218f40d66b72b8f8288dcae7e6010c253bc0 Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Thu, 27 Feb 2014 11:03:50 +0800
Subject: [PATCH] ACPI: ignore invalid acpi device resources

ACPI table may export resource entry with 0 length.
But the current code interprets this kind of resource in a wrong way.
It will create a resource structure with
res->end = acpi_resource->start + acpi_resource->len - 1;

This patch fixes a problem on my machine that
a platform device fails to be created because one of its
acpi io resource entry (start = 0, end = 0, length = 0) is translated into
a generic resource with start = 0, end = 0xffffffff.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/resource.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index b7201fc..0bdacc5 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -77,18 +77,24 @@ bool acpi_dev_resource_memory(struct acpi_resource *ares, struct resource *res)
 	switch (ares->type) {
 	case ACPI_RESOURCE_TYPE_MEMORY24:
 		memory24 = &ares->data.memory24;
+		if (!memory24->address_length)
+			return false;
 		acpi_dev_get_memresource(res, memory24->minimum,
 					 memory24->address_length,
 					 memory24->write_protect);
 		break;
 	case ACPI_RESOURCE_TYPE_MEMORY32:
 		memory32 = &ares->data.memory32;
+		if (!memory32->address_length)
+			return false;
 		acpi_dev_get_memresource(res, memory32->minimum,
 					 memory32->address_length,
 					 memory32->write_protect);
 		break;
 	case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
 		fixed_memory32 = &ares->data.fixed_memory32;
+		if (!fixed_memory32->address_length)
+			return false;
 		acpi_dev_get_memresource(res, fixed_memory32->address,
 					 fixed_memory32->address_length,
 					 fixed_memory32->write_protect);
@@ -144,12 +150,16 @@ bool acpi_dev_resource_io(struct acpi_resource *ares, struct resource *res)
 	switch (ares->type) {
 	case ACPI_RESOURCE_TYPE_IO:
 		io = &ares->data.io;
+		if (!io->address_length)
+			return false;
 		acpi_dev_get_ioresource(res, io->minimum,
 					io->address_length,
 					io->io_decode);
 		break;
 	case ACPI_RESOURCE_TYPE_FIXED_IO:
 		fixed_io = &ares->data.fixed_io;
+		if (!fixed_io->address_length)
+			return false;
 		acpi_dev_get_ioresource(res, fixed_io->address,
 					fixed_io->address_length,
 					ACPI_DECODE_10);
-- 
1.7.9.5



