From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: S3 suspend fails with lockdep BUG warning (TP T60, 2.6.18-rc1)
Date: Mon, 10 Jul 2006 18:23:51 +0100
Message-ID: <E1FzzU7-0004PA-00@skye.ra.phy.cam.ac.uk>
References: <20060710110336.GC7172@atrey.karlin.mff.cuni.cz>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:40171 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1422703AbWGJRX5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Jul 2006 13:23:57 -0400
In-Reply-To: Your message of "Mon, 10 Jul 2006 13:03:37 +0200."
             <20060710110336.GC7172@atrey.karlin.mff.cuni.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org

>> > I just did that, but found no /sys/power/state file (or anything under
>> > /sys).  

> You need to mount /sys, first...?!

Right.  But /proc was also not there, so I just rebooted to runlevel 1
to get both.

> > >   $ echo mem > /sys/power/state
> > >   bash: echo: write error: Operation not permitted

> Anything in dmesg?

This one was solved in my later email to linux-acpi: I hadn't enabled 
hotpluggable CPUs, which is needed for SMP to suspend.  So I did that,
which helped but it failed with a locking problem and a failure to
stop tasks.  See this linux-acpi msg:

Date:   Sat, 08 Jul 2006 12:22:45 EDT
Subject: Re: S3 suspend fails with lockdep BUG warning (TP T60, 2.6.18-rc1) 

> > > By the way, I'm not sure why standby is included as a possible
> > > /sys/power/state, since the boot messages don't include S1:
> > > 
> > >   [17179570.492000] ACPI: (supports S0 S3 S4 S5)
> 
> Now, that's really strange. My /sys/power/state does not include
> standby... Ask on acpi list...

I did, in the email that you're responding to (which went to
linux-acpi), but this reply can be taken as my asking again :-)

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
