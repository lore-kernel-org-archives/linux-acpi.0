From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [RFC][PATCH] Runtime switching of the idle function [take 2]
Date: Thu, 01 Dec 2005 17:27:00 -0800
Message-ID: <438FA2E4.80705@qualcomm.com>
References: <20051118220755.GA3029@elte.hu>	<1132353689.4735.43.camel@cmn3.stanford.edu>	<1132367947.5706.11.camel@localhost.localdomain>	<20051124150731.GD2717@elte.hu>	<1132952191.24417.14.camel@localhost.localdomain>	<20051126130548.GA6503@elte.hu>	<1133232503.6328.18.camel@localhost.localdomain>	<20051128190253.1b7068d6.akpm@osdl.org>	<1133235740.6328.27.camel@localhost.localdomain>	<20051128200108.068b2dcd.akpm@osdl.org>	<20051129064420.GA15374@elte.hu> <p73mzjngwim.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932709AbVLBB21@vger.kernel.org>
In-Reply-To: <p73mzjngwim.fsf@verdi.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>, acpi-devel@lists.sourceforge.net, len.brown@intel.com, nando@ccrma.stanford.edu, rlrevell@joe-job.com, linux-kernel@vger.kernel.org, paulmck@us.ibm.com, kr@cybsft.com, tglx@linutronix.de, pluto@agmk.net, john.cooper@timesys.com, bene@linutronix.de, dwalker@mvista.com, trini@kernel.crashing.org, george@mvista.com, akpm@osdl.org
List-Id: linux-acpi@vger.kernel.org

Andi Kleen wrote:
> Ingo Molnar <mingo@elte.hu> writes:
>>> If it's just for some sort of instrumentation, run NR_CPUS instances 
>>> of a niced-down busyloop, pin each one to a different CPU?  That way 
>>> the idle function doesn't get called at all..
>> idle=poll is also frequently done for performance reasons [it reduces 
>> idle wakeup latency by 10 usecs] 
> 
> And it's obsolete on CPUs with monitor/mwait.
There are some platforms for example IBM ZPro Xeon based machines where
monitor/mwait seems to trigger some kind of SMM and introduce horrible latencies.
With idle=poll ZPros show pretty good worst case latencies, in the order of 10usec
(tested with RTAI/Fusion). With default idle (ie mwait) even average latency is in
hundreds of milliseconds.
You might argue that it's a bug in the their HW design or something but as it stands
today I wouldn't say that monitor/mwait obsoletes idle=poll.

Also IMO saying that CPU will run too hot with idle=poll is basically saying that those
CPUs cannot be used for simulations and stuff which run flat out for days (months actually).
Which is obviously not true (again speaking from experience :)).

Max
