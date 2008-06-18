From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 6/8] libata hotplug to align with dock driver
Date: Wed, 18 Jun 2008 12:02:59 +0800
Message-ID: <1213761779.22371.8.camel@sli10-desk.sh.intel.com>
References: <1212729788.25188.29.camel@sli10-desk.sh.intel.com>
	 <20080609013719.GA30665@srcf.ucam.org>
	 <1213061676.32112.6.camel@sli10-desk.sh.intel.com>
	 <20080610081527.GB29300@homac>
	 <1213086452.21428.1.camel@sli10-desk.sh.intel.com>
	 <20080610164302.GA4900@homac.suse.de>
	 <1213154621.5075.3.camel@sli10-desk.sh.intel.com>
	 <20080611125217.GB9377@homac.suse.de>
	 <1213233828.21018.4.camel@sli10-desk.sh.intel.com>
	 <20080616124939.GE17191@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9291 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758037AbYFRD45 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jun 2008 23:56:57 -0400
In-Reply-To: <20080616124939.GE17191@homac.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Holger Macht <hmacht@suse.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>

On Mon, 2008-06-16 at 14:49 +0200, Holger Macht wrote:
> On Thu 12. Jun - 09:23:48, Shaohua Li wrote:
> > On Wed, 2008-06-11 at 14:52 +0200, Holger Macht wrote:
> > > On Wed 11. Jun - 11:23:41, Shaohua Li wrote:
> > > > On Tue, 2008-06-10 at 18:43 +0200, Holger Macht wrote:
> > > > > On Tue 10. Jun - 16:27:32, Shaohua Li wrote:
> > > > > > On Tue, 2008-06-10 at 10:15 +0200, Holger Macht wrote:
> > > > > > > On Tue 10. Jun - 09:34:36, Shaohua Li wrote:
> > > > > > > > On Mon, 2008-06-09 at 02:37 +0100, Matthew Garrett wrot=
e:
> > > > > > > > > On Fri, Jun 06, 2008 at 01:23:08PM +0800, Shaohua Li =
wrote:
> > > > > > > > >=20
> > > > > > > > > >  	case ACPI_NOTIFY_EJECT_REQUEST:
> > > > > > > > > >  		ata_ehi_push_desc(ehi, "ACPI event");
> > > > > > > > > > -
> > > > > > > > > > -		if (!is_dock_event)
> > > > > > > > > > -			break;
> > > > > > > > > > -
> > > > > > > > > > -		/* undock event - immediate unplug */
> > > > > > > > > >  		ata_acpi_detach_device(ap, dev);
> > > > > > > > >=20
> > > > > > > > > Ok, just to check that I've understood the other patc=
hes - this will=20
> > > > > > > > > only be called if the device has actually been remove=
d, and not if you=20
> > > > > > > > > merely get an EJECT_REQUEST, right? An EJECT_REQUEST =
from a bay device=20
> > > > > > > > > should always just signal userspace, and never actual=
ly cause the device=20
> > > > > > > > > to be deleted. I don't really like the way that you'r=
e remapping event=20
> > > > > > > > > types inside the dock driver - it'd be cleaner if the=
 per-driver=20
> > > > > > > > > handlers received ADD_DEVICE or REMOVE_DEVICE or some=
thing.
> > > > > > > > It's not forcely ejected. This patch adds a check in do=
ck.c, if eject
> > > > > > > > request is for an ata bay, we just signal userspace. La=
tter if a
> > > > > > > > device/bus check invoked, dock driver will check status=
, and doing force
> > > > > > > > eject. At this time, ata's EJECT_REQUEST handler will b=
e called.
> > > > > > > > Remapping event is to make per-driver handlers easy. co=
mplex is all in
> > > > > > > > dock driver.
> > > > > > >=20
> > > > > > > I still don't get a uevent signalled to userspace for a b=
ay device in my
> > > > > > > dock station when pressing the lever on the bay device. I=
 think I'll get
> > > > > > > to debug this by the end of the week or the weekend if yo=
u like...
> > > > > > can you send me the acpidump output, so I can have a quick =
check first?
> > > > Looks my patch didn't handle bay device in a dock station corre=
ctly. Can
> > > > you please try below patch?
> > >=20
> > > Now I get the uevent, however, when trying with init=3D/bin/bash,=
 the device
> > > never comes back once ejected.
> > >=20
> > > Furthermore, the must be a race somewhere, when docking, the syst=
em
> > > freezes sporadically. First dock worked, second time didn't.
> > Double checked a T61 here, can't reproduce, please help do some
> > debug. =EF=BB=BFDoes this work without my patches?
>=20
> Yes, it does.
>=20
> I think the main difference between those devices in the system and t=
hose
> in the dock station itself, is that for the separate device in the do=
ck,
> no ACPI_DEVICE_CHECK is emitted when the device is replugged.
>=20
> After an APCI_NOTIFY_EJECT_REQUEST, if I do
> 'echo 1 > /sys/devices/platform/dock.2/undock',
> the device is properly ejected and comes back when replugging.  When =
doing
> 'echo 1 > /sys/class/scsi_device/.../delete', or doing nothing
> the device never comes back (except undocking/redocking).
I had some discussions with Holger on the issue. The problem is
ACPI_DEVICE_CHECK event is missed in the system, so dock driver didn't
receive any event when the bay is actually removed. The solution is
easy, userspace should do 'echo 1 > /sys/devices/platform/dock.*/undock=
'
when NOTIFY_EJECT_REQUEST is received. For system which can send
DEVICE_CHECK like T61, this isn't required, but not harmful. So in any
case, userspace should write the 'undock' file.

'echo 1 > /sys/class/.../delete' just remove the bay from scsi layer.
the device isn't removed from ACPI layer. the device is still present
from ACPI point of view and in Holger's case _EJ0 isn't executed. This
is insane though it works before. For ACPI controlled bay, we should
take the ACPI way, that is to write 'undock' file.

Thanks,
Shaohua

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
