From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 7/12] acpi: fix another compile warning
Date: Wed, 20 Jun 2007 15:46:28 +0200
Message-ID: <200706201546.28457.ak@suse.de>
References: <20070619225035.GI5193@alberich.amd.com> <20070620084911.GO5193@alberich.amd.com> <200706200936.31236.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40954 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270AbXFTNqk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Jun 2007 09:46:40 -0400
In-Reply-To: <200706200936.31236.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andreas Herrmann <andreas.herrmann3@amd.com>, Steven Whitehouse <swhiteho@redhat.com>, Shai Fultheim <shai@scalex86.org>, Ravikiran Thirumalai <kiran@scalex86.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org


> The underlying problem is that Kconfig doesn't support using select
> on targets which themselves have dependencies.
> 
> Signed-off-by: Len Brown <len.brown@intel.com>

The depends on ACPI is fine by me, but I would prefer if the 
ACPI_NUMA dependency worked the other way round (APCI_NUMA default y
and depends on the relevant architecture specific symbols). That would
be more user friendly I think because all the NUMA options would
be in one place.

-Andi

> diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
> index 5ce9443..e9d7767 100644
> --- a/arch/x86_64/Kconfig
> +++ b/arch/x86_64/Kconfig
> @@ -364,9 +364,9 @@ config NODES_SHIFT
>  config X86_64_ACPI_NUMA
>         bool "ACPI NUMA detection"
>         depends on NUMA
> -       select ACPI 
> +       depends on ACPI 
>  	select PCI
> -       select ACPI_NUMA
> +       depends on ACPI_NUMA
>         default y
>         help
>  	 Enable ACPI SRAT based node topology detection.
> 


