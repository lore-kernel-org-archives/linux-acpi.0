From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 3/3] clockevents: Fix resume logic - updated version
Date: Sat, 12 May 2007 19:01:41 +0200
Message-ID: <1178989302.22481.185.camel@localhost.localdomain>
References: <20070430102837.748238000@linutronix.de>
	 <20070511132846.5ebf4437.akpm@linux-foundation.org>
	 <200705112302.47726.rjw@sisk.pl> <200705112309.15996.rjw@sisk.pl>
	 <20070511235607.83ad0eb5.akpm@linux-foundation.org>
	 <1178959563.22481.126.camel@localhost.localdomain>
	 <20070512020056.a24cf472.akpm@linux-foundation.org>
	 <1178961489.22481.133.camel@localhost.localdomain>
	 <20070512030754.90488f79.akpm@linux-foundation.org>
	 <1178970253.22481.143.camel@localhost.localdomain>
	 <20070512095145.0cf58a57.akpm@linux-foundation.org>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:59284 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754352AbXELQ6f (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 May 2007 12:58:35 -0400
In-Reply-To: <20070512095145.0cf58a57.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, John Stultz <johnstul@us.ibm.com>, linux-acpi@vger.kernel.org

On Sat, 2007-05-12 at 09:51 -0700, Andrew Morton wrote:
> The locking in clocksource_resume_watchdog looks pretty pointless anyway.
> Can't we just delete it?
> 
> The only thing it can race against is, conceivably,
> 
>         resumed = watchdog_resumed;
>         if (unlikely(resumed))
>                 watchdog_resumed = 0;
> 
> which could be solved by using test_and_clear_bit().

True. I'll redo it.

> Does anyone have any theories about my lockdep warning?

Can you upload a snapshot of your current queue ?

	tglx



