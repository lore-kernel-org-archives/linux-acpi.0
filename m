From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] CPPC: Fix potential ptr leak
Date: Wed, 28 Oct 2015 04:18:06 +0100
Message-ID: <14755745.R11NDk0xNR@vostro.rjw.lan>
References: <20151022194928.GA24403@mwanda> <1445590972-12331-1-git-send-email-ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65031 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754940AbbJ1CtJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Oct 2015 22:49:09 -0400
In-Reply-To: <1445590972-12331-1-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: rafael@kernel.org, dan.carpenter@oracle.com, linux-acpi@vger.kernel.org

On Friday, October 23, 2015 05:02:52 AM Ashwin Chaugule wrote:
> The patch 337aadff8e45: "ACPI: Introduce CPU performance controls
> using CPPC" from Oct 2, 2015, leads to the following static checker
> warning:
> 
>         drivers/acpi/cppc_acpi.c:527 acpi_cppc_processor_probe()
>         warn: overwrite may leak 'cpc_ptr'
> 
> Fix warning by removing bogus per cpu ptr dereference.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> ---
>  drivers/acpi/cppc_acpi.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 0bbf84b..8ca4c2c 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -524,7 +524,6 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>  	return 0;
>  
>  out_free:
> -	cpc_ptr = per_cpu(cpc_desc_ptr, pr->id);
>  	kfree(cpc_ptr);
>  
>  out_buf_free:

Applied, thanks!

Rafael

