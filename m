From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 3/3] clockevents: Fix resume logic - updated version
Date: Thu, 10 May 2007 02:18:41 -0700
Message-ID: <20070510021841.2dff9233.akpm@linux-foundation.org>
References: <20070430102837.748238000@linutronix.de>
	<200705092036.20953.rjw@sisk.pl>
	<1178743550.3042.541.camel@localhost.localdomain>
	<200705092253.49896.rjw@sisk.pl>
	<1178745983.3042.565.camel@localhost.localdomain>
	<20070510014645.c4e79032.akpm@linux-foundation.org>
	<1178787345.4646.4.camel@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:42096 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755425AbXEJJTR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 May 2007 05:19:17 -0400
In-Reply-To: <1178787345.4646.4.camel@chaos>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, John Stultz <johnstul@us.ibm.com>, linux-acpi@vger.kernel.org

On Thu, 10 May 2007 10:55:45 +0200 Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, 2007-05-10 at 01:46 -0700, Andrew Morton wrote:
> > On Wed, 09 May 2007 23:26:22 +0200 Thomas Gleixner <tglx@linutronix.de> wrote:
> > 
> > > Andrew,
> > > 
> > > can you test the alternative replacement patch for 
> > > 
> > > clockevents: Fix resume logic - updated version
> > > 
> > > It does not touch the interrupt controller, it does the PIT restart
> > > different. That's a patch from Chris Wright and confirmed to work on the
> > > affected machines - except the @%$#! VAIO of course.
> > > 
> > > If that patch makes the problem go away, then we should have a quite
> > > good hint what we need to look at.
> > 
> > No joy, sorry.  It still hangs at the last statement in acpi_evaluate_object().
> 
> Can you add "nolapic_timer" to the command line please ?
> 

That works.
