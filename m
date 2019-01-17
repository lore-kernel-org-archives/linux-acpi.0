From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCHv4 08/13] Documentation/ABI: Add node performance attributes
Date: Thu, 17 Jan 2019 16:09:32 +0100
Message-ID: <CAJZ5v0iV8qt3_1BP_4fPN77CC7yLXT4QMW=q+jWdts+e5rf8dg@mail.gmail.com>
References: <20190116175804.30196-1-keith.busch@intel.com> <20190116175804.30196-9-keith.busch@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190116175804.30196-9-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keith Busch <keith.busch@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 16, 2019 at 6:59 PM Keith Busch <keith.busch@intel.com> wrote:
>
> Add descriptions for memory class initiator performance access attributes.

Again, I would combine this with the previous patch.

> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  Documentation/ABI/stable/sysfs-devices-node | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
> index a9c47b4b0eee..2217557f29d3 100644
> --- a/Documentation/ABI/stable/sysfs-devices-node
> +++ b/Documentation/ABI/stable/sysfs-devices-node
> @@ -114,3 +114,31 @@ Description:
>                 The node list of memory targets that this initiator node has
>                 class "Y" access. Memory accesses from this node to nodes not
>                 in this list may have differet performance.
> +
> +What:          /sys/devices/system/node/nodeX/classY/read_bandwidth
> +Date:          December 2018
> +Contact:       Keith Busch <keith.busch@intel.com>
> +Description:
> +               This node's read bandwidth in MB/s available to memory
> +               initiators in nodes found in this class's initiators_nodelist.
> +
> +What:          /sys/devices/system/node/nodeX/classY/read_latency
> +Date:          December 2018
> +Contact:       Keith Busch <keith.busch@intel.com>
> +Description:
> +               This node's read latency in nanoseconds available to memory
> +               initiators in nodes found in this class's initiators_nodelist.

I'm not sure if the term "read latency" is sufficient here.  Is this
the latency between sending a request and getting a response or
between sending the request and when the data actually becomes
available?

Moreover, is it the worst-case latency or the average latency?

> +
> +What:          /sys/devices/system/node/nodeX/classY/write_bandwidth
> +Date:          December 2018
> +Contact:       Keith Busch <keith.busch@intel.com>
> +Description:
> +               This node's write bandwidth in MB/s available to memory
> +               initiators in nodes found in this class's initiators_nodelist.
> +
> +What:          /sys/devices/system/node/nodeX/classY/write_latency
> +Date:          December 2018
> +Contact:       Keith Busch <keith.busch@intel.com>
> +Description:
> +               This node's write latency in nanoseconds available to memory
> +               initiators in nodes found in this class's initiators_nodelist.
> --

Same questions as for the read latency apply here.
