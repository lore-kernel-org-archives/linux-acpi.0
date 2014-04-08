From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] ACPI: Update the ownership and developers for ACPI in Kconfig
Date: Tue, 08 Apr 2014 14:01:57 +0200
Message-ID: <3442476.Y3PYFAt6A7@vostro.rjw.lan>
References: <1396956241-8337-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60572 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756288AbaDHLp5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Apr 2014 07:45:57 -0400
In-Reply-To: <1396956241-8337-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Grant Likely <grant.likely@linaro.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

On Tuesday, April 08, 2014 07:24:01 PM Hanjun Guo wrote:
> The UEFI Forum included the ACPI spec in its portfolio in October 2013
> and will host future spec iterations, following the ACPI v5.0a release.
> 
> A UEFI Forum working group named ACPI Specification Working Group (ASWG)
> has been established to handle future ACPI developments, any UEFI member
> can join the group and contribute to ACPI specification.
> 
> So update the ownership and developers for ACPI in Kconfig accordingly,
> and add another website link to ACPI specification too.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/acpi/Kconfig |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index c205653..6bbf36e 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -32,9 +32,11 @@ menuconfig ACPI
>  	  <http://acpica.org/>
>  
>  	  ACPI is an open industry specification co-developed by
> -	  Hewlett-Packard, Intel, Microsoft, Phoenix, and Toshiba.
> +	  ACPI Specification Working Group (ASWG) under UEFI Forum, any
> +	  UEFI member can join ASWG and contribute to ACPI specification.

Thinking a bit more about that, I'd prefer this wording:

	ACPI is an open industry specification originally co-developed by
	Hewlett-Packard, Intel, Microsoft, Phoenix, and Toshiba.  Currently,
	it is developed by the ACPI Specification Working Group (ASWG) under
	the UEFI Forum and any UEFI member can join the ASWG and contribute
	to the ACPI specification.

>  	  The specification is available at:
>  	  <http://www.acpi.info>
> +	  <http://www.uefi.org/acpi/specs>
>  
>  if ACPI

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
