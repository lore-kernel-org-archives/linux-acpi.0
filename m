From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [patch 1/11]avoid check _STA method
Date: Fri, 26 Sep 2008 09:04:59 +0800
Message-ID: <20080926010459.GA28382@sli10-desk.sh.intel.com>
References: <1219888923.29375.21.camel@sli10-desk.sh.intel.com> <20080922105759.GB26633@homac.suse.de> <1222224665.968.3.camel@sli10-desk.sh.intel.com> <20080925144945.GA8942@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:16236 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752542AbYIZBFD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Sep 2008 21:05:03 -0400
Content-Disposition: inline
In-Reply-To: <20080925144945.GA8942@homac.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andi Kleen <andi@firstfloor.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, mjg59 <mjg59@srcf.ucam.org>, Teju

On Thu, Sep 25, 2008 at 10:49:45PM +0800, Holger Macht wrote:
> On Wed 24. Sep - 10:51:05, Shaohua Li wrote:
> > On Mon, 2008-09-22 at 18:57 +0800, Holger Macht wrote:
> > > On Thu 28. Aug - 10:02:03, Shaohua Li wrote:
> > > > In some BIOSes, every _STA method call will send a notification again,
> > > > this cause freeze. And in some BIOSes, it appears _STA should be called
> > > > after _DCK. This tries to avoid calls _STA, and still keep the device
> > > > present check.
> > > > http://bugzilla.kernel.org/show_bug.cgi?id=10431
> > >
> > > Finally found some time to test this...
> > >
> > > >
> > > > Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> > > > ---
> > > >  drivers/acpi/dock.c |    5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > Index: linux/drivers/acpi/dock.c
> > > > ===================================================================
> > > > --- linux.orig/drivers/acpi/dock.c    2008-08-27 14:38:44.000000000 +0800
> > > > +++ linux/drivers/acpi/dock.c 2008-08-28 09:33:02.000000000 +0800
> > > > @@ -604,14 +604,17 @@ static int handle_eject_request(struct d
> > > >  static void dock_notify(acpi_handle handle, u32 event, void *data)
> > > >  {
> > > >       struct dock_station *ds = data;
> > > > +     struct acpi_device *tmp;
> > > >
> > > >       switch (event) {
> > > >       case ACPI_NOTIFY_BUS_CHECK:
> > > > -             if (!dock_in_progress(ds) && dock_present(ds)) {
> > > > +             if (!dock_in_progress(ds) && acpi_bus_get_device(ds->handle,
> > >
> > > On the Thinkpad X60, when booting undocked, the first time I dock,
> > > acpi_bus_get_device() returns 0, so hotplug is not performed
> > > properly. Second time (undock->dock), it works.
> > So the patch breaks your X60? acpi_bus_get_device() returns 0 means the
> > device is already in ACPI device tree, but it shouldn't as it's not
> > present.
> 
> Do you have a model number of a system which needs this patch? If so,
> maybe I could get my hands on one to do some more testing...maybe finding
> another solution...
please see the bugzilla above. I haven't a system which requires this at hand.
I'm quite strange why acpi_bus_get_device() returns 0 for a non-present device,
maybe you can dig into this. Is it possible the BIOS wrongly reported device
status?

Thanks,
Shaohua
