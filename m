From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] [28/2many] MAINTAINERS - ACPI VIDEO DRIVER
Date: Tue, 14 Aug 2007 01:16:29 -0400
Message-ID: <200708140116.30199.lenb@kernel.org>
References: <46bff898.QBRdcCdpCAEm8W02%joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54547 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S940845AbXHNFQi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Aug 2007 01:16:38 -0400
In-Reply-To: <46bff898.QBRdcCdpCAEm8W02%joe@perches.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joe@perches.com, rui.zhang@intel.com
Cc: torvalds@linux-foundation.org, luming.yu@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org

On Monday 13 August 2007 02:22, joe@perches.com wrote:
> Add file pattern to MAINTAINER entry
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b159b00..4faf1ce 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -300,6 +300,7 @@ M:	luming.yu@intel.com
>  L:	linux-acpi@vger.kernel.org
>  W:	http://acpi.sourceforge.net/
>  S:	Supported
> +F:	drivers/acpi/video.c

Acked-by: Len Brown <len.brown@intel.com>

Also, as Luming has moved onto other things, and Rui is shy
about being in MAINTAINERS as yet...  Please update to

P:	Len Brown
M: 	len.brown@intel.com

while you are there.

thanks,
-Len

>  ADM1025 HARDWARE MONITOR DRIVER
>  P:	Jean Delvare
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
