From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/3] ACPI: Don't create a platform_device for IOAPIC/IOxAPIC
Date: Wed, 22 Mar 2017 18:42:39 +0100
Message-ID: <2232546.0OJbVJtxLm@aspire.rjw.lan>
References: <1490204005-2733-1-git-send-email-joro@8bytes.org> <1490204005-2733-4-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61883 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934386AbdCVRsP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 22 Mar 2017 13:48:15 -0400
In-Reply-To: <1490204005-2733-4-git-send-email-joro@8bytes.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>

On Wednesday, March 22, 2017 06:33:25 PM Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> No platform-device is required for IO(x)APICs, so don't even
> create them.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

If we do this, I'd prefer not to do [2/3], because we'll introduce code that
will be essentially dead then.

> ---
>  drivers/acpi/acpi_platform.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> index b4c1a6a..03250e1 100644
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -25,9 +25,11 @@
>  ACPI_MODULE_NAME("platform");
>  
>  static const struct acpi_device_id forbidden_id_list[] = {
> -	{"PNP0000", 0},	/* PIC */
> -	{"PNP0100", 0},	/* Timer */
> -	{"PNP0200", 0},	/* AT DMA Controller */

Why do you change the existing entries?

> +	{"PNP0000",  0},	/* PIC */
> +	{"PNP0100",  0},	/* Timer */
> +	{"PNP0200",  0},	/* AT DMA Controller */
> +	{"ACPI0009", 0},	/* IOxAPIC */
> +	{"ACPI000A", 0},	/* IOAPIC */
>  	{"", 0},
>  };
>  
> 

Thanks,
Rafael

