From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH  1/16][BUG] Export kobject_rename for pci_hotplug_core
	(Not for mainline!)
Date: Fri, 21 Mar 2008 09:56:05 -0600
Message-ID: <20080321155605.GE17292@ldl.fc.hp.com>
References: <20080318210539.GA30421@ldl.fc.hp.com> <47E33472.1000602@jp.fujitsu.com> <47E334E2.6060306@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:1508 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756968AbYCUP4H (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Mar 2008 11:56:07 -0400
Content-Disposition: inline
In-Reply-To: <47E334E2.6060306@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Greg KH <gregkh@suse.de>, Gary Hade <garyhade@us.ibm.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Matthew Wilcox <matthew@wil.cx>, warthog19@eaglescrag.net, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org

Hi Greg,

This patch looks like a candidate for the current 2.6.25 cycle.
Any chance of getting it in there?

If not, maybe you can push it into linux-next without waiting for
the rest of my pci_slot changes, since this is a fix for the
kobject core, and not necessarily what I'm working on.

Thanks.

/ac

* Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>:
> Export kobject_rename() to fix the following link error. This happens
> when pci_hotplug_core driver is compiled as a kernel module.
> 
> ERROR: "kobject_rename" [drivers/pci/hotplug/pci_hotplug.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
> make: *** Waiting for unfinished jobs....
> 
> Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

Acked-by: Alex Chiang <achiang@hp.com>

> 
> ---
>  lib/kobject.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: linux-2.6.25-rc6/lib/kobject.c
> ===================================================================
> --- linux-2.6.25-rc6.orig/lib/kobject.c
> +++ linux-2.6.25-rc6/lib/kobject.c
> @@ -456,6 +456,7 @@ out:
>  
>  	return error;
>  }
> +EXPORT_SYMBOL_GPL(kobject_rename);
>  
>  /**
>   * kobject_move - move object to another parent
> 
> 
