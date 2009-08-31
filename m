From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 4/6] thermal: add sanity check for the passive attribute
Date: Mon, 31 Aug 2009 16:33:50 +0800
Message-ID: <1251707630.3483.181.camel@rzhang-dt>
References: <1251303445-25317-1-git-send-email-elendil@planet.nl>
	 <1251303445-25317-5-git-send-email-elendil@planet.nl>
	 <20090826162342.GA15868@srcf.ucam.org>
	 <200908261848.29897.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:61963 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751515AbZHaIfv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 31 Aug 2009 04:35:51 -0400
In-Reply-To: <200908261848.29897.elendil@planet.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, 2009-08-27 at 00:48 +0800, Frans Pop wrote:
> On Wednesday 26 August 2009, Matthew Garrett wrote:
> > On Wed, Aug 26, 2009 at 06:17:23PM +0200, Frans Pop wrote:
> > > Values below 40000 milli-celsius (limit is somewhat arbitrary)
> > > don't make sense and can cause the system to go into a thermal
> > > heart attack: the actual temperature will always be lower and
> > > thus the system will be throttled down to its lowest setting.
> >
> > Not keen on this - it's a pretty arbitrary cutoff, and there are so=
me
> > cases where someone might want this value. Policy belongs in usersp=
ace,
> > and all that.
>=20
> What cases do you see? Testing? Or systems that might have to operate=
 at=20
> such a low temperature? I deliberately chose a value that's at a leve=
l=20
> that's easy to reach.
>=20
> I agree it is arbitrary, but it will prevent major confusion when som=
eone=20
> like me echo's 95 directly in sysfs.

this is a problem.
how about something like:
#define THERMAL_PASSIVE_WARNING_LEVEL 0x40000

if (state < THERMAL_PASSIVE_WARNING_LEVEL)
   printk(KERN_WARNING PREFIX "Passive trip point too low, this may"
          "slow down your laptop because processors are throttled "
          "whenever the temperature is higher than %dC\n", state/1000);

thanks,
rui

> Would 1000 (1 =C2=B0C) perhaps be more acceptable as a limit? I doubt=
 there are=20
> valid use-cases for below 0 temps :-)

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
