From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC/RFT][PATCH -mm 1/4] PM: Introduce set_target method in pm_ops
Date: Tue, 26 Jun 2007 00:06:06 +0200
Message-ID: <200706260006.10246.rjw@sisk.pl>
References: <200706242239.05678.rjw@sisk.pl> <200706242240.40476.rjw@sisk.pl> <200706241911.18201.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41660 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751798AbXFYV7J (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Jun 2007 17:59:09 -0400
In-Reply-To: <200706241911.18201.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Shaohua Li <shaohua.li@intel.com>, Johannes Berg <johannes@sipsolutions.net>, Igor Stoppa <igor.stoppa@nokia.com>

On Monday, 25 June 2007 04:11, David Brownell wrote:
> On Sunday 24 June 2007, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Some drivers may need to use ACPI to determine the low power states in which
> > to place their devices, but to provide the drivers with this information the
> > ACPI core needs to know what sleep state the system is going to enter.
> 
> It also needs to export that to things like the ACPI-to-PCI glue
> code.  So it would be good if you defined the missing routine now,
> saving the effort of patching it in later:
> 
> 	int acpi_get_target_sleep_state(void);
> 
> It doesn't need EXPORT_SYMBOL().

I'd rather like to add this as a separate patch in the same series.  Will do.

> > Namely, the device's state should not be too high power for given system sleep
> > state and, if the device is supposed to be able to wake up the system, its state
> > should not be too low power for the wake up to be possible).  However,
> > pm_ops->prepare() is only called after the drivers' .suspend() callbacks have
> > been executed, 
> 
> That's a critical point that should show up in your doc updates.

Yes, will add that.

> > so we need an additional means to pass the information of the 
> > target system sleep state to the ACPI core.  For this purpose, we can introduce
> > an additional member function in 'struct pm_ops'.
> > 
> > Additionally, the at91 platform code incorrectly assumes that pm_ops->prepare()
> > will be called before devices are suspended and uses it for setting the target
> > system sleep state, so pm_ops->prepare() should to be replaced with the new
> > operation, pm_ops->set_target(), for this architecture.
> 
> That was originally correct ... but as you pointed out, the
> semantics there changed in RC5.
> 
> Which means this patch is a *BUGFIX*, preventing what would
> otherwise be a regression in 2.6.22 ... and so it should
> be merged for RC6 or so.

In that case I'd separate the addition of set_target() and the at91 from
the rest of the series and push it to Andrew ASAP (there's a little time left
before 2.6.22, it seems).

> Another way to describe the changes is that set_target() now
> does what prepare() used to do, while prepare() serves a
> new role.  A role which still needs to be well-described in
> the documentation you provided, by the way... it seems to
> do whatever needs to be done after devices suspend but
> before nonboot CPUs are disabled.

Yes, exactly.

I have the updated series of patches almost ready.  I'll send it in a new
thread in a while.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
