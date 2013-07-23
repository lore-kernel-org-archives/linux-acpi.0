From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 18/21] x86, numa: Synchronize nid info in
 memblock.reserve with numa_meminfo.
Date: Tue, 23 Jul 2013 17:25:48 -0400
Message-ID: <20130723212548.GZ21100@mtj.dyndns.org>
References: <1374220774-29974-1-git-send-email-tangchen@cn.fujitsu.com>
 <1374220774-29974-19-git-send-email-tangchen@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1374220774-29974-19-git-send-email-tangchen@cn.fujitsu.com>
Sender: owner-linux-mm@kvack.org
To: Tang Chen <tangchen@cn.fujitsu.com>
Cc: tglx@linutronix.de, mingo@elte.hu, hpa@zytor.com, akpm@linux-foundation.org, trenn@suse.de, yinghai@kernel.org, jiang.liu@huawei.com, wency@cn.fujitsu.com, laijs@cn.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, mgorman@suse.de, minchan@kernel.org, mina86@mina86.com, gong.chen@linux.intel.com, vasilis.liaskovitis@profitbricks.com, lwoodman@redhat.com, riel@redhat.com, jweiner@redhat.com, prarit@redhat.com, zhangyanfei@cn.fujitsu.com, yanghy@cn.fujitsu.com, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jul 19, 2013 at 03:59:31PM +0800, Tang Chen wrote:
> Vasilis Liaskovitis found that before we parse SRAT and fulfill numa_meminfo,
> the nids of all the regions in memblock.reserve[] are MAX_NUMNODES. That is
> because nids have not been mapped at that time.
> 
> When we arrange ZONE_MOVABLE in each node later, we need nid in memblock. So
> after we parse SRAT and fulfill nume_meminfo, synchronize the nid info to
> memblock.reserve[] immediately.

Having a separate sync is rather nasty.  Why not let
memblock_set_node() and alloc functions set nid on the reserved
regions?

Thanks.

-- 
tejun

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
