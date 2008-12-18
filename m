From: Pavel Machek <pavel@suse.cz>
Subject: Re: suspend/resume fails on second attempt in LNXVIDEO:00
Date: Thu, 18 Dec 2008 08:52:27 +0100
Message-ID: <20081218075226.GD2110@ucw.cz>
References: <gi247o$iog$1@ger.gmane.org> <200812161625.37318.rjw@sisk.pl> <gi8jf1$m5f$5@ger.gmane.org> <200812161713.08451.rjw@sisk.pl> <20081216163746.GA9478@srcf.ucam.org> <gi8qoj$m5f$7@ger.gmane.org> <20081216205335.GA14332@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37724 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbYLRHwh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Dec 2008 02:52:37 -0500
Content-Disposition: inline
In-Reply-To: <20081216205335.GA14332@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Brian J. Murrell" <brian@interlinx.bc.ca>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue 2008-12-16 20:53:35, Matthew Garrett wrote:
> On Tue, Dec 16, 2008 at 06:07:15PM +0000, Brian J. Murrell wrote:
> > On Tue, 16 Dec 2008 16:37:46 +0000, Matthew Garrett wrote:
> > > 
> > > I seem to be missing the original message, but: no, s2ram doesn't exist
> > > in Ubuntu because pm-utils handles that role.
> > 
> > Well, that's *their* argument but lots of people think otherwise.  There 
> > appears to be no shortage of people for whom pm-utils does NOT work yet 
> > s2ram does.  https://bugs.launchpad.net/ubuntu/+source/uswsusp/+bug/134238
> 
> The right answer to "This piece of software contains bugs" is not 
> "Provide two pieces of software with the same features but different 
> bugs". The only real functional difference between the two is that

Yes, and that's why pm-utils should die: they have design problems
(depend on hal, can't be pagelocked, unusable for suspend debugging).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
