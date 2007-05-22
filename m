From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 3/4] swsusp: Introduce restore platform operations
Date: Tue, 22 May 2007 22:30:34 +0200
Message-ID: <200705222230.35078.rjw@sisk.pl>
References: <200705180019.35548.rjw@sisk.pl> <200705222203.48568.rjw@sisk.pl> <46534E2C.60808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:58056 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754431AbXEVUZ2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 May 2007 16:25:28 -0400
In-Reply-To: <46534E2C.60808@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>

On Tuesday, 22 May 2007 22:10, Alexey Starikovskiy wrote:
> Rafael J. Wysocki ?????:
> > On Tuesday, 22 May 2007 01:55, Rafael J. Wysocki wrote:
> > Moreover, I'm not quite certain in which points the GPEs should actually be
> >   
> > disabled and enabled.  For example, there are some testing data indicating that
> > the enabling of GPEs should be done after all of the device drivers' .resume()
> > callbacks have run.
> Opposite, ACPI devices require enabled GPEs to do their resume, so 
> enabling of GPEs
> should happen at least before .resume() of ACPI devices is called.

Theoretically, that surely is correct, and which is what the patch actually
does. :-)

Still, we have users for whom hibernation was broken by moving the execution
of acpi_leave_sleep_state() before enable_nonboot_cpus().  At least on one
of these systems the hibernation can be fixed by removing the execution of
acpi_leave_sleep_state() from before enable_nonboot_cpus() and adding a
simplified version of it that only executes _WAK and enables the GPEs *after*
device_resume().  Unfortunately, I was unable to check if _WAK was necessary
for this (I hope it wasn't).

Greetings,
Rafael
