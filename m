From: Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [4.17 regression] Performance drop on kernel-4.17 visible on
 Stream, Linpack and NAS parallel benchmarks
Date: Fri, 15 Jun 2018 14:52:12 +0100
Message-ID: <20180615135212.wq45co7ootvdeo2f@techsingularity.net>
References: <CAE4VaGBRFBM-uZEE=DdUzQkcNmpnUHdjK-7hgEeywmG8bvOOgw@mail.gmail.com>
 <20180611141113.pfuttg7npch3jtg6@techsingularity.net>
 <CAE4VaGCMS2pXfPVSnMbudexv_m5wRCTuBKA5ijh2x==11uQg9g@mail.gmail.com>
 <20180614083640.dekqhsopoefnfhb4@techsingularity.net>
 <CAE4VaGCzB99es_TpAaYvtjX8fqzFA=7HX-ezqgO6FaEB5if4zg@mail.gmail.com>
 <20180615112522.3wujbq7bajof57qx@techsingularity.net>
 <CAE4VaGBtasbDBoZ-c5R-AY++Y1BXgjrE7DwN0zOt113xmV95xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAE4VaGBtasbDBoZ-c5R-AY++Y1BXgjrE7DwN0zOt113xmV95xw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jirka Hladky <jhladky@redhat.com>
Cc: Jakub Racek <jracek@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, "kkolakow@redhat.com" <kkolakow@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jun 15, 2018 at 02:23:17PM +0200, Jirka Hladky wrote:
> I added configurations that used half of the CPUs. However, that would
> > mean it fits too nicely within sockets. I've added another set for one
> > third of the CPUs and scheduled the tests. Unfortunately, they will not
> > complete quickly as my test grid has a massive backlog of work.
> 
> 
> We always use the number of threads being an integer multiple of the number
> of sockets.  With another number of threads, we have seen the bigger
> variation in results (that's variation between subsequent runs of the same
> test).
> 

It's not immediately obvious what's special about those numbers. I did
briefly recheck the variability of NAS on one of the machines but the
coefficient of variance was usually quite low with occasional outliers
of +/- 5% or +/- 7%. Anyway, it's a side-issue.

>  Nice one, thanks. It's fairly clear that rate limiting may be a major
> > component and it's worth testing with the ratelimit increased. Given that
> > there have been a lot of improvements on locality and corner cases since
> > the rate limit was first introduced, it may also be worth considering
> > elimintating the rate limiting entirely and see what falls out.
> 
> 
> How can we tune mm_numa_migrate_ratelimit? It doesn't seem to be a runtime
> tunable nor kernel boot parameter. Could you please share some hints on how
> to change it and what value to use? I would be interested to try it out.
> 

It's not runtime tunable I'm afraid. It's a code change and recompile.
For example the following allows more pages to be migrated within a
100ms window.

diff --git a/mm/migrate.c b/mm/migrate.c
index 8c0af0f7cab1..edb550493f06 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1862,7 +1862,7 @@ static struct page *alloc_misplaced_dst_page(struct page *page,
  * window of time. Default here says do not migrate more than 1280M per second.
  */
 static unsigned int migrate_interval_millisecs __read_mostly = 100;
-static unsigned int ratelimit_pages __read_mostly = 128 << (20 - PAGE_SHIFT);
+static unsigned int ratelimit_pages __read_mostly = 512 << (20 - PAGE_SHIFT);
 
 /* Returns true if the node is migrate rate-limited after the update */
 static bool numamigrate_update_ratelimit(pg_data_t *pgdat,

-- 
Mel Gorman
SUSE Labs
