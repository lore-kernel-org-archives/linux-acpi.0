From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.25-rc2 System no longer powers off after suspend-to-disk. Screen becomes green.
Date: Fri, 22 Feb 2008 18:02:17 +0100
Message-ID: <200802221802.18640.rjw@sisk.pl>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com> <alpine.LFD.1.00.0802210819560.1777@xo-0C-FC-0F.localdomain> <47BEFEC4.7090904@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43303 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756477AbYBVRDp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Feb 2008 12:03:45 -0500
In-Reply-To: <47BEFEC4.7090904@rtr.ca>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: david@lang.hm, Linus Torvalds <torvalds@linux-foundation.org>, Jesse Barnes <jesse.barnes@intel.com>, Jeff Chua <jeff.chua.linux@gmail.com>, lkml <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>, linux-acpi@vger.kernel.org, Greg KH <gregkh@suse.de>

On Friday, 22 of February 2008, Mark Lord wrote:
> david@lang.hm wrote:
> ..
> > I've been watching for kexec hibernate for a little while now, and the 
> > last I saw was that acpi was incompatible with the kexec hibernate (but 
> > the suspend folks were still claiming that devices needed to be put in 
> > the 'right mode' not just powered off. I've been waiting to see this 
> > resolved.
> ..
> 
> Yeah, exactly.  What's so special about poweroff on hibernation?
> Why even bother with the special "S4" state there?

(1) To be able to wake up with the help of devices that can't wake
    the system up from S5 (power off)
(2) To handle some platform devices appropriately over the cycle

> I want a real full poweroff, or at least I think I do.  Why wouldn't I?
> 
> ????

You may want that, some people may not want it.

We are supposed to handle S4, the BIOS/platform may expect us to do that, so
IMO this is a good enough reason to do it.  Especially that we can.

Thanks,
Rafael
