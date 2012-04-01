From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: evaluate _PS3 when entering D3 Cold
Date: Sun, 1 Apr 2012 10:55:39 +0200
Message-ID: <201204011055.39417.rjw@sisk.pl>
References: <1333217910-29579-1-git-send-email-aaron.lu@amd.com> <201204010947.27234.rjw@sisk.pl> <1333267314.2387.122.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:47698 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800Ab2DAIvU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 1 Apr 2012 04:51:20 -0400
In-Reply-To: <1333267314.2387.122.camel@rui.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Aaron Lu <aaron.lu@amd.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Andiry Xu <andiry.xu@amd.com>, Alex He <alex.he@amd.com>, "Moore, Robert" <robert.moore@intel.com>

On Sunday, April 01, 2012, Zhang Rui wrote:
> On =E6=97=A5, 2012-04-01 at 09:47 +0200, Rafael J. Wysocki wrote:
> > On Sunday, April 01, 2012, Aaron Lu wrote:
> > > Hi,
> > >=20
> > > On Sun, Apr 01, 2012 at 03:03:39PM +0800, Zhang Rui wrote:
> > > > First of all, I agree that we must evaluate _PS3 when setting d=
evice to
> > > > either D3_HOT or D3_COLD.
> > > Good.
> > >=20
> > > >=20
> > > > And here is my understanding about D3/D3_HOT/D3_COLD,
> > > >=20
> > > > if _PR3 exists, it means the devices supports both D3_HOT and D=
3_COLD.
> > > Agree.
> > >=20
> > > >=20
> > > > if only _PS3 exists, we can only say that the state after evalu=
ating
> > > > _PS3 is D3, it could either be D3_HOT or D3_COLD, and this is d=
evice
> > > > specific, which in your case, is D3_COLD.
> > > I prefer Rafeal's definition, let's just *assume* the device is a=
t D3
> > > cold after its _PS3 is executed. Unless it has _PR3, in which cas=
e, we
> > > have a chance to put the device into D3 hot instead.
> > >=20
> > > >=20
> > > > BTW, here is the description of _S0W in ACPI spec,
> > > > If OSPM has not indicated that it supports _PR3 through the OSP=
M
> > > > Platform-Wide Capabilities (see Section 6.2.10.2), then the val=
ue "3"
> > > > corresponds to D3. If it has indicated _PR3 support, the value =
"3"
> > > > represents D3hot and the value "4" represents D3cold.
> > > >=20
> > > > So IMO, the _S0W should return 3 in AMD's implementation as it =
does not
> > > > have _PR3.
> > > OK, sounds like a firmware bug.
> > > Thanks for identifying this.
> >=20
> > I don't think this is a bug.  It actually may return either 3 or 4,=
 because
> > there is no difference between them if there's no _PR3 (i.e. the ac=
tion to
> > carry out by software would only be different if _PR3 were present)=
=2E
> >=20
> I mean, surely that software should handle this case.

Well, exactly. :-)

> But this is still a violation of ACPI spec, as the device has only on=
e
> D3 state, instead of D3_HOT/D3_COLD,, thus _S0W should return 3 inste=
ad.

If software is expected to handle that case anyway, I wouldn't really c=
all
it a violation.  What really matters is what software is supposed to do=
=2E

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
