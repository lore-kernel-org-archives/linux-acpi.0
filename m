From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC][PATCH] Runtime switching of the idle function [take 2]
Date: Tue, 29 Nov 2005 07:44:20 +0100
Message-ID: <20051129064420.GA15374@elte.hu>
References: <20051118220755.GA3029@elte.hu> <1132353689.4735.43.camel@cmn3.stanford.edu> <1132367947.5706.11.camel@localhost.localdomain> <20051124150731.GD2717@elte.hu> <1132952191.24417.14.camel@localhost.localdomain> <20051126130548.GA6503@elte.hu> <1133232503.6328.18.camel@localhost.localdomain> <20051128190253.1b7068d6.akpm@osdl.org> <1133235740.6328.27.camel@localhost.localdomain> <20051128200108.068b2dcd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751296AbVK2Gom@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20051128200108.068b2dcd.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, acpi-devel@lists.sourceforge.net, len.brown@intel.com, nando@ccrma.Stanford.EDU, rlrevell@joe-job.com, linux-kernel@vger.kernel.org, paulmck@us.ibm.com, kr@cybsft.com, tglx@linutronix.de, pluto@agmk.net, john.cooper@timesys.com, bene@linutronix.de, dwalker@mvista.com, trini@kernel.crashing.org, george@mvista.com
List-Id: linux-acpi@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > The way to solve this was to set
> >  idle=poll.  The original patch I sent was to allow the user to change to
> >  idle=poll dynamically.  This way they could switch to the poll_idle and
> >  run there tests (requiring tsc not to drift) and then switch back to the
> >  default idle to save on electricity.
> 
> Use gettimeofday()?
> 
> If it's just for some sort of instrumentation, run NR_CPUS instances 
> of a niced-down busyloop, pin each one to a different CPU?  That way 
> the idle function doesn't get called at all..

idle=poll is also frequently done for performance reasons [it reduces 
idle wakeup latency by 10 usecs] - while it could be turned off if the 
system has been idle for some time. E.g. cpufreqd could sample idle time 
and turn on/off idle=poll. High-performance setups could enable it all 
the time.

as long as it can be done with zero-cost, i dont see why Steven's patch 
wouldnt be a plus for us. It's a performance thing, and having runtime 
switches for seemless performance features cannot be bad.

	Ingo
