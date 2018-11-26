From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 4/7] node: Add memory caching attributes
Date: Mon, 26 Nov 2018 20:06:19 +0100
Message-ID: <20181126190619.GA32595@kroah.com>
References: <20181114224921.12123-2-keith.busch@intel.com>
 <20181114224921.12123-5-keith.busch@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181114224921.12123-5-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keith Busch <keith.busch@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Nov 14, 2018 at 03:49:17PM -0700, Keith Busch wrote:
> System memory may have side caches to help improve access speed. While
> the system provided cache is transparent to the software accessing
> these memory ranges, applications can optimize their own access based
> on cache attributes.
> 
> In preparation for such systems, provide a new API for the kernel to
> register these memory side caches under the memory node that provides it.
> 
> The kernel's sysfs representation is modeled from the cpu cacheinfo
> attributes, as seen from /sys/devices/system/cpu/cpuX/cache/. Unlike CPU
> cacheinfo, though, a higher node's memory cache level is nearer to the
> CPU, while lower levels are closer to the backing memory. Also unlike
> CPU cache, the system handles flushing any dirty cached memory to the
> last level the memory on a power failure if the range is persistent.
> 
> The exported attributes are the cache size, the line size, associativity,
> and write back policy.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/base/node.c  | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/node.h |  23 ++++++++++
>  2 files changed, 140 insertions(+)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 232535761998..bb94f1d18115 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -60,6 +60,12 @@ static DEVICE_ATTR(cpumap,  S_IRUGO, node_read_cpumask, NULL);
>  static DEVICE_ATTR(cpulist, S_IRUGO, node_read_cpulist, NULL);
>  
>  #ifdef CONFIG_HMEM
> +struct node_cache_obj {
> +	struct kobject kobj;
> +	struct list_head node;
> +	struct node_cache_attrs cache_attrs;
> +};

I know you all are off in the weeds designing some new crazy api for
this instead of this current proposal (sorry, I lost the thread, I'll
wait for the patches before commenting on it), but I do want to say one
thing here.

NEVER use a raw kobject as a child for a 'struct device' unless you
REALLY REALLY REALLY REALLY know what you are doing and have a VERY good
reason to do so.

Just use a 'struct device', otherwise you end up having to reinvent all
of the core logic that struct device provides you, like attribute
callbacks (which you had to create), and other good stuff like telling
userspace that a device has shown up so it knows to look at it.

That last one is key, a kobject is suddenly a "black hole" in sysfs as
far as userspace knows because it does not see them for the most part
(unless you are mucking around in the filesystem on your own, and
really, don't do that, use a library like the rest of the world unless
you really like reinventing everything, which, from your patchset it
feels like...)

Anyway, use 'struct device'.  That's all.

greg k-h
