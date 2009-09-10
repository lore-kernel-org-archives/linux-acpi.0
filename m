From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: RFC: Light sensors, unifying current options?
Date: Thu, 10 Sep 2009 11:10:04 +0100
Message-ID: <4AA8D07C.1000600@cam.ac.uk>
References: <4A9FC9D7.20000@cam.ac.uk> <1252308744.3483.414.camel@rzhang-dt> <4AA4F194.1070507@cam.ac.uk> <1252467684.3483.446.camel@rzhang-dt> <4AA79144.8060104@cam.ac.uk> <1252546449.3483.476.camel@rzhang-dt> <20090910082312.GG7248@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:48192 "EHLO
	ppsw-6.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755358AbZIJKKE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Sep 2009 06:10:04 -0400
In-Reply-To: <20090910082312.GG7248@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, "alan@linux.intel.com" <alan@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "Cory T. Tusar" <ctusar@videon-central.com>, "Trisal, Kalhan" <kalhan.trisal@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

Pavel Machek wrote:
> Hi!
> 
>>> Perhaps we might do it via sysfs naming instead.
>>>
>>> illuminance[n] - defined to be visible (which is what term means anyway)
>>>
>>> infrared[n] - hmm.. will be in different units to illuminance - perhaps we leave
>>> these raw with suitable documentation?
>>>
>>> illuminance_and_infrared[n]
>>>
>> what's the unit of this?
>> what does the value of this file mean?
>> I think we should make sure that there are more sensors need this and
>> the same "visible + infrared" reading on different sensors stands for
>> the same ambient light environment.
> 
> Are you sure that makes sense? And is that even possible? I'd be
> afraid that the sensors are not nearly accurate enough to give precise
> values, and each sensor is going to take different parts of spectrum,
> etc.
> 
> Yes, we should aim at having similar interface with similar values on
> all the sensors, but lets not overdo it.
Agreed, if we match on the illuminance, pretty much everything else can
initially be chip dependent as long as they are sufficiently documented.
If certain things keep repeating then they can be standardized as and when
this occurs.
 
>> But maybe there are some other sensors that don't have this asynchronous
>> notification so that the cached values don't have a chance to get
>> updated.
>> then we need to read the sensor every time the sysfs I/F is poked.
> 
> I bet most sensors are like that. And no, we don't have to reread from
> hw every time, we can just read and cache it once per second or
> something.
The ones I've seen in embedded devices tend to have some sort of interrupt
system, but it's reasonably complicated to configure as you have to read the
sensor then write threshold values back to get the same sort of notifications
as acpi is doing.  Also, it's far from unusual for people not to bother connecting
the interrupt pin up in the first place so we can't have those drivers relying on its
presence.

I think we are getting to the point where the easiest way to work out further
issues is going to be in code as drivers get converted to the new subsystem.
I'm happy to do the two tsl drivers once the core as discussed in this thread
is in place.

Jonathan
