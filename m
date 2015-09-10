From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 3/7] x86, gfp: Cache best near node for memory
 allocation.
Date: Thu, 10 Sep 2015 18:08:57 -0400
Message-ID: <20150910220857.GN8114@mtj.duckdns.org>
References: <1441859269-25831-1-git-send-email-tangchen@cn.fujitsu.com>
 <1441859269-25831-4-git-send-email-tangchen@cn.fujitsu.com>
 <20150910192935.GI8114@mtj.duckdns.org>
 <20150910193819.GJ8114@mtj.duckdns.org>
 <alpine.DEB.2.11.1509101701220.11096@east.gentwo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1509101701220.11096@east.gentwo.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Lameter <cl@linux.com>
Cc: Tang Chen <tangchen@cn.fujitsu.com>, jiang.liu@linux.intel.com, mika.j.penttila@gmail.com, mingo@redhat.com, akpm@linux-foundation.org, rjw@rjwysocki.net, hpa@zytor.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, qiaonuohan@cn.fujitsu.com, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Gu Zheng <guz.fnst@cn.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

Hello,

On Thu, Sep 10, 2015 at 05:02:31PM -0500, Christoph Lameter wrote:
> > Also, shouldn't kmalloc_node() or any public allocator fall back
> > automatically to a near node w/o GFP_THISNODE?  Why is this failing at
> > all?  I get that cpu id -> node id mapping changing messes up the
> > locality but allocations shouldn't fail, right?
> 
> Without a node specification allocations are subject to various
> constraints and memory policies. It is not simply going to the next node.
> The memory load may require spreading out the allocations over multiple
> nodes, the app may have specified which nodes are to be used etc etc.

Yeah, sure, but even w/ node specified, it shouldn't fail unless
THISNODE, right?

Thanks.

-- 
tejun
