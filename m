From: Peter Klotz <peter.klotz@aon.at>
Subject: Re: ACPI related kernel panic when booting 2.6.29-rc2
Date: Sun, 18 Jan 2009 09:57:49 +0100
Message-ID: <4972EF0D.7050109@aon.at>
References: <497243D5.8000708@aon.at> <497260A0.6030401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from WARSL404PIP1.highway.telekom.at ([195.3.96.112]:12428 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752699AbZARI5x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 18 Jan 2009 03:57:53 -0500
Received: from 212-183-96-37.adsl.highway.telekom.at (HELO [192.168.0.100]) ([212.183.96.37])
          (envelope-sender <peter.klotz@aon.at>)
          by smarthub92.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-acpi@vger.kernel.org>; 18 Jan 2009 08:57:50 -0000
In-Reply-To: <497260A0.6030401@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Alexey Starikovskiy wrote:
> please use the patch from Tero Roponen.
> 
> This patch fixes the crash I experienced in 2.6.29-rc2.
> Tested on ASUS M50vm.
> 
> Signed-off-by: Tero Roponen <tero.roponen@gmail.com>
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index a2b82c9..5c2f5d3 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -982,7 +982,7 @@ int __init acpi_ec_ecdt_probe(void)
>         saved_ec = kmalloc(sizeof(struct acpi_ec), GFP_KERNEL);
>         if (!saved_ec)
>             return -ENOMEM;
> -        memcpy(&saved_ec, boot_ec, sizeof(saved_ec));
> +        memcpy(saved_ec, boot_ec, sizeof(*saved_ec));
>     /* fall through */
>     }
>     /* This workaround is needed only on some broken machines,

Thanks a lot, this patch fixed the problem on my Asus B50A.

Regards, Peter.
