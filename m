From: Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH] Runtime switching of the idle function [take 2]
Date: Fri, 2 Dec 2005 02:45:12 +0100
Message-ID: <20051202014512.GH997@wotan.suse.de>
References: <20051124150731.GD2717@elte.hu> <1132952191.24417.14.camel@localhost.localdomain> <20051126130548.GA6503@elte.hu> <1133232503.6328.18.camel@localhost.localdomain> <20051128190253.1b7068d6.akpm@osdl.org> <1133235740.6328.27.camel@localhost.localdomain> <20051128200108.068b2dcd.akpm@osdl.org> <20051129064420.GA15374@elte.hu> <p73mzjngwim.fsf@verdi.suse.de> <438FA2E4.80705@qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964772AbVLBBpl@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <438FA2E4.80705@qualcomm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>, acpi-devel@lists.sourceforge.net, len.brown@intel.com, nando@ccrma.stanford.edu, rlrevell@joe-job.com, linux-kernel@vger.kernel.org, paulmck@us.ibm.com, kr@cybsft.com, tglx@linutronix.de, pluto@agmk.net, john.cooper@timesys.com, bene@linutronix.de, dwalker@mvista.com, trini@kernel.crashing.org, george@mvista.com, akpm@osdl.org
List-Id: linux-acpi@vger.kernel.org

> Also IMO saying that CPU will run too hot with idle=poll is basically 
> saying that those
> CPUs cannot be used for simulations and stuff which run flat out for days 
> (months actually).
> Which is obviously not true (again speaking from experience :)).

The CPUs can be used, but many cooling setups
(both AirCon in complete data centers, cooling in Blade Racks, laptops)  
the cooling is now often designed to not cool
the maximum thermal output of all systems in parallel, but instead
throttle the systems when things get too hot. This usually
works because in most workloads systems are more often idle
than busy, so no throttling is needed.

On desktops it probably won't throttle, but just become noisy
when all the fans spin up.

All things you don't really want.

Super computing is different of course, but even there maximum
capacity of the air condition often limits how many CPUs you can buy.
And you need all the help you can get.

That said you're right that there is still a small niche 
where idle=poll makes sense, but it's definitely nothing
that should be encouraged to be used regularly like that
original patch would.

-Andi
