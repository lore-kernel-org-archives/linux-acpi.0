From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v8 7/7] Provide the interface to validate the proc_id
 which they give
Date: Tue, 19 Jul 2016 14:53:20 -0400
Message-ID: <20160719185320.GN3078@mtj.duckdns.org>
References: <1468913288-16605-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <1468913288-16605-8-git-send-email-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1468913288-16605-8-git-send-email-douly.fnst@cn.fujitsu.com>
Sender: owner-linux-mm@kvack.org
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: cl@linux.com, mika.j.penttila@gmail.com, mingo@redhat.com, akpm@linux-foundation.org, rjw@rjwysocki.net, hpa@zytor.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, len.brown@intel.com, lenb@kernel.org, tglx@linutronix.de, chen.tang@easystack.cn, rafael@kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 19, 2016 at 03:28:08PM +0800, Dou Liyang wrote:
> When we want to identify whether the proc_id is unreasonable or not, we
> can call the "acpi_processor_validate_proc_id" function. It will search
> in the duplicate IDs. If we find the proc_id in the IDs, we return true
> to the call function. Conversely, false represents available.
> 
> When we establish all possible cpuid <-> nodeid mapping, we will use the
> proc_id from ACPI table.
> 
> We do validation when we get the proc_id. If the result is true, we will
> stop the mapping.

The patch title probably should include "acpi:" header.  I can't tell
much about the specifics of the acpi changes but I think this is the
right approach for handling cpu hotplugs.

Thanks.

-- 
tejun

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
