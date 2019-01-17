From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCHv4 11/13] Documentation/ABI: Add node cache attributes
Date: Thu, 17 Jan 2019 17:25:30 +0100
Message-ID: <CAJZ5v0hYx_fG6UW+MXfLtdBAyWc_qi4A0h5xVTpTSAbo4ntz7g@mail.gmail.com>
References: <20190116175804.30196-1-keith.busch@intel.com> <20190116175804.30196-12-keith.busch@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190116175804.30196-12-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keith Busch <keith.busch@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 16, 2019 at 6:59 PM Keith Busch <keith.busch@intel.com> wrote:
>
> Add the attributes for the system memory side caches.

I really would combine this with the previous one.

> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  Documentation/ABI/stable/sysfs-devices-node | 34 +++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
> index 2217557f29d3..613d51fb52a3 100644
> --- a/Documentation/ABI/stable/sysfs-devices-node
> +++ b/Documentation/ABI/stable/sysfs-devices-node
> @@ -142,3 +142,37 @@ Contact:   Keith Busch <keith.busch@intel.com>
>  Description:
>                 This node's write latency in nanoseconds available to memory
>                 initiators in nodes found in this class's initiators_nodelist.
> +
> +What:          /sys/devices/system/node/nodeX/side_cache/indexY/associativity
> +Date:          December 2018
> +Contact:       Keith Busch <keith.busch@intel.com>
> +Description:
> +               The caches associativity: 0 for direct mapped, non-zero if
> +               indexed.
> +
> +What:          /sys/devices/system/node/nodeX/side_cache/indexY/level
> +Date:          December 2018
> +Contact:       Keith Busch <keith.busch@intel.com>
> +Description:
> +               This cache's level in the memory hierarchy. Matches 'Y' in the
> +               directory name.
> +
> +What:          /sys/devices/system/node/nodeX/side_cache/indexY/line_size
> +Date:          December 2018
> +Contact:       Keith Busch <keith.busch@intel.com>
> +Description:
> +               The number of bytes accessed from the next cache level on a
> +               cache miss.
> +
> +What:          /sys/devices/system/node/nodeX/side_cache/indexY/size
> +Date:          December 2018
> +Contact:       Keith Busch <keith.busch@intel.com>
> +Description:
> +               The size of this memory side cache in bytes.
> +
> +What:          /sys/devices/system/node/nodeX/side_cache/indexY/write_policy
> +Date:          December 2018
> +Contact:       Keith Busch <keith.busch@intel.com>
> +Description:
> +               The cache write policy: 0 for write-back, 1 for write-through,
> +               2 for other or unknown.
> --

It would be good to document the meaning of indexY itself too.
