From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: [PATCH] ACPI: evaluate _PS3 when entering D3 Cold
Date: Sun, 1 Apr 2012 13:56:03 +0800
Message-ID: <20120401055603.GA11505@localhost.amd.com>
References: <1333217910-29579-1-git-send-email-aaron.lu@amd.com>
 <1333258053.2939.22.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:29678
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751475Ab2DAF4m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 1 Apr 2012 01:56:42 -0400
Content-Disposition: inline
In-Reply-To: <1333258053.2939.22.camel@minggr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Rafeal J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Andiry Xu <andiry.xu@amd.com>, Alex He <alex.he@amd.com>

Hi,

On Sun, Apr 01, 2012 at 01:27:33PM +0800, Lin Ming wrote:
> > -		if (device->power.states[state].flags.explicit_set) {
> > +		/* If state is D3 Cold, try to evaluate _PS3 first */
> > +		if (state =3D=3D ACPI_STATE_D3_COLD) {
> > +			explicit_set =3D (ps - 1)->flags.explicit_set;
> > +			object_name[3] -=3D 1;
> > +		}
>=20
> I'm not sure whether this works or not.
>=20
> From ACPI spec,
>=20
> _PS3 "is used to put the specific device into its D3hot or D3 state"
>=20
> D3 neither means D3hot nor D3cold. It's an old term before D3hot and
> D3cold were introduced.
I guess D3 has to mean something, right? :-)

Here is the problem, there is no _PR3 in AMD's implementation, just _PS=
3.
And since _S0W evaluates 4, I've to put this device into D3 cold state
with _PS3.

And the ACPI does have some words like:

------
Platform/drivers must assume that the device will have power completely
removed when the device is place into =E2=80=9CD3=E2=80=9D via _PS3
------

This is in section 7.2.11: _PR3.

>=20
> Another problem:
>=20
> With your patch, both D3hot and D3cold will evaluate _PS3, right?
>=20
Yes.

> Will it have problem on AMD platform if you try to put ODD into D3hot
> state? _PS3 is evaluated, so it actually enters D3Cold state.

There is no D3 hot support for this device(from the firmware's
perspective), either it is at D0(via _PS0), or it will be at D3 cold(vi=
a
_PS3).


Thanks for the review.

-Aaron

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
