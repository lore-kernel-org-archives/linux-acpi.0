From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] [25/2many] MAINTAINERS - ACPI FAN DRIVER
Date: Tue, 14 Aug 2007 00:20:35 -0400
Message-ID: <200708140020.36192.lenb@kernel.org>
References: <46bff892.QY86DfzmPpGJRVW1%joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47045 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934164AbXHNEVJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Aug 2007 00:21:09 -0400
In-Reply-To: <46bff892.QY86DfzmPpGJRVW1%joe@perches.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joe@perches.com
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, akpm@linux-foundation.org

Acked-by: Len Brown <len.brown@intel.com>

(and the maintainer can just be me now, per other message)

thanks,
-Len

On Monday 13 August 2007 02:22, joe@perches.com wrote:
> Add file pattern to MAINTAINER entry
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ef63c9d..e99d959 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -277,6 +277,7 @@ M:	konstantin.a.karasyov@intel.com
>  L:	linux-acpi@vger.kernel.org
>  W:	http://acpi.sourceforge.net/
>  S:	Supported
> +F:	drivers/acpi/fan.c
>  
>  ACPI PCI HOTPLUG DRIVER
>  P:	Kristen Carlson Accardi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
