From: Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH v2 3/7] x86, gfp: Cache best near node for memory
 allocation.
Date: Thu, 10 Sep 2015 19:14:40 -0500 (CDT)
Message-ID: <alpine.DEB.2.11.1509101908410.11150@east.gentwo.org>
References: <1441859269-25831-1-git-send-email-tangchen@cn.fujitsu.com> <1441859269-25831-4-git-send-email-tangchen@cn.fujitsu.com> <20150910192935.GI8114@mtj.duckdns.org> <20150910193819.GJ8114@mtj.duckdns.org>
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from resqmta-ch2-06v.sys.comcast.net ([69.252.207.38]:50590 "EHLO
	resqmta-ch2-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751181AbbIKAOn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Sep 2015 20:14:43 -0400
In-Reply-To: <20150910193819.GJ8114@mtj.duckdns.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Tang Chen <tangchen@cn.fujitsu.com>, jiang.liu@linux.intel.com, mika.j.penttila@gmail.com, mingo@redhat.com, akpm@linux-foundation.org, rjw@rjwysocki.net, hpa@zytor.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, qiaonuohan@cn.fujitsu.com, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Gu Zheng <guz.fnst@cn.fujitsu.com>

On Thu, 10 Sep 2015, Tejun Heo wrote:

> > Why not just update node_data[]->node_zonelist in the first place?
> > Also, what's the synchronization rule here?  How are allocators
> > synchronized against node hot [un]plugs?
>
> Also, shouldn't kmalloc_node() or any public allocator fall back
> automatically to a near node w/o GFP_THISNODE?  Why is this failing at
> all?  I get that cpu id -> node id mapping changing messes up the
> locality but allocations shouldn't fail, right?

Yes that should occur in the absence of other constraints (mempolicies,
cpusets, cgroups, allocation type). If the constraints do not allow an
allocation then the allocation will fail.

Also: Are the zonelists setup the right way?


