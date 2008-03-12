From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] PNP: use dev_printk for quirk messages
Date: Wed, 12 Mar 2008 14:22:31 -0700
Message-ID: <20080312142231.cf6ecc46.akpm@linux-foundation.org>
References: <200803041647.28298.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33295 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751672AbYCLVWt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Mar 2008 17:22:49 -0400
In-Reply-To: <200803041647.28298.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: ambx1@neo.rr.com, linux-acpi@vger.kernel.org

On Tue, 4 Mar 2008 16:47:27 -0700
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> Convert quirk printks to dev_printk().
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> Index: linux-mm/drivers/pnp/quirks.c
> ===================================================================
> --- linux-mm.orig/drivers/pnp/quirks.c	2008-03-04 16:41:17.000000000 -0700
> +++ linux-mm/drivers/pnp/quirks.c	2008-03-04 16:44:00.000000000 -0700
> @@ -51,7 +51,8 @@
>  		port3->min += 0x800;
>  		port3->max += 0x800;
>  	}
> -	printk(KERN_INFO "pnp: AWE32 quirk - adding two ports\n");
> +	dev_info(&dev->dev, "AWE32 quirk - added ioports 0x%lx and 0x%lx\n",
> +		(unsigned long) port2->min, (unsigned long) port3->min);
>  }

drivers/pnp/quirks.c: In function 'quirk_awe32_resources':
drivers/pnp/quirks.c:25: warning: 'port3' may be used uninitialized in this function
drivers/pnp/quirks.c:25: warning: 'port2' may be used uninitialized in this function

the warning is correct, methinks.  If dev->dependent happens to be NULL,
we oops.

I'll just move the dev_info() inside the loop, which is more logical and
is actually correct.  The code at present will only print the last-added
ports?
