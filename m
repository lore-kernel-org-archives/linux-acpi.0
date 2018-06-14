From: Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [4.17 regression] Performance drop on kernel-4.17 visible on
 Stream, Linpack and NAS parallel benchmarks
Date: Thu, 14 Jun 2018 09:36:40 +0100
Message-ID: <20180614083640.dekqhsopoefnfhb4@techsingularity.net>
References: <CAE4VaGBRFBM-uZEE=DdUzQkcNmpnUHdjK-7hgEeywmG8bvOOgw@mail.gmail.com>
 <20180611141113.pfuttg7npch3jtg6@techsingularity.net>
 <CAE4VaGCMS2pXfPVSnMbudexv_m5wRCTuBKA5ijh2x==11uQg9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAE4VaGCMS2pXfPVSnMbudexv_m5wRCTuBKA5ijh2x==11uQg9g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jirka Hladky <jhladky@redhat.com>
Cc: Jakub Racek <jracek@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, "kkolakow@redhat.com" <kkolakow@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jun 11, 2018 at 06:07:58PM +0200, Jirka Hladky wrote:
> >
> > Fixing any part of it for STREAM will end up regressing something else.
> 
> 
> I fully understand that. We run a set of benchmarks and we always look at
> the results as the ensemble. Looking only at one benchmark would be
> completely wrong.
> 

Indeed

> And in fact, we do see regression on NAS benchmark going from 4.16 to 4.17
> kernel as well. On 4 NUMA node server with Xeon Gold CPUs we see the
> regression around 26% for ft_C,   35% for mg_C_x and 25% for sp_C_x. The
> biggest regression is with 32 threads (the box has 96 CPUs in total). I
> have not yet tried if it's
> linked to 2c83362734dad8e48ccc0710b5cd2436a0323893. I will do that
> testing tomorrow.
> 

It would be worthwhile. However, it's also worth noting that 32 threads
out of 96 implies that 4 nodes would not be evenly used and it may
account for some of the discrepency. ft and mg for C class are typically
short-lived on modern hardware and sp is not particularly long-lived
either. Hence, they are most likely to see problems with a patch that
avoids spreading tasks across the machine early. Admittedly, I have not
seen similar slowdowns but NAS has a lot of configuration options.

In terms of the speed of migration, it may be worth checking how often the
mm_numa_migrate_ratelimit tracepoint is triggered with bonus points for using
the nr_pages to calculate how many pages get throttled from migrating. If
it's high frequency then you could test increasing ratelimit_pages (which
is set at compile time despite not being a macro). It still may not work
for tasks that are too short-lived to have enough time to identify a
misplacement and migration.

-- 
Mel Gorman
SUSE Labs
