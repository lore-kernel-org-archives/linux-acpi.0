From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH] Revert "ACPI / LPSS: Remove non-existing clock control
 from Intel Lynxpoint I2C"
Date: Mon, 16 Feb 2015 07:29:44 -0600
Message-ID: <CAEUsAPbr9_Oqt43PnQBF+ciindUDo4nO8T2H2X5W7Cv1viu-Mw@mail.gmail.com>
References: <1424075188-23834-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:50038 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932355AbbBPN3p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Feb 2015 08:29:45 -0500
Received: by mail-qc0-f180.google.com with SMTP id s11so23966984qcv.11
        for <linux-acpi@vger.kernel.org>; Mon, 16 Feb 2015 05:29:44 -0800 (PST)
In-Reply-To: <1424075188-23834-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Mon, Feb 16, 2015 at 2:26 AM, Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
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
> -       .flags = LPSS_CLK | LPSS_LTR,
> +       .flags = LPSS_CLK | LPSS_CLK_GATE | LPSS_LTR,
>         .prv_offset = 0x800,
>  };

Tested-by: Chris Rorvick <chris@rorvick.com>
