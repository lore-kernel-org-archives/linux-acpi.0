From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 10/11] acpi: Export acpi_bus_type
Date: Mon, 18 Jan 2016 15:57:29 +0100
Message-ID: <2702251.zg6zbsLF6s@vostro.rjw.lan>
References: <1452752207-30382-1-git-send-email-ankitprasad.r.sharma@intel.com> <19135964.pq7BquODL6@vostro.rjw.lan> <1453107660.10582.31.camel@ankitprasad-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52996 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752626AbcARO4t (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Jan 2016 09:56:49 -0500
In-Reply-To: <1453107660.10582.31.camel@ankitprasad-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ankitprasad Sharma <ankitprasad.r.sharma@intel.com>
Cc: intel-gfx@lists.freedesktop.org, akash.goel@intel.com, shashidhar.hiremath@intel.com, tvrtko.ursulin@linux.intel.com, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, January 18, 2016 02:31:00 PM Ankitprasad Sharma wrote:
> On Fri, 2016-01-15 at 15:51 +0100, Rafael J. Wysocki wrote:
> > On Thursday, January 14, 2016 11:46:46 AM ankitprasad.r.sharma@intel.com wrote:
> > > From: Ankitprasad Sharma <ankitprasad.r.sharma@intel.com>
> > > 
> > > Some modules, like i915.ko, needs to detect when certain ACPI features
> > > are active inorder to prevent corruption on contended resources.
> > > In particular, use of BIOS RapidStart Technology may corrupt the contents
> > > of the reserved graphics memory, due to unalarmed hibernation. In which
> > > case i915.ko cannot assume that it (reserved gfx memory) remains
> > > unmodified and must recreate teh contents and importantly not use it to
> > > store unrecoverable user data.
> > > 
> > > Signed-off-by: Ankitprasad Sharma <ankitprasad.r.sharma@intel.com>
> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > Cc: Len Brown <lenb@kernel.org>
> > > Cc: linux-acpi@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > ---
> > >  drivers/acpi/bus.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > > index a212cef..69509c7 100644
> > > --- a/drivers/acpi/bus.c
> > > +++ b/drivers/acpi/bus.c
> > > @@ -814,6 +814,7 @@ struct bus_type acpi_bus_type = {
> > >  	.remove		= acpi_device_remove,
> > >  	.uevent		= acpi_device_uevent,
> > >  };
> > > +EXPORT_SYMBOL_GPL(acpi_bus_type);
> > >  
> > >  /* --------------------------------------------------------------------------
> > >                               Initialization/Cleanup
> > > 
> > 
> > No.
> > 
> > I see no reason whatsoever for doing this.
> > 
> > Thanks,
> > Rafael
> Hi Rafael,
> 
> Thanks for the response.
> 
> Can you please help me with, how to detect the presence of a certain
> acpi device using its id (for example, INT3392 for Intel RST device)? 

If you want to check if the device ir present at all, you cen use
acpi_device_is_present() introduced recently (although that would need
to be exported if you want to use it from a driver).

> As you might have seen (in the next patch in this series), that we use
> this symbol (acpi_bus_type) to iterate over all the devices registered
> on acpi bus, to check if there is a device with id INT3392 present or
> not.

Please don't do that this way.

I'll have a look at the other patch later.

Thanks,
Rafael

