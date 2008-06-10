From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 6/8] libata hotplug to align with dock driver
Date: Tue, 10 Jun 2008 16:27:32 +0800
Message-ID: <1213086452.21428.1.camel@sli10-desk.sh.intel.com>
References: <1212729788.25188.29.camel@sli10-desk.sh.intel.com>
	 <20080609013719.GA30665@srcf.ucam.org>
	 <1213061676.32112.6.camel@sli10-desk.sh.intel.com>
	 <20080610081527.GB29300@homac>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:47618 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753974AbYFJIV5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Jun 2008 04:21:57 -0400
In-Reply-To: <20080610081527.GB29300@homac>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Holger Macht <hmacht@suse.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>

On Tue, 2008-06-10 at 10:15 +0200, Holger Macht wrote:
> On Tue 10. Jun - 09:34:36, Shaohua Li wrote:
> > On Mon, 2008-06-09 at 02:37 +0100, Matthew Garrett wrote:
> > > On Fri, Jun 06, 2008 at 01:23:08PM +0800, Shaohua Li wrote:
> > > 
> > > >  	case ACPI_NOTIFY_EJECT_REQUEST:
> > > >  		ata_ehi_push_desc(ehi, "ACPI event");
> > > > -
> > > > -		if (!is_dock_event)
> > > > -			break;
> > > > -
> > > > -		/* undock event - immediate unplug */
> > > >  		ata_acpi_detach_device(ap, dev);
> > > 
> > > Ok, just to check that I've understood the other patches - this will 
> > > only be called if the device has actually been removed, and not if you 
> > > merely get an EJECT_REQUEST, right? An EJECT_REQUEST from a bay device 
> > > should always just signal userspace, and never actually cause the device 
> > > to be deleted. I don't really like the way that you're remapping event 
> > > types inside the dock driver - it'd be cleaner if the per-driver 
> > > handlers received ADD_DEVICE or REMOVE_DEVICE or something.
> > It's not forcely ejected. This patch adds a check in dock.c, if eject
> > request is for an ata bay, we just signal userspace. Latter if a
> > device/bus check invoked, dock driver will check status, and doing force
> > eject. At this time, ata's EJECT_REQUEST handler will be called.
> > Remapping event is to make per-driver handlers easy. complex is all in
> > dock driver.
> 
> I still don't get a uevent signalled to userspace for a bay device in my
> dock station when pressing the lever on the bay device. I think I'll get
> to debug this by the end of the week or the weekend if you like...
can you send me the acpidump output, so I can have a quick check first?

Thanks,
Shaohua

