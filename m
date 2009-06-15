From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch update] PM: Introduce core framework for run-time PM of
 I/O devices
Date: Mon, 15 Jun 2009 17:08:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906151700570.2643-100000@iolanthe.rowland.org>
References: <200906150057.32424.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:54298 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S934483AbZFOVI4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Jun 2009 17:08:56 -0400
In-Reply-To: <200906150057.32424.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Oliver Neukum <oliver@neukum.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>

On Mon, 15 Jun 2009, Rafael J. Wysocki wrote:

> On Sunday 14 June 2009, Rafael J. Wysocki wrote:
> > On Sunday 14 June 2009, Rafael J. Wysocki wrote:
> > > Hi,
> > > 
> > > Below is the current version of my "run-time PM for I/O devices" patch.
> > > 
> > > I've done my best to address the comments received during the recent
> > > discussions, but at the same time I've tried to make the patch only contain
> > > the most essential things.  For this reason, for example, the sysfs interface
> > > is not there and it's going to be added in a separate patch.
> > > 
> > > Please let me know if you want me to change anything in this patch or to add
> > > anything new to it.  [Magnus, I remember you wanted something like
> > > ->runtime_wakeup() along with ->runtime_idle(), but I'm not sure it's really
> > > necessary.  Please let me know if you have any particular usage scenario for
> > > it.]
> 
> Appended is an update of the patch addressing the today's comments from Magnus.

This is really looking very good.  I'll do a more detailed review
later.  (In particular, I have not checked the details of the rather
intricate state machine transitions.)  For now, a couple of things 
struck my eye:

Shouldn't the calls to complete() really be complete_all()?  There
might be more than one thread waiting for a suspend or resume callback
to finish.

Since pm_runtime_resume() takes care of powering up the parent, there's 
no need for pm_request_resume() to worry about it also.

The documentation should mention that the runtime_suspend method is 
supposed to enable remote wakeup if it as available and if 
device_may_wakeup(dev) is true.

Alan Stern

