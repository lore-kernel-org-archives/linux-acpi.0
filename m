From: Suresh Siddha <suresh.b.siddha@intel.com>
Subject: Re: [PATCH -v2] x86, acpi: Handle xapic/x2apic entries in MADT at
 same time
Date: Fri, 28 Jan 2011 18:01:44 -0800
Message-ID: <1296266504.29747.70.camel@sbsiddha-MOBL3.sc.intel.com>
References: <4D423360.6080408@kernel.org>
Reply-To: Suresh Siddha <suresh.b.siddha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:57228 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754343Ab1A2CBf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Jan 2011 21:01:35 -0500
In-Reply-To: <4D423360.6080408@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: "Brown, Len" <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thu, 2011-01-27 at 19:09 -0800, Yinghai Lu wrote:
> One system have mixing xapic and x2apic entries in MADT and SRAT.
> BIOS guys insist that ACPI 4.0 SPEC said so, if apic id < 255, even
> the cpus are with x2apic mode pre-enabled, still need to use xapic entries
> instead of x2apic entries.

true. thats what the spec says.

> on 8 socket system with x2apic pre-enabled, will get out of order sequence:
> CPU0: socket0, core0, thread0.
> CPU1 - CPU 40: socket 4 - socket 7, thread 0
> CPU41 - CPU 80: socket 4 - socket 7, thread 1
> CPU81 - CPU 119: socket 0 - socket 3, thread 0
> CPU120 - CPU 159: socket 0 - socket 3, thread 1
> 
> so max_cpus=80 will not get all thread0 now.
> 
> Need to handle every entry in MADT at same time with xapic and x2apic.
> so we can honor sequence in MADT.

hmm few things.

So is your bios listing like this:

xapic entries for all thread-0
x2apic entries for all thread-0
xapic entries for all thread-1
x2apic entries for all thread-1

What happens if some other bios lists like:

all xapic entries
followed by all x2apic entries

or

all x2apic entries
followed by all x2apic entries

I am not sure if there is a strict recommendation by Intel bios writers
guide to list all thread-0 first followed by thread-1. Even if there is
a strict recommendation like that, I am sure there will be some bios's
that don't follow the rules.

Anyways two things.

a) I don't want to complicate the code too much and still doesn't get
the desired behavior when some bios has a different silly ordering.

b) Also perhaps we need to make it more explicit. Like instead of
relying on the "maxcpus=n/2" to boot all thread-0's, we should say it
more explicitly like perhaps nosmt or noht (we used to have this kind of
option before).  Or is it even worth to bother about this, given that we
can boot all the cpu's and offline the SMT siblings.


> We can use max_cpus= command line to use thread0 in every core,
> because recent MADT always have all thread0 at first.
> Also it could make the cpu to node mapping more sane.
> 
> after patch will get
> CPU0 - CPU 79: socket 0 - socket 7, thread 0
> CPU80 - CPU 159: socket 0 - socket 7, thread 1
> 
> -v2: update some comments, and change to pass array pointer.
> 

thanks,
suresh

