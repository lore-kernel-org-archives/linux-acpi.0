From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] x86/numa: move setting parse numa node to num_add_memblk
Date: Fri, 1 Dec 2017 09:58:33 +0100
Message-ID: <20171201085833.4hs6sgjvcokdrr35@dhcp22.suse.cz>
References: <1511946807-22024-1-git-send-email-zhongjiang@huawei.com>
 <5A211759.5080800@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39342 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751805AbdLAI6i (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 1 Dec 2017 03:58:38 -0500
Content-Disposition: inline
In-Reply-To: <5A211759.5080800@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: zhong jiang <zhongjiang@huawei.com>
Cc: tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, lenb@kernel.org, akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org, David Rientjes <rientjes@google.com>, Ingo Molnar <mingo@kernel.org>, Minchan Kim <minchan@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, richard.weiyang@gmail.com, pombredanne@nexb.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri 01-12-17 16:48:25, zhong jiang wrote:
> +cc more mm maintainer.
> 
> Any one has any object.  please let me know.  

Please repost with the changelog which actually tells 1) what is the
problem 2) why do we need to address it and 3) how do we address it.
-- 
Michal Hocko
SUSE Labs
