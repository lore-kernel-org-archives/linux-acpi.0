From: Wanpeng Li <liwanp@linux.vnet.ibm.com>
Subject: Re: [PATCH 00/11] x86, memblock: Allocate memory near kernel image
 before SRAT parsed.
Date: Mon, 9 Sep 2013 20:04:29 +0800
Message-ID: <26555.4413352676$1378728290@news.gmane.org>
References: <1377596268-31552-1-git-send-email-tangchen@cn.fujitsu.com>
 <20130904192215.GG26609@mtj.dyndns.org>
 <52299935.0302450a.26c9.ffffb240SMTPIN_ADDED_BROKEN@mx.google.com>
 <20130906151526.GA22423@mtj.dyndns.org>
 <157310e1-f8cb-4184-b58d-63cf9fa611ee@email.android.com>
Reply-To: Wanpeng Li <liwanp@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <157310e1-f8cb-4184-b58d-63cf9fa611ee@email.android.com>
Sender: owner-linux-mm@kvack.org
To: "H. Peter Anvin" <hpa@zytor.com>, Tejun Heo <tj@kernel.org>
Cc: rjw@sisk.pl, lenb@kernel.org, tglx@linutronix.de, mingo@elte.hu, akpm@linux-foundation.org, trenn@suse.de, yinghai@kernel.org, jiang.liu@huawei.com, wency@cn.fujitsu.com, laijs@cn.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, mgorman@suse.de, minchan@kernel.org, mina86@mina86.com, gong.chen@linux.intel.com, vasilis.liaskovitis@profitbricks.com, lwoodman@redhat.com, riel@redhat.com, jweiner@redhat.com, prarit@redhat.com, zhangyanfei@cn.fujitsu.com, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Peter and Tejun,
On Fri, Sep 06, 2013 at 08:47:45AM -0700, H. Peter Anvin wrote:
>Specifically there are a bunch of things which need to be below a certain address (which one varies.)
>

off-topic 

If memblock allocator have less fragmentation than old bootmem allocator?

Regards,
Wanpeng Li 

>Tejun Heo <tj@kernel.org> wrote:
>>Hello, Wanpeng.
>>
>>On Fri, Sep 06, 2013 at 04:58:11PM +0800, Wanpeng Li wrote:
>>> What's the root reason memblock alloc from high to low? To reduce 
>>> fragmentation or ...
>>
>>Because low memory tends to be more precious, it's just easier to pack
>>everything towards the top so that we don't have to worry about which
>>zone to use for allocation and fallback logic.
>>
>>Thanks.
>
>-- 
>Sent from my mobile phone.  Please pardon brevity and lack of formatting.
>
>--
>To unsubscribe, send a message with 'unsubscribe linux-mm' in
>the body to majordomo@kvack.org.  For more info on Linux MM,
>see: http://www.linux-mm.org/ .
>Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
