From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RESEND RFC PATCH 2/2] gfp: use the best near online node if
 the target node is offline
Date: Fri, 24 Apr 2015 13:01:53 -0700
Message-ID: <20150424130153.f7b494f1533529651b2696c6@linux-foundation.org>
References: <1429869513-2906-1-git-send-email-guz.fnst@cn.fujitsu.com>
	<1429869513-2906-2-git-send-email-guz.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:55456 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933628AbbDXUBy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Apr 2015 16:01:54 -0400
In-Reply-To: <1429869513-2906-2-git-send-email-guz.fnst@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, tj@kernel.org, mingo@redhat.com, x86@kernel.org, rjw@rjwysocki.net, hpa@zytor.com, linux-acpi@vger.kernel.org, laijs@cn.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, tangchen@cn.fujitsu.com, izumi.taku@jp.fujitsu.com

On Fri, 24 Apr 2015 17:58:33 +0800 Gu Zheng <guz.fnst@cn.fujitsu.com> wrote:

> Since the change to the cpu <--> mapping (map the cpu to the physical
> node for all possible at the boot), the node of cpu may be not present,
> so we use the best near online node if the node is not present in the low
> level allocation APIs.
> 
> ...
>
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -298,9 +298,31 @@ __alloc_pages(gfp_t gfp_mask, unsigned int order,
>  	return __alloc_pages_nodemask(gfp_mask, order, zonelist, NULL);
>  }
>  
> +static int find_near_online_node(int node)
> +{
> +	int n, val;
> +	int min_val = INT_MAX;
> +	int best_node = -1;
> +
> +	for_each_online_node(n) {
> +		val = node_distance(node, n);
> +
> +		if (val < min_val) {
> +			min_val = val;
> +			best_node = n;
> +		}
> +	}
> +
> +	return best_node;
> +}

This should be `inline' if it's in a header file.

But it is far too large to be inlined anyway - please move it to a .c file.

And please document it.  A critical thing to describe is how we
determine whether a node is "near".  There are presumably multiple ways
in which we could decide that a node is "near" (number of hops, minimum
latency, ...).  Which one did you choose, and why?

>  static inline struct page *alloc_pages_node(int nid, gfp_t gfp_mask,
>  						unsigned int order)
>  {
> +	/* Offline node, use the best near online node */
> +	if (!node_online(nid))
> +		nid = find_near_online_node(nid);
> +
>  	/* Unknown node is current node */
>  	if (nid < 0)
>  		nid = numa_node_id();
> @@ -311,7 +333,11 @@ static inline struct page *alloc_pages_node(int nid, gfp_t gfp_mask,
>  static inline struct page *alloc_pages_exact_node(int nid, gfp_t gfp_mask,
>  						unsigned int order)
>  {
> -	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES || !node_online(nid));
> +	/* Offline node, use the best near online node */
> +	if (!node_online(nid))
> +		nid = find_near_online_node(nid);
> +
> +	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
>  
>  	return __alloc_pages(gfp_mask, order, node_zonelist(nid, gfp_mask));
>  }

Ouch.  These functions are called very frequently, and adding overhead
to them is a big deal.  And the patch even adds overhead to non-x86
architectures which don't benefit from it!

Is there no way this problem can be fixed somewhere else?  Preferably
by fixing things up at hotplug time.
