From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH 4/6] thermal: add sanity check for the passive attribute
Date: Mon, 31 Aug 2009 12:30:30 +0200
Message-ID: <200908311230.32021.elendil@planet.nl>
References: <1251303445-25317-1-git-send-email-elendil@planet.nl> <200908261848.29897.elendil@planet.nl> <1251707630.3483.181.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from Cpsmtpm-eml108.kpnxchange.com ([195.121.3.12]:60056 "EHLO
	CPSMTPM-EML108.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751733AbZHaKab convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 31 Aug 2009 06:30:31 -0400
In-Reply-To: <1251707630.3483.181.camel@rzhang-dt>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Monday 31 August 2009, Zhang Rui wrote:
> On Thu, 2009-08-27 at 00:48 +0800, Frans Pop wrote:
> > On Wednesday 26 August 2009, Matthew Garrett wrote:
> > > On Wed, Aug 26, 2009 at 06:17:23PM +0200, Frans Pop wrote:
> > > > Values below 40000 milli-celsius (limit is somewhat arbitrary)
> > > > don't make sense and can cause the system to go into a thermal
> > > > heart attack: the actual temperature will always be lower and
> > > > thus the system will be throttled down to its lowest setting.
> > >
> > > Not keen on this - it's a pretty arbitrary cutoff, and there are
> > > some cases where someone might want this value. Policy belongs in
> > > userspace, and all that.
> >
> > What cases do you see? Testing? Or systems that might have to opera=
te
> > at such a low temperature? I deliberately chose a value that's at a
> > level that's easy to reach.
> >
> > I agree it is arbitrary, but it will prevent major confusion when
> > someone like me echo's 95 directly in sysfs.
>
> this is a problem.
> how about something like:
> #define THERMAL_PASSIVE_WARNING_LEVEL 0x40000

Hmmm. 40000 hexadecimal? That seems a bit high ;-)

> if (state < THERMAL_PASSIVE_WARNING_LEVEL)
>    printk(KERN_WARNING PREFIX "Passive trip point too low, this may"
>           "slow down your laptop because processors are throttled "
>           "whenever the temperature is higher than %dC\n", state/1000=
);

Disadvantage is that users are unlikely to actually see that message at=
=20
the time they set the value, especially if they're working in some xter=
m.=20
They'd have to check dmesg or log files. It also increases the .text si=
ze=20
of the module for an option that very few people are likely to use.

> > Would 1000 (1 =C2=B0C) perhaps be more acceptable as a limit? I dou=
bt
> > there are valid use-cases for below 0 temps :-)

I'd prefer this option. Do you see any downside to this?

Cheers,
=46JP
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
