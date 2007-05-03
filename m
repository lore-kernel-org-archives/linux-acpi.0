From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] swsusp: Do not use pm_ops
Date: Thu, 3 May 2007 12:11:18 +0200
Message-ID: <20070503101118.GJ12554@elf.ucw.cz>
References: <200705022213.35831.rjw@sisk.pl> <1178181680.13233.74.camel@johannes.berg> <200705031146.03358.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37464 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1031092AbXECKL1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 May 2007 06:11:27 -0400
Content-Disposition: inline
In-Reply-To: <200705031146.03358.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Johannes Berg <johannes@sipsolutions.net>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pekka Enberg <penberg@cs.helsinki.fi>

On Thu 2007-05-03 11:46:02, Rafael J. Wysocki wrote:
> On Thursday, 3 May 2007 10:41, Johannes Berg wrote:
> > On Wed, 2007-05-02 at 22:13 +0200, Rafael J. Wysocki wrote:
> > 
> > > +void hibernation_set_ops(struct hibernation_ops *ops)
> > > +{
> > > +	if (ops && !(ops->prepare && ops->enter && ops->finish)) {
> > > +		printk(KERN_ERR "Wrong definition of hibernation operations! "
> > > +			"Using defaults\n");
> > > +		return;
> > > +	}
> > 
> > Why not BUG_ON here as I had before? I don't see much point in giving a
> > runtime warning, and the docs clearly state that you must assign all
> > three items. Oh, I see I had a bug before when ops was NULL, but you can
> > still do
> >   BUG_ON(ops && !(ops->prepare && ops->enter && ops->finish));
> 
> Well, BUG_ON() is extremely user-unfriendly, and it'd trigger even if the user
> actually didn't intend to suspend at all.

WARN_ON()?
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
