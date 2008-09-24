From: Holger Macht <hmacht@suse.de>
Subject: Re: [patch 1/11]avoid check _STA method
Date: Wed, 24 Sep 2008 14:17:32 +0200
Message-ID: <20080924121732.GA3131@homac.suse.de>
References: <1219888923.29375.21.camel@sli10-desk.sh.intel.com> <20080922105759.GB26633@homac.suse.de> <1222224665.968.3.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:45964 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418AbYIXMRn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Sep 2008 08:17:43 -0400
Content-Disposition: inline
In-Reply-To: <1222224665.968.3.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andi Kleen <andi@firstfloor.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, mjg59 <mjg59@srcf.ucam.org>, Tejun Heo <htejun@gmail.com>

On Wed 24. Sep - 10:51:05, Shaohua Li wrote:
> On Mon, 2008-09-22 at 18:57 +0800, Holger Macht wrote:
> > On Thu 28. Aug - 10:02:03, Shaohua Li wrote:
> > > In some BIOSes, every _STA method call will send a notification again,
> > > this cause freeze. And in some BIOSes, it appears _STA should be called
> > > after _DCK. This tries to avoid calls _STA, and still keep the device
> > > present check.
> > > http://bugzilla.kernel.org/show_bug.cgi?id=10431
> > 
> > Finally found some time to test this...
> > 
> > >
> > > Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> > > ---
> > >  drivers/acpi/dock.c |    5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > Index: linux/drivers/acpi/dock.c
> > > ===================================================================
> > > --- linux.orig/drivers/acpi/dock.c    2008-08-27 14:38:44.000000000 +0800
> > > +++ linux/drivers/acpi/dock.c 2008-08-28 09:33:02.000000000 +0800
> > > @@ -604,14 +604,17 @@ static int handle_eject_request(struct d
> > >  static void dock_notify(acpi_handle handle, u32 event, void *data)
> > >  {
> > >       struct dock_station *ds = data;
> > > +     struct acpi_device *tmp;
> > >
> > >       switch (event) {
> > >       case ACPI_NOTIFY_BUS_CHECK:
> > > -             if (!dock_in_progress(ds) && dock_present(ds)) {
> > > +             if (!dock_in_progress(ds) && acpi_bus_get_device(ds->handle,
> > 
> > On the Thinkpad X60, when booting undocked, the first time I dock,
> > acpi_bus_get_device() returns 0, so hotplug is not performed
> > properly. Second time (undock->dock), it works.
> So the patch breaks your X60? acpi_bus_get_device() returns 0 means the
> device is already in ACPI device tree, but it shouldn't as it's not
> present.

Well, it does not really break it, I just have to dock a second time :-)
This second time, acpi_bus_get_device() return -ENODEV.

So for this laptop, the old way with dock_present() (checking _STA) would
work just fine.

Regards,
	Holger
