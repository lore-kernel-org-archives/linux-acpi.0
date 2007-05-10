From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 3/3] clockevents: Fix resume logic - updated version
Date: Thu, 10 May 2007 11:27:41 +0200
Message-ID: <1178789261.4646.9.camel@chaos>
References: <20070430102837.748238000@linutronix.de>
	 <200705092036.20953.rjw@sisk.pl>
	 <1178743550.3042.541.camel@localhost.localdomain>
	 <200705092253.49896.rjw@sisk.pl>
	 <1178745983.3042.565.camel@localhost.localdomain>
	 <20070510014645.c4e79032.akpm@linux-foundation.org>
	 <1178787345.4646.4.camel@chaos>
	 <20070510021841.2dff9233.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:39619 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754238AbXEJJZK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 May 2007 05:25:10 -0400
In-Reply-To: <20070510021841.2dff9233.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, John Stultz <johnstul@us.ibm.com>, linux-acpi@vger.kernel.org

On Thu, 2007-05-10 at 02:18 -0700, Andrew Morton wrote:
> > > > If that patch makes the problem go away, then we should have a quite
> > > > good hint what we need to look at.
> > > 
> > > No joy, sorry.  It still hangs at the last statement in acpi_evaluate_object().
> > 
> > Can you add "nolapic_timer" to the command line please ?
> > 
> 
> That works.

Ok, that boils it down to the change, which affects the lapic timer
resume. It does nothing else, than fiddling in some APIC registers, but
I don't see how this affects the ACPI stuff. This smells extremly fishy.

	tglx


