From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 3/3] clockevents: Fix resume logic - updated version
Date: Sun, 13 May 2007 18:12:50 +0200
Message-ID: <1179072770.22481.265.camel@localhost.localdomain>
References: <20070430102837.748238000@linutronix.de>
	 <20070511132846.5ebf4437.akpm@linux-foundation.org>
	 <200705112302.47726.rjw@sisk.pl> <200705112309.15996.rjw@sisk.pl>
	 <20070511235607.83ad0eb5.akpm@linux-foundation.org>
	 <1178959563.22481.126.camel@localhost.localdomain>
	 <20070512020056.a24cf472.akpm@linux-foundation.org>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:51228 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755568AbXEMQJj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 13 May 2007 12:09:39 -0400
In-Reply-To: <20070512020056.a24cf472.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, John Stultz <johnstul@us.ibm.com>, linux-acpi@vger.kernel.org

On Sat, 2007-05-12 at 02:00 -0700, Andrew Morton wrote:
> Still hangs in the same fashion, sorry.
> 
> It's peculiar that the hang happens when acpi_evaluate_object() hits its
> return statement.  Any theories there?

I assume you have a printk right before the return and one after the
call to acpi_evaluate_object().

Can you dump the stack at the point before the return, so we can see if
the stack is corrupt there ? A WARN_ON(1) should do the trick.

	tglx




