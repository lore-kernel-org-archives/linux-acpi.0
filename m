From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v8 1/7] x86, memhp, numa: Online memory-less nodes at
 boot time.
Date: Tue, 19 Jul 2016 14:50:17 -0400
Message-ID: <20160719185017.GM3078@mtj.duckdns.org>
References: <1468913288-16605-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <1468913288-16605-2-git-send-email-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36150 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbcGSSuW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Jul 2016 14:50:22 -0400
Content-Disposition: inline
In-Reply-To: <1468913288-16605-2-git-send-email-douly.fnst@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: cl@linux.com, mika.j.penttila@gmail.com, mingo@redhat.com, akpm@linux-foundation.org, rjw@rjwysocki.net, hpa@zytor.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, len.brown@intel.com, lenb@kernel.org, tglx@linutronix.de, chen.tang@easystack.cn, rafael@kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Tang Chen <tangchen@cn.fujitsu.com>, Zhu Guihua <zhugh.fnst@cn.fujitsu.com>

Hello,

On Tue, Jul 19, 2016 at 03:28:02PM +0800, Dou Liyang wrote:
> In this series of patches, we are going to construct cpu <-> node mapping
> for all possible cpus at boot time, which is a 1-1 mapping. It means the

1-1 mapping means that each cpu is mapped to its own private node
which isn't the case.  Just call it a persistent mapping?

> cpu will be mapped to the node it belongs to, and will never be changed.
> If a node has only cpus but no memory, the cpus on it will be mapped to
> a memory-less node. And the memory-less node should be onlined.
> 
> This patch allocate pgdats for all memory-less nodes and online them at
> boot time. Then build zonelists for these nodes. As a result, when cpus
> on these memory-less nodes try to allocate memory from local node, it
> will automatically fall back to the proper zones in the zonelists.

Yeah, I think this is an a lot better approach for memory-less nodes.

> Signed-off-by: Zhu Guihua <zhugh.fnst@cn.fujitsu.com>
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
