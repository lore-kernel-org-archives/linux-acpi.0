From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2 17/17] arch, x86: pmem api for ensuring durability of
 persistent memory updates
Date: Tue, 30 Jun 2015 13:21:37 +0300
Message-ID: <20150630102137.GC12986@mwanda>
References: <20150625090554.40066.69562.stgit@dwillia2-desk3.jf.intel.com>
 <20150625093749.40066.25475.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:18906 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbbF3KWR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Jun 2015 06:22:17 -0400
Content-Disposition: inline
In-Reply-To: <20150625093749.40066.25475.stgit@dwillia2-desk3.jf.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>, Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: linux-nvdimm@ml01.01.org, axboe@kernel.dk, boaz@plexistor.com, toshi.kani@hp.com, mingo@kernel.org, linux-kernel@vger.kernel.org, hch@lst.de, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-fsdevel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

On Thu, Jun 25, 2015 at 05:37:49AM -0400, Dan Williams wrote:
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 867722591be2..9a528d945498 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -21,6 +21,7 @@
>  # define __rcu		__attribute__((noderef, address_space(4)))

On this side of the #ifdef CONFIG_SPARSE_RCU_POINTER statement then
__pmem isn't defined so it leads to a build error running a CHECKER on
today's linux-next.

I would define __pmem away, but I don't understand why __pmem and
CONFIG_SPARSE_RCU_POINTER are related at all.  Maybe it should be
outside the if statement?

>  #else
>  # define __rcu
> +# define __pmem		__attribute__((noderef, address_space(5)))
>  #endif
>  extern void __chk_user_ptr(const volatile void __user *);
>  extern void __chk_io_ptr(const volatile void __iomem *);
> @@ -42,6 +43,7 @@ extern void __chk_io_ptr(const volatile void __iomem *);
>  # define __cond_lock(x,c) (c)
>  # define __percpu
>  # define __rcu
> +# define __pmem
>  #endif
>  
>  /* Indirect macros required for expanded argument pasting, eg. __LINE__. */

regards,
dan carpenter
