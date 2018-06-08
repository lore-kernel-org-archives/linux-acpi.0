From: Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [4.17 regression] Performance drop on kernel-4.17 visible on
 Stream, Linpack and NAS parallel benchmarks
Date: Fri, 8 Jun 2018 08:40:57 +0100
Message-ID: <20180608074057.jtxczsw3jwx6boti@techsingularity.net>
References: <20180606122731.GB27707@jra-laptop.brq.redhat.com>
 <20180607123915.avrqbpp4adgj7ck4@techsingularity.net>
 <CAE4VaGBAZ0HCy-M2rC3ce9ePOBhE6H-LDVBuJDJMNFf40j70Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAE4VaGBAZ0HCy-M2rC3ce9ePOBhE6H-LDVBuJDJMNFf40j70Aw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jirka Hladky <jhladky@redhat.com>
Cc: Jakub Racek <jracek@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jun 08, 2018 at 07:49:37AM +0200, Jirka Hladky wrote:
> Hi Mel,
> 
> we will do the bisection today and report the results back.
> 

The most likely outcome is 2c83362734dad8e48ccc0710b5cd2436a0323893
which is a patch that restricts newly forked processes from selecting a
remote node when the local node is similarly loaded. The upside is that
an almost idle node will not queue that task on a remote node. The
downside is that there are cases that the newly forked task allocates a
lot of memory and then the idle balancer spreads it anyway. It'll be a
classic case of "win some, lose some".

That would match this pattern

> > > * all processes are started at NODE #1

So at fork time, the local node is almost idle and is used

> > > * memory is also allocated on NODE #1

Early in the lifetime of the task

> > > * roughly half of the processes are moved to the NODE #0 very quickly. *

Idle balancer kicks in

> > > however, memory is not moved to NODE #0 and stays allocated on NODE #1
> > >

automatic NUMA balancing doesn't run long enough to migrate all the
memory. That would definitely be the case for STREAM. It's less clear
for NAS where, depending on the parallelisation, wake_affine can keep a
task away from its memory or it's cross-node migrating a lot. As before,
I've no idea about linpack.

-- 
Mel Gorman
SUSE Labs
