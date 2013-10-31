From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [Resend PATCH 5/5] IA64/PCI/ACPI: Rework PCI root bridge ACPI
 resource conversion
Date: Thu, 31 Oct 2013 07:00:02 -0600
Message-ID: <20131031130002.GA9862@google.com>
References: <20131016235541.GD17866@google.com>
 <525F7F0F.5010306@intel.com>
 <CAErSpo7P+n5c2uUoodT=LOjE3UH3LBcjifbj8reXzAeWydsoLA@mail.gmail.com>
 <52612D1C.4070701@intel.com>
 <20131023223904.GA18454@google.com>
 <526BF37E.8040801@intel.com>
 <CAErSpo50_JQEhGOK6mcnaj36f6Fhgp3VcHKSmziC6JB_Ycu0Xg@mail.gmail.com>
 <5270C47C.5040206@intel.com>
 <CAErSpo5ye_Y=b7476cFuDi7-hW4bJzm+D99cTek+wNkWefs4DQ@mail.gmail.com>
 <5271BFBB.8040307@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:42559 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480Ab3JaNAG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Oct 2013 09:00:06 -0400
Received: by mail-ie0-f178.google.com with SMTP id x13so5000062ief.9
        for <linux-acpi@vger.kernel.org>; Thu, 31 Oct 2013 06:00:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5271BFBB.8040307@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: Tony Luck <tony.luck@intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yinghai@kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Yoknis, Mike" <mike.yoknis@hp.com>, "Pearson, Greg" <greg.pearson@hp.com>

On Thu, Oct 31, 2013 at 10:26:03AM +0800, Lan Tianyu wrote:
> On 2013=E5=B9=B410=E6=9C=8831=E6=97=A5 00:23, Bjorn Helgaas wrote:
> > On Wed, Oct 30, 2013 at 2:34 AM, Lan Tianyu <tianyu.lan@intel.com> =
wrote:
> >> On 2013=E5=B9=B410=E6=9C=8829=E6=97=A5 01:32, Bjorn Helgaas wrote:
> >>>
> >>> On Sat, Oct 26, 2013 at 10:53 AM, Lan Tianyu <tianyu.lan@intel.co=
m> wrote:
> >>>>
> >>>> On 10/24/2013 06:39 AM, Bjorn Helgaas wrote:
> >>>>>
> >>>>> On Fri, Oct 18, 2013 at 08:44:12PM +0800, Lan Tianyu wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 10/18/2013 04:33 AM, Bjorn Helgaas wrote:
> >>>
> >>>
> >>>>>>> I wonder if it would make sense to make
> >>>>>>> acpi_dev_resource_address_space() ignore addr.translation_off=
set for
> >>>>>>> IO resources.  Or maybe ignore it if the _TTP (type translati=
on) bit
> >>>>>>> is set?
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> I wonder why current code doesn't check _TTP? The code in the
> >>>>>> add_io_space() seems to think _TTP is always set, right?
> >>>>>
> >>>>>
> >>>>> I think it's an oversight, and you should fix it.  I suggest th=
at you
> >>>>> ignore the _TRA value when _TTP is set.  Obviously this only ap=
plies
> >>>>> to I/O port resources, since _TTP is only defined in the I/O Re=
source
> >>>>> Flag (Table 6-185 in ACPI 5.0 spec).
> >>>>
> >>>>
> >>>> _TTP is also defined in the Memory Resource flag, Please have a =
look at
> >>>> Table 6-184 in the ACPI 5.0 Spec.
> >>>
> >>>
> >>> Yes, you're right.  That would be for a host bridge that converts=
 I/O
