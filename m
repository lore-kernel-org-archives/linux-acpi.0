From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: [PATCH] ACPI: evaluate _PS3 when entering D3 Cold
Date: Sun, 1 Apr 2012 23:34:35 +0800
Message-ID: <20120401153434.GA3268@localhost.amd.com>
References: <1333217910-29579-1-git-send-email-aaron.lu@amd.com>
 <1333258053.2939.22.camel@minggr>
 <20120401055603.GA11505@localhost.amd.com>
 <1333263819.2387.94.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1333263819.2387.94.camel@rui.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <lenb@kernel.org>, "Rafeal J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Andiry Xu <andiry.xu@amd.com>, Alex He <alex.he@amd.com>
List-Id: linux-acpi@vger.kernel.org

Hi,

On Sun, Apr 01, 2012 at 03:03:39PM +0800, Zhang Rui wrote:
> First of all, I agree that we must evaluate _PS3 when setting device =
to
> either D3_HOT or D3_COLD.
Good.

>=20
> And here is my understanding about D3/D3_HOT/D3_COLD,
>=20
> if _PR3 exists, it means the devices supports both D3_HOT and D3_COLD=
=2E
Agree.

>=20
> if only _PS3 exists, we can only say that the state after evaluating
> _PS3 is D3, it could either be D3_HOT or D3_COLD, and this is device
> specific, which in your case, is D3_COLD.
I prefer Rafeal's definition, let's just *assume* the device is at D3
cold after its _PS3 is executed. Unless it has _PR3, in which case, we
have a chance to put the device into D3 hot instead.

>=20
> BTW, here is the description of _S0W in ACPI spec,
> If OSPM has not indicated that it supports _PR3 through the OSPM
> Platform-Wide Capabilities (see Section 6.2.10.2), then the value "3"
> corresponds to D3. If it has indicated _PR3 support, the value "3"
> represents D3hot and the value "4" represents D3cold.
>=20
> So IMO, the _S0W should return 3 in AMD's implementation as it does n=
ot
> have _PR3.
OK, sounds like a firmware bug.
Thanks for identifying this.

>=20
> > And the ACPI does have some words like:
> >=20
> > ------
> > Platform/drivers must assume that the device will have power comple=
tely
> > removed when the device is place into =E2=80=9CD3=E2=80=9D via _PS3
> > ------
> >=20
> I think this means OS can not access device any more after evaluating
> _PS3, and it should re-enumerate the device when transiting back to D=
0.
>=20
> > This is in section 7.2.11: _PR3.
> >=20
> > >=20
> > > Another problem:
> > >=20
> > > With your patch, both D3hot and D3cold will evaluate _PS3, right?
> > >=20
> > Yes.
> >=20
> > > Will it have problem on AMD platform if you try to put ODD into D=
3hot
> > > state? _PS3 is evaluated, so it actually enters D3Cold state.
> >=20
> > There is no D3 hot support for this device(from the firmware's
> > perspective), either it is at D0(via _PS0), or it will be at D3 col=
d(via
> > _PS3).
> >=20
> I was trying to make a cleanup of the D3/D3_HOT/D3_COLD support in
> Linux, and this gives me some clue.
This is great, and I would like to help as much as I can.

>=20
> How about this?
>=20
> We should use the term "D3" in general in Linux.
> Without _PR3, OS should *assume* that the power is removed, although =
it
> may be not true.
> With _PR3, OS can *assure* that the power is removed, because it know=
s
> how to remove thw power (evaluating _PR3._OFF).
>=20
> So the difference is that OS need to make sure whether to evaluate
> _PR3._OFF when _PR3 exists. For example, a device has _PR3, but _S0W
> returns 3, OS should not evaluate _PR3._OFF when the device sleeps wi=
th
> remote wakeup support.
>=20
> what do you think?
I agree with Rafeal's ideas.

-Aaron
