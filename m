From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch update] PM: Introduce core framework for run-time PM of I/O devices
Date: Sat, 27 Jun 2009 23:52:40 +0200
Message-ID: <200906272352.42022.rjw@sisk.pl>
References: <200906140023.36147.rjw@sisk.pl> <200906150057.32424.rjw@sisk.pl> <20090624150400.GG1784@ucw.cz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:34437 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751519AbZF0Vv5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 27 Jun 2009 17:51:57 -0400
In-Reply-To: <20090624150400.GG1784@ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oliver@neukum.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>

On Wednesday 24 June 2009, Pavel Machek wrote:
> Hi!
> 
> 
> > +2. Run-time PM Helper Functions and Device Fields
> > +
> > +The following helper functions are defined in drivers/base/power/runtime.c
> > +and include/linux/pm_runtime.h:
> > +
> > +* void pm_runtime_init(struct device *dev);
> > +* void pm_runtime_enable(struct device *dev);
> > +* void pm_runtime_disable(struct device *dev);
> > +* int pm_runtime_suspend(struct device *dev);
> > +* void pm_request_suspend(struct device *dev, unsigned long delay);
> > +* int pm_runtime_resume(struct device *dev);
> > +* void pm_request_resume(struct device *dev);
> > +* void pm_cancel_runtime_suspend(struct device *dev);
> > +* void pm_cancel_runtime_resume(struct device *dev);
> > +* void pm_suspend_check_children(struct device *dev, bool enable);
> 
> Those *s look confusingly like pointers. Remove them?

>From the doc?  OK, I can use another character. :-)

Best,
Rafael
