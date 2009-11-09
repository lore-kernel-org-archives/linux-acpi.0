From: Stefan Bader <stefan.bader@canonical.com>
Subject: Re: [PATCH][RESEND] acerhdf: Limit modalias matching to supported
Date: Mon, 09 Nov 2009 09:48:01 +0100
Message-ID: <4AF7D741.1040607@canonical.com>
References: <cone.1256214203.879632.3269.1000@onepiie> <1256221616-22577-1-git-send-email-stefan.bader@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:41195 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303AbZKIIr7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2009 03:47:59 -0500
In-Reply-To: <1256221616-22577-1-git-send-email-stefan.bader@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Len,

could you please apply the patch mentioned or help me to understand
what I need to do, in order to correctly submit them?

Thanks,
Stefan

Stefan Bader wrote:
> Inlined patch version
> 
> -Stefan
> 
> From 230e81c3440cdfc5f931755cece4f1181a3b1374 Mon Sep 17 00:00:00 2001
> From: Stefan Bader <stefan.bader@canonical.com>
> Date: Mon, 28 Sep 2009 17:11:29 +0000
> Subject: [PATCH] acerhdf: Limit modalias matching to supported boards
> 
> BugLink: https://bugs.launchpad.net/ubuntu/+bug/435958
> 
> The module alias currently matches any Acer computer but when loaded the
> BIOS checks will only succeed on Aspire One models. This causes a invalid
> BIOS warning for all other models (seen on Aspire 4810T).
> This is not fatal but worries users that see this message. Limiting the
> moule alias to models starting with AOA or DOA for Packard Bell.
> 
> Signed-off-by: Stefan Bader <stefan.bader@canonical.com>
> Acked-by: Borislav Petkov <petkovbb@gmail.com>
> Acked-by: Peter Feuerer <peter@piie.net>
> ---
>  drivers/platform/x86/acerhdf.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
> index aa298d6..890976f 100644
> --- a/drivers/platform/x86/acerhdf.c
> +++ b/drivers/platform/x86/acerhdf.c
> @@ -629,9 +629,10 @@ static void __exit acerhdf_exit(void)
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Peter Feuerer");
>  MODULE_DESCRIPTION("Aspire One temperature and fan driver");
> -MODULE_ALIAS("dmi:*:*Acer*:*:");
> -MODULE_ALIAS("dmi:*:*Gateway*:*:");
> -MODULE_ALIAS("dmi:*:*Packard Bell*:*:");
> +MODULE_ALIAS("dmi:*:*Acer*:pnAOA*:");
> +MODULE_ALIAS("dmi:*:*Gateway*:pnAOA*:");
> +MODULE_ALIAS("dmi:*:*Packard Bell*:pnAOA*:");
> +MODULE_ALIAS("dmi:*:*Packard Bell*:pnDOA*:");
>  
>  module_init(acerhdf_init);
>  module_exit(acerhdf_exit);

