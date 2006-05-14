From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 12/16] acpi: memory leakages in drivers/acpi/thermal.c
Date: Sat, 13 May 2006 23:48:26 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB670F33C@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43417 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932318AbWENDsa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 May 2006 23:48:30 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, vvs@sw.ru, "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>

applied.
thanks,
-Len

>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Thursday, April 27, 2006 5:25 AM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; vvs@sw.ru
>Subject: [patch 12/16] acpi: memory leakages in drivers/acpi/thermal.c
>
>
>From: Vasily Averin <vvs@sw.ru>
>
>acpi_thermal_write_trip_points() and acpi_thermal_add() do not 
>call kfree()
>for allocated memory on the error path.
>
>Signed-off-by: Vasily Averin <vvs@sw.ru>
>Cc: "Brown, Len" <len.brown@intel.com>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> drivers/acpi/thermal.c |    2 +-
> 1 files changed, 1 insertion(+), 1 deletion(-)
>
>diff -puN 
>drivers/acpi/thermal.c~acpi-memory-leakages-in-drivers-acpi-the
>rmalc drivers/acpi/thermal.c
>--- 
>devel/drivers/acpi/thermal.c~acpi-memory-leakages-in-drivers-ac
>pi-thermalc	2006-04-10 23:16:26.000000000 -0700
>+++ devel-akpm/drivers/acpi/thermal.c	2006-04-10 
>23:16:26.000000000 -0700
>@@ -1329,7 +1329,7 @@ static int acpi_thermal_add(struct acpi_
> 
> 	result = acpi_thermal_add_fs(device);
> 	if (result)
>-		return_VALUE(result);
>+		goto end;
> 
> 	init_timer(&tz->timer);
> 
>_
>
