From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 5/5] mem-hotplug: Introduce movablenode boot option to
 control memblock allocation direction.
Date: Mon, 23 Sep 2013 13:11:08 -0400
Message-ID: <20130923171108.GG14547@htj.dyndns.org>
References: <1379064655-20874-1-git-send-email-tangchen@cn.fujitsu.com>
 <1379064655-20874-6-git-send-email-tangchen@cn.fujitsu.com>
 <20130923155713.GF14547@htj.dyndns.org>
 <5240731B.9070906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <5240731B.9070906@gmail.com>
Sender: owner-linux-mm@kvack.org
To: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Cc: Tang Chen <tangchen@cn.fujitsu.com>, rjw@sisk.pl, lenb@kernel.org, tglx@linutronix.de, mingo@elte.hu, hpa@zytor.com, akpm@linux-foundation.org, toshi.kani@hp.com, zhangyanfei@cn.fujitsu.com, liwanp@linux.vnet.ibm.com, trenn@suse.de, yinghai@kernel.org, jiang.liu@huawei.com, wency@cn.fujitsu.com, laijs@cn.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, mgorman@suse.de, minchan@kernel.org, mina86@mina86.com, gong.chen@linux.intel.com, vasilis.liaskovitis@profitbricks.com, lwoodman@redhat.com, riel@redhat.com, jweiner@redhat.com, prarit@redhat.com, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hello,

On Tue, Sep 24, 2013 at 12:58:03AM +0800, Zhang Yanfei wrote:
> you mean we define memblock_set_bottom_up and memblock_bottom_up like below:
> 
> #ifdef CONFIG_MOVABLE_NODE
> void memblock_set_bottom_up(bool enable)
> {
>         /* do something */
> }
> 
> bool memblock_bottom_up()
> {
>         return  direction == bottom_up;
> }
> #else
> void memblock_set_bottom_up(bool enable)
> {
>         /* empty */
> }
> 
> bool memblock_bottom_up()
> {
>         return false;
> }
> #endif
> 
> right?

Yeah, the compiler would be able to drop bottom_up code if
!MOVABLE_NODE as long as the implementation functions are static.

Thanks.

-- 
tejun

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
