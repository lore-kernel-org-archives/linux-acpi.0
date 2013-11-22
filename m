From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v2 4/6] ACPI: ARM: exclude DMI calls
Date: Fri, 22 Nov 2013 07:25:49 -0600
Message-ID: <CAL_JsqKbL2Zhpbg8wp4qZekZwJO20njUO4nCzzz1KZexmK9tLQ@mail.gmail.com>
References: <1385080915-23430-1-git-send-email-al.stone@linaro.org>
	<1385080915-23430-5-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vc0-f170.google.com ([209.85.220.170]:50927 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132Ab3KVNZu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Nov 2013 08:25:50 -0500
Received: by mail-vc0-f170.google.com with SMTP id ht10so869964vcb.1
        for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2013 05:25:50 -0800 (PST)
In-Reply-To: <1385080915-23430-5-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: al.stone@linaro.org
Cc: linux-acpi@vger.kernel.org, Linaro Patches <patches@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, linaro-acpi@lists.linaro.org

On Thu, Nov 21, 2013 at 6:41 PM,  <al.stone@linaro.org> wrote:
> From: Al Stone <al.stone@linaro.org>
>
> Modified #ifdef so that DMI is not used on ARM platforms which
> are currently implementing ACPI reduced HW mode.

It is really not allowed or is optional? There are various people that
want DMI tables on ARM.

Rob

> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>  include/linux/dmi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/dmi.h b/include/linux/dmi.h
> index f820f0a..a03deb8 100644
> --- a/include/linux/dmi.h
> +++ b/include/linux/dmi.h
> @@ -83,7 +83,7 @@ struct dmi_device {
>         void *device_data;      /* Type specific data */
>  };
>
> -#ifdef CONFIG_DMI
> +#if IS_ENABLED(CONFIG_DMI) && !IS_ENABLED(CONFIG_ACPI_REDUCED_HARDWARE)
>
>  struct dmi_dev_onboard {
>         struct dmi_device dev;
> --
> 1.8.3.1
>
>
> _______________________________________________
> linaro-kernel mailing list
> linaro-kernel@lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-kernel
