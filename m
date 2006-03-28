From: akpm@osdl.org
Subject: [patch 23/26] x86_64: Remove entries in /sys/firmware/acpi for processor also
Date: Tue, 28 Mar 2006 14:03:48 -0800
Message-ID: <200603282203.k2SM3tt6027719@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:1968 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932429AbWC1WEA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Mar 2006 17:04:00 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, ashok.raj@intel.com, ak@muc.de


From: Ashok Raj <ashok.raj@intel.com>

Processor entries under /sys/firmware/acpi/namespace/ACPI/_SB/CPU* were not
being removed due to acpi_bus_trim not asking for it just for processors. 
Without which a new hot-add after a remove doesnt call appropriate init
functions resulting in subsequent hot-add for same cpu failing.

Not clear why we restricted that to non-processor devices.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <ak@muc.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/scan.c |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)

diff -puN drivers/acpi/scan.c~remove-entries-in-sys-firmware-acpi-for-processor-also drivers/acpi/scan.c
--- devel/drivers/acpi/scan.c~remove-entries-in-sys-firmware-acpi-for-processor-also	2006-03-28 14:03:07.000000000 -0800
+++ devel-akpm/drivers/acpi/scan.c	2006-03-28 14:03:07.000000000 -0800
@@ -433,10 +433,7 @@ acpi_eject_store(struct acpi_device *dev
 	islockable = device->flags.lockable;
 	handle = device->handle;
 
-	if (type == ACPI_TYPE_PROCESSOR)
-		result = acpi_bus_trim(device, 0);
-	else
-		result = acpi_bus_trim(device, 1);
+	result = acpi_bus_trim(device, 1);
 
 	if (!result)
 		result = acpi_eject_operation(handle, islockable);
_
