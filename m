From: Naresh Bhat <naresh.bhat@linaro.org>
Subject: Re: [PATCH] ACPI/fan: Initialize acpi_state variable
Date: Mon, 1 Jul 2013 17:31:46 +0530
Message-ID: <CAFoFrHa_XsKaWDag_k3o_Lgizsf+qZUYPjBn9pvWSe83BY8sOg@mail.gmail.com>
References: <1372362463-4186-1-git-send-email-naresh.bhat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:53881 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695Ab3GAMBr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Jul 2013 08:01:47 -0400
Received: by mail-ob0-f169.google.com with SMTP id up14so4186789obb.0
        for <linux-acpi@vger.kernel.org>; Mon, 01 Jul 2013 05:01:47 -0700 (PDT)
In-Reply-To: <1372362463-4186-1-git-send-email-naresh.bhat@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com, Patch Tracking <patches@linaro.org>, linaro-kernel@lists.linaro.org, Naresh Bhat <naresh.bhat@linaro.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

Hi Rafeal,

I appreciate if you give any feedback on the provided patch.

Thanks
-Naresh Bhat

On 28 June 2013 01:17,  <naresh.bhat@linaro.org> wrote:
> From: Naresh Bhat <naresh.bhat@linaro.org>
>
>   CC      drivers/acpi/fan.o
> drivers/acpi/fan.c: In function =91fan_get_cur_state=92:
> drivers/acpi/fan.c:96:9: warning: =91acpi_state=92 may be used uninit=
ialized in this function [-Wuninitialized]
> ---
>  drivers/acpi/fan.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
> index f815da8..f961435 100644
> --- a/drivers/acpi/fan.c
> +++ b/drivers/acpi/fan.c
> @@ -84,7 +84,7 @@ static int fan_get_cur_state(struct thermal_cooling=
_device *cdev, unsigned long
>  {
>         struct acpi_device *device =3D cdev->devdata;
>         int result;
> -       int acpi_state;
> +       int acpi_state =3D ACPI_STATE_D0;
>
>         if (!device)
>                 return -EINVAL;
> --
> 1.7.9.5
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
