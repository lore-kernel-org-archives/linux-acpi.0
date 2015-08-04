From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH 1/5] x86, gfp: Cache best near node for memory allocation.
Date: Tue, 4 Aug 2015 16:24:08 +0800
Message-ID: <55C076A8.6060206@cn.fujitsu.com>
References: <1436261425-29881-1-git-send-email-tangchen@cn.fujitsu.com> <1436261425-29881-2-git-send-email-tangchen@cn.fujitsu.com> <20150715214802.GL15934@mtj.duckdns.org> <55C03332.2030808@cn.fujitsu.com> <55C0725B.80201@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:23857 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755110AbbHDIZm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Aug 2015 04:25:42 -0400
In-Reply-To: <55C0725B.80201@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>, Tejun Heo <tj@kernel.org>
Cc: mingo@redhat.com, akpm@linux-foundation.org, rjw@rjwysocki.net, hpa@zytor.com, laijs@cn.fujitsu.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, qiaonuohan@cn.fujitsu.com, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, tangchen@cn.fujitsu.com


On 08/04/2015 04:05 PM, Jiang Liu wrote:
> ......
>
>
> But,
> 1) in cpu_up(), it will try to online a node, and it doesn't check if
> the node has memory.
> 2) in try_offline_node(), it offlines CPUs first, and then the memory.
>
> This behavior looks a little wired, or let's say it is ambiguous. It
> seems that a NUMA node
> consists of CPUs and memory. So if the CPUs are online, the node should
> be online.
> Hi Chen,
> 	I have posted a patch set to enable memoryless node on x86,
> will repost it for review:) Hope it help to solve this issue.
> Thanks!
> Gerry
>
>
Sure. Looking forward to the latest patches. :)

Thanks.
