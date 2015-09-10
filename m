From: Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH v2 3/7] x86, gfp: Cache best near node for memory
 allocation.
Date: Thu, 10 Sep 2015 17:02:31 -0500 (CDT)
Message-ID: <alpine.DEB.2.11.1509101701220.11096@east.gentwo.org>
References: <1441859269-25831-1-git-send-email-tangchen@cn.fujitsu.com> <1441859269-25831-4-git-send-email-tangchen@cn.fujitsu.com> <20150910192935.GI8114@mtj.duckdns.org> <20150910193819.GJ8114@mtj.duckdns.org>
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150910193819.GJ8114@mtj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Tang Chen <tangchen@cn.fujitsu.com>, jiang.liu@linux.intel.com, mika.j.penttila@gmail.com, mingo@redhat.com, akpm@linux-foundation.org, rjw@rjwysocki.net, hpa@zytor.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, qiaonuohan@cn.fujitsu.com, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Gu Zheng <guz.fnst@cn.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, 10 Sep 2015, Tejun Heo wrote:

> > Why not just update node_data[]->node_zonelist in the first place?
> > Also, what's the synchronization rule here?  How are allocators
> > synchronized against node hot [un]plugs?
>
> Also, shouldn't kmalloc_node() or any public allocator fall back
> automatically to a near node w/o GFP_THISNODE?  Why is this failing at
> all?  I get that cpu id -> node id mapping changing messes up the
> locality but allocations shouldn't fail, right?

Without a node specification allocations are subject to various
constraints and memory policies. It is not simply going to the next node.
The memory load may require spreading out the allocations over multiple
nodes, the app may have specified which nodes are to be used etc etc.
