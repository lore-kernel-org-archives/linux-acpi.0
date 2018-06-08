From: Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [4.17 regression] Performance drop on kernel-4.17 visible on
 Stream, Linpack and NAS parallel benchmarks
Date: Fri, 8 Jun 2018 12:15:05 +0100
Message-ID: <20180608111505.qlru36ycih6eltqc@techsingularity.net>
References: <20180606122731.GB27707@jra-laptop.brq.redhat.com>
 <20180607123915.avrqbpp4adgj7ck4@techsingularity.net>
 <CAE4VaGBAZ0HCy-M2rC3ce9ePOBhE6H-LDVBuJDJMNFf40j70Aw@mail.gmail.com>
 <20180608074057.jtxczsw3jwx6boti@techsingularity.net>
 <CAE4VaGAgC7vDwaa-9AzJYst9hdQ5KbnrBUnk_mfp=NeTEe5dAQ@mail.gmail.com>
 <20180608092451.mwzr6pvxh2cprzju@techsingularity.net>
 <CAE4VaGATk3_Hr_2Wh44BZvXDc06A=rxUZXRFj+D=Xwh2x1YOyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAE4VaGATk3_Hr_2Wh44BZvXDc06A=rxUZXRFj+D=Xwh2x1YOyg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jirka Hladky <jhladky@redhat.com>
Cc: Jakub Racek <jracek@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jun 08, 2018 at 01:02:54PM +0200, Jirka Hladky wrote:
> >
> > Unknown and unknowable. It depends entirely on the reference pattern of
> > the different threads. If they are fully parallelised with private buffers
> > that are page-aligned then I expect it to be quick (to pass the 2-reference
> > filter).
> 
> 
> I'm running 20 parallel processes. There is no connection between them. If
> I read it correctly the migration should happen fast in this case, right?
> 
> I have checked the source code and variables are global and static (and
> thus allocated in the data segment). They are NOT 4k aligned:
> 
> variable a is at address: 0x9e999e0
> variable b is at address: 0x524e5e0
> variable c is at address: 0x6031e0
> 
> static double a[N],
> b[N],
> c[N];
> 

If these are 20 completely indepent processes (and not sharing data via
MPI if you're using that version of STREAM) then the migration should be
relatively quick. Migrations should start within 3 seconds of the process
starting. How long it takes depends on the size of the STREAM processes
as it's only scanned in chunks and migrations won't start until there
are two full passes of the address space. You can partially monitor the
progress using /proc/pid/numa_maps. More detailed monitoring needs ftrace
for some activity and the use of probes on specific functions to get
detailed information.

It may also be worth examining /proc/pid/sched and seeing if a task
sets numa_preferred_nid to node 0 and keeps it there even after
migrating to node 1 but that's doubtful.

-- 
Mel Gorman
SUSE Labs
