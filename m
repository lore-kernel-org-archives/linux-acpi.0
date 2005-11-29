From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [RFC][PATCH] Runtime switching of the idle function [take 2]
Date: Tue, 29 Nov 2005 15:35:39 -0500
Message-ID: <1133296540.4627.7.camel@mindpipe>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005456F00@hdsmsx401.amr.corp.intel.com>
	 <20051129195336.GP19515@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932381AbVK2Ufs@vger.kernel.org>
In-Reply-To: <20051129195336.GP19515@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: "Brown, Len" <len.brown@intel.com>, Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net, nando@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org, paulmck@us.ibm.com, kr@cybsft.com, tglx@linutronix.de, pluto@agmk.net, john.cooper@timesys.com, bene@linutronix.de, dwalker@mvista.com, trini@kernel.crashing.org, george@mvista.com
List-Id: linux-acpi@vger.kernel.org

On Tue, 2005-11-29 at 20:53 +0100, Andi Kleen wrote:
> We're mostly addressing it - there are problems left, but
> overall it's looking good. The remaining problem is 
> an education issue of users to not use RDTSC directly, 
> but use gettimeofday/clock_gettime 

No the issue is to make gettimeofday fast enough that the people who
currently have to use the TSC can use it.  Right now it's 1500-3000 nsec
or so, Vojtech mentioned that he has a patch that could reduce that to
150-300 nsec.

Lee
