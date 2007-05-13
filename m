From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 3/3] clockevents: Fix resume logic - updated version
Date: Sat, 12 May 2007 18:11:40 -0700
Message-ID: <20070512181140.50140334.akpm@linux-foundation.org>
References: <20070430102837.748238000@linutronix.de>
	<20070511132846.5ebf4437.akpm@linux-foundation.org>
	<200705112302.47726.rjw@sisk.pl>
	<200705112309.15996.rjw@sisk.pl>
	<20070511235607.83ad0eb5.akpm@linux-foundation.org>
	<1178959563.22481.126.camel@localhost.localdomain>
	<20070512020056.a24cf472.akpm@linux-foundation.org>
	<1178961489.22481.133.camel@localhost.localdomain>
	<20070512030754.90488f79.akpm@linux-foundation.org>
	<1178970253.22481.143.camel@localhost.localdomain>
	<20070512095145.0cf58a57.akpm@linux-foundation.org>
	<1178989302.22481.185.camel@localhost.localdomain>
	<20070512102350.04126320.akpm@linux-foundation.org>
	<1178999770.22481.211.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757874AbXEMBMW@vger.kernel.org>
In-Reply-To: <1178999770.22481.211.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, John Stultz <johnstul@us.ibm.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, 12 May 2007 21:56:10 +0200 Thomas Gleixner <tglx@linutronix.de> wrote:

> On Sat, 2007-05-12 at 10:23 -0700, Andrew Morton wrote:
> > The broken-out queue should turn up at
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/
> > in a few minutes.
> 
> Sigh. I can't reproduce your lockdep problem :(

We should write a Vaio emulator.

> Can you send me your .config please ?
> 

http://userweb.kernel.org/~akpm/config-sony.txt
