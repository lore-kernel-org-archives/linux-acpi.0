From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: RFC: Light sensors, unifying current options?
Date: Thu, 10 Sep 2009 09:34:09 +0800
Message-ID: <1252546449.3483.476.camel@rzhang-dt>
References: <4A9FC9D7.20000@cam.ac.uk> <1252308744.3483.414.camel@rzhang-dt>
	 <4AA4F194.1070507@cam.ac.uk> <1252467684.3483.446.camel@rzhang-dt>
	 <4AA79144.8060104@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:52363 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753882AbZIJBhW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Sep 2009 21:37:22 -0400
In-Reply-To: <4AA79144.8060104@cam.ac.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, "alan@linux.intel.com" <alan@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "Cory T. Tusar" <ctusar@videon-central.com>, "Trisal, Kalhan" <kalhan.trisal@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Wed, 2009-09-09 at 19:28 +0800, Jonathan Cameron wrote:
> Zhang Rui wrote:
> > On Mon, 2009-09-07 at 19:42 +0800, Jonathan Cameron wrote:
> >> Zhang Rui wrote:

> >
> >> Maybe similar to hwmon approach allowing for multiple readings of a given
> >> type?
> >>
> >> illumiance[n]
> >> illuminmance_type[n]
> >
> > what's the value in illuminance_type, infrared/visible/ultraviolet?
> Probably a mask allowing for a given sensor to cover several of these.
> Hence if you have an infrared and an visible + infrared, userspace can
> pull the visible out.  Or we could do that separation in kernel, so
> in this case export
> 
> visible, visible+infrared and infrared.
> 
> Perhaps we might do it via sysfs naming instead.
> 
> illuminance[n] - defined to be visible (which is what term means anyway)
> 
> infrared[n] - hmm.. will be in different units to illuminance - perhaps we leave
> these raw with suitable documentation?
> 
> illuminance_and_infrared[n]
> 
what's the unit of this?
what does the value of this file mean?
I think we should make sure that there are more sensors need this and
the same "visible + infrared" reading on different sensors stands for
the same ambient light environment.
Or else we should convert it to something generic. what do you think?

>   If they are capable of
> exporting other things all well and good.  The naming can be decided as and
> when people post drivers with new functionality.
> 

> The other obvious question is whether it makes sense to cache values from sensors?
> (as per many hwmon drivers)  These things are pretty slow, so there is no point in
> taking a new reading unless there has been sufficient time for it to update.
> Still this is again a documentation issue rather than core code, as it would be
> down to the individual drivers.
> 

I think this depends and it's the individual drivers responsibility to
keep these values valid.

For example, ACPI ALS can get a notification "whenever the lux reading
changes more than 10% (from the last reading that resulted in a
notification)". So it can use cache values because they're refreshed
from time to time.

But maybe there are some other sensors that don't have this asynchronous
notification so that the cached values don't have a chance to get
updated.
then we need to read the sensor every time the sysfs I/F is poked.

thanks,
rui


