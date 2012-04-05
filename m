From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH] ACPI: evaluate _PS3 when entering D3 Cold
Date: Thu, 05 Apr 2012 10:31:20 +0800
Message-ID: <1333593080.11327.22.camel@minggr>
References: <1333217910-29579-1-git-send-email-aaron.lu@amd.com>
	 <20120401055603.GA11505@localhost.amd.com>
	 <1333261737.2939.84.camel@minggr>  <201204010923.18330.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:57217 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756637Ab2DECbY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 4 Apr 2012 22:31:24 -0400
In-Reply-To: <201204010923.18330.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Aaron Lu <aaron.lu@amd.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Andiry Xu <andiry.xu@amd.com>, Alex He <alex.he@amd.com>

On Sun, 2012-04-01 at 09:23 +0200, Rafael J. Wysocki wrote:
> Hi,
>=20
> Sorry for the delayed response, I've been travelling recently.
>=20
> On Sunday, April 01, 2012, Lin Ming wrote:
> > On Sun, 2012-04-01 at 13:56 +0800, Aaron Lu wrote:
> > > Hi,
> > >=20
> > > On Sun, Apr 01, 2012 at 01:27:33PM +0800, Lin Ming wrote:
> > > > > -		if (device->power.states[state].flags.explicit_set) {
> > > > > +		/* If state is D3 Cold, try to evaluate _PS3 first */
> > > > > +		if (state =3D=3D ACPI_STATE_D3_COLD) {
> > > > > +			explicit_set =3D (ps - 1)->flags.explicit_set;
> > > > > +			object_name[3] -=3D 1;
> > > > > +		}
> > > >=20
> > > > I'm not sure whether this works or not.
> > > >=20
> > > > From ACPI spec,
> > > >=20
> > > > _PS3 "is used to put the specific device into its D3hot or D3 s=
tate"
> > > >=20
> > > > D3 neither means D3hot nor D3cold. It's an old term before D3ho=
t and
> > > > D3cold were introduced.
> > > I guess D3 has to mean something, right? :-)
>=20
> Well, not necessarily.
>=20
> The problem is what state the _PS3 method puts the device into: D3_ho=
t or
> D3_cold.
>=20
> Unfortunately, as far as I can say, ACPI 4.0 didn't specify any "offi=
cial"
> mapping between the "old" D3 and the "new" D3_{hod|cold} states, so w=
e need to
> figure out something.  In my opinion, the only reasonable approach is=
 to
> assume that the state _PS3 puts the device into is always D3_cold, be=
cuase
> _PS3 may remove power completely from the device.  It may not do that=
, but
> we _must_ assume it does that in general.
>=20
> > > Here is the problem, there is no _PR3 in AMD's implementation, ju=
st _PS3.
> > > And since _S0W evaluates 4, I've to put this device into D3 cold =
state
> > > with _PS3.
> > >=20
> > > And the ACPI does have some words like:
> > >=20
> > > ------
> > > Platform/drivers must assume that the device will have power comp=
letely
> > > removed when the device is place into =E2=80=9CD3=E2=80=9D via _P=
S3
>=20
> Exactly.  What it means is basically "always reinitialize the device =
from
> scratch if you have run _PS3 on it".  And that's what we should do.
>=20
> > > ------
> > >=20
> > > This is in section 7.2.11: _PR3.
> > >=20
> > > >=20
> > > > Another problem:
> > > >=20
> > > > With your patch, both D3hot and D3cold will evaluate _PS3, righ=
t?
> > > >=20
> > > Yes.
> > >=20
> > > > Will it have problem on AMD platform if you try to put ODD into=
 D3hot
> > > > state? _PS3 is evaluated, so it actually enters D3Cold state.
> > >=20
> > > There is no D3 hot support for this device(from the firmware's
> > > perspective), either it is at D0(via _PS0), or it will be at D3 c=
old(via
> > > _PS3).
> >=20
> > But this is the generic code. We can't only consider some special
> > device.
> >=20
> > Maybe we need some flag to tell which D3 state _PS3 is used for.
>=20
> No, please.  As I said above, we need to reinitialize devices that _P=
S3 was
> executed on, which is equivalent to saying that those devices were pu=
t into
> D3_cold.
>=20
> The only situation where a device can be put into ACPI D3_hot (which =
is not
> the same as PCI D3_hot, mind you) is when:
>=20
> (1) There is _PR3 listing some of the device's power resources as "on=
".
> (2) The power resources listed by the _PR3 as "off" are turned off an=
d the
>     power resources listed by the _PR3 as "on" are left in the "on" s=
tate.

I don't understand item (2):

If the power resource is listed as "off", which means it's already
turned off. Then why should it be turned off again?

Let's see an example

Assume a device "dev0" depends on 5 power resources:

pr1, pr2, pr3, pr4, pr5

_PR3 lists 3 power resources: pr3, pr4, pr5

Device(dev0)
{
	Name(_PR3, Package (0x03)
	{
		pr3,
		pr4,
		pr5
	})
}

If dev0 is put into ACPI D3_hot and pr1 and pr2 are not referenced by
other devices, then it requires:

- pr1 and pr2 are off
- pr3, pr4 and pr5 are on

right?

Thanks,
Lin Ming

>=20
> Our generic code should reflect that.
>=20
> Thanks,
> Rafael


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
