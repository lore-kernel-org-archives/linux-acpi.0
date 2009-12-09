From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates for 2.6.33)
Date: Wed, 9 Dec 2009 16:46:54 +0000
Message-ID: <20091209164653.GI9018@sirena.org.uk>
References: <20091209160256.GA3229@rakim.wolfsonmicro.main> <Pine.LNX.4.44L0.0912091117080.4120-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:58021 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbZLIQqz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2009 11:46:55 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0912091117080.4120-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Wed, Dec 09, 2009 at 11:23:00AM -0500, Alan Stern wrote:
> On Wed, 9 Dec 2009, Mark Brown wrote:

> > I'm not convinced that helps with the fact that the suspend may take a
> > long time - ideally we'd be able to start the suspend process off but
> > let other things carry on while it completes without having to worry
> > about something we're relying on getting suspended underneath us.

> The suspend procedure is oriented around device structures, and what 
> you're talking about isn't.  It's something separate which has to be 
> finished before _any_ of the audio devices are suspended.

In this context the "subsystem" actually has a struct device associated
with it so does appear in the device flow.

> How long does it take to bring down the entire embedded audio 
> subsystem?  And how critical is the timing for typical systems?

Worst case is about a second for both resume and suspend which means two
seconds total but it's very hardware dependant.  

The latency budget for suspend and resume are both zero in an ideal
world, users want to be able to suspend as much as possible which means
they'd like it to take no perceptible time at the human level.  Some
hardware is at the point where that's getting realistic but the folks on
older hardware still want to get as close to that as they can.
