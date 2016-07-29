From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] ACPI / button: remove pointer to old lid_sysfs on unbind
Date: Fri, 29 Jul 2016 09:53:35 +0200
Message-ID: <20160729075335.GP19383@mail.corp.redhat.com>
References: <1469701167-24257-1-git-send-email-benjamin.tissoires@redhat.com>
 <1AE640813FDE7649BE1B193DEA596E883BC07E6E@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60058 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817AbcG2Hxk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 29 Jul 2016 03:53:40 -0400
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BC07E6E@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Jul 29 2016 or thereabouts, Zheng, Lv wrote:
> Hi, Benjamin
> 
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > owner@vger.kernel.org] On Behalf Of Benjamin Tissoires
> > Subject: [PATCH] ACPI / button: remove pointer to old lid_sysfs on unbind
> > 
> > When we removed the procfs dir on error or if the driver is
> > unbound, the two variables acpi_lid_dir and acpi_button_dir
> > were not reset. On the next rebind, those static variables
> > were not null and we couldn't re-register the device again.
> > 
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
> >  drivers/acpi/button.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> > index 5c3b091..e413599 100644
> > --- a/drivers/acpi/button.c
> > +++ b/drivers/acpi/button.c
> > @@ -188,9 +188,11 @@ done:
> [Lv Zheng] 
> I have a concern here for acpi_button_add_fs().
> It looks like that this function doesn't support 2 lid devices.
> So why do we need /proc/acpi/button/lid/LID0 folder?

History I guess?

- (re)introduced in b34a803 "[ACPI] restore /proc/acpi/button/ (ala 2.6.12)"
  (2005-08-03)
- procfs cleaned up in 912b742 "ACPI button: remove unused procfs I/F"
  (2011-03-23)

And I would believe given that it was introduced prior 2.6.12, it's now
kernel ABI.

> 
> >  remove_dev_dir:
> >  	remove_proc_entry(acpi_device_bid(device),
> >  			  acpi_lid_dir);
> > +	acpi_lid_dir = NULL;
> >  	acpi_device_dir(device) = NULL;
> >  remove_lid_dir:
> >  	remove_proc_entry(ACPI_BUTTON_SUBCLASS_LID,
> > acpi_button_dir);
> [Lv Zheng] 
> Should acpi_lid_dir = NULL be put here?

Right

> 
> > +	acpi_button_dir = NULL;
> >  remove_button_dir:
> >  	remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
> [Lv Zheng] 
> Should acpi_button_dir = NULL be put here?
> 

Right

> >  	goto done;
> > @@ -207,8 +209,10 @@ static int acpi_button_remove_fs(struct
> > acpi_device *device)
> >  			  acpi_device_dir(device));
> >  	remove_proc_entry(acpi_device_bid(device),
> >  			  acpi_lid_dir);
> > +	acpi_lid_dir = NULL;
> >  	acpi_device_dir(device) = NULL;
> >  	remove_proc_entry(ACPI_BUTTON_SUBCLASS_LID,
> > acpi_button_dir);
> [Lv Zheng] 
> Should acpi_lid_dir = NULL be put here?
> 
> > +	acpi_button_dir = NULL;
> >  	remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
> [Lv Zheng] 
> Should acpi_button_dir = NULL be put here?

Right for these too to, but it won't change the result in the end :)

I'll send a v2 ASAP.

Cheers,
Benjamin

> 
> Thanks and best regards
> Lv
> 
> > 
> >  	return 0;
> > --
> > 2.5.5
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
