From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC/RFT][PATCH -mm 1/8][bugfix] PM: Introduce set_target method in pm_ops
Date: Wed, 27 Jun 2007 22:55:55 +0200
Message-ID: <200706272255.57243.rjw@sisk.pl>
References: <200706242239.05678.rjw@sisk.pl> <200706260041.20561.rjw@sisk.pl> <200706271341.53599.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:51318 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754644AbXF0Usk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Jun 2007 16:48:40 -0400
In-Reply-To: <200706271341.53599.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Shaohua Li <shaohua.li@intel.com>, Johannes Berg <johannes@sipsolutions.net>, Igor Stoppa <igor.stoppa@nokia.com>, Andrew Victor <andrew@sanpeople.com>

On Wednesday, 27 June 2007 22:41, David Brownell wrote:
> On Monday 25 June 2007, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > The at91 platform code incorrectly assumes that pm_ops->prepare() will be called
> 
> Make that "code assumes that ... but that requirement was broken
> by a patch merged in RC5 to make ACPI behave better."  That is,
> the problem is not that the AT91 code was doing anything wrong,
> it's that the API definition changed (incompatibly!) in RC5.
> 
> > before devices are suspended and uses it to make the PM core set the target
> > system sleep state used by the platform when suspending devices.  Thus, at91
> > needs a new member function in 'struct pm_ops' that will be used by the PM core
> > to convey the target system sleep state to the platform code before devices are
> > suspended.
> > 
> > Moreover, in the future some drivers may need to use ACPI to determine the low
> > power states in which to place their devices, but to provide the drivers with
> > this information the ACPI core needs to know what sleep state the system is
> > going to enter.  Namely, the device's state should not be too high power for
> > given system sleep state and, if the device is supposed to be able to wake up
> > the system, its state should not be too low power for the wake up to be
> > possible).  However, pm_ops->prepare() is only called after the drivers'
> > .suspend() callbacks have been executed, so we need an additional means to
> > convey the target system sleep state to the ACPI core.  The new member function
> > in 'struct pm_ops', set_target(), can be used for this purpose.
> 
> That's all extremely verbose:  (a) prepare() used to be called
> early, so a platform knew the target state while devices were
> being suspended; (b) that changed in RC5; (c) we still need a
> call delivering the original semantics, since (c1) AT91 depends
> on it now and (c2) ACPI should be depending on it, and this change
> broke a patch fixing that; ... so (d) here's a patch adding a new
> function that can do what prepare() used to do.

OK, I'll modify the changelog.

> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Acked-by: David Brownell <dbrownell@users.sourceforge.net>

Thanks,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
