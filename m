From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH] ACPI: evaluate _PS3 when entering D3 Cold
Date: Sun, 01 Apr 2012 14:28:57 +0800
Message-ID: <1333261737.2939.84.camel@minggr>
References: <1333217910-29579-1-git-send-email-aaron.lu@amd.com>
	 <1333258053.2939.22.camel@minggr>
	 <20120401055603.GA11505@localhost.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:49236 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843Ab2DAG3A (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 1 Apr 2012 02:29:00 -0400
In-Reply-To: <20120401055603.GA11505@localhost.amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: Len Brown <lenb@kernel.org>, "Rafeal J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Andiry Xu <andiry.xu@amd.com>, Alex He <alex.he@amd.com>

On Sun, 2012-04-01 at 13:56 +0800, Aaron Lu wrote:
> Hi,
>=20
> On Sun, Apr 01, 2012 at 01:27:33PM +0800, Lin Ming wrote:
> > > -		if (device->power.states[state].flags.explicit_set) {
> > > +		/* If state is D3 Cold, try to evaluate _PS3 first */
> > > +		if (state =3D=3D ACPI_STATE_D3_COLD) {
> > > +			explicit_set =3D (ps - 1)->flags.explicit_set;
> > > +			object_name[3] -=3D 1;
> > > +		}
> >=20
> > I'm not sure whether this works or not.
> >=20
> > From ACPI spec,
> >=20
> > _PS3 "is used to put the specific device into its D3hot or D3 state=
"
> >=20
> > D3 neither means D3hot nor D3cold. It's an old term before D3hot an=
d
> > D3cold were introduced.
> I guess D3 has to mean something, right? :-)
>=20
> Here is the problem, there is no _PR3 in AMD's implementation, just _=
PS3.
> And since _S0W evaluates 4, I've to put this device into D3 cold stat=
e
> with _PS3.
>=20
> And the ACPI does have some words like:
>=20
> ------
> Platform/drivers must assume that the device will have power complete=
ly
> removed when the device is place into =E2=80=9CD3=E2=80=9D via _PS3
> ------
>=20
> This is in section 7.2.11: _PR3.
>=20
> >=20
> > Another problem:
> >=20
> > With your patch, both D3hot and D3cold will evaluate _PS3, right?
> >=20
> Yes.
>=20
> > Will it have problem on AMD platform if you try to put ODD into D3h=
ot
> > state? _PS3 is evaluated, so it actually enters D3Cold state.
>=20
> There is no D3 hot support for this device(from the firmware's
> perspective), either it is at D0(via _PS0), or it will be at D3 cold(=
via
> _PS3).

But this is the generic code. We can't only consider some special
device.

Maybe we need some flag to tell which D3 state _PS3 is used for.

Lin Ming

>=20
>=20
> Thanks for the review.
>=20
> -Aaron
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
