From: Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [4.17 regression] Performance drop on kernel-4.17 visible on
 Stream, Linpack and NAS parallel benchmarks
Date: Thu, 7 Jun 2018 13:39:15 +0100
Message-ID: <20180607123915.avrqbpp4adgj7ck4@techsingularity.net>
References: <20180606122731.GB27707@jra-laptop.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180606122731.GB27707@jra-laptop.brq.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jakub Racek <jracek@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 06, 2018 at 02:27:32PM +0200, Jakub Racek wrote:
> There is a huge performance regression on the 2 and 4 NUMA node systems on
> stream benchmark with 4.17 kernel compared to 4.16 kernel. Stream, Linpack
> and NAS parallel benchmarks show upto 50% performance drop.
> 

I have not observed this yet but NAS is the only one I'll see and that could
be a week or more away before I have data. I'll keep an eye out at least.

> When running for example 20 stream processes in parallel, we see the following behavior:
> 
> * all processes are started at NODE #1
> * memory is also allocated on NODE #1
> * roughly half of the processes are moved to the NODE #0 very quickly. *
> however, memory is not moved to NODE #0 and stays allocated on NODE #1
> 

Ok, 20 processes getting rescheduled to another node is not unreasonable
from a load-balancing perspective but memory locality is not always taken
into account. You also don't state what parallelisation method you used
for STREAM and it's relevant because of how tasks end up communicating
and what that means for placement.

The only automatic NUMA balancing patch I can think of that has a high
chance of being a factor is 7347fc87dfe6b7315e74310ee1243dc222c68086
but I cannot see how STREAM would be affected as I severely doubt
the processes are communicating heavily (unless openmp and then it's
a maybe). It might affect NAS because that does a lot of wakeups
via futex that has "interesting" characteristics (either openmp or
openmpi). 082f764a2f3f2968afa1a0b04a1ccb1b70633844 might also be a factor
but it's doubtful. I don't know about Linpack as I've never characterised
it so I don't know how it behaves.

There are a few patches that affect utilisation calculation which might
affect the load balancer but I can't pinpoint a single likely candidate.

Given that STREAM is usually short-lived, is bisection an option?

-- 
Mel Gorman
SUSE Labs
