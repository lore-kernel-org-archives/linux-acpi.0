From: Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] Runtime switching of the idle function [take 2]
Date: Mon, 28 Nov 2005 20:01:08 -0800
Message-ID: <20051128200108.068b2dcd.akpm@osdl.org>
References: <20051115090827.GA20411@elte.hu>
	<1132336954.20672.11.camel@cmn3.stanford.edu>
	<1132350882.6874.23.camel@mindpipe>
	<1132351533.4735.37.camel@cmn3.stanford.edu>
	<20051118220755.GA3029@elte.hu>
	<1132353689.4735.43.camel@cmn3.stanford.edu>
	<1132367947.5706.11.camel@localhost.localdomain>
	<20051124150731.GD2717@elte.hu>
	<1132952191.24417.14.camel@localhost.localdomain>
	<20051126130548.GA6503@elte.hu>
	<1133232503.6328.18.camel@localhost.localdomain>
	<20051128190253.1b7068d6.akpm@osdl.org>
	<1133235740.6328.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750707AbVK2ECK@vger.kernel.org>
In-Reply-To: <1133235740.6328.27.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mingo@elte.hu, acpi-devel@lists.sourceforge.net, len.brown@intel.com, nando@ccrma.Stanford.EDU, rlrevell@joe-job.com, linux-kernel@vger.kernel.org, paulmck@us.ibm.com, kr@cybsft.com, tglx@linutronix.de, pluto@agmk.net, john.cooper@timesys.com, bene@linutronix.de, dwalker@mvista.com, trini@kernel.crashing.org, george@mvista.com
List-Id: linux-acpi@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 2005-11-28 at 19:02 -0800, Andrew Morton wrote:
>  > Steven Rostedt <rostedt@goodmis.org> wrote:
>  > >
>  > > This patch creates a directory in /sys/kernel called idle.
>  > >
>  > 
>  > At no point do you appear to explain _why_ the kernel needs this feature?
> 
>  Sorry about that.  This originally came up when we had problems with the
>  AMD64 x2 in the -rt patch.  It was noted that the TSCs would get very
>  far out of sync and cause problems.

Unsynced TSCs are rare, but they happen.  I guess even if we were to resync
them, these measurements would screw up.


> The way to solve this was to set
>  idle=poll.  The original patch I sent was to allow the user to change to
>  idle=poll dynamically.  This way they could switch to the poll_idle and
>  run there tests (requiring tsc not to drift) and then switch back to the
>  default idle to save on electricity.

Use gettimeofday()?

If it's just for some sort of instrumentation, run NR_CPUS instances of a
niced-down busyloop, pin each one to a different CPU?  That way the idle
function doesn't get called at all..
