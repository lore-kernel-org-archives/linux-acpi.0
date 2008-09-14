From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI suspend: Always use the 32-bit waking vector
Date: Mon, 15 Sep 2008 01:56:08 +0200
Message-ID: <200809150156.09914.rjw@sisk.pl>
References: <1220507476.4007.117.camel@yakui_zhao.sh.intel.com> <200809061313.02088.rjw@sisk.pl> <20080914114615.GA4641@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:50871 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777AbYINXva (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 14 Sep 2008 19:51:30 -0400
In-Reply-To: <20080914114615.GA4641@ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: "Li, Shaohua" <shaohua.li@intel.com>, "Zhao, Yakui" <yakui.zhao@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "Zhang, Rui" <rui.zhang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "andi@firstfloor.org" <andi@firstfloor.org>

On Sunday, 14 of September 2008, Pavel Machek wrote:
> Hi!
> 
> > > There was discussion about this issue several months ago (intel's ml), looks
> > > people forgot to take action after the discussion. The spec owner said 64bit
> > > vector is used in protected mode. That is if OS sets it, wakeup code is
> > > called in protected mode by BIOS. So the 64-bit vector shouldn't be used.   
> > 
> > Well, I read this part of the spec (2.0c, 3.0b) more carefully and it matches
> > what you're saying.  Moreover, my understanding of it is that we should
> > actually _clear_ the 64-bit vector on systems that support it, because
> > otherwise the BIOS is supposed to use it and call the wake-up code in protected
> > mode.
> > 
> > The appended patch is based on this observation.
> 
> Hmm, nice.
> 
> 64-bit waking is the one that is 'recommended' to use, right? Could we
> get some strange machines (kohjisha?) to jump to the waking vector by
> using 64-bit one?

If the 32-bit one is set and the 64-bit one is zero, the BIOS is _required_ to
use the 32-bit one.

There may be BIOSes that don't follow the spec in that respect (ie. are only
able to use the 64-bit vector and can only enter the wake-up code in Protected
Mode), but I'm not aware of any.

> Do windows use 32-bit or 64-bit vector?

I think XP uses the 32-bit one.  I don't know about Vista, though.

Thanks,
Rafael
