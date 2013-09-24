From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Subject: Re: [PATCH 1/6] memblock: Factor out of top-down allocation
Date: Tue, 24 Sep 2013 21:04:55 +0800
Message-ID: <52418DF7.5080101@gmail.com>
References: <524162DA.30004@cn.fujitsu.com> <5241636B.2060206@cn.fujitsu.com> <20130924121005.GB2366@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:57024 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038Ab3IXNFh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Sep 2013 09:05:37 -0400
In-Reply-To: <20130924121005.GB2366@htj.dyndns.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>, "Rafael J . Wysocki" <rjw@sisk.pl>, lenb@kernel.org, Thomas Gleixner <tglx@linutronix.de>, mingo@elte.hu, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Toshi Kani <toshi.kani@hp.com>, Wanpeng Li <liwanp@linux.vnet.ibm.com>, Thomas Renninger <trenn@suse.de>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <jiang.liu@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, isimatu.yasuaki@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, mina86@mina86.com, gong.chen@linux.intel.com, vasilis.liaskovitis@profitbricks.com, lwoodman@redhat.com, Rik van Riel <riel@redhat.com>, jweiner@redhat.com, prarit@redhat.com, "x86@kernel.org" <x86@kernel.org>, linux-doc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kern>

Hello tejun,

On 09/24/2013 08:10 PM, Tejun Heo wrote:
> On Tue, Sep 24, 2013 at 06:03:23PM +0800, Zhang Yanfei wrote:
>> From: Tang Chen <tangchen@cn.fujitsu.com>
>>
>> This patch imports a new function __memblock_find_range_rev
> 
> "imports" sounds a bit weird.  I think "creates" or "this patch
> factors out __memblock_find_range_rev() from
> memblock_find_in_range_node()" would be better.

Okay, will update it in next version. Thanks.

> 
>> to factor out of top-down allocation from memblock_find_in_range_node.
>> This is a preparation because we will introduce a new bottom-up
>> allocation mode in the following patch.
>>
>> Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
>> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> 
> Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

> 
> Thanks.
> 


-- 
Thanks.
Zhang Yanfei
