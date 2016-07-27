From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Help/info request (in re trip points)
Date: Wed, 27 Jul 2016 09:29:51 +0800
Message-ID: <1469582991.2367.63.camel@intel.com>
References: <alpine.LSU.2.20.13.1607221012230.4463@coulomb.u-pec.fr>
	 <alpine.LNX.2.20.13.1607262256590.2759@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52855 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932471AbcG0Bab (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Jul 2016 21:30:31 -0400
In-Reply-To: <alpine.LNX.2.20.13.1607262256590.2759@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lucas Levrel <lucas.levrel@free.fr>, linux-acpi@vger.kernel.org

Hi, Lucas,

As you have mentioned thermal.c, I think you are using ACPI thermal
control on your platform, right?
trip_point_?_hyst files are created by thermal core, if the platform
thermal driver supports hysteresis, and ACPI thermal driver, which is
used in your case, does not support=C2=A0hysteresis.

On =E4=BA=8C, 2016-07-26 at 23:01 +0200, Lucas Levrel wrote:
> Hi (once more),
>=20
> Isn't there anyone who could spare a few minutes to guide me on this?
>=20
> I found some references to trip_point_?_hyst files, which seem
> promising,=C2=A0
> but they aren't there in my sysfs, and I cannot create them (e.g.
> "touch:=C2=A0
> cannot touch `trip_point_4_hyst': No such file or directory").
>=20
> Thanks.
>=20
> Lucas Levrel
>=20
> Le 22 juillet 2016, Lucas Levrel a =C3=A9crit :
>=20
> >=20
> > Hi,
> >=20
> > Is this the right place to request for help and/or information
> > about thermal=C2=A0
> > zones? If not, please point me to the right place.
> >=20
> > I browsed through thermal.c but couldn't find an answer to my
> > question (it=C2=A0
> > goes without saying I'm not an expert), namely:
> > how are trip point temperatures set at boot,

ACPI thermal driver gets the trip point temperature information from
ACPI tables.

> >  and how are they reset when=C2=A0
> > crossed?
> >=20
Usually, ACPI trip point is not reset when crossed, but it does
have=C2=A0granularity, which determines when to generate a
temperature change notification.
Say, for a platform that the trip point temperature is 50C, and
granularity is 5C, when the ACPI thermal driver receives a notification
at 50C, it starts to spin the fan.
Then next time when the ACPI thermal driver gets a temperature change
notification, the temperature is either 55C, which means we need to
take further action to cool the system, or the temperature is 45C and
we can turn off the fan.

In some cases, the trip point may get reset. You can refer to section
11.1.2 in ACPI spec 6.1. IN this case, a trip point change notification
will be sent to thermal driver, and ACPI thermal driver will re-
evaluate the trip point control methods to get new trip point
temperature. But AFAICS, this is really rare.

> > I'm aiming at changing the temperatures at which the fan starts and
> > stops.=C2=A0
> > The kernel parameter thermal.act=3DXXX did change the "fan on"
> > temperature, but=C2=A0
> > not the "fan off" one. I expected the hysteresis T(on)-T(off) to be
> > constant,=C2=A0
> > and thus I thought T(off) would raise as much as I raised T(on),
> > but this is=C2=A0
> > not the case.
> >=20
Dynamic trip point can only be supported by platform thermal design.
Specifying such values in userspace does not make sense, because it's
not guaranteed that the thermal driver can get notification upon the
values you specified, thus it would screw up the thermal control
entirely.

thanks,
rui

> > Any help is greatly appreciated.
> >=20
> > Lucas Levrel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
=20
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-in=
fo.html
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
