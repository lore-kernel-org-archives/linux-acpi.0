From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 0/5] Make cpuid <-> nodeid mapping persistent.
Date: Mon, 23 Nov 2015 17:04:51 -0500
Message-ID: <20151123220451.GG19072@mtj.duckdns.org>
References: <1447906935-31899-1-git-send-email-tangchen@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:36061 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384AbbKWWEz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Nov 2015 17:04:55 -0500
Content-Disposition: inline
In-Reply-To: <1447906935-31899-1-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tang Chen <tangchen@cn.fujitsu.com>
Cc: cl@linux.com, jiang.liu@linux.intel.com, mika.j.penttila@gmail.com, mingo@redhat.com, akpm@linux-foundation.org, rjw@rjwysocki.net, hpa@zytor.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org

Hello,

On Thu, Nov 19, 2015 at 12:22:10PM +0800, Tang Chen wrote:
> [Solution]
> 
> There are four mappings in the kernel:
> 1. nodeid (logical node id)   <->   pxm
> 2. apicid (physical cpu id)   <->   nodeid
> 3. cpuid (logical cpu id)     <->   apicid
> 4. cpuid (logical cpu id)     <->   nodeid
> 
> 1. pxm (proximity domain) is provided by ACPI firmware in SRAT, and nodeid <-> pxm
>    mapping is setup at boot time. This mapping is persistent, won't change.
> 
> 2. apicid <-> nodeid mapping is setup using info in 1. The mapping is setup at boot
>    time and CPU hotadd time, and cleared at CPU hotremove time. This mapping is also
>    persistent.
> 
> 3. cpuid <-> apicid mapping is setup at boot time and CPU hotadd time. cpuid is
>    allocated, lower ids first, and released at CPU hotremove time, reused for other
>    hotadded CPUs. So this mapping is not persistent.
> 
> 4. cpuid <-> nodeid mapping is also setup at boot time and CPU hotadd time, and
>    cleared at CPU hotremove time. As a result of 3, this mapping is not persistent.
> 
> To fix this problem, we establish cpuid <-> nodeid mapping for all the possible
> cpus at boot time, and make it persistent. And according to init_cpu_to_node(),
> cpuid <-> nodeid mapping is based on apicid <-> nodeid mapping and cpuid <-> apicid
> mapping. So the key point is obtaining all cpus' apicid.

I don't know much about acpi so can't actually review the patches but
the overall approach looks good to me.

Thanks.

-- 
tejun
