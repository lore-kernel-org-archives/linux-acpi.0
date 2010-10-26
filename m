From: Alex Chiang <achiang@canonical.com>
Subject: Re: [PATCH] ACPI: install ACPI table handler before any dynamic
 tables being loaded
Date: Mon, 25 Oct 2010 23:06:04 -0600
Message-ID: <20101026050604.GA10465@canonical.com>
References: <1288058814.2210.165.camel@rui>
 <1288059117.2210.167.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:47995 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417Ab0JZFGN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Oct 2010 01:06:13 -0400
Content-Disposition: inline
In-Reply-To: <1288059117.2210.167.camel@rui>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Brown, Len" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "dennis.jansen@web.de" <dennis.jansen@web.de>, bjorn.helgaas@hp.com

Hello Rui,

Thank you for adding me to the cc.

* Zhang Rui <rui.zhang@intel.com>:
> cc Alex Chiang.
> 
> On Tue, 2010-10-26 at 10:06 +0800, Zhang Rui wrote:
> > ACPI table sysfs I/F is broken by commit
> > 
> > 78f1699659963fff97975df44db6d5dbe7218e55
> > Author: Alex Chiang <achiang@hp.com>
> > Date:   Sun Dec 20 12:19:09 2009 -0700
> >     ACPI: processor: call _PDC early
> > 
> > because dynamic SSDT tables may be loaded in _PDC,
> > before installing the ACPI table handler.
> > As a result, the sysfs I/F of these dynamic tables are
> > located at  /sys/firmware/acpi/tables instead of
> > /sys/firmware/acpi/tables/dynamic, which is not true.
> > 
> > Invoke acpi_sysfs_init() before acpi_early_processor_set_pdc(),
> > so that the table handler is installed before any dynamic tables loaded.

You are right; I wasn't careful when I wrote 78f169965996, and
forgot to verify that dynamically loaded tables should appear in
/sys/firmware/acpi/tables/dynamic.

I see that the interface was introduced by 4658e4ef9d252 in
February 2009, so I should have been aware of it.

I think it will be easier for future developers to be aware of
the ACPI sysfs interfaces if they were documented. I see that the
file Documentation/ABI/testing/sysfs-firmware-acpi exists, but
does not describe many of the interfaces in sysfs.

Do you want to write a documentation patch, or shall I?

Also, I think Bjorn had some opinions on acpi_early_processor_set_pdc():
	https://bugzilla.kernel.org/show_bug.cgi?id=14824#c7

Your current patch is fine for fixing the immediate problem you
notice, but perhaps you should explore the ideas that Bjorn wrote
in his last comment, and then we can get rid of this ugly bit
altogether.

Acked-by: Alex Chiang <achiang@canonical.com>

Thanks,
/ac

> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=21142
> > 
> > CC: Dennis Jansen <dennis.jansen@web.de>
> > CC: Alex Chiang <achiang@hp.com>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/acpi/bus.c |    7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > Index: linux-2.6/drivers/acpi/bus.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/acpi/bus.c
> > +++ linux-2.6/drivers/acpi/bus.c
> > @@ -935,6 +935,12 @@ static int __init acpi_bus_init(void)
> >  		goto error1;
> >  	}
> >  
> > +	/*
> > +	 * _PDC control method may load dynamic SSDT tables,
> > +	 * and we need to install the table handler before that.
> > +	 */
> > +	acpi_sysfs_init();
> > +
> >  	acpi_early_processor_set_pdc();
> >  
> >  	/*
> > @@ -1026,7 +1032,6 @@ static int __init acpi_init(void)
> >  	acpi_scan_init();
> >  	acpi_ec_init();
> >  	acpi_power_init();
> > -	acpi_sysfs_init();
> >  	acpi_debugfs_init();
> >  	acpi_sleep_proc_init();
> >  	acpi_wakeup_device_init();
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
