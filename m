From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH] ACPI: Disable Windows 8 compatibility for some Lenovo
 ThinkPads
Date: Wed, 13 Feb 2013 15:46:54 -0600
Message-ID: <20130213214654.GG22867@thinkpad-t410>
References: <1360599681-24781-1-git-send-email-seth.forshee@canonical.com>
 <20130211175213.GA25139@srcf.ucam.org>
 <20130211190617.GH13768@thinkpad-t410>
 <20130211190914.GA27364@srcf.ucam.org>
 <20130213203228.GE22867@thinkpad-t410>
 <20130213205558.GA16559@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:56845 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080Ab3BMVq7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Feb 2013 16:46:59 -0500
Content-Disposition: inline
In-Reply-To: <20130213205558.GA16559@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Ben Jencks <ben@bjencks.net>, joeyli <jlee@suse.com>

On Wed, Feb 13, 2013 at 08:55:58PM +0000, Matthew Garrett wrote:
> On Wed, Feb 13, 2013 at 02:32:28PM -0600, Seth Forshee wrote:
> > On Mon, Feb 11, 2013 at 07:09:14PM +0000, Matthew Garrett wrote:
> > > Right. My concern here is that Windows clearly doesn't trigger the 
> > > issue, and so there's some chance that we'll see similar issues on other 
> > > machines. Disabling Windows 8 compatibility isn't really an option. One 
> > > choice might be to have the ACPI video driver set all intermediate 
> > > values if the system makes the Windows 8 OSI call?
> > 
> > This turns out to have some problems. The hotkeys on the x230 at least
> > generate increase/decrease brightness notifications. In response
> > acpi_video reads the current brightness level via _BQC and decides what
> > the next value should be. A value adjacent to a working value is never
> > another working value on this machine, so _BCM does nothing. The next
> > time a notification comes _BQC returns the same value as it did the
> > previous time. Obviously this gets us nowhere.
> 
> Nrgh. Having this logic in the kernel has always been miserable. On the 
> other hand, having _BQC return wrong values is arguably even worse.
> 
> > The (untested) fix I've come up with is to use the cached value for the
> > current brightness rather than asking the firmware. I'm assuming though
> > that acpi_video would be using the cached values already if there wasn't
> > a chance that their changing without its knowledge?
> 
> Yeah. What I'd suggest here is calling _BQC after every change, and if 
> it returns the old value throw a firmware bug message and fall back to 
> using a cached one.

After every brightness change? Maybe it would be better to just test for
this during initialization, then set device->cap._BQC to 0 so we won't
use it.

