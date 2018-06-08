From: Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [4.17 regression] Performance drop on kernel-4.17 visible on
 Stream, Linpack and NAS parallel benchmarks
Date: Fri, 8 Jun 2018 10:24:51 +0100
Message-ID: <20180608092451.mwzr6pvxh2cprzju@techsingularity.net>
References: <20180606122731.GB27707@jra-laptop.brq.redhat.com>
 <20180607123915.avrqbpp4adgj7ck4@techsingularity.net>
 <CAE4VaGBAZ0HCy-M2rC3ce9ePOBhE6H-LDVBuJDJMNFf40j70Aw@mail.gmail.com>
 <20180608074057.jtxczsw3jwx6boti@techsingularity.net>
 <CAE4VaGAgC7vDwaa-9AzJYst9hdQ5KbnrBUnk_mfp=NeTEe5dAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAE4VaGAgC7vDwaa-9AzJYst9hdQ5KbnrBUnk_mfp=NeTEe5dAQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jirka Hladky <jhladky@redhat.com>
Cc: Jakub Racek <jracek@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jun 08, 2018 at 10:49:03AM +0200, Jirka Hladky wrote:
> Hi Mel,
> 
> automatic NUMA balancing doesn't run long enough to migrate all the
> > memory. That would definitely be the case for STREAM.
> 
> This could explain the behavior we observe. stream is running ~20 seconds
> at the moment. I can easily change the runtime by changing the number of
> iterations. What is the time period when you expect the memory to be fully
> migrated?
> 

Unknown and unknowable. It depends entirely on the reference pattern of
the different threads. If they are fully parallelised with private buffers
that are page-aligned then I expect it to be quick (to pass the 2-reference
filter). If threads are sharing data on a 4K (base page case) or 2M boundary
(THP enabled) then it may take longer as two or more threads will disagree
on what the appropriate placement for a page is.

> I have now checked numastat logs and after 15 seconds I see roughly 80MiB
> out of 200MiB of the allocated memory migrated for each of 10 processes
> which have changed the NUMA CPU node after started. This is on 2
> socket Gold 6126 CPU @ 2.60GHz server with DDR4 2666 MHz. That's 800 MiB of
> memory migrated in 15 seconds which is results in the average migration
> rate of 50MiB/s - is this an expected value?
> 

I expect that to be far short of the capabilities of the machine.
Again, migrations can be delayed indefinitely if threads have buffers
that are not page-aligned (4K or 2M depending).

-- 
Mel Gorman
SUSE Labs
