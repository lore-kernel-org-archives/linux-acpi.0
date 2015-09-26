From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 5/7] x86, acpi, cpu-hotplug: Introduce
 apicid_to_cpuid[] array to store persistent cpuid <-> apicid mapping.
Date: Sat, 26 Sep 2015 13:56:22 -0400
Message-ID: <20150926175622.GC3572@htj.duckdns.org>
References: <1441859269-25831-1-git-send-email-tangchen@cn.fujitsu.com>
 <1441859269-25831-6-git-send-email-tangchen@cn.fujitsu.com>
 <20150910195532.GK8114@mtj.duckdns.org>
 <56066AC9.6020703@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:36582 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217AbbIZR41 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Sep 2015 13:56:27 -0400
Content-Disposition: inline
In-Reply-To: <56066AC9.6020703@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tang Chen <tangchen@cn.fujitsu.com>
Cc: jiang.liu@linux.intel.com, mika.j.penttila@gmail.com, mingo@redhat.com, akpm@linux-foundation.org, rjw@rjwysocki.net, hpa@zytor.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, qiaonuohan@cn.fujitsu.com, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org

On Sat, Sep 26, 2015 at 05:52:09PM +0800, Tang Chen wrote:
> >>+static int allocate_logical_cpuid(int apicid)
> >>+{
> >>+	int i;
> >>+
> >>+	/*
> >>+	 * cpuid <-> apicid mapping is persistent, so when a cpu is up,
> >>+	 * check if the kernel has allocated a cpuid for it.
> >>+	 */
> >>+	for (i = 0; i < max_logical_cpuid; i++) {
> >>+		if (cpuid_to_apicid[i] == apicid)
> >>+			return i;
> >>+	}
> >>+
> >>+	/* Allocate a new cpuid. */
> >>+	if (max_logical_cpuid >= nr_cpu_ids) {
> >>+		WARN_ONCE(1, "Only %d processors supported."
> >>+			     "Processor %d/0x%x and the rest are ignored.\n",
> >>+			     nr_cpu_ids - 1, max_logical_cpuid, apicid);
> >>+		return -1;
> >>+	}
> >So, the original code didn't have this failure mode, why is this
> >different for the new code?
> 
> It is not different. Since max_logical_cpuid is new, this is ensure it won't
> go beyond NR_CPUS.

If the above condition can happen, the original code should have had a
similar check as above, right?  Sure, max_logical_cpuid is a new thing
but that doesn't seem to change whether the above condition can happen
or not, no?

Thanks.

-- 
tejun
