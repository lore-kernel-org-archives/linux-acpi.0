From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Subject: Re: [PATCH v2 RESEND 13/18] x86, numa, mem_hotplug: Skip all the
 regions the kernel resides in.
Date: Mon, 05 Aug 2013 23:12:44 +0800
Message-ID: <51FFC0EC.6060805@gmail.com>
References: <1375434877-20704-1-git-send-email-tangchen@cn.fujitsu.com> <1375434877-20704-14-git-send-email-tangchen@cn.fujitsu.com> <51FF44B7.8050704@cn.fujitsu.com> <20130805145212.GA19631@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20130805145212.GA19631@mtj.dyndns.org>
Sender: linux-doc-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Tang Chen <tangchen@cn.fujitsu.com>, robert.moore@intel.com, lv.zheng@intel.com, rjw@sisk.pl, lenb@kernel.org, tglx@linutronix.de, mingo@elte.hu, hpa@zytor.com, akpm@linux-foundation.org, trenn@suse.de, yinghai@kernel.org, jiang.liu@huawei.com, wency@cn.fujitsu.com, laijs@cn.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, mgorman@suse.de, minchan@kernel.org, mina86@mina86.com, gong.chen@linux.intel.com, vasilis.liaskovitis@profitbricks.com, lwoodman@redhat.com, riel@redhat.com, jweiner@redhat.com, prarit@redhat.com, zhangyanfei@cn.fujitsu.com, yanghy@cn.fujitsu.com, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi tj,

On 08/05/2013 10:52 PM, Tejun Heo wrote:
> On Mon, Aug 05, 2013 at 02:22:47PM +0800, Tang Chen wrote:
>> I have resent the v2 patch-set. Would you please give some more
>> comments about the memblock and x86 booting code modification ?
> 
> Patch 13 still seems corrupt.  Is it a problem on my side maybe?
> Nope, gmane raw message is corrupt too.
> 
>  http://article.gmane.org/gmane.linux.kernel.mm/104549/raw
> 
> Can you please verify your mail setup?  It's not very nice to repeat
> the same problem.
> 

Sorry for this format problem again. Maybe our mail client does have some
problem. We will check tomorrow when we go to our company since we are at
night now....

And could you please kindly help reviewing other memblock and bootstrap related
patches, so we could have a discussion with you and come to an agreement as soon
as possible.

Thanks in advance!

-- 
Thanks.
Zhang Yanfei
