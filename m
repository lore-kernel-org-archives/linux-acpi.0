From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 3/3] clockevents: Fix resume logic - updated version
Date: Fri, 11 May 2007 23:56:07 -0700
Message-ID: <20070511235607.83ad0eb5.akpm@linux-foundation.org>
References: <20070430102837.748238000@linutronix.de>
	<20070511132846.5ebf4437.akpm@linux-foundation.org>
	<200705112302.47726.rjw@sisk.pl>
	<200705112309.15996.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:49396 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751076AbXELG4k (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 May 2007 02:56:40 -0400
In-Reply-To: <200705112309.15996.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, John Stultz <johnstul@us.ibm.com>, linux-acpi@vger.kernel.org

On Fri, 11 May 2007 23:09:15 +0200 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> > > 
> > > hm, Fedora don't seem to want to give me an RPM which contains acpidump and
> > > all the yum servers are featuring scrogged checksums.  I could build it, I
> > > guess, but there's a principle involved ;)
> > > 
> > > http://userweb.kernel.org/~akpm/dsdt is /proc/acpi/dsdt.  Is that OK?
> > 
> > Yes, thanks.
> 
> Hmm, have you tried to do 'echo shutdown > /sys/power/disk' before the
> hibernation?

That didn't change the behaviour.
