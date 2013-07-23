From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 20/21] x86, numa, acpi, memory-hotplug: Make
 movablecore=acpi have higher priority.
Date: Tue, 23 Jul 2013 17:21:08 -0400
Message-ID: <20130723212108.GX21100@mtj.dyndns.org>
References: <1374220774-29974-1-git-send-email-tangchen@cn.fujitsu.com>
 <1374220774-29974-21-git-send-email-tangchen@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gg0-f171.google.com ([209.85.161.171]:40986 "EHLO
	mail-gg0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756516Ab3GWVVQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Jul 2013 17:21:16 -0400
Content-Disposition: inline
In-Reply-To: <1374220774-29974-21-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tang Chen <tangchen@cn.fujitsu.com>
Cc: tglx@linutronix.de, mingo@elte.hu, hpa@zytor.com, akpm@linux-foundation.org, trenn@suse.de, yinghai@kernel.org, jiang.liu@huawei.com, wency@cn.fujitsu.com, laijs@cn.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, mgorman@suse.de, minchan@kernel.org, mina86@mina86.com, gong.chen@linux.intel.com, vasilis.liaskovitis@profitbricks.com, lwoodman@redhat.com, riel@redhat.com, jweiner@redhat.com, prarit@redhat.com, zhangyanfei@cn.fujitsu.com, yanghy@cn.fujitsu.com, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org

On Fri, Jul 19, 2013 at 03:59:33PM +0800, Tang Chen wrote:
> Arrange hotpluggable memory as ZONE_MOVABLE will cause NUMA performance down
> because the kernel cannot use movable memory. For users who don't use memory
> hotplug and who don't want to lose their NUMA performance, they need a way to
> disable this functionality. So we improved movablecore boot option.
> 
> If users specify the original movablecore=nn@ss boot option, the kernel will
> arrange [ss, ss+nn) as ZONE_MOVABLE. The kernelcore=nn@ss boot option is similar
> except it specifies ZONE_NORMAL ranges.
> 
> Now, if users specify "movablecore=acpi" in kernel commandline, the kernel will
> arrange hotpluggable memory in SRAT as ZONE_MOVABLE. And if users do this, all
> the other movablecore=nn@ss and kernelcore=nn@ss options should be ignored.
> 
> For those who don't want this, just specify nothing. The kernel will act as
> before.

As I wrote before, I find movablecore=acpi rather weird.  Shouldn't it
be memory_hotplug enable/disable switch instead and movablecore, if
specified, overriding information provided by firmware?

Thanks.

-- 
tejun
