From: Jakub Racek <jracek@redhat.com>
Subject: [4.17 regression] Performance drop on kernel-4.17 visible on Stream,
 Linpack and NAS parallel benchmarks
Date: Wed, 6 Jun 2018 14:27:32 +0200
Message-ID: <20180606122731.GB27707@jra-laptop.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, jracek@redhat.com
List-Id: linux-acpi@vger.kernel.org

Hi,

There is a huge performance regression on the 2 and 4 NUMA node systems on stream 
benchmark with 4.17 kernel compared to 4.16 kernel. 
Stream, Linpack and NAS parallel benchmarks show upto 50% performance drop.

When running for example 20 stream processes in parallel, we see the following behavior:

* all processes are started at NODE #1
* memory is also allocated on NODE #1
* roughly half of the processes are moved to the NODE #0 very quickly. 
* however, memory is not moved to NODE #0 and stays allocated on NODE #1

As the result, half of the processes are running on NODE#0 with memory being still 
allocated on NODE#1. This leads to non-local memory accesses
on the high Remote-To-Local Memory Access Ratio on the numatop charts.  

So it seems that 4.17 is not doing a good job to move the memory to the right NUMA
node after the process has been moved.

----8<----

The above is an excerpt from performance testing on 4.16 and 4.17 kernels.

For now I'm merely making sure the problem is reported.

Thank you.

Best regards,
Jakub Racek
