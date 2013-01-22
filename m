From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI: Drop device start operation that is not used
Date: Tue, 22 Jan 2013 23:25:05 +0100
Message-ID: <1726547.g8rCOVpa6k@vostro.rjw.lan>
References: <1518653.CUpDmbmCI3@vostro.rjw.lan> <CAE9FiQV1N0hrUui1rGrs1=kFJFiuOhZ6tT-wGfK-B25it5feLQ@mail.gmail.com> <4046863.eHD8RPonGC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:50703 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752226Ab3AVWTG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Jan 2013 17:19:06 -0500
In-Reply-To: <4046863.eHD8RPonGC@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Bjorn Helgaas <bhelgaas@google.com>, Toshi Kani <toshi.kani@hp.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ACPI device start operation, acpi_op_start, is never used, so
drop it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/acpi_bus.h |    2 --
 1 file changed, 2 deletions(-)

Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -90,13 +90,11 @@ struct acpi_device;
 
 typedef int (*acpi_op_add) (struct acpi_device * device);
 typedef int (*acpi_op_remove) (struct acpi_device * device);
-typedef int (*acpi_op_start) (struct acpi_device * device);
 typedef void (*acpi_op_notify) (struct acpi_device * device, u32 event);
 
 struct acpi_device_ops {
 	acpi_op_add add;
 	acpi_op_remove remove;
-	acpi_op_start start;
 	acpi_op_notify notify;
 };
 

