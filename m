From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch update] PM: Introduce core framework for run-time PM of
 I/O devices
Date: Tue, 16 Jun 2009 10:30:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906161028480.3740-100000@iolanthe.rowland.org>
References: <200906160121.40843.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:55769 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751023AbZFPOaS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jun 2009 10:30:18 -0400
In-Reply-To: <200906160121.40843.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Oliver Neukum <oliver@neukum.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>

On Tue, 16 Jun 2009, Rafael J. Wysocki wrote:

> > Since pm_runtime_resume() takes care of powering up the parent, there's 
> > no need for pm_request_resume() to worry about it also.
> 
> But still it won't hurt to do it IMO, because the parents are then going to be
> resumed before our pm_runtime_resume() is called.

It's extra code that isn't needed.  In essence, you are trading code
space for a shorter runtime stack.

> > The documentation should mention that the runtime_suspend method is 
> > supposed to enable remote wakeup if it as available and if 
> > device_may_wakeup(dev) is true.
> 
> Well, I thought that was obvious. :-)

Sometimes it doesn't hurt to state the obvious!  :-)

Alan Stern

