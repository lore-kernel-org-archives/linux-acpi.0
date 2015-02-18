From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] Revert "ACPI / LPSS: Remove non-existing clock control from Intel Lynxpoint I2C"
Date: Wed, 18 Feb 2015 07:16:27 +0100
Message-ID: <1912364.L5Uad8UjkH@vostro.rjw.lan>
References: <1424075188-23834-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58266 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750783AbbBRFxP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Feb 2015 00:53:15 -0500
In-Reply-To: <1424075188-23834-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Chris Rorvick <chris@rorvick.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Monday, February 16, 2015 10:26:28 AM Jarkko Nikula wrote:
> Revert commit b893e80e3147 ("ACPI / LPSS: Remove non-existing clock control
> from Intel Lynxpoint I2C") because it causes touchpad to not load on Dell
> XPS13.
> 
> Regression is a clear indication that not only some early prototype version
> of Lynxpoint I2C but also newer versions can be doing clock gating even
> documentation does not state it.
> 
> Therefore it is best to revert since this clock gating haven't caused known
> issues on those Lynxpoint version which don't do clock gating.
> 
> Reported-by: Chris Rorvick <chris@rorvick.com>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Applied, thanks!

> ---
> For v3.20.
> ---
>  drivers/acpi/acpi_lpss.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 02e835f3cf8a..fa0e3d61e5e7 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -125,7 +125,7 @@ static struct lpss_device_desc lpt_dev_desc = {
>  };
>  
>  static struct lpss_device_desc lpt_i2c_dev_desc = {
> -	.flags = LPSS_CLK | LPSS_LTR,
> +	.flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_LTR,
>  	.prv_offset = 0x800,
>  };
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
