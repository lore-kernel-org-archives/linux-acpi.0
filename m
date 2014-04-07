From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: Update the ownership and developers for ACPI in Kconfig
Date: Mon, 07 Apr 2014 14:21:31 +0200
Message-ID: <1487377.07icAKoM8K@vostro.rjw.lan>
References: <1396528650-7402-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59610 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755208AbaDGMFe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Apr 2014 08:05:34 -0400
In-Reply-To: <1396528650-7402-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Grant Likely <grant.likely@linaro.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On Thursday, April 03, 2014 08:37:30 PM Hanjun Guo wrote:
> The UEFI Forum included the ACPI spec in its portfolio in October 2013
> and will host future spec iterations, following the ACPI v5.0a release.
> 
> A UEFI Forum working group named ACPI Specification Working Group (ASWG)
> has been established to handle future ACPI developments, any UEFI member
> can join the group and contribute to ACPI specification.
> 
> So update the ownership and developers for ACPI in Kconfig accordingly,
> and update the website link to ACPI specification too.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/acpi/Kconfig |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index c205653..831e541 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -32,9 +32,10 @@ menuconfig ACPI
>  	  <http://acpica.org/>
>  
>  	  ACPI is an open industry specification co-developed by
> -	  Hewlett-Packard, Intel, Microsoft, Phoenix, and Toshiba.
> +	  ACPI Specification Working Group (ASWG) under UEFI Forum, any
> +	  UEFI member can join ASWG and contribute to ACPI specification.
>  	  The specification is available at:
> -	  <http://www.acpi.info>

The spec is still available from here, so why are you removing this link?

> +	  <http://www.uefi.org/acpi/specs>
>  
>  if ACPI
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
