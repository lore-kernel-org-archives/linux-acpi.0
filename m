From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] [22/2many] MAINTAINERS - ACPI
Date: Mon, 13 Aug 2007 11:46:12 +0100
Message-ID: <20070813114612.04f2986a@the-village.bc.nu>
References: <46bff88d.zVo0DUSTuvIvka+P%joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43220 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S938446AbXHMKjv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Aug 2007 06:39:51 -0400
In-Reply-To: <46bff88d.zVo0DUSTuvIvka+P%joe@perches.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joe@perches.com
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, len.brown@intel.com, akpm@linux-foundation.org

On Sun, 12 Aug 2007 23:22:05 -0700
joe@perches.com wrote:

> Add file pattern to MAINTAINER entry
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1162fb7..93a100b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -251,6 +251,9 @@ L:	linux-acpi@vger.kernel.org
>  W:	http://acpi.sourceforge.net/
>  T:	git kernel.org:/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git
>  S:	Supported
> +F:	drivers/acpi/
> +F:	drivers/ata/libata-acp*
> +F:	drivers/pnp/pnpacpi/

NAK - libata-acpi isthe libata team
