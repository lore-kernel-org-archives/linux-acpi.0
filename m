From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 6/8] libata hotplug to align with dock driver
Date: Thu, 12 Jun 2008 09:23:48 +0800
Message-ID: <1213233828.21018.4.camel@sli10-desk.sh.intel.com>
References: <1212729788.25188.29.camel@sli10-desk.sh.intel.com>
	 <20080609013719.GA30665@srcf.ucam.org>
	 <1213061676.32112.6.camel@sli10-desk.sh.intel.com>
	 <20080610081527.GB29300@homac>
	 <1213086452.21428.1.camel@sli10-desk.sh.intel.com>
	 <20080610164302.GA4900@homac.suse.de>
	 <1213154621.5075.3.camel@sli10-desk.sh.intel.com>
	 <20080611125217.GB9377@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:44600 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753826AbYFLBSc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Jun 2008 21:18:32 -0400
In-Reply-To: <20080611125217.GB9377@homac.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Holger Macht <hmacht@suse.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>

On Wed, 2008-06-11 at 14:52 +0200, Holger Macht wrote:
> On Wed 11. Jun - 11:23:41, Shaohua Li wrote:
> > On Tue, 2008-06-10 at 18:43 +0200, Holger Macht wrote:
> > > On Tue 10. Jun - 16:27:32, Shaohua Li wrote:
> > > > On Tue, 2008-06-10 at 10:15 +0200, Holger Macht wrote:
> > > > > On Tue 10. Jun - 09:34:36, Shaohua Li wrote:
> > > > > > On Mon, 2008-06-09 at 02:37 +0100, Matthew Garrett wrote:
> > > > > > > On Fri, Jun 06, 2008 at 01:23:08PM +0800, Shaohua Li wrot=
e:
> > > > > > >=20
> > > > > > > >  	case ACPI_NOTIFY_EJECT_REQUEST:
> > > > > > > >  		ata_ehi_push_desc(ehi, "ACPI event");
> > > > > > > > -
> > > > > > > > -		if (!is_dock_event)
> > > > > > > > -			break;
> > > > > > > > -
> > > > > > > > -		/* undock event - immediate unplug */
> > > > > > > >  		ata_acpi_detach_device(ap, dev);
> > > > > > >=20
> > > > > > > Ok, just to check that I've understood the other patches =
- this will=20
> > > > > > > only be called if the device has actually been removed, a=
nd not if you=20
> > > > > > > merely get an EJECT_REQUEST, right? An EJECT_REQUEST from=
 a bay device=20
> > > > > > > should always just signal userspace, and never actually c=
ause the device=20
> > > > > > > to be deleted. I don't really like the way that you're re=
mapping event=20
> > > > > > > types inside the dock driver - it'd be cleaner if the per=
-driver=20
> > > > > > > handlers received ADD_DEVICE or REMOVE_DEVICE or somethin=
g.
> > > > > > It's not forcely ejected. This patch adds a check in dock.c=
, if eject
> > > > > > request is for an ata bay, we just signal userspace. Latter=
 if a
> > > > > > device/bus check invoked, dock driver will check status, an=
d doing force
> > > > > > eject. At this time, ata's EJECT_REQUEST handler will be ca=
lled.
> > > > > > Remapping event is to make per-driver handlers easy. comple=
x is all in
> > > > > > dock driver.
> > > > >=20
> > > > > I still don't get a uevent signalled to userspace for a bay d=
evice in my
> > > > > dock station when pressing the lever on the bay device. I thi=
nk I'll get
> > > > > to debug this by the end of the week or the weekend if you li=
ke...
> > > > can you send me the acpidump output, so I can have a quick chec=
k first?
> > Looks my patch didn't handle bay device in a dock station correctly=
=2E Can
> > you please try below patch?
>=20
> Now I get the uevent, however, when trying with init=3D/bin/bash, the=
 device
> never comes back once ejected.
>=20
> Furthermore, the must be a race somewhere, when docking, the system
> freezes sporadically. First dock worked, second time didn't.
Double checked a T61 here, can't reproduce, please help do some
debug. =EF=BB=BFDoes this work without my patches?

Thanks,
Shaohua

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
