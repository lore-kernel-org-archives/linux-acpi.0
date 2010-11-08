From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] PNPACPI: check return value of pnp_add_device()
Date: Mon, 8 Nov 2010 11:06:04 -0800
Message-ID: <20101108190603.GA18738@core.coreip.homeip.net>
References: <20101104173929.GA11251@core.coreip.homeip.net>
 <201011081445.00124.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44461 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635Ab0KHTGX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Nov 2010 14:06:23 -0500
Received: by vws13 with SMTP id 13so2107156vws.19
        for <linux-acpi@vger.kernel.org>; Mon, 08 Nov 2010 11:06:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201011081445.00124.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Mon, Nov 08, 2010 at 02:45:00PM -0700, Bjorn Helgaas wrote:
> On Thursday, November 04, 2010 11:39:30 am Dmitry Torokhov wrote:
> > pnp_add_device() may fail so we need to handle errors and avoid leaking
> > memory. Also, do not use ACPI-specific return codes (AE_OK) but rather
> > standard ones.
> 
> I think this is generally a good thing.  You probably found this by
> inspection, but if there's a bug report, please include the URL.

I am not aware of an existing bug report,I just happened to look into
the code in question...

> 
> Would you consider fixing the similar leaks and failure path issues
> in isapnp and pnpbios at the same time?

-ENOTIME at the moment ;( The only reason I happened to look into PNP
code is that issue with HID strings exceeding 8 characters.

> 
> > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> > ---
> > 
> >  drivers/pnp/pnpacpi/core.c |   13 ++++++++++---
> >  1 files changed, 10 insertions(+), 3 deletions(-)
> > 
> > 
> > diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
> > index 2d73dfc..06ee06c 100644
> > --- a/drivers/pnp/pnpacpi/core.c
> > +++ b/drivers/pnp/pnpacpi/core.c
> > @@ -194,8 +194,9 @@ static char *pnpacpi_get_id(struct acpi_device *device)
> >  
> >  static int __init pnpacpi_add_device(struct acpi_device *device)
> >  {
> > -	acpi_handle temp = NULL;
> > +	acpi_handle temp;
> >  	acpi_status status;
> > +	int error;
> >  	struct pnp_dev *dev;
> >  	char *pnpid;
> >  	struct acpi_hardware_id *id;
> > @@ -256,10 +257,16 @@ static int __init pnpacpi_add_device(struct acpi_device *device)
> >  	/* clear out the damaged flags */
> >  	if (!dev->active)
> >  		pnp_init_resources(dev);
> > -	pnp_add_device(dev);
> > +
> > +	error = pnp_add_device(dev);
> > +	if (error) {
> > +		put_device(&dev->dev);
> > +		return error;
> > +	}
> > +
> >  	num++;
> >  
> > -	return AE_OK;
> > +	return 0;
> 
> The acpi_get_devices() usage of pnpacpi_add_device() expects an
> acpi_status return value, so maybe we should leave this same and
> change the pnpacpi_add_device() return type from
> "int" to "acpi_status"?

PNPACPI calls acpi_get_devices() with pnpacpi_add_device_handler() which
returns proper type (acpi_status).

Thanks.

-- 
Dmitry
