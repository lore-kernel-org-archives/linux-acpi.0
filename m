From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 4/6] thermal: add sanity check for the passive attribute
Date: Thu, 03 Sep 2009 14:10:05 +0800
Message-ID: <1251958205.3483.290.camel@rzhang-dt>
References: <1251303445-25317-1-git-send-email-elendil@planet.nl>
	 <200908261848.29897.elendil@planet.nl>
	 <1251707630.3483.181.camel@rzhang-dt>
	 <200908311230.32021.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17662 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754503AbZICGM2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Sep 2009 02:12:28 -0400
In-Reply-To: <200908311230.32021.elendil@planet.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, 2009-08-31 at 18:30 +0800, Frans Pop wrote:
> On Monday 31 August 2009, Zhang Rui wrote:
> > On Thu, 2009-08-27 at 00:48 +0800, Frans Pop wrote:
> > > On Wednesday 26 August 2009, Matthew Garrett wrote:
> > > > On Wed, Aug 26, 2009 at 06:17:23PM +0200, Frans Pop wrote:
> > > > > Values below 40000 milli-celsius (limit is somewhat arbitrary=
)
> > > > > don't make sense and can cause the system to go into a therma=
l
> > > > > heart attack: the actual temperature will always be lower and
> > > > > thus the system will be throttled down to its lowest setting.
> > > >
> > > > Not keen on this - it's a pretty arbitrary cutoff, and there ar=
e
> > > > some cases where someone might want this value. Policy belongs =
in
> > > > userspace, and all that.
> > >
> > > What cases do you see? Testing? Or systems that might have to ope=
rate
> > > at such a low temperature? I deliberately chose a value that's at=
 a
> > > level that's easy to reach.
> > >
> > > I agree it is arbitrary, but it will prevent major confusion when
> > > someone like me echo's 95 directly in sysfs.
> >
> > this is a problem.
> > how about something like:
> > #define THERMAL_PASSIVE_WARNING_LEVEL 0x40000
>=20
> Hmmm. 40000 hexadecimal? That seems a bit high ;-)
>=20
> > if (state < THERMAL_PASSIVE_WARNING_LEVEL)
> >    printk(KERN_WARNING PREFIX "Passive trip point too low, this may=
"
> >           "slow down your laptop because processors are throttled "
> >           "whenever the temperature is higher than %dC\n", state/10=
00);
>=20
> Disadvantage is that users are unlikely to actually see that message =
at=20
> the time they set the value, especially if they're working in some xt=
erm.=20
> They'd have to check dmesg or log files. It also increases the .text =
size=20
> of the module for an option that very few people are likely to use.
>=20
> > > Would 1000 (1 =C2=B0C) perhaps be more acceptable as a limit? I d=
oubt
> > > there are valid use-cases for below 0 temps :-)
>=20
> I'd prefer this option. Do you see any downside to this?
>=20
I see many laptops with a passive trip point higher than 90C, so a
passive trip point higher than 100C may be meaningful.
I think we should use a higher value, say 2000?

thanks,
rui


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
