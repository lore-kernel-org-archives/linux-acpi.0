From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 03/15] ACPICA: move common private headers under
 kernel/acpi/acpica/
Date: Fri, 02 Jan 2009 16:56:32 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901021648440.3590@localhost.localdomain>
References: <526647e1bb69fd3248558fce365bb1fbfb226ccd.1230719795.git.len.brown@intel.com>
 <c6b6f68232ab6da57e764c64b23b4649c4e7c463.1230719801.git.len.brown@intel.com>
 <20090102191451.GB14249@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:37376 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758114AbZABV4w (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jan 2009 16:56:52 -0500
In-reply-to: <20090102191451.GB14249@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>



-- Len Brown, Intel Open Source Technology Center
> Random example - i dont think stuff like this is readable [in to-be 
> kernel/acpi/utilities/utcache.c]:
> 
>         if (cache->current_depth >= cache->max_depth) {
>                 ACPI_FREE(object);
>                 ACPI_MEM_TRACKING(cache->total_freed++);
>         }
> 
>         /* Otherwise put this object back into the cache */
> 
>         else {
>                 status = acpi_ut_acquire_mutex(ACPI_MTX_CACHES);
>                 if (ACPI_FAILURE(status)) {
>                         return (status);
>                 }

Oops, I notice that I skipped over this comment.

It is a good example of needed cleanup.
(I proposed moving this to kernel/acpi/acpica/, not 
kernel/acpi/utilities/)
But the Linux kernel doesn't compile the contents of utcache.c
and indeed, I should delete that entire file from the tree.

Linux compiles this in osl.c instead:

acpi_status acpi_os_release_object(acpi_cache_t * cache, void *object)
{               
        kmem_cache_free(cache, object);
        return (AE_OK);
}

thanks for pointing this out, I'll deal with it right now.

-Len

