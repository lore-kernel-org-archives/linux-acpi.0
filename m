From: Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH] Runtime switching of the idle function [take 2]
Date: 29 Nov 2005 11:05:21 -0700
Message-ID: <p73mzjngwim.fsf@verdi.suse.de>
References: <20051118220755.GA3029@elte.hu>
	<1132353689.4735.43.camel@cmn3.stanford.edu>
	<1132367947.5706.11.camel@localhost.localdomain>
	<20051124150731.GD2717@elte.hu>
	<1132952191.24417.14.camel@localhost.localdomain>
	<20051126130548.GA6503@elte.hu>
	<1133232503.6328.18.camel@localhost.localdomain>
	<20051128190253.1b7068d6.akpm@osdl.org>
	<1133235740.6328.27.camel@localhost.localdomain>
	<20051128200108.068b2dcd.akpm@osdl.org>
	<20051129064420.GA15374@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751178AbVK2Nhk@vger.kernel.org>
In-Reply-To: <20051129064420.GA15374@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, acpi-devel@lists.sourceforge.net, len.brown@intel.com, nando@ccrma.Stanford.EDU, rlrevell@joe-job.com, linux-kernel@vger.kernel.org, paulmck@us.ibm.com, kr@cybsft.com, tglx@linutronix.de, pluto@agmk.net, john.cooper@timesys.com, bene@linutronix.de, dwalker@mvista.com, trini@kernel.crashing.org, george@mvista.com, akpm@osdl.org
List-Id: linux-acpi@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > > The way to solve this was to set
> > >  idle=poll.  The original patch I sent was to allow the user to change to
> > >  idle=poll dynamically.  This way they could switch to the poll_idle and
> > >  run there tests (requiring tsc not to drift) and then switch back to the
> > >  default idle to save on electricity.
> > 
> > Use gettimeofday()?
> > 
> > If it's just for some sort of instrumentation, run NR_CPUS instances 
> > of a niced-down busyloop, pin each one to a different CPU?  That way 
> > the idle function doesn't get called at all..
> 
> idle=poll is also frequently done for performance reasons [it reduces 
> idle wakeup latency by 10 usecs] 

And it's obsolete on CPUs with monitor/mwait.
And in practice the CPU will run so hot that only benchmarkers like it.

I think switching idle is the wrong way to do. We should rather
fix the various problems.

For fixing the TSC issue it is 100% the wrong approach Imho.
Basically software has to live with TSCs being unsynchronized
and gettimeofday should do the right thing (and if not it should be fixed)

- while it could be turned off if the 
> system has been idle for some time. E.g. cpufreqd could sample idle time 
> and turn on/off idle=poll. High-performance setups could enable it all 
> the time.

And upgrade their server air condition or issue additional ear protection
to the desktop user? Most likely you will just drive the CPUs into
thermal throttle at some point with that, not get more performance anyways.
  
> as long as it can be done with zero-cost, i dont see why Steven's patch 
> wouldnt be a plus for us. It's a performance thing, and having runtime 
> switches for seemless performance features cannot be bad.

The interface is ugly and I suspect fixing the various obscure race this
obscure feature would undoubtedly add will be a long term maintenance
issue. And it's the wrong thing to do anyways because it just papers
over other problems that should be fixed in the right way.

-Andi
