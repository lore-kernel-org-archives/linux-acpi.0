From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH] ACPI: Disable Windows 8 compatibility for some Lenovo
 ThinkPads
Date: Sat, 20 Apr 2013 21:29:56 -0500
Message-ID: <20130421022956.GA25614@thinkpad-t410>
References: <1360599681-24781-1-git-send-email-seth.forshee@canonical.com>
 <20130318212546.GC3964@thinkpad-t410>
 <20130419122403.GI4699@thinkpad-t410>
 <5063522.ljsshHL4Hy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:59963 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab3DUCaH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 20 Apr 2013 22:30:07 -0400
Content-Disposition: inline
In-Reply-To: <5063522.ljsshHL4Hy@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Aaron Lu <aaron.lu@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Ben Jencks <ben@bjencks.net>, joeyli <jlee@suse.com>

On Sun, Apr 21, 2013 at 12:06:00AM +0200, Rafael J. Wysocki wrote:
> On Friday, April 19, 2013 07:24:03 AM Seth Forshee wrote:
> > On Mon, Mar 18, 2013 at 04:25:46PM -0500, Seth Forshee wrote:
> > > > I've had the patches implementing your suggestions written for a while
> > > > now but just got test feedback this week. So here they are.
> > > 
> > > Ping.
> > > 
> > > Matthew, do these patches look like what you had in mind?
> > 
> > What needs to be done to move forward on this issue? Because so far no
> > one besides Aaron has made any comment at all on the actual content of
> > the patches.
> 
> I'm not commenting mostly because I haven't had the time to think more about
> this issue yet.  Sorry about that.
> 
> If I were to comment without much consideration, though, I'd say I wasn't
> particularly impressed by any approach mentioned so far.

I doubt there's going to be any "good" solution to this problem. What
gives the best results is to force the affected models back to the
pre-Win8 behavior, but of course that requires quirking. If we could
assume that all graphics drivers will export backlight control then just
disabling the ACPI interface for these machines would work nearly as
well, but I don't think we can count on that, and it probably requires
quirking as well.

If we rule out quirking there are only a couple of options that anyone
has suggested. We can hit every intermediate brightness level as in the
patches I sent, but this is imperfect and requires a number of
comprimises. Or we can test every level the machine claims to support
and see which ones cause the value returned by _BQC to change, which
seems like it ought to work but means changing the brightness during
boot (which Matthew already objected to, though in another context). I
haven't been able to think of any others, but I'm happy to listen to
suggestions.

Thanks,
Seth

