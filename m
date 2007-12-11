From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend to RAM failure on t61p
Date: Tue, 11 Dec 2007 22:50:36 +0100
Message-ID: <200712112250.36496.rjw@sisk.pl>
References: <20071209011928.c9873c66.akpm@linux-foundation.org> <200712101206.15037.rjw@sisk.pl> <20071210222156.f51dd114.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:53206 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799AbXLKVba (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Dec 2007 16:31:30 -0500
In-Reply-To: <20071210222156.f51dd114.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tomas Carnecky <tom@dbservice.com>, linux-acpi@vger.kernel.org

On Tuesday, 11 of December 2007, Andrew Morton wrote:
> On Mon, 10 Dec 2007 12:06:14 +0100 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Monday, 10 of December 2007, Andrew Morton wrote:
> > > On Mon, 10 Dec 2007 02:04:13 +0100 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > 
> > > > On Monday, 10 of December 2007, Andrew Morton wrote:
> > > > > On Sun, 09 Dec 2007 13:40:07 +0100 Tomas Carnecky <tom@dbservice.com> wrote:
> > > > > 
> > > > > > Andrew Morton wrote:
> > > > > > > 2.6.24-rc4 on a Lenovo t61p, using FC8 config.
> > > > > > > 
> > > > > > > echo mem > /sys/power/state while running X.
> > > > > > > 
> > > > > > > It appears to suspend OK but then it instantly resumes and runs
> > > > > > > OK except the display is blank.
> > > > > > 
> > > > > > http://bugzilla.kernel.org/show_bug.cgi?id=9258
> > > > > > 
> > > > > > I have a X61 tablet, and the screen is blank after resume, too, but
> > > > > > pressing ctrl+alt+F1/F7 usually fixes it. It seems a problem with the X
> > > > > > video driver. I'm not sure though.
> > > > > > 
> > > > > 
> > > > > This machine doesn't bring the display back after resume-from-RAM under
> > > > > 2.6.23 either.
> > > > > 
> > > > > The post-2.6.23 regresison here is that the suspend itself fails.  Under
> > > > > 2.6.23 the machine suspends and requires a keystrike to start resuming. 
> > > > > Under 2.6.24-rc4 it just instantly resumes all by itself.
> > > > 
> > > > Please see if the appended patch helps (it will probably break the RTC wakeup
> > > > again, but well ...).
> > > > 
> > > > 
> > > > ---
> > > >  kernel/power/disk.c |    9 ++++++---
> > > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > > > 
> > > > Index: linux-2.6/kernel/power/disk.c
> > > > ===================================================================
> > > > --- linux-2.6.orig/kernel/power/disk.c
> > > > +++ linux-2.6/kernel/power/disk.c
> > > > @@ -378,9 +378,12 @@ int hibernation_platform_enter(void)
> > > >  		return error;
> > > >  
> > > >  	suspend_console();
> > > > -	error = device_suspend(PMSG_SUSPEND);
> > > > -	if (error)
> > > > -		goto Resume_console;
> > > > +	/*
> > > > +	 * FIXME: device_suspend(PMSG_SUSPEND) should be called here, but
> > > > +	 * some EHCI controllers make boxes reboot instead of going into the
> > > > +	 * S4 sleep state in that case.
> > > > +	 */
> > > > +	device_shutdown();
> > > >  
> > > >  	error = hibernation_ops->prepare();
> > > >  	if (error)
> > > 
> > > Nope, the machine still instantly resumes after suspend-to-RAM.
> > > 
> > > Sigh.  I guess I need to git-bisect my cant-find-root-disk problem and then
> > > once that is fixed I can bisect this suspend-to-RAM-resumes-itself
> > > regression and the resume-from-disk-causes-reboot regression.
> > 
> > Well, please try to revert the entire commit 9cd9a0058dd35268b24fa16795a92c800f4086d4
> > "Hibernation: Enter platform hibernation state in a consistent way" for the last one.
> 
> Yes, reverting 9cd9a0058dd35268b24fa16795a92c800f4086d4 fixes the
> suspend-to-RAM problem: it now stays suspended.

Well, this patch doesn't touch the suspend-to-RAM code path, it only touches
the last phase of hibernation.  I'm quite sure it can't affect the suspend to
RAM.
 
