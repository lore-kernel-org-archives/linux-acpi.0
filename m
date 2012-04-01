From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI: evaluate _PS3 when entering D3 Cold
Date: Sun, 01 Apr 2012 15:45:46 +0800
Message-ID: <1333266346.2387.110.camel@rui.sh.intel.com>
References: <1333217910-29579-1-git-send-email-aaron.lu@amd.com>
	 <20120401055603.GA11505@localhost.amd.com>
	 <1333261737.2939.84.camel@minggr> <201204010923.18330.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59517 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770Ab2DAHpP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 1 Apr 2012 03:45:15 -0400
In-Reply-To: <201204010923.18330.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Lin Ming <ming.m.lin@intel.com>, Aaron Lu <aaron.lu@amd.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Andiry Xu <andiry.xu@amd.com>, Alex He <alex.he@amd.com>

On =E6=97=A5, 2012-04-01 at 09:23 +0200, Rafael J. Wysocki wrote:
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
There is a problem that I can think of.
Say currently, ACPI always returns D3 when _PS3 exists.
And this "ACPI_STATE_D3" is translated to PCI_D3hot.
But with this approach, we're going to put these devices to PCI_D3cold
instead, right?
I'm not against this approach, but this may affect a lot of PCI devices=
,
which we need to take care of, no?

thanks,
rui


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
