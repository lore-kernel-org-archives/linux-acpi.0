From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH] ACPI: Disable Windows 8 compatibility for some Lenovo
 ThinkPads
Date: Wed, 13 Feb 2013 14:32:28 -0600
Message-ID: <20130213203228.GE22867@thinkpad-t410>
References: <1360599681-24781-1-git-send-email-seth.forshee@canonical.com>
 <20130211175213.GA25139@srcf.ucam.org>
 <20130211190617.GH13768@thinkpad-t410>
 <20130211190914.GA27364@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:56589 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab3BMUck (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Feb 2013 15:32:40 -0500
Content-Disposition: inline
In-Reply-To: <20130211190914.GA27364@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Ben Jencks <ben@bjencks.net>, joeyli <jlee@suse.com>

On Mon, Feb 11, 2013 at 07:09:14PM +0000, Matthew Garrett wrote:
> On Mon, Feb 11, 2013 at 01:06:17PM -0600, Seth Forshee wrote:
> > On Mon, Feb 11, 2013 at 05:52:13PM +0000, Matthew Garrett wrote:
> > > So the problem is that userspace is writing values that don't happen to 
> > > be aligned with the values the hardware reacts to, and so nothing gets 
> > > changed?
> > 
> > Yes. The values are valid according to to _BCL, but _BCM is discarding
> > any values that aren't contained in an array named BRTW. BRTW is
> > literally the object returned by _BCL returns for !Windows 2012. Here's
> > a link to the AML if you'd like to take a look.
> 
> Right. My concern here is that Windows clearly doesn't trigger the 
> issue, and so there's some chance that we'll see similar issues on other 
> machines. Disabling Windows 8 compatibility isn't really an option. One 
> choice might be to have the ACPI video driver set all intermediate 
> values if the system makes the Windows 8 OSI call?

This turns out to have some problems. The hotkeys on the x230 at least
generate increase/decrease brightness notifications. In response
acpi_video reads the current brightness level via _BQC and decides what
the next value should be. A value adjacent to a working value is never
another working value on this machine, so _BCM does nothing. The next
time a notification comes _BQC returns the same value as it did the
previous time. Obviously this gets us nowhere.

The (untested) fix I've come up with is to use the cached value for the
current brightness rather than asking the firmware. I'm assuming though
that acpi_video would be using the cached values already if there wasn't
a chance that their changing without its knowledge?

The other issue with using the cached value is that the hotkeys on these
machines are still going to end up cycling through 101 brightness levels
with 85% of them leaving the brightness unchanged. When there's that
many levels though maybe it makes sense to jump more than one level at a
time.

Seth

