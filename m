From: john stultz <johnstul@us.ibm.com>
Subject: Re: [RFC][PATCH] Runtime switching of the idle function [take 2]
Date: Tue, 29 Nov 2005 18:19:41 -0800
Message-ID: <1133317181.1421.47.camel@cog.beaverton.ibm.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005456F00@hdsmsx401.amr.corp.intel.com>
	 <20051129195336.GP19515@wotan.suse.de> <1133296540.4627.7.camel@mindpipe>
	 <20051129205108.GQ19515@wotan.suse.de> <1133308505.4627.31.camel@mindpipe>
	 <20051130010646.GD19515@wotan.suse.de> <1133313771.4627.39.camel@mindpipe>
	 <20051130015809.GF19515@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750789AbVK3CTr@vger.kernel.org>
In-Reply-To: <20051130015809.GF19515@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, "Brown, Len" <len.brown@intel.com>, Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net, nando@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org, paulmck@us.ibm.com, kr@cybsft.com, tglx@linutronix.de, pluto@agmk.net, john.cooper@timesys.com, bene@linutronix.de, dwalker@mvista.com, trini@kernel.crashing.org, george@mvista.com, Vojtech Pavlik <vojtech@suse.cz>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2005-11-30 at 02:58 +0100, Andi Kleen wrote:
> > > Then you're likely running 32bit. It doesn't use vsyscall gettimeofday
> > > yet, which makes it slower. 64bit would.
> > 
> > Yes, I am.  So it sounds like vsyscall gettimeofday for i386 is in the
> > works?
> 
> John Stultz used to have patches for it, but for some reason he never
> pushed them into mainline. 

Unfortunately it was a pretty ugly patch. Correctness issues with the
existing code have kept focused on my timekeeping rework, however I have
kept it in mind, and I do have a i386 vsyscall gtod patch that applies
ontop of my tod work. I've been maintaining it on the side while I focus
on the core code, but it is much cleaner now. For fun I'll try to
remember to send it out with the next release.

> On i386 it unfortunately needs adding
> a test and branch to the syscall path to be 100% ABI compatible, but I 
> doubt that was the reason he dropped it.

Yea, I didn't know enough about the VDSO/unwind bits to get it to do the
right thing w/ glibc, so that bit was pretty hackish. I'll still need
some help on this bit to make it really something that could be
included.

thanks
-john
