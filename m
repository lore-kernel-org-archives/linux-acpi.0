From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 7/8] auto bind the memory device which is hotpluged before
 the driver is loaded
Date: Tue, 26 Jun 2012 21:33:25 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1206262132120.24245@chino.kir.corp.google.com>
References: <4FE97DD5.6030205@cn.fujitsu.com> <4FE97F60.90101@cn.fujitsu.com> <20120626170635.GC21579@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62995 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734Ab2F0Ed1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jun 2012 00:33:27 -0400
Received: by dady13 with SMTP id y13so838079dad.19
        for <linux-acpi@vger.kernel.org>; Tue, 26 Jun 2012 21:33:27 -0700 (PDT)
In-Reply-To: <20120626170635.GC21579@phenom.dumpdata.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Wen Congyang <wency@cn.fujitsu.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yasuaki ISIMATU <isimatu.yasuaki@jp.fujitsu.com>

On Tue, 26 Jun 2012, Konrad Rzeszutek Wilk wrote:

> > diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> > index 148c88a..a682657 100644
> > --- a/drivers/acpi/acpi_memhotplug.c
> > +++ b/drivers/acpi/acpi_memhotplug.c
> > @@ -52,6 +52,9 @@ MODULE_LICENSE("GPL");
> >  #define MEMORY_POWER_ON_STATE	1
> >  #define MEMORY_POWER_OFF_STATE	2
> >  
> > +static bool auto_probe;
> > +module_param(auto_probe, bool, S_IRUGO | S_IWUSR);
> > +
> >  static int acpi_memory_device_add(struct acpi_device *device);
> >  static int acpi_memory_device_remove(struct acpi_device *device, int type);
> >  
> > @@ -515,12 +518,44 @@ acpi_memory_register_notify_handler(acpi_handle handle,
> >  				    u32 level, void *ctxt, void **retv)
> >  {
> >  	acpi_status status;
> > -
> > +	struct acpi_memory_device *mem_device = NULL;
> > +	unsigned long long current_status;
> 
> Can it just be unsigned long?
> 

Not on 32-bit, the ACPI 2.0 and later specs can handle 64 bit integers.
