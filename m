From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [4.17 regression] Performance drop on kernel-4.17 visible on
 Stream, Linpack and NAS parallel benchmarks
Date: Wed, 6 Jun 2018 14:34:32 +0200
Message-ID: <CAJZ5v0hTTe9zYwYKtoQKjJJbazFeaGVO2SdbaODyvTFiNpGTdw@mail.gmail.com>
References: <20180606122731.GB27707@jra-laptop.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606122731.GB27707@jra-laptop.brq.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jakub Racek <jracek@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 6, 2018 at 2:27 PM, Jakub Racek <jracek@redhat.com> wrote:
> Hi,
>
> There is a huge performance regression on the 2 and 4 NUMA node systems on
> stream benchmark with 4.17 kernel compared to 4.16 kernel. Stream, Linpack
> and NAS parallel benchmarks show upto 50% performance drop.
>
> When running for example 20 stream processes in parallel, we see the
> following behavior:
>
> * all processes are started at NODE #1
> * memory is also allocated on NODE #1
> * roughly half of the processes are moved to the NODE #0 very quickly. *
> however, memory is not moved to NODE #0 and stays allocated on NODE #1
>
> As the result, half of the processes are running on NODE#0 with memory being
> still allocated on NODE#1. This leads to non-local memory accesses
> on the high Remote-To-Local Memory Access Ratio on the numatop charts.
> So it seems that 4.17 is not doing a good job to move the memory to the
> right NUMA
> node after the process has been moved.
>
> ----8<----
>
> The above is an excerpt from performance testing on 4.16 and 4.17 kernels.
>
> For now I'm merely making sure the problem is reported.

OK, and why do you think that it is related to ACPI?

Thanks,
Rafael
