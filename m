From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 3/3] clockevents: Fix resume logic - updated version
Date: Wed, 09 May 2007 19:15:50 +0200
Message-ID: <1178730950.3042.533.camel@localhost.localdomain>
References: <20070430102837.748238000@linutronix.de>
	 <200705091512.13171.rjw@sisk.pl>
	 <1178716776.3042.485.camel@localhost.localdomain>
	 <200705091909.25443.rjw@sisk.pl>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:57419 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756052AbXEIRM5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 May 2007 13:12:57 -0400
In-Reply-To: <200705091909.25443.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, John Stultz <johnstul@us.ibm.com>, linux-acpi@vger.kernel.org

On Wed, 2007-05-09 at 19:09 +0200, Rafael J. Wysocki wrote:
> > > Well, where is unregister_time_interpolator() called from?
> > 
> > # grep -rn unregister_time_interpolator .
> > ./kernel/timer.c:1893:unregister_time_interpolator(struct time_interpolator *ti)
> > ./include/linux/timex.h:270:extern void unregister_time_interpolator(struct time_interpolator *);
> > 
> > I don't see a caller. i386 does not use time interpolator anyway.
> > 
> > # find -iname Kconfig | xargs grep TIME_INTERPOLATION
> > ./arch/sparc64/Kconfig:37:config TIME_INTERPOLATION
> > ./arch/ia64/Kconfig:60:config TIME_INTERPOLATION
> 
> But clocksource_resume() has no other caller, AFAICS ...

Eeep ?

clocksource_resume is called from timekeeping_resume()

timestatic int timekeeping_resume(struct sys_device *dev)
{
        unsigned long flags;
        unsigned long now = read_persistent_clock();

        clocksource_resume();
....
}

keeping_resume() called via the sysdev resume 

static struct sysdev_class timekeeping_sysclass = {
        .resume         = timekeeping_resume,
        .suspend        = timekeeping_suspend,
        set_kset_name("timekeeping"),
};

	tglx


