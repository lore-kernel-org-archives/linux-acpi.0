From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 01/21] acpi: Print Hot-Pluggable Field in SRAT.
Date: Tue, 23 Jul 2013 14:48:43 -0400
Message-ID: <20130723184843.GG21100@mtj.dyndns.org>
References: <1374220774-29974-1-git-send-email-tangchen@cn.fujitsu.com>
 <1374220774-29974-2-git-send-email-tangchen@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1374220774-29974-2-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-doc-owner@vger.kernel.org
To: Tang Chen <tangchen@cn.fujitsu.com>
Cc: tglx@linutronix.de, mingo@elte.hu, hpa@zytor.com, akpm@linux-foundation.org, trenn@suse.de, yinghai@kernel.org, jiang.liu@huawei.com, wency@cn.fujitsu.com, laijs@cn.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, mgorman@suse.de, minchan@kernel.org, mina86@mina86.com, gong.chen@linux.intel.com, vasilis.liaskovitis@profitbricks.com, lwoodman@redhat.com, riel@redhat.com, jweiner@redhat.com, prarit@redhat.com, zhangyanfei@cn.fujitsu.com, yanghy@cn.fujitsu.com, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jul 19, 2013 at 03:59:14PM +0800, Tang Chen wrote:
> The Hot-Pluggable field in SRAT suggests if the memory could be
> hotplugged while the system is running. Print it as well when
> parsing SRAT will help users to know which memory is hotpluggable.
> 
> Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
> Reviewed-by: Wanpeng Li <liwanp@linux.vnet.ibm.com>

Acked-by: Tejun Heo <tj@kernel.org>

But a nit below

> +	pr_info("SRAT: Node %u PXM %u [mem %#010Lx-%#010Lx] %s\n",
> +		node, pxm,
> +		(unsigned long long) start, (unsigned long long) end - 1,
> +		hotpluggable ? "Hot Pluggable" : "");

The following would be more conventional.

  "...10Lx]%s\n", ..., hotpluggable ? " Hot Pluggable" : ""

Also, isn't "Hot Pluggable" a bit too verbose?  "hotplug" should be
fine, I think.

Thanks.

-- 
tejun
