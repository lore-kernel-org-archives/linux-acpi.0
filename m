From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/3] Support PMIC operation region for CrystalCove and
 XPower
Date: Wed, 12 Nov 2014 09:44:19 +0000
Message-ID: <20141112094419.GC24004@x1>
References: <1414735705-18366-1-git-send-email-aaron.lu@intel.com>
 <54616E55.80204@intel.com>
 <20141111111152.GX24004@x1>
 <3052882.EdcZmghHR3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3052882.EdcZmghHR3-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 12 Nov 2014, Rafael J. Wysocki wrote:

> On Tuesday, November 11, 2014 11:11:52 AM Lee Jones wrote:
> > On Tue, 11 Nov 2014, Aaron Lu wrote:
> >=20
> > > On 10/31/2014 02:08 PM, Aaron Lu wrote:
> > > > On Intel Baytrail-T and Baytrail-T-CR platforms, there are two =
customized
> > > > ACPI operation regions defined for the Power Management Integra=
ted Circuit
> > > > device, one is for power resource handling and one is for therm=
al: sensor
> > > > temperature reporting, trip point setting, etc. There are diffe=
rent PMIC
> > > > chips used on those platforms and though each has the same two =
operation
> > > > regions and functionality, their implementation is different so=
 every PMIC
> > > > will need a driver. But since their functionality is similar, s=
ome common
> > > > code is abstracted into the intel_soc_pmic_opregion.c.
> > > >=20
> > > > The last version is posted here:
> > > > https://lkml.org/lkml/2014/9/8/801
> > > >=20
> > > > Changes since then:
> > > > 1 Move to drivers/acpi as discussed on the above thread;
> > > > 2 Added support for XPower AXP288 PMIC operation region support=
;
> > > > 3 Since operation region handler can not be removed(at the mome=
nt at least),
> > > >   use bool for the two operation region driver configs instead =
of tristate;
> > > >   Another reason to do this is that, with Mika's MFD ACPI suppo=
rt patch, all
> > > >   those MFD cell devices created will have the same modalias as=
 their parent's
> > > >   so it doesn't make much sense to compile these drivers into m=
odules.
> > > >=20
> > > > Patch 1 applies on top of Rafael's pm-next branch, and then pat=
ch 2 and
> > > > patch 3 needs merge of Lee's mfd/ib-mfd-iio-3.19 branch where t=
he PMIC
> > > > driver XPower AXP288 and iio driver axp288_adc is located.
> > >=20
> > > Since patch 2-3 are based on top of the mfd/ib-mfd-iio-3.19 branc=
h, it
> > > would be easy to go through the mfd/ib-mfd-iio-3.19 branch.
> > >=20
> > > Rafael,
> > > Can I get your ACK for the three patches?
> > >=20
> > > Lee,
> > > Can you please take the series if Rafael gives it ack?
> >=20
> > Yes, no problem.
>=20
> Well, since the code is going to reside mostly in drivers/acpi, I thi=
nk I should
> be applying the patches and from your response it looks like you are =
fine with
> them.  Is that correct?

I read that this set has dependencies on patches which are already in
the MFD tree.  If that's not the case please go ahead and apply them
with my Ack for the MFD components.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
