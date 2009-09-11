From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: RFC: Light sensors, unifying current options?
Date: Fri, 11 Sep 2009 09:55:01 +0800
Message-ID: <1252634101.3483.514.camel@rzhang-dt>
References: <4A9FC9D7.20000@cam.ac.uk> <1252308744.3483.414.camel@rzhang-dt>
	 <4AA4F194.1070507@cam.ac.uk> <1252467684.3483.446.camel@rzhang-dt>
	 <4AA79144.8060104@cam.ac.uk> <1252546449.3483.476.camel@rzhang-dt>
	 <4AA8CF57.4010409@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:13853 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360AbZIKB6H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Sep 2009 21:58:07 -0400
In-Reply-To: <4AA8CF57.4010409@cam.ac.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, "alan@linux.intel.com" <alan@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "Cory T. Tusar" <ctusar@videon-central.com>, "Trisal, Kalhan" <kalhan.trisal@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Thu, 2009-09-10 at 18:05 +0800, Jonathan Cameron wrote:
> Zhang Rui wrote:
> > On Wed, 2009-09-09 at 19:28 +0800, Jonathan Cameron wrote:
> >> Zhang Rui wrote:
> >>> On Mon, 2009-09-07 at 19:42 +0800, Jonathan Cameron wrote:
> >>>> Zhang Rui wrote:
> > 
> >>>> Maybe similar to hwmon approach allowing for multiple readings of a given
> >>>> type?
> >>>>
> >>>> illumiance[n]
> >>>> illuminmance_type[n]
> >>> what's the value in illuminance_type, infrared/visible/ultraviolet?
> >> Probably a mask allowing for a given sensor to cover several of these.
> >> Hence if you have an infrared and an visible + infrared, userspace can
> >> pull the visible out.  Or we could do that separation in kernel, so
> >> in this case export
> >>
> >> visible, visible+infrared and infrared.
> >>
> >> Perhaps we might do it via sysfs naming instead.
> >>
> >> illuminance[n] - defined to be visible (which is what term means anyway)
> >>
> >> infrared[n] - hmm.. will be in different units to illuminance - perhaps we leave
> >> these raw with suitable documentation?
> >>
> >> illuminance_and_infrared[n]
> >>
> > what's the unit of this?
> Indeed, there in lies a problem.  I guess we export any we that don't fit
> within the standard set (e.g. that infrared sensor etc) as raw values with
> suitable documentation.  If people want to use them it is up to them, but they
> shouldn't assume that two different sensors give equivalent readings.

> > what does the value of this file mean?
> It's really just an adc count.
> > I think we should make sure that there are more sensors need this and
> > the same "visible + infrared" reading on different sensors stands for
> > the same ambient light environment.
> From what I've encountered it is a fairly common way of getting illuminance,
> the question is merely whether the relevant processing is done on the sensor
> or in software.  If in software the two values are available, in hardware
> they probably only export illuminance.
> > Or else we should convert it to something generic. what do you think?
> Would be nice to be generic, but given they exact frequency ranges will change
> between different sensors even if they do use this approach, I'm not sure what
> it would be.

so, if there are two sensors that support visible and infrared,
sensor 1:
illuminance:	xxx
infrared:	yyy
sensor 2:
illuminance:	xxx
infrared:	yyy

does this mean the ambient light of these two sensors are the same?

If no, I can't image how the userspace app uses these attributes?

> > 
> >>   If they are capable of
> >> exporting other things all well and good.  The naming can be decided as and
> >> when people post drivers with new functionality.
> >>
> > 
> >> The other obvious question is whether it makes sense to cache values from sensors?
> >> (as per many hwmon drivers)  These things are pretty slow, so there is no point in
> >> taking a new reading unless there has been sufficient time for it to update.
> >> Still this is again a documentation issue rather than core code, as it would be
> >> down to the individual drivers.
> >>
> > 
> > I think this depends and it's the individual drivers responsibility to
> > keep these values valid.
> Agreed.
> > 
> > For example, ACPI ALS can get a notification "whenever the lux reading
> > changes more than 10% (from the last reading that resulted in a
> > notification)". So it can use cache values because they're refreshed
> > from time to time.
> > 
> > But maybe there are some other sensors that don't have this asynchronous
> > notification so that the cached values don't have a chance to get
> > updated.
> > then we need to read the sensor every time the sysfs I/F is poked.
> Some sensors, e.g. tsl2561 use an internal clock to do sampling and hence
> have some predefined period in which the reading taken doesn't change.
> Perhaps exporting said period would be useful to userspace?
> 
I don't think so.
IMO, the tsl2561 driver should handle this, and there is no need to
annoy the user space.
i.e. users always assume the content of "illuminance" attribute is
valid, and it's the driver's job to make this true. We don't need to
document this.
what do you think?

thanks,
rui

