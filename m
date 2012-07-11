From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v3 3/13] memory-hotplug : unify argument of firmware_map_add_early/hotplug
Date: Wed, 11 Jul 2012 08:30:16 -0700
Message-ID: <4FFD9C08.2070502@linux.vnet.ibm.com>
References: <4FFAB0A2.8070304@jp.fujitsu.com> <4FFAB17F.2090209@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:38391 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758106Ab2GKPbJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Jul 2012 11:31:09 -0400
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <dave@linux.vnet.ibm.com>;
	Wed, 11 Jul 2012 11:31:08 -0400
In-Reply-To: <4FFAB17F.2090209@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, rientjes@google.com, liuj97@gmail.com, len.brown@intel.com, benh@kernel.crashing.org, paulus@samba.org, cl@linux.com, minchan.kim@gmail.com, akpm@linux-foundation.org, kosaki.motohiro@jp.fujitsu.com, wency@cn.fujitsu.com

On 07/09/2012 03:25 AM, Yasuaki Ishimatsu wrote:
> @@ -642,7 +642,7 @@ int __ref add_memory(int nid, u64 start,
>  	}
> 
>  	/* create new memmap entry */
> -	firmware_map_add_hotplug(start, start + size, "System RAM");
> +	firmware_map_add_hotplug(start, start + size - 1, "System RAM");

I know the firmware_map_*() calls use inclusive end addresses
internally, but do we really need to expose them?  Both of the callers
you mentioned do:

	firmware_map_add_hotplug(start, start + size - 1, "System RAM");

or

                firmware_map_add_early(entry->addr,
                        entry->addr + entry->size - 1,
                        e820_type_to_string(entry->type));

So it seems a _bit_ silly to keep all of the callers doing this size-1
thing.  I also noted that the new caller that you added does the same
thing.  Could we just change the external calling convention to be
exclusive?

BTW, this patch should probably be first in your series.  It's a real
bugfix.

