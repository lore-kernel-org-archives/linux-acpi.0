From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: suspend to RAM failure on t61p
Date: Mon, 10 Dec 2007 22:21:56 -0800
Message-ID: <20071210222156.f51dd114.akpm@linux-foundation.org>
References: <20071209011928.c9873c66.akpm@linux-foundation.org>
	<200712100204.13881.rjw@sisk.pl>
	<20071209232547.1d0c6599.akpm@linux-foundation.org>
	<200712101206.15037.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43911 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751273AbXLKGWP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Dec 2007 01:22:15 -0500
In-Reply-To: <200712101206.15037.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Tomas Carnecky <tom@dbservice.com>, linux-acpi@vger.kernel.org

On Mon, 10 Dec 2007 12:06:14 +0100 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Monday, 10 of December 2007, Andrew Morton wrote:
> > On Mon, 10 Dec 2007 02:04:13 +0100 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > 
> > > On Monday, 10 of December 2007, Andrew Morton wrote:
> > > > On Sun, 09 Dec 2007 13:40:07 +0100 Tomas Carnecky <tom@dbservice.com> wrote:
> > > > 
> > > > > Andrew Morton wrote:
> > > > > > 2.6.24-rc4 on a Lenovo t61p, using FC8 config.
> > > > > > 
> > > > > > echo mem > /sys/power/state while running X.
> > > > > > 
> > > > > > It appears to suspend OK but then it instantly resumes and runs
> > > > > > OK except the display is blank.
> > > > > 
> > > > > http://bugzilla.kernel.org/show_bug.cgi?id=9258
> > > > > 
> > > > > I have a X61 tablet, and the screen is blank after resume, too, but
> > > > > pressing ctrl+alt+F1/F7 usually fixes it. It seems a problem with the X
> > > > > video driver. I'm not sure though.
> > > > > 
> > > > 
> > > > This machine doesn't bring the display back after resume-from-RAM under
> > > > 2.6.23 either.
> > > > 
> > > > The post-2.6.23 regresison here is that the suspend itself fails.  Under
> > > > 2.6.23 the machine suspends and requires a keystrike to start resuming. 
> > > > Under 2.6.24-rc4 it just instantly resumes all by itself.
> > > 
> > > Please see if the appended patch helps (it will probably break the RTC wakeup
> > > again, but well ...).
> > > 
> > > 
> > > ---
> > >  kernel/power/disk.c |    9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > > 
> > > Index: linux-2.6/kernel/power/disk.c
> > > ===================================================================
> > > --- linux-2.6.orig/kernel/power/disk.c
> > > +++ linux-2.6/kernel/power/disk.c
> > > @@ -378,9 +378,12 @@ int hibernation_platform_enter(void)
> > >  		return error;
> > >  
> > >  	suspend_console();
> > > -	error = device_suspend(PMSG_SUSPEND);
> > > -	if (error)
> > > -		goto Resume_console;
> > > +	/*
> > > +	 * FIXME: device_suspend(PMSG_SUSPEND) should be called here, but
> > > +	 * some EHCI controllers make boxes reboot instead of going into the
> > > +	 * S4 sleep state in that case.
> > > +	 */
> > > +	device_shutdown();
> > >  
> > >  	error = hibernation_ops->prepare();
> > >  	if (error)
> > 
> > Nope, the machine still instantly resumes after suspend-to-RAM.
> > 
> > Sigh.  I guess I need to git-bisect my cant-find-root-disk problem and then
> > once that is fixed I can bisect this suspend-to-RAM-resumes-itself
> > regression and the resume-from-disk-causes-reboot regression.
> 
> Well, please try to revert the entire commit 9cd9a0058dd35268b24fa16795a92c800f4086d4
> "Hibernation: Enter platform hibernation state in a consistent way" for the last one.

Yes, reverting 9cd9a0058dd35268b24fa16795a92c800f4086d4 fixes the
suspend-to-RAM problem: it now stays suspended.

However it doens't resume on a keystroke like 2.6.23 does: I have to tap the
power switch to make it resume.


However reverting 9cd9a0058dd35268b24fa16795a92c800f4086d4 does not fix the
machine-reboots-after-resume-from-disk regression.

It gets to here:

Attempting manual resume
swsusp: Marking nosave pages: 000000000009d000 - 0000000000100000
swsusp: Basic memory bitmaps created
Freezing user space processes ... (elapsed 0.00 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
Loading image data pages (52207 pages) ... done
Read 208828 kbytes in 5.40 seconds (38.67 MB/s)
Suspending console(s)

then everything stops for five seconds then wham.

This bug is present in 2.6.24-rc1 but I'm basically unable to bisect it
because every bisection point (tried about four so far) hits fatal runtime
errors: cant-find-/dev/root, an oops in ipv6, an oops in netfilter, etc.

This is just a basic boot-it-on-fc8 test with RH's config and nothing
works.  The quality of code which people have been checking into the tree
is just appalling and here we see the costs of that.

I think I'll see if it's present in the last 2.6.23 -mm lineup: I know I
can bisect that.  Probably it won't be, given the way in which people like
to jam vast amounts of new code into the merge window.

Sigh.

