From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: evaluate _PS3 when entering D3 Cold
Date: Sun, 1 Apr 2012 09:47:26 +0200
Message-ID: <201204010947.27234.rjw@sisk.pl>
References: <1333217910-29579-1-git-send-email-aaron.lu@amd.com> <1333263819.2387.94.camel@rui.sh.intel.com> <20120401153434.GA3268@localhost.amd.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:47635 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765Ab2DAHnG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 1 Apr 2012 03:43:06 -0400
In-Reply-To: <20120401153434.GA3268@localhost.amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Andiry Xu <andiry.xu@amd.com>, Alex He <alex.he@amd.com>

On Sunday, April 01, 2012, Aaron Lu wrote:
> Hi,
>=20
> On Sun, Apr 01, 2012 at 03:03:39PM +0800, Zhang Rui wrote:
> > First of all, I agree that we must evaluate _PS3 when setting devic=
e to
> > either D3_HOT or D3_COLD.
> Good.
>=20
> >=20
> > And here is my understanding about D3/D3_HOT/D3_COLD,
> >=20
> > if _PR3 exists, it means the devices supports both D3_HOT and D3_CO=
LD.
> Agree.
>=20
> >=20
> > if only _PS3 exists, we can only say that the state after evaluatin=
g
> > _PS3 is D3, it could either be D3_HOT or D3_COLD, and this is devic=
e
> > specific, which in your case, is D3_COLD.
> I prefer Rafeal's definition, let's just *assume* the device is at D3
> cold after its _PS3 is executed. Unless it has _PR3, in which case, w=
e
> have a chance to put the device into D3 hot instead.
>=20
> >=20
> > BTW, here is the description of _S0W in ACPI spec,
> > If OSPM has not indicated that it supports _PR3 through the OSPM
> > Platform-Wide Capabilities (see Section 6.2.10.2), then the value "=
3"
> > corresponds to D3. If it has indicated _PR3 support, the value "3"
> > represents D3hot and the value "4" represents D3cold.
> >=20
> > So IMO, the _S0W should return 3 in AMD's implementation as it does=
 not
> > have _PR3.
> OK, sounds like a firmware bug.
> Thanks for identifying this.

I don't think this is a bug.  It actually may return either 3 or 4, bec=
ause
there is no difference between them if there's no _PR3 (i.e. the action=
 to
carry out by software would only be different if _PR3 were present).

> > > And the ACPI does have some words like:
> > >=20
> > > ------
> > > Platform/drivers must assume that the device will have power comp=
letely
> > > removed when the device is place into =E2=80=9CD3=E2=80=9D via _P=
S3
> > > ------
> > >=20
> > I think this means OS can not access device any more after evaluati=
ng
> > _PS3, and it should re-enumerate the device when transiting back to=
 D0.
> >=20
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
> > >=20
> > I was trying to make a cleanup of the D3/D3_HOT/D3_COLD support in
> > Linux, and this gives me some clue.
> This is great, and I would like to help as much as I can.
>=20
> >=20
> > How about this?
> >=20
> > We should use the term "D3" in general in Linux.
> > Without _PR3, OS should *assume* that the power is removed, althoug=
h it
> > may be not true.
> > With _PR3, OS can *assure* that the power is removed, because it kn=
ows
> > how to remove thw power (evaluating _PR3._OFF).
> >=20
> > So the difference is that OS need to make sure whether to evaluate
> > _PR3._OFF when _PR3 exists. For example, a device has _PR3, but _S0=
W
> > returns 3, OS should not evaluate _PR3._OFF when the device sleeps =
with
> > remote wakeup support.
> >=20
> > what do you think?
> I agree with Rafeal's ideas.

Good. :-)

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
