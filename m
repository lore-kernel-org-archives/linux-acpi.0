From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] x86/numa: move setting parse numa node to num_add_memblk
Date: Wed, 29 Nov 2017 14:33:55 +0100
Message-ID: <20171129133355.ybbhzpqhmjreyofi@dhcp22.suse.cz>
References: <1511946807-22024-1-git-send-email-zhongjiang@huawei.com>
 <20171129120328.dfbr26o4wsjpwct3@dhcp22.suse.cz>
 <5A1EAAF5.4040602@huawei.com>
 <20171129130158.hji24remijkaoydb@dhcp22.suse.cz>
 <5A1EB57B.2080101@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59140 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750863AbdK2Nd7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 29 Nov 2017 08:33:59 -0500
Content-Disposition: inline
In-Reply-To: <5A1EB57B.2080101@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: zhong jiang <zhongjiang@huawei.com>
Cc: tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, lenb@kernel.org, akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org, richard.weiyang@gmail.com, pombredanne@nexb.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed 29-11-17 21:26:19, zhong jiang wrote:
> On 2017/11/29 21:01, Michal Hocko wrote:
> > On Wed 29-11-17 20:41:25, zhong jiang wrote:
> >> On 2017/11/29 20:03, Michal Hocko wrote:
> >>> On Wed 29-11-17 17:13:27, zhong jiang wrote:
> >>>> Currently, Arm64 and x86 use the common code wehn parsing numa node
> >>>> in a acpi way. The arm64 will set the parsed node in numa_add_memblk,
> >>>> but the x86 is not set in that , then it will result in the repeatly
> >>>> setting. And the parsed node maybe is  unreasonable to the system.
> >>>>
> >>>> we would better not set it although it also still works. because the
> >>>> parsed node is unresonable. so we should skip related operate in this
> >>>> node. This patch just set node in various architecture individually.
> >>>> it is no functional change.
> >>> I really have hard time to understand what you try to say above. Could
> >>> you start by the problem description and then how you are addressing it?
> >>   I am so sorry for that.  I will make the issue clear.
> >>  
> >>   Arm64  get numa information through acpi.  The code flow is as follows.
> >>
> >>   arm64_acpi_numa_init
> >>        acpi_parse_memory_affinity
> >>           acpi_numa_memory_affinity_init
> >>               numa_add_memblk(nid, start, end);      //it will set node to numa_nodes_parsed successfully.
> >>               node_set(node, numa_nodes_parsed);     // numa_add_memblk had set that.  it will repeat.
> >>
> >>  the root cause is that X86 parse numa also  go through above code.  and  arch-related
> >>  numa_add_memblk  is not set the parsed node to numa_nodes_parsed.  it need
> >>  additional node_set(node, numa_parsed) to handle.  therefore,  the issue will be introduced.
> >>
> > No it is not much more clear. I would have to go and re-study the whole
> > code flow to see what you mean here. So you could simply state what _the
> > issue_ is? How can user observe it and what are the consequences?
>   The patch do not fix a real issue.  it is a cleanup.
>   because the acpi code  is public,  I find they are messy between
>   Arch64 and X86 when parsing numa message .  therefore,  I try to
>   make the code more clear between them.

So make this explicit in the changelog. Your previous wording sounded
like there is a _problem_ in the code.

-- 
Michal Hocko
SUSE Labs
