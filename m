From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH part5 0/7] Arrange hotpluggable memory as ZONE_MOVABLE.
Date: Thu, 15 Aug 2013 08:49:25 -0400
Message-ID: <20130815124925.GB14606@htj.dyndns.org>
References: <5208FBBC.2080304@zytor.com>
 <20130812152343.GK15892@htj.dyndns.org>
 <52090D7F.6060600@gmail.com>
 <20130812164650.GN15892@htj.dyndns.org>
 <5209CEC1.8070908@cn.fujitsu.com>
 <520A02DE.1010908@cn.fujitsu.com>
 <CAE9FiQV2-OOvHZtPYSYNZz+DfhvL0e+h2HjMSW3DyqeXXvdJkA@mail.gmail.com>
 <520C947B.40407@cn.fujitsu.com>
 <20130815121900.GA14606@htj.dyndns.org>
 <520CCD41.5000508@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <520CCD41.5000508@cn.fujitsu.com>
Sender: owner-linux-mm@kvack.org
To: Tang Chen <tangchen@cn.fujitsu.com>
Cc: Yinghai Lu <yinghai@kernel.org>, Tang Chen <imtangchen@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Renninger <trenn@suse.de>, Jiang Liu <jiang.liu@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Taku Izumi <izumi.taku@jp.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, "mina86@mina86.com" <mina86@mina86.com>, "gong.chen@linux.intel.com" <gong.chen@linux.intel.com>, Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>, "lwoodman@redhat.com" <lwoodman@redhat.com>, Rik van Riel <riel@redhat.com>jw
List-Id: linux-acpi@vger.kernel.org

Hello,

On Thu, Aug 15, 2013 at 08:44:49PM +0800, Tang Chen wrote:
> I wanted to ask for some comment to the above solution. When I was
> coding, I found that change the behavior of pagetable initialization
> could be ugly. We should start from the middle of the memory, where
> the kernel image is, but not the end of memory.
> 
> I'm not asking for any detail comment, just seeing from the description,
> is it acceptable ?

Hmmm... I can't really tell without knowing how ugly it gets and why.
Do you mind posting a draft patch so that we can have better context?

Thanks.

-- 
tejun

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
