From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm] PM: Introduce set_target method in pm_ops
Date: Sun, 24 Jun 2007 14:57:20 +0200
Message-ID: <200706241457.21237.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0706232026460.9663-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:35776 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754836AbXFXM5v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 24 Jun 2007 08:57:51 -0400
In-Reply-To: <Pine.LNX.4.44L0.0706232026460.9663-100000@netrider.rowland.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: pm list <linux-pm@lists.linux-foundation.org>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Shaohua Li <shaohua.li@intel.com>, Johannes Berg <johannes@sipsolutions.net>, Igor Stoppa <igor.stoppa@nokia.com>

On Sunday, 24 June 2007 02:28, Alan Stern wrote:
> On Sun, 24 Jun 2007, Rafael J. Wysocki wrote:
> 
> > > Is this design okay with system states in which the CPU is able to run?
> > 
> > Do you mean the patch or the suggestions above?
> 
> The suggestions.
> 
> > > Right now the states we have are On, Standby, and Suspend, and the CPU
> > > runs only in the On state.  But on some platforms there could be
> > > multiple states in which the CPU is able to run, albeit with degraded 
> > > performance.
> > 
> > I wouldn't call those system sleep states.  For example, ACPI defines system
> > sleep states as the states in which no instructions are executed by any CPUs
> > and I think that's reasonable.
> > 
> > Moreover, the ACPI spec insists that transitions between different sleep
> > states should be made through the On state.
> 
> Okay.  But on non-ACPI systems, do we want to restrict the 
> /sys/power/state interface to sleep states?  How then should the user 
> tell the system to go to a low-performance run state?  Or should that 
> be handled automatically within the kernel?

I think that the /sys/power/state interface should be restricted to system
sleep states only and we should introduce another one for handling non-sleep
low-power states.

IMHO, the kernel can automatically transition to non-sleep low-power states,
but the users should be able to define the conditions for that.  Also, the user
should be able to force the transition if necessary/desired.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
