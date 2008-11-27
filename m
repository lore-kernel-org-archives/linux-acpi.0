From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [RFC]  [PATCH] ACPI :Remove the EC space handler explicitly
	when failing in _REG object
Date: Thu, 27 Nov 2008 09:29:03 +0800
Message-ID: <1227749343.4053.32.camel@yakui_zhao.sh.intel.com>
References: <1227689447.4053.5.camel@yakui_zhao.sh.intel.com>
	 <492DAB8B.30409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:65379 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932AbYK0BVz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Nov 2008 20:21:55 -0500
In-Reply-To: <492DAB8B.30409@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "astarikovskiy@suse.de" <astarikovskiy@suse.de>

On Thu, 2008-11-27 at 04:03 +0800, Alexey Starikovskiy wrote:
> This is hardly a "fix", you just disable EC on this machine... Famous 
Yes. This can't fix the issue on the box of bug11884. 
But in theory if the incorrect status is returned by
acpi_install_address_space_handler, the EC space handler should be
removed explicitly. Right? In such case the EC device will be disabled
on this box. 
    But if the EC space handler is not removed and EC flag in AML code
still indicates that EC operation region is already accessible, the EC
internal register will be accessed in AML code. At the same time the
memory region pointed by acpi_ec is already freed. This is the fourth
argument of ec_space_handler.
    In such case if the EC space handler is still accessed, OS will try
to access the memory region already freed. Maybe the kernel panic will
be reported and the system can't be booted.
    In fact we have a similar bug 10237. And on that box of bug10237 OS
fails in evaluating _REG object and then kernel panic is reported. 
    The workaround patch is that OS ignores the error and continue to
initialize EC device if AE_NOT_FOUND is returned by the _REG object.
In such case the system can be booted very normally.
> "how windows runs on this machine?" is not answered...
Windows can work well on such boxes while Linux can't work well.This is
the gap between Linux and windows. It is our target to narrow the gap.
Maybe on windows the incorrect status returned by EC _REG object is
ignored by EC driver. In such case the EC device can be initialized
correctly. 
> Regards,
> Alex.
> 
> Zhao Yakui wrote:
> > Hi, All
> >
> >     On some laptops as it fails in evaluating the _REG object, which brings that
> > EC device can't be initialized correctly. But the EC space handler is not removed.
> > In such case maybe EC internal register will still be accessed in AML code. It is
> > not reasonable.
> >     The following patch is to fix the above issue. When it fails in evaluating the
> > _REG object, the EC space handler should be removed explicitly. 
> >     Thanks for the comments.
> >     
> >
> >     On some laptops the incorrect status is returned by acpi_install_space
> > _handler because of the buggy _REG object, which causes that the EC device can't
> > be initialized correctly. 
> >     In such case it will be appropriate that the EC space handler is removed
> > explicitly if OS fails in evaluating _REG object.
> >
> > http://bugzilla.kernel.org/show_bug.cgi?id=11884
> >
> > Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> > cc:Alexey Starikovskiy <astarikovskiy@suse.de>
> > ---
> >  drivers/acpi/ec.c |   11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > Index: linux-2.6/drivers/acpi/ec.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/acpi/ec.c
> > +++ linux-2.6/drivers/acpi/ec.c
> > @@ -916,6 +916,17 @@ static int ec_install_handlers(struct ac
> >  			printk(KERN_ERR "Fail in evaluating the _REG object"
> >  				" of EC device. Broken bios is suspected.\n");
> >  		} else {
> > +			/*
> > +			 * If incorrect status is returned because of the buggy
> > +			 * _REG object, the EC space handler should be
> > +			 * uninstalled explicitly.
> > +			 * Otherwise maybe the EC internal register is still
> > +			 * accessed in AML code although EC device is not
> > +			 * initialized correctly.
> > +			 */
> > +			acpi_remove_address_space_handler(ec->handle,
> > +						ACPI_ADR_SPACE_EC,
> > +						&acpi_ec_space_handler);
> >  			acpi_remove_gpe_handler(NULL, ec->gpe,
> >  				&acpi_ec_gpe_handler);
> >  			return -ENODEV;
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >   
> 

