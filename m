From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/5] x86/smpboot: Add the missing description of
 possible_cpus
Date: Wed, 21 Mar 2018 10:41:21 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1803211039170.3754@nanos.tec.linutronix.de>
References: <20180320110432.28127-1-douly.fnst@cn.fujitsu.com> <20180320110432.28127-2-douly.fnst@cn.fujitsu.com> <20180320123712.GR4043@hirez.programming.kicks-ass.net> <f64cb207-3851-9a26-2001-653fc0068540@cn.fujitsu.com>
 <20180321090826.GW4043@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180321090826.GW4043@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, mingo@redhat.com, corbet@lwn.net, rjw@rjwysocki.net, lenb@kernel.org, hpa@zytor.com
List-Id: linux-acpi@vger.kernel.org

On Wed, 21 Mar 2018, Peter Zijlstra wrote:
> On Wed, Mar 21, 2018 at 01:33:24PM +0800, Dou Liyang wrote:
> > How about:
> > 
> > possible_cpus=	[s390,x86_64] Set the number of possible CPUs which
> > 		are determined by the ACPI tables MADT or mptables by
> > 		default. possible_cpus=n : n >= 1 enforces the possible
> > 		number to be 'n'.
> > 		While nr_cpus is also be set: nr_cpus=m, choice the
> > 		minimum one for the number of possible CPUs.
> 
> So what is the exact difference between possible_cpus and nr_cpus ? I
> konw maxcpus= limits the number of CPUs we bring up, and possible_cpus
> limits the possible_map, but I'm not entirely sure what nr_cpus does
> here.

nr_cpus limits the number of CPUs the kernel will handle. Think of it as a
boot time override of NR_CPUs.

Way too many commandline switches though.

Thanks,

	tglx
