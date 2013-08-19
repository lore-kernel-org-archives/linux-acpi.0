From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH 2/6] acpi, numa, mem_hotplug: Print Hot-Pluggable Field
 in SRAT.
Date: Mon, 19 Aug 2013 12:48:56 -0600
Message-ID: <1376938136.10300.454.camel@misato.fc.hp.com>
References: <1376636809-10159-1-git-send-email-tangchen@cn.fujitsu.com>
	 <1376636809-10159-3-git-send-email-tangchen@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0187.atlanta.hp.com ([15.193.32.64]:20664 "EHLO
	g6t0187.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829Ab3HSSuR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Aug 2013 14:50:17 -0400
In-Reply-To: <1376636809-10159-3-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tang Chen <tangchen@cn.fujitsu.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, lenb@kernel.org, rjw@sisk.pl, liwanp@linux.vnet.ibm.com, tj@kernel.org, akpm@linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, 2013-08-16 at 15:06 +0800, Tang Chen wrote:
> The Hot-Pluggable field in SRAT suggests if the memory could be
> hotplugged while the system is running. Print it as well when
> parsing SRAT will help users to know which memory is hotpluggable.
> 
> Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
> Reviewed-by: Wanpeng Li <liwanp@linux.vnet.ibm.com>
> Reviewed-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> Acked-by: Tejun Heo <tj@kernel.org>

Acked-by: Toshi Kani <toshi.kani@hp.com>

Thanks,
-Toshi


