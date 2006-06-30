From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 4/6] drivers/acpi/scan.c: make acpi_bus_type static
Date: Fri, 30 Jun 2006 14:28:25 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6E16BC0@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:45750 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S933018AbWF3S2i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Jun 2006 14:28:38 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, bunk@stusta.de

applied,
thanks,
-Len 

>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Friday, June 30, 2006 5:15 AM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; bunk@stusta.de
>Subject: [patch 4/6] drivers/acpi/scan.c: make acpi_bus_type static
>
>From: Adrian Bunk <bunk@stusta.de>
>
>Make the needlessly global acpi_bus_type static.
>
>I'd also suggest to rename this struct, since although it's named
>acpi_bus_type, it's of type "struct bus_type", not "struct 
>acpi_bus_type"
>as defined in include/acpi/acpi_bus.h .
>
>Signed-off-by: Adrian Bunk <bunk@stusta.de>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> drivers/acpi/scan.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff -puN 
>drivers/acpi/scan.c~drivers-acpi-scanc-make-acpi_bus_type-stati
>c drivers/acpi/scan.c
>--- a/drivers/acpi/scan.c~drivers-acpi-scanc-make-acpi_bus_type-static
>+++ a/drivers/acpi/scan.c
>@@ -1433,7 +1433,7 @@ static int acpi_device_resume(struct dev
> }
> 
> 
>-struct bus_type acpi_bus_type = {
>+static struct bus_type acpi_bus_type = {
> 	.name		= "acpi",
> 	.suspend	= acpi_device_suspend,
> 	.resume		= acpi_device_resume,
>_
>
