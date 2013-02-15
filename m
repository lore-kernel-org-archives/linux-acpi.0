From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH EDAC 13/13] ghes_edac: Improve driver's printk messages
Date: Fri, 15 Feb 2013 08:38:17 -0800
Message-ID: <1360946297.2089.6.camel@joe-AO722>
References: <cover.1360931635.git.mchehab@redhat.com>
	 <30bb26a76d98f876648020517cd38a4884626f44.1360931635.git.mchehab@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from perches-mx.perches.com ([206.117.179.246]:38397 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751320Ab3BOQiS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Feb 2013 11:38:18 -0500
In-Reply-To: <30bb26a76d98f876648020517cd38a4884626f44.1360931635.git.mchehab@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: linux-acpi@vger.kernel.org, Huang Ying <ying.huang@intel.com>, Tony Luck <tony.luck@intel.com>, Linux Edac Mailing List <linux-edac@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, 2013-02-15 at 10:45 -0200, Mauro Carvalho Chehab wrote:
> Provide a better infrastructure for printk's inside the driver:
> 	- use edac_dbg() for debug messages;
> 	- standardize the usage of pr_info();
> 	- provide warning about the risk of relying on this
> 	  driver.
[]
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
[]
> @@ -80,7 +80,8 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
>  						       dimm_fill->count, 0, 0);
>  
>  		if (entry->size == 0xffff) {
> -			pr_info(GHES_PFX "Can't get dimm size\n");
> +			pr_info(GHES_PFX "Can't get DIMM%i size\n",
> +				dimm_fill->count);

Perhaps these should use
#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
and remove GHEX_PFX from all the pr_<level>()'s?


