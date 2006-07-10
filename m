From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [patch 4/5] ACPI: disable SBS by default
Date: Sun, 9 Jul 2006 22:19:28 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6ECFA17@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:23876 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1161298AbWGJCTc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Jul 2006 22:19:32 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, dtor@insightbb.com, dtor@mail.ru

While SBS is rare in the general population,
it is common on some product lines, and thus
this should have the same default as the regular
battery driver.

Rahter than y or n, neither should have any default --
I'll fix that now.

thanks,
-Len 

>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Friday, July 07, 2006 2:53 AM
>To: Brown, Len
>Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; 
>dtor@insightbb.com; dtor@mail.ru
>Subject: [patch 4/5] ACPI: disable SBS by default
>
>From: Dmitry Torokhov <dtor@insightbb.com>
>
>Kconfig help even says that SBS is pretty rare and already 
>obsolete so it
>does not make sence to keep it enabled.
>
>Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> drivers/acpi/Kconfig |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff -puN drivers/acpi/Kconfig~acpi-disable-sbs-by-default 
>drivers/acpi/Kconfig
>--- a/drivers/acpi/Kconfig~acpi-disable-sbs-by-default
>+++ a/drivers/acpi/Kconfig
>@@ -368,7 +368,7 @@ config ACPI_SBS
> 	tristate "Smart Battery System (EXPERIMENTAL)"
> 	depends on X86 && I2C
> 	depends on EXPERIMENTAL
>-	default y
>+	default n
> 	help
> 	  This driver adds support for the Smart Battery System.
> 	  Depends on I2C (Device Drivers ---> I2C support)
>_
>
