From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH] ACPI: Disable Windows 8 compatibility for some Lenovo
 ThinkPads
Date: Mon, 18 Mar 2013 16:25:46 -0500
Message-ID: <20130318212546.GC3964@thinkpad-t410>
References: <1360599681-24781-1-git-send-email-seth.forshee@canonical.com>
 <20130211175213.GA25139@srcf.ucam.org>
 <20130211190617.GH13768@thinkpad-t410>
 <20130211190914.GA27364@srcf.ucam.org>
 <20130213203228.GE22867@thinkpad-t410>
 <20130213205558.GA16559@srcf.ucam.org>
 <20130307193812.GD24233@thinkpad-t410>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:43380 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933149Ab3CRVZz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Mar 2013 17:25:55 -0400
Content-Disposition: inline
In-Reply-To: <20130307193812.GD24233@thinkpad-t410>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Ben Jencks <ben@bjencks.net>, joeyli <jlee@suse.com>

On Thu, Mar 07, 2013 at 01:38:12PM -0600, Seth Forshee wrote:
> On Wed, Feb 13, 2013 at 08:55:58PM +0000, Matthew Garrett wrote:
> > On Wed, Feb 13, 2013 at 02:32:28PM -0600, Seth Forshee wrote:
> > > On Mon, Feb 11, 2013 at 07:09:14PM +0000, Matthew Garrett wrote:
> > > > Right. My concern here is that Windows clearly doesn't trigger the 
> > > > issue, and so there's some chance that we'll see similar issues on other 
> > > > machines. Disabling Windows 8 compatibility isn't really an option. One 
> > > > choice might be to have the ACPI video driver set all intermediate 
> > > > values if the system makes the Windows 8 OSI call?
> > > 
> > > This turns out to have some problems. The hotkeys on the x230 at least
> > > generate increase/decrease brightness notifications. In response
> > > acpi_video reads the current brightness level via _BQC and decides what
> > > the next value should be. A value adjacent to a working value is never
> > > another working value on this machine, so _BCM does nothing. The next
> > > time a notification comes _BQC returns the same value as it did the
> > > previous time. Obviously this gets us nowhere.
> > 
> > Nrgh. Having this logic in the kernel has always been miserable. On the 
> > other hand, having _BQC return wrong values is arguably even worse.
> > 
> > > The (untested) fix I've come up with is to use the cached value for the
> > > current brightness rather than asking the firmware. I'm assuming though
> > > that acpi_video would be using the cached values already if there wasn't
> > > a chance that their changing without its knowledge?
> > 
> > Yeah. What I'd suggest here is calling _BQC after every change, and if 
> > it returns the old value throw a firmware bug message and fall back to 
> > using a cached one.
> > 
> > > The other issue with using the cached value is that the hotkeys on these
> > > machines are still going to end up cycling through 101 brightness levels
> > > with 85% of them leaving the brightness unchanged. When there's that
> > > many levels though maybe it makes sense to jump more than one level at a
> > > time.
> > 
> > Right. I'd recommend turning off that functionality and just leaving it 
> > up to userspace. We still seem to be carrying a patch to do that in 
> > Fedora. I thought I had a patch to make this a config option somewhere, 
> > but can't find any sign of it now...
> 
> I've had the patches implementing your suggestions written for a while
> now but just got test feedback this week. So here they are.

Ping.

Matthew, do these patches look like what you had in mind?

