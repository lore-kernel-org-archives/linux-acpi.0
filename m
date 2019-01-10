From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCHv3 07/13] node: Add heterogenous memory access attributes
Date: Thu, 10 Jan 2019 18:07:02 +0530
Message-ID: <87y37sit8x.fsf@linux.ibm.com>
References: <20190109174341.19818-1-keith.busch@intel.com> <20190109174341.19818-8-keith.busch@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109174341.19818-8-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>, Keith Busch <keith.busch@intel.com>
List-Id: linux-acpi@vger.kernel.org

Keith Busch <keith.busch@intel.com> writes:

> Heterogeneous memory systems provide memory nodes with different latency
> and bandwidth performance attributes. Provide a new kernel interface for
> subsystems to register the attributes under the memory target node's
> initiator access class. If the system provides this information, applications
> may query these attributes when deciding which node to request memory.
>
> The following example shows the new sysfs hierarchy for a node exporting
> performance attributes:
>
>   # tree -P "read*|write*" /sys/devices/system/node/nodeY/classZ/
>   /sys/devices/system/node/nodeY/classZ/
>   |-- read_bandwidth
>   |-- read_latency
>   |-- write_bandwidth
>   `-- write_latency
>
> The bandwidth is exported as MB/s and latency is reported in nanoseconds.
> Memory accesses from an initiator node that is not one of the memory's
> class "Z" initiator nodes may encounter different performance than
> reported here. When a subsystem makes use of this interface, initiators
> of a lower class number, "Z", have better performance relative to higher
> class numbers. When provided, class 0 is the highest performing access
> class.

How does the definition of performance relate to bandwidth and latency here?. The
initiator in this class has the least latency and high bandwidth? Can there
be a scenario where both are not best for the same node? ie, for a
target Node Y, initiator Node A gives the highest bandwidth but initiator
Node B gets the least latency. How such a config can be represented? Or is
that not possible?

-aneesh
