From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/22] Remove trailing whitespace
Date: Wed, 20 Dec 2006 02:35:30 -0500
Message-ID: <200612200235.30393.lenb@kernel.org>
References: <200612192218.49326.corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53291 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072AbWLTHgH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Dec 2006 02:36:07 -0500
In-Reply-To: <200612192218.49326.corentincj@iksaif.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: corentincj@iksaif.net
Cc: linux-acpi@vger.kernel.org

On Tuesday 19 December 2006 16:18, Corentin CHARY wrote:

> @@ -485,9 +485,9 @@
>         len += sprintf(page, ACPI_HOTK_NAME " " ASUS_ACPI_VERSION "\n");
>         len += sprintf(page + len, "Model reference    : %s\n",
>                        hotk->methods->name);
> -       /*
> -        * The SFUN method probably allows the original driver to get the list
> -        * of features supported by a given model. For now, 0x0100 or 0x0800
> +       /*
> +        * The SFUN method probably allows the original driver to get the list
> +        * of features supported by a given model. For now, 0x0100 or 0x0800
>          * bit signifies that the laptop is equipped with a Wi-Fi MiniPCI 
> card.

This patch is corrupt because "card." starts a new line.
If you are using kmail, perhaps you could check
settings/configure kmail/composer/
and uncheck "word wrap at column [n]"

thanks,
-Len
 
