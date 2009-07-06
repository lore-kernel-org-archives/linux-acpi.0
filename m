From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch update] PM: Introduce core framework for run-time PM of I/O devices
Date: Mon, 6 Jul 2009 10:28:27 +0200
Message-ID: <20090706082827.GA26142@atrey.karlin.mff.cuni.cz>
References: <200906140023.36147.rjw@sisk.pl> <200906150057.32424.rjw@sisk.pl> <20090624150400.GG1784@ucw.cz> <200906272352.42022.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58435 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbZGFI2Y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Jul 2009 04:28:24 -0400
Content-Disposition: inline
In-Reply-To: <200906272352.42022.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oliver@neukum.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>

> On Wednesday 24 June 2009, Pavel Machek wrote:
> > Hi!
> > 
> > 
> > > +2. Run-time PM Helper Functions and Device Fields
> > > +
> > > +The following helper functions are defined in drivers/base/power/runtime.c
> > > +and include/linux/pm_runtime.h:
> > > +
> > > +* void pm_runtime_init(struct device *dev);
> > > +* void pm_runtime_enable(struct device *dev);
> > > +* void pm_runtime_disable(struct device *dev);
> > > +* int pm_runtime_suspend(struct device *dev);
> > > +* void pm_request_suspend(struct device *dev, unsigned long delay);
> > > +* int pm_runtime_resume(struct device *dev);
> > > +* void pm_request_resume(struct device *dev);
> > > +* void pm_cancel_runtime_suspend(struct device *dev);
> > > +* void pm_cancel_runtime_resume(struct device *dev);
> > > +* void pm_suspend_check_children(struct device *dev, bool enable);
> > 
> > Those *s look confusingly like pointers. Remove them?
> 
> From the doc?  OK, I can use another character. :-)

Yes. I suggest # :-)

> 
> Best,
> Rafael

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
