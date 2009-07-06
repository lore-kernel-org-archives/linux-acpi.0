From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: 2.6.30: hibernation/swsusp lockup due to acpi-cpufreq
Date: Mon, 06 Jul 2009 14:20:30 -0700
Message-ID: <1246915230.11545.61.camel@localhost.localdomain>
References: <cNOy0-5C5-23@gated-at.bofh.it> <cNOok-5pJ-11@gated-at.bofh.it>
	 <4a4f9af3.27015a0a.48c6.ffffa6d5@mx.google.com>
	 <200907042329.04926.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11656 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753318AbZGFVWV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 6 Jul 2009 17:22:21 -0400
In-Reply-To: <200907042329.04926.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Michael Witten <mfwitten@gmail.com>, Johannes Stezenbach <js@sig21.net>, Andrew Morton <akpm@linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sat, 2009-07-04 at 14:29 -0700, Rafael J. Wysocki wrote:
> On Saturday 04 July 2009, Michael Witten wrote:
> > On Tue, 16 Jun 2009 23:39:59 +0200, Rafael J. Wysocki wrote
> > (http://www.spinics.net/lists/linux-acpi/msg22661.html):
> > 
> > > In fact, we need to do this entire thing differently.
> > > 
> > > The basic problem is that cpufreq_suspend() is a sysdev thing, so it will 
> > > always be called with iterrupts off and *only* for CPU0.  So, it looks like
> > > the majority of things we do there is just unnecessary (at least).
> > 
> > What's the status? This bug is driving me nuts.
> 
> Unfortunately, still unresolved.

Looked at this a bit more from acpi cpufreq angle.

But, I feel the patch that Johannes had here
http://lkml.indiana.edu/hypermail/linux/kernel/0906.2/00335.html
is the right fix as we do the same saving and restoring of flags on SMP
when cpu==this_cpu. This change will make code in UP same as that in SMP
with 1 CPU active.

We can avoid the driver->get call from cpufreq_suspend for the drivers
that do not do any freq changes in their suspend methods. But, then we
will hit this same problem in cpufreq_resume() path and there we do want
to check for adjust_jiffies for all drivers as long as CONSTANT_LOOPS is
not set.

Thanks,
Venki

