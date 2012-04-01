From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI: evaluate _PS3 when entering D3 Cold
Date: Sun, 01 Apr 2012 16:01:54 +0800
Message-ID: <1333267314.2387.122.camel@rui.sh.intel.com>
References: <1333217910-29579-1-git-send-email-aaron.lu@amd.com>
	 <1333263819.2387.94.camel@rui.sh.intel.com>
	 <20120401153434.GA3268@localhost.amd.com> <201204010947.27234.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201204010947.27234.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Aaron Lu <aaron.lu@amd.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Andiry Xu <andiry.xu@amd.com>, Alex He <alex.he@amd.com>, "Moore, Robert" <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

On =E6=97=A5, 2012-04-01 at 09:47 +0200, Rafael J. Wysocki wrote:
> On Sunday, April 01, 2012, Aaron Lu wrote:
> > Hi,
> >=20
> > On Sun, Apr 01, 2012 at 03:03:39PM +0800, Zhang Rui wrote:
> > > First of all, I agree that we must evaluate _PS3 when setting dev=
ice to
> > > either D3_HOT or D3_COLD.
> > Good.
> >=20
> > >=20
> > > And here is my understanding about D3/D3_HOT/D3_COLD,
> > >=20
> > > if _PR3 exists, it means the devices supports both D3_HOT and D3_=
COLD.
> > Agree.
> >=20
> > >=20
> > > if only _PS3 exists, we can only say that the state after evaluat=
ing
> > > _PS3 is D3, it could either be D3_HOT or D3_COLD, and this is dev=
ice
> > > specific, which in your case, is D3_COLD.
> > I prefer Rafeal's definition, let's just *assume* the device is at =
D3
> > cold after its _PS3 is executed. Unless it has _PR3, in which case,=
 we
> > have a chance to put the device into D3 hot instead.
> >=20
> > >=20
> > > BTW, here is the description of _S0W in ACPI spec,
> > > If OSPM has not indicated that it supports _PR3 through the OSPM
> > > Platform-Wide Capabilities (see Section 6.2.10.2), then the value=
 "3"
> > > corresponds to D3. If it has indicated _PR3 support, the value "3=
"
> > > represents D3hot and the value "4" represents D3cold.
> > >=20
> > > So IMO, the _S0W should return 3 in AMD's implementation as it do=
es not
> > > have _PR3.
> > OK, sounds like a firmware bug.
> > Thanks for identifying this.
>=20
> I don't think this is a bug.  It actually may return either 3 or 4, b=
ecause
> there is no difference between them if there's no _PR3 (i.e. the acti=
on to
> carry out by software would only be different if _PR3 were present).
>=20
I mean, surely that software should handle this case.
But this is still a violation of ACPI spec, as the device has only one
D3 state, instead of D3_HOT/D3_COLD,, thus _S0W should return 3 instead=
=2E

thanks,
rui
> > > > And the ACPI does have some words like:
> > > >=20
> > > > ------
> > > > Platform/drivers must assume that the device will have power co=
mpletely
> > > > removed when the device is place into =E2=80=9CD3=E2=80=9D via =
_PS3
> > > > ------
> > > >=20
> > > I think this means OS can not access device any more after evalua=
ting
> > > _PS3, and it should re-enumerate the device when transiting back =
to D0.
> > >=20
> > > > This is in section 7.2.11: _PR3.
> > > >=20
> > > > >=20
> > > > > Another problem:
> > > > >=20
> > > > > With your patch, both D3hot and D3cold will evaluate _PS3, ri=
ght?
> > > > >=20
> > > > Yes.
> > > >=20
> > > > > Will it have problem on AMD platform if you try to put ODD in=
to D3hot
> > > > > state? _PS3 is evaluated, so it actually enters D3Cold state.
> > > >=20
> > > > There is no D3 hot support for this device(from the firmware's
> > > > perspective), either it is at D0(via _PS0), or it will be at D3=
 cold(via
> > > > _PS3).
> > > >=20
> > > I was trying to make a cleanup of the D3/D3_HOT/D3_COLD support i=
n
> > > Linux, and this gives me some clue.
> > This is great, and I would like to help as much as I can.
> >=20
> > >=20
> > > How about this?
> > >=20
> > > We should use the term "D3" in general in Linux.
> > > Without _PR3, OS should *assume* that the power is removed, altho=
ugh it
> > > may be not true.
> > > With _PR3, OS can *assure* that the power is removed, because it =
knows
> > > how to remove thw power (evaluating _PR3._OFF).
> > >=20
> > > So the difference is that OS need to make sure whether to evaluat=
e
> > > _PR3._OFF when _PR3 exists. For example, a device has _PR3, but _=
S0W
> > > returns 3, OS should not evaluate _PR3._OFF when the device sleep=
s with
> > > remote wakeup support.
> > >=20
> > > what do you think?
> > I agree with Rafeal's ideas.
>=20
> Good. :-)
>=20
> Thanks,
> Rafael
