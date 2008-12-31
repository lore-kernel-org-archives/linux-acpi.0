From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/2] video: mark "actual_brightness" deprecated
Date: Wed, 31 Dec 2008 10:12:16 +0800
Message-ID: <1230689536.562.272.camel@rzhang-dt>
References: <1230088061.562.220.camel@rzhang-dt>
	 <1230633437.5328.13.camel@dax.rpnet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:44381 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753515AbYLaCOs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Dec 2008 21:14:48 -0500
In-Reply-To: <1230633437.5328.13.camel@dax.rpnet.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Tue, 2008-12-30 at 18:37 +0800, Richard Purdie wrote:
> On Wed, 2008-12-24 at 11:07 +0800, Zhang Rui wrote:
> > /sys/class/backlight/.../brightness returns a cached value,
> > which confuses a lot of users.
> > 
> > Make the "brightness" reflect the actual backlight levels,
> > and mark /sys/class/backlight/.../brightness as depreacated
> > in this patch.
> 
> This isn't an acceptable approach I'm afraid. We have some hardware
> which needs limiting of the backlight brightness in cases of low battery
we use "brightness" as the backlight limiting? then how does it work?
users can always set it to a higher or lower value no matter whether
it's low battery or not. IMO we'd better to use another file instead.
I got a couple of bugs about "the brightness file doesn't work", because
if people can change the backlight by poking "brightness", they prefer
to get the current brightness by reading it. what do you think?

> for example. "brightness" is the user requested value,
> "actual_brightness" is the one that is actually active.
why do we need the "user requested value"?
does some application depend on it?

thanks,
rui

