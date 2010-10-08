From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 1/2] ACPI: Do not export hid/modalias sysfs file for ACPI objects without a HID
Date: Fri, 8 Oct 2010 09:27:56 +0200
Message-ID: <201010080927.56406.trenn@suse.de>
References: <1285923240-31671-1-git-send-email-trenn@suse.de> <1286497581.2111.3753.camel@rui>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:40020 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754330Ab0JHH2A (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Oct 2010 03:28:00 -0400
In-Reply-To: <1286497581.2111.3753.camel@rui>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "kay.sievers@vrfy.org" <kay.sievers@vrfy.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>

On Friday 08 October 2010 02:26:21 Zhang Rui wrote:
> On Fri, 2010-10-01 at 16:53 +0800, Thomas Renninger wrote:
> > Boot and compile tested.
> > The fact that pnp.ids can now be empty needs testing on some
> > further machines, though.
...
> > -	result = device_create_file(&dev->dev, &dev_attr_hid);
> > -	if (result)
> > -		goto end;
> > +	if (!list_empty(&dev->pnp.ids)) {
> > +		result = device_create_file(&dev->dev, &dev_attr_hid);
> > +		if (result)
> > +			goto end;
> >  
> > -	result = device_create_file(&dev->dev, &dev_attr_modalias);
> > -	if (result)
> > -		goto end;
> > +		result = device_create_file(&dev->dev, &dev_attr_modalias);
> > +		if (result)
> > +			goto end;
> > +	}
> >  
> 
> the "hid" attribute exports the first entry of the device.pnp..ids list,
> while "modalias" exports all the entries.
> now it seems that the "hid" file is redundant, right?
Yep. You need some parsing, but udev is already doing that.
But it's sysfs api..., you'd need to add a:
printk_once("Deprecated HID file accessed by %s, use modalias instead\n",
              current->comm);
and deprecate that for some years.

    Thomas
