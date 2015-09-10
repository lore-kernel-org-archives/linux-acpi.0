From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 3/7] x86, gfp: Cache best near node for memory
 allocation.
Date: Thu, 10 Sep 2015 15:29:35 -0400
Message-ID: <20150910192935.GI8114@mtj.duckdns.org>
References: <1441859269-25831-1-git-send-email-tangchen@cn.fujitsu.com>
 <1441859269-25831-4-git-send-email-tangchen@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1441859269-25831-4-git-send-email-tangchen@cn.fujitsu.com>
Sender: owner-linux-mm@kvack.org
To: Tang Chen <tangchen@cn.fujitsu.com>
Cc: jiang.liu@linux.intel.com, mika.j.penttila@gmail.com, mingo@redhat.com, akpm@linux-foundation.org, rjw@rjwysocki.net, hpa@zytor.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, qiaonuohan@cn.fujitsu.com, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Gu Zheng <guz.fnst@cn.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

Hello,

On Thu, Sep 10, 2015 at 12:27:45PM +0800, Tang Chen wrote:
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index ad35f30..1a1324f 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -307,13 +307,19 @@ static inline struct page *alloc_pages_node(int nid, gfp_t gfp_mask,
>  	if (nid < 0)
>  		nid = numa_node_id();
>  
> +	if (!node_online(nid))
> +		nid = get_near_online_node(nid);
> +
>  	return __alloc_pages(gfp_mask, order, node_zonelist(nid, gfp_mask));
>  }

Why not just update node_data[]->node_zonelist in the first place?
Also, what's the synchronization rule here?  How are allocators
synchronized against node hot [un]plugs?

Thanks.

-- 
tejun

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
