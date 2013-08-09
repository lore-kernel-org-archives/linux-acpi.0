From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH part2 0/4] acpi: Trivial fix and improving for memory
 hotplug.
Date: Fri, 9 Aug 2013 11:59:49 -0400
Message-ID: <20130809155949.GN20515@mtj.dyndns.org>
References: <1375938239-18769-1-git-send-email-tangchen@cn.fujitsu.com>
 <1851799.n4moZnvj4u@vostro.rjw.lan>
 <520439C9.3080601@cn.fujitsu.com>
 <1792540.pdAYjdHnnL@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1792540.pdAYjdHnnL@vostro.rjw.lan>
Sender: owner-linux-mm@kvack.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Tang Chen <tangchen@cn.fujitsu.com>, robert.moore@intel.com, lv.zheng@intel.com, lenb@kernel.org, tglx@linutronix.de, mingo@elte.hu, hpa@zytor.com, akpm@linux-foundation.org, trenn@suse.de, yinghai@kernel.org, jiang.liu@huawei.com, wency@cn.fujitsu.com, laijs@cn.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, mgorman@suse.de, minchan@kernel.org, mina86@mina86.com, gong.chen@linux.intel.com, vasilis.liaskovitis@profitbricks.com, lwoodman@redhat.com, riel@redhat.com, jweiner@redhat.com, prarit@redhat.com, zhangyanfei@cn.fujitsu.com, yanghy@cn.fujitsu.com, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Aug 09, 2013 at 03:36:16PM +0200, Rafael J. Wysocki wrote:
> > No, it doesn't. And this patch-set can be merged first.
> 
> OK, so if nobody objects, I can take patches [1,3-4/4], but I don't think I'm
> the right maintainer to handle [2/4].

Given the dependencies, we'll probably need some coordination among
trees.  It spans across ACPI, memblock and x86.  Maybe the best way to
do it is applying the ACPI part to your tree, pulling the rest into a
tip branch and then put everything else there.

Thanks.

-- 
tejun

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
