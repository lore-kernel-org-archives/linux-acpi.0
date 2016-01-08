From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 5/5] x86, acpi, cpu-hotplug: Set persistent cpuid <->
 nodeid mapping when booting.
Date: Fri, 8 Jan 2016 14:13:05 -0500
Message-ID: <20160108191305.GA1898@mtj.duckdns.org>
References: <1452140425-16577-1-git-send-email-tangchen@cn.fujitsu.com>
 <1452140425-16577-6-git-send-email-tangchen@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:35958 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbcAHTNH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Jan 2016 14:13:07 -0500
Content-Disposition: inline
In-Reply-To: <1452140425-16577-6-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tang Chen <tangchen@cn.fujitsu.com>
Cc: cl@linux.com, jiang.liu@linux.intel.com, mika.j.penttila@gmail.com, mingo@redhat.com, akpm@linux-foundation.org, rjw@rjwysocki.net, hpa@zytor.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Gu Zheng <guz.fnst@cn.fujitsu.com>

Hello, Tang.

On Thu, Jan 07, 2016 at 12:20:25PM +0800, Tang Chen wrote:
> From: Gu Zheng <guz.fnst@cn.fujitsu.com>
> 
> This patch finishes step 4.

This doesn't help people trying to read the patch.  If you wanna say
it's one of the steps of something, you also need to say what the
steps are.  No need to duplicate the whole thing but a short summary
would be helpful.

> This patch set the persistent cpuid <-> nodeid mapping for all enabled/disabled
> processors at boot time via an additional acpi namespace walk for processors.

So, the patchset generally looks good to me although I'm not too
familiar with acpi.  Rafael, Len, what do you think?

Thanks.

-- 
tejun
