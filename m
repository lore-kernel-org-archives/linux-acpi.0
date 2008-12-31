From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH 2/2] video: mark "actual_brightness" deprecated
Date: Wed, 31 Dec 2008 13:32:19 +0000
Message-ID: <1230730339.5325.5.camel@dax.rpnet.com>
References: <1230088061.562.220.camel@rzhang-dt>
	 <1230633437.5328.13.camel@dax.rpnet.com>
	 <1230689536.562.272.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]:54669 "EHLO
	tim.rpsys.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752829AbYLaNcZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 31 Dec 2008 08:32:25 -0500
In-Reply-To: <1230689536.562.272.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Wed, 2008-12-31 at 10:12 +0800, Zhang Rui wrote:
> On Tue, 2008-12-30 at 18:37 +0800, Richard Purdie wrote:
> > On Wed, 2008-12-24 at 11:07 +0800, Zhang Rui wrote:
> > > /sys/class/backlight/.../brightness returns a cached value,
> > > which confuses a lot of users.
> > > 
> > > Make the "brightness" reflect the actual backlight levels,
> > > and mark /sys/class/backlight/.../brightness as depreacated
> > > in this patch.
> > 
> > This isn't an acceptable approach I'm afraid. We have some hardware
> > which needs limiting of the backlight brightness in cases of low battery
> we use "brightness" as the backlight limiting? then how does it work?

Limiting is done by the driver itself so userspace would request "5",
the hardware would only allow "2" due to power contraints so
"birghtness" reads "5" but actual_brightness reads "2".

> users can always set it to a higher or lower value no matter whether
> it's low battery or not. IMO we'd better to use another file instead.
> I got a couple of bugs about "the brightness file doesn't work", because
> if people can change the backlight by poking "brightness", they prefer
> to get the current brightness by reading it. what do you think?

No, this can't work. If you put a value into a sysfs file you should get
the same value back. This is why "actual_brightness" exists and is
readonly, reflecting the end result. Were possible/necessary that is
read from the hardware. People expecting anything else from the
interface aren't using it as designed.

> > for example. "brightness" is the user requested value,
> > "actual_brightness" is the one that is actually active.
> why do we need the "user requested value"?
> does some application depend on it?

Two reasons, one is that some applications might want to see both what
was set and also what the result was. Secondly, I'm uneasy with a sysfs
file that write one value and reads something different. The current
setup doesn't cause any problems as long as people understand what to
expect and why? By merging the two things it gets more confusing and
also removes information which is potentially useful to userspace.

Cheers,

Richard

