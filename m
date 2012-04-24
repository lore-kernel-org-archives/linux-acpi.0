From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: [PATCH] ACPI: evaluate _PS3 when entering D3 Cold
Date: Tue, 24 Apr 2012 22:24:57 +0800
Message-ID: <20120424142457.GA5292@fedora>
References: <1333217910-29579-1-git-send-email-aaron.lu@amd.com>
 <201204231343.03382.rjw@sisk.pl>
 <20120423151327.GA4019@fedora>
 <201204232150.57812.rjw@sisk.pl>
 <20120424020708.GA10397@localhost.amd.com>
 <1335234576.15942.19.camel@minggr>
 <20120424031011.GA27099@ladygaga>
 <CAF1ivSbOhUbE6wreRQ5E3jV5N_haHn1y9q48CU_OZFeCRTed+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAF1ivSbOhUbE6wreRQ5E3jV5N_haHn1y9q48CU_OZFeCRTed+A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Andiry Xu <andiry.xu@amd.com>, Alex He <alex.he@amd.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 24, 2012 at 09:15:37PM +0800, Lin Ming wrote:
> >> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> >> > index 7417267..734d946 100644
> >> > --- a/drivers/acpi/scan.c
> >> > +++ b/drivers/acpi/scan.c
> >> > @@ -908,6 +908,10 @@ static int acpi_bus_get_power_flags(struct =
acpi_device *device)
> >> > =A0 =A0 device->power.states[ACPI_STATE_D3].flags.valid =3D 1;
> >> > =A0 =A0 device->power.states[ACPI_STATE_D3].power =3D 0;
> >> >
> >> > + =A0 /* Also set D3cold's explicit flag when _PS3 exists */
> >> > + =A0 if (device->power.states[ACPI_STATE_D3_HOT].flags.explicit=
_set)
> >> > + =A0 =A0 =A0 =A0 =A0 device->power.states[ACPI_STATE_D3].flags.=
explicit_set =3D 1;
> >>
> >> We should use ACPI_STATE_D3_COLD instead of ACPI_STATE_D3 to make =
thing
> >> clear.
> >>
> > Thanks for your suggestion.
> >
> > Well, considering all those ACPI_STATE_D3 used in tree, I don't thi=
nk I
> > should use ACPI_STATE_D3_COLD here, especially the two lines above =
are
> > still using ACPI_STATE_D3.
> >
> > But if that is desired, we should probably change all the existing
> > ACPI_STATE_D3 macros to ACPI_STATE_D3_COLD to make things clear.
> >
> > Or we all use ACPI_STATE_D3, since it is defined as 4 and means D3 =
cold,
> > and people will learn this, won't they?
> >
> > What do you think?
>=20
> OK.
>=20
> But we may do more cleanup later.
>=20

Sure :-)
I think the first thing to do is to agree on which macro should be used=
,
ACPI_STATE_D3 or ACPI_STATE_D3_COLD. And then replace the other one
altogether.

Thanks,
Aaron
