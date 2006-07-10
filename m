From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [patch 4/5] ACPI: disable SBS by default
Date: Sun, 9 Jul 2006 19:36:07 -0700
Message-ID: <20060709193607.21b63fa1.rdunlap@xenotime.net>
References: <CFF307C98FEABE47A452B27C06B85BB6ECFA17@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:47053 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161301AbWGJCdV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Jul 2006 22:33:21 -0400
Received: from midway.site ([71.117.253.75]) by xenotime.net for <linux-acpi@vger.kernel.org>; Sun, 9 Jul 2006 19:33:20 -0700
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6ECFA17@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: akpm@osdl.org, linux-acpi@vger.kernel.org, dtor@insightbb.com, dtor@mail.ru

On Sun, 9 Jul 2006 22:19:28 -0400 Brown, Len wrote:

> While SBS is rare in the general population,
> it is common on some product lines, and thus
> this should have the same default as the regular
> battery driver.
> 
> Rahter than y or n, neither should have any default --
> I'll fix that now.

Default is 'n' when omitted...

> thanks,
> -Len 
> 
> >-----Original Message-----
> >From: akpm@osdl.org [mailto:akpm@osdl.org] 
> >Sent: Friday, July 07, 2006 2:53 AM
> >To: Brown, Len
> >Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; 
> >dtor@insightbb.com; dtor@mail.ru
> >Subject: [patch 4/5] ACPI: disable SBS by default
> >
> >From: Dmitry Torokhov <dtor@insightbb.com>
> >
> >Kconfig help even says that SBS is pretty rare and already 
> >obsolete so it
> >does not make sence to keep it enabled.
> >
> >Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> >Signed-off-by: Andrew Morton <akpm@osdl.org>
> >---
> >
> > drivers/acpi/Kconfig |    2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff -puN drivers/acpi/Kconfig~acpi-disable-sbs-by-default 
> >drivers/acpi/Kconfig
> >--- a/drivers/acpi/Kconfig~acpi-disable-sbs-by-default
> >+++ a/drivers/acpi/Kconfig
> >@@ -368,7 +368,7 @@ config ACPI_SBS
> > 	tristate "Smart Battery System (EXPERIMENTAL)"
> > 	depends on X86 && I2C
> > 	depends on EXPERIMENTAL
> >-	default y
> >+	default n
> > 	help
> > 	  This driver adds support for the Smart Battery System.
> > 	  Depends on I2C (Device Drivers ---> I2C support)
> >_


---
~Randy
