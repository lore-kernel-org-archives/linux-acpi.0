From: Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [4.17 regression] Performance drop on kernel-4.17 visible on
 Stream, Linpack and NAS parallel benchmarks
Date: Mon, 11 Jun 2018 15:11:13 +0100
Message-ID: <20180611141113.pfuttg7npch3jtg6@techsingularity.net>
References: <CAE4VaGBRFBM-uZEE=DdUzQkcNmpnUHdjK-7hgEeywmG8bvOOgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAE4VaGBRFBM-uZEE=DdUzQkcNmpnUHdjK-7hgEeywmG8bvOOgw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jirka Hladky <jhladky@redhat.com>
Cc: Jakub Racek <jracek@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, "kkolakow@redhat.com" <kkolakow@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jun 11, 2018 at 12:04:34PM +0200, Jirka Hladky wrote:
> Hi Mel,
> 
> your suggestion about the commit which has caused the regression was right
> - it's indeed this commit:
> 
> 2c83362734dad8e48ccc0710b5cd2436a0323893
> 
> The question now is what can be done to improve the results. I have made
> stream to run longer and I see that data are moved very slowly from NODE#1
> to NODE#0.
> 

Ok, this is somewhat expected although I suspect the scan rate slowed a lot
in the early phase of the program and that's why the migration is slow --
slow scan means fewer samples and takes longer to reach the 2-pass filter.

> The process has started on NODE#1 where all memory has been allocated.
> Right after the start, the process has been moved to NODE#0 but only part
> of the memory has been moved to that node. numa_preferred_nid has stayed 1
> for 30 seconds. The numa_preferred_nid has changed to 0 at
> 2018-Jun-09_03h35m58s and most of the memory has been finally reallocated.
> See the logs below.
> 
> Could we try to make numa_preferred_nid to change faster?
> 

What catches us is that each element in itself makes sense, it's just not a
universal win. The identified patch makes a reasonable choice in that fork
shouldn't necessary spread across the machine as it hurts short-lived
or communicating processes. Unfortunately, if a load is NUMA-aware
and the processes are independent then automatic NUMA balancing has to
take action which means there is a period of time where performance is
sub-optimal. Similarly, the load balancer is making a reasonable decision
when a socket gets overloaded. Fixing any part of it for STREAM will end
up regressing something else.

The numa_preferred_nid can probably be changed faster by adjusting the scan
rate. Unfortunately, it comes with the penalty that system CPU overhead
will be higher and stalls in the process increase to handle the PTE updates
and the subsequent faults. This might help STREAM but anything that is
latency sensitive will be hurt. Worse, if a socket is over-saturated and
there is a high frequency of cross-node migrations to load balance then
the scan rate might always stay at the max frequency and a very high cost
incurred so we end up with another class of regression.

Srikar Dronamra did have a series with two patches that increase the scan
rate when there is a cross-node migration. It may be the case that it
also has the impact of changing numa_preferred_nid faster but it has a
real risk of introducing regressions. Still, for the purposes of testing
you might be interested in testing the following two patches?

Srikar Dronamra [PATCH 17/19] sched/numa: Pass destination cpu as a parameter to migrate_task_rq
Srikar Dronamra [PATCH 18/19] sched/numa: Reset scan rate whenever task moves across nodes

-- 
Mel Gorman
SUSE Labs
