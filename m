From: Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [4.17 regression] Performance drop on kernel-4.17 visible on
 Stream, Linpack and NAS parallel benchmarks
Date: Thu, 21 Jun 2018 10:23:32 +0100
Message-ID: <20180621092331.p2pmaiu6563kp5u2@techsingularity.net>
References: <20180614083640.dekqhsopoefnfhb4@techsingularity.net>
 <CAE4VaGCzB99es_TpAaYvtjX8fqzFA=7HX-ezqgO6FaEB5if4zg@mail.gmail.com>
 <20180615112522.3wujbq7bajof57qx@techsingularity.net>
 <CAE4VaGBtasbDBoZ-c5R-AY++Y1BXgjrE7DwN0zOt113xmV95xw@mail.gmail.com>
 <20180615135212.wq45co7ootvdeo2f@techsingularity.net>
 <CAE4VaGAdXNYXMUn4eQgMqQtLKfp6-YHMa1NUSpL-L078oX7C-w@mail.gmail.com>
 <CAE4VaGBeTpxd1phR4rVAjqOXuLgLWPtVMPoRSOcG3HXfWDF=8w@mail.gmail.com>
 <20180619151803.bu6pehdu6wbd6l5x@techsingularity.net>
 <CAE4VaGAPOfy0RtQehKoe+443C1GRrJXCveBFgcAZ1nChVavp1g@mail.gmail.com>
 <CAE4VaGBMeL82SJK53gtcWkor-9eXeLX6VP9juw=FW=BOyp+hMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAE4VaGBMeL82SJK53gtcWkor-9eXeLX6VP9juw=FW=BOyp+hMA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jirka Hladky <jhladky@redhat.com>
Cc: Jakub Racek <jracek@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, "kkolakow@redhat.com" <kkolakow@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 20, 2018 at 07:25:19PM +0200, Jirka Hladky wrote:
> Hi Mel and others,
> 
> I would like to let you know that I have tested following patch
> 

Understood. FWIW, there is a lot in flight at the moment but the first
likely patch is removing rate limiting entirely and see what falls out.
The rest of the experiment series deals with fast-scan-start, reset of
preferred_nid on cross-node load balancing and dealing with THP false
sharing but it's all preliminary and untested.

Furthermore, matters have been complicated by the posting of "Fixes for
sched/numa_balancing". My own testing indicates that this helped which
means that I need to review this first and then rebase anything else on
top of it.

I would also suggest you test that series paying particular attention to
whether it a) improves performance and b) how close it gets to the
revert in terms of overall performance.

-- 
Mel Gorman
SUSE Labs