> >>> on the primary (upstream) side of the bridge to memory on the PCI
> >>> side.  I've never seen such a bridge, and I can't really imagine =
why
> >>> anybody would do that.  But I guess you should be able to safely
> >>> ignore _TRA when _TTP is set in either a MEM or IO descriptor, be=
cause
> >>> the same reasoning should apply to both.
> >>>
> >>>> I am not sure how to deal with _TTP unsetting io resource? _TTP =
unsetting
> >>>> mean the resource is IO on the primary side and also IO on the s=
econdary
> >>>> side.
> >>>
> >>>
> >>> If _TTP is not set, I guess you would apply _TRA.  That's what yo=
u
> >>> already do for MEM descriptors, and think you should just do the =
same
> >>> for IO descriptors.  I would guess that having _TTP =3D 0 and _TR=
A !=3D 0
> >>> is rare for IO descriptors, but I suppose it could happen.
> >>
> >>
> >> Yes, my concern is for the IO resource case of _TTP=3D0 and _TRA !=
=3D0. The
> >> only reason for this case I think of is that the IO resource offse=
ts on
> >> the prime bus and second bus are different. In this case, we still=
 need
> >> to pass _TRA to new_space() and the finial resource->start still s=
hould be
> >> acpi_resource->min + offset returned by add_io_space(), right?
> >=20
> > No, I don't think so.  If the "phys_base" argument to new_space() i=
s
> > non-zero, it is the base of an MMIO region that needs to be
> > ioremapped.  This is handling the _TTP=3D1 case, where the MMIO reg=
ion
> > is translated by the bridge into an IO region on PCI.
> >=20
> > If _TTP=3D0, the region is IO on both the upstream and downstream s=
ides
> > of the host bridge, and we don't want to ioremap a new MMIO region =
for
> > it.  It might be part of the "legacy I/O port space," but that's
> > already covered elsewhere.
> >=20
> > I don't think we need to add special handling for the _TTP=3D0 and =
_TRA
> > !=3D 0 case because I don't think it exists in the field.  If and w=
hen
> > it *does* exist, we'll know what to do.  In the meantime, it should
> > look just like the MEM path.
>=20
>=20
> OK. I get it. acpi_dev_resource_address_space() will only apply _TRA =
to
> resource ->start and ->end for both mem and io resource when _TTP=3D0=
=2E In
> the add_window(), the offset returned by add_io_space() will be added
> directly to ->start and ->end.
>=20
> add_window() {
> 	...
> 	if (resource->flags & IORESOURCE_MEM) {
> 		root =3D &iomem_resource;
> 		offset =3D addr.translation_offset;

I can wait for your patch to see the whole thing, but I would expect
"offset =3D 0" here.  For MEM resources, the arch code should not need =
to
look inside "addr" at all.

> 	} else if (resource->flags & IORESOURCE_IO) {
> 		root =3D &ioport_resource;
>=20
> 		offset =3D add_io_space(info, &addr);
> 		if (offset =3D=3D ~0)
> 			return AE_OK;
>=20
> 		resource->start +=3D offset;
> 		resource->end +=3D offset;
> 	} else
> 		return AE_OK;
>=20
> 	...
> }
>=20
> >=20
> >> If yes, I think _TRA can't be applied to IO resource in the
> >> acpi_dev_resource_address_space() regardless of the value of _TTP.
> >>
> >> BTW, Translation Sparse(_TRS) is only meaningful if _TTP is set.(T=
able
> >> 6-185). The add_io_space() doesn't check _TTP when set sparse. So =
this
> >> should be corrected?
> >=20
> > Sure, I'm OK with this.  It's possible we could trip over a BIOS bu=
g
> > where _TRS=3D1 but _TTP=3D0, but I think the risk is low because on=
ly
> > large ia64 boxes would use this, and there aren't very many of thos=
e.
> >=20
>=20
> Ok. I will add a check for _TTP before setting sparse. Something like=
s this.
>=20
> add_io_space()
> {
> ...
> if (addr->info.io.translation =3D=3D ACPI_TYPE_TRANSLATION &&
>     addr->info.io.translation_type =3D=3D ACPI_SPARSE_TRANSLATION)
> 	sparse =3D 1;
> ...
> }
>=20
>=20
>=20
> > Bjorn
> >=20
>=20
>=20
> --=20
> Best regards
> Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
