From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: Fix acpi_pm_device_sleep_state()
Date: Sat, 12 Jan 2008 12:36:52 +0100
Message-ID: <200801121236.52430.rjw@sisk.pl>
References: <200801110010.38658.rjw@sisk.pl> <200801112346.04744.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33092 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758856AbYALLeg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Jan 2008 06:34:36 -0500
In-Reply-To: <200801112346.04744.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Saturday, 12 of January 2008, Len Brown wrote:
> On Thursday 10 January 2008 18:10, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Fix acpi_pm_device_sleep_state() to return the value returned
> > by _SxD if the device is supposed to wake up the system from
> > given sleep state and the evaluation of _SxW fails (e.g. _SxW
> > is not present).
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  drivers/acpi/sleep/main.c |   15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > Index: linux-2.6/drivers/acpi/sleep/main.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/acpi/sleep/main.c
> > +++ linux-2.6/drivers/acpi/sleep/main.c
> > @@ -472,11 +472,20 @@ int acpi_pm_device_sleep_state(struct de
> >  	if (acpi_target_sleep_state == ACPI_STATE_S0 ||
> >  	    (wake && adev->wakeup.state.enabled &&
> >  	     adev->wakeup.sleep_state <= acpi_target_sleep_state)) {
> > +		acpi_status status;
> > +
> >  		acpi_method[3] = 'W';
> > -		acpi_evaluate_integer(handle, acpi_method, NULL, &d_max);
> > -		/* Sanity check */
> > -		if (d_max < d_min)
> > +		status = acpi_evaluate_integer(handle, acpi_method, NULL,
> > +						&d_max);
> > +		if (ACPI_FAILURE(status)) {
> > +			d_max = d_min;
> > +		} else if (d_max < d_min) {
> > +			/* Warn the user of the broken DSDT */
> > +			printk(KERN_WARNING "ACPI: Wrong value from %s\n",
> > +				acpi_method);
> > +			/* Sanitize it */
> >  			d_min = d_max;
> > +		}
> >  	}
> >  
> >  	if (d_min_p)
> > 
> 
> this patch looks correct, it fixes the bug where 
> _SxD=2, _PRW=x, _SxW was absent, we would return D3 as legal,
> when we should have returned D2.
> 
> applied to acpi test.
> 
> BTW.  We currently don't use *d_min_p
> and I can't imagine when and why we ever would,
> so it would be fine with me if you simplify by deleting it.

It was requested by someone.  I can imagine that if _SxW > _SxD, a driver can
decide which state to choose on the basis of some policy we don't know of.

> Also, the last line of this block comment can be deleted,
> though that was true before this patch also:

Not sure what you mean here ...
 
> acpi_pci_choose_state() block comment can now be updated to delete this line:
> 
> * currently we simply return _SxD, if present.

Yes, I'll do that in a separate patch.

Thanks,
Rafael
