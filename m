From: Yasunori Goto <y-goto@jp.fujitsu.com>
Subject: Re: [Lhms-devel] [PATCH](memory hotplug) Fix acpi_get_node() when _PXM is not defined.
Date: Wed, 02 Aug 2006 10:47:07 +0900
Message-ID: <20060802095647.C821.Y-GOTO@jp.fujitsu.com>
References: <20060801222852.156A.Y-GOTO@jp.fujitsu.com> <1154456573.6249.11.camel@keithlap>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:10442 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750994AbWHBBs1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Aug 2006 21:48:27 -0400
In-Reply-To: <1154456573.6249.11.camel@keithlap>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: kmannth@us.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, ACPI-ML <linux-acpi@vger.kernel.org>, Andi Kleen <ak@suse.de>, Linux Hotplug Memory Support <lhms-devel@lists.sourceforge.net>


> I don't think Linux should require the ACPI add event to contain the
> _pxm information. (I don't see it required in the spec).

Agree.

> acpi_get_node
> is only going to work with systems that implement the acpi table in this
> way.  

This cause is just I didn't know that there is a box without _PXM
in DSDT. :-P
I prefer that acpi_get_node() should include your case.
Then caller of it can get node without knowledge about SRAT or
DSDT by one call. So, my idea was like followings.

acpi_get_node()
{
       :
	if (node < 0)
		node = arch_search_srat_info(handle);
	if (node < 0) /* NUMA kernel executed on non NUMA box */
		node = 0;

	return node;
}

arch_search_srat_info() must be made for each arch
(i386, x86-64, ia64). And I don't know that all of them can be
posted by publish of 2.6.18. So, I would like to rescue
againt panic.

However, I might make sense one more by your patch....

>  I think something like this might be better...

Why do you enter memory_add_physaddr_to_nid() IN the loop of
searching mem_device? This implies, there is a _CRS which have multiple
memory block entries, and each entries might belong DIFFERENT node 
each other. If so, above my idea is not appropriate. :-(

BTW, memory_add_physaddr_to_nid() is not defined for ia64's NUMA box and
i386's NUMA box. 

Thanks.

> 
> diff -urN linux-2.6.18-rc3-stock/drivers/acpi/acpi_memhotplug.c linux-2.6.17/drivers/acpi/acpi_memhotplug.c
> --- linux-2.6.18-rc3-stock/drivers/acpi/acpi_memhotplug.c	2006-07-31 19:59:05.000000000 -0400
> +++ linux-2.6.17/drivers/acpi/acpi_memhotplug.c	2006-08-01 13:56:03.000000000 -0400
> @@ -241,6 +241,9 @@
>  			continue;
>  		}
>  
> +		if (node < 0)
> +			node = memory_add_physaddr_to_nid(info->start_addr);
> +
>  		result = add_memory(node, info->start_addr, info->length);
>  		if (result)
>  			continue;

-- 
Yasunori Goto 


