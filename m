From: Jeff Wu <zlinuxkernel@gmail.com>
Subject: Re: [PATCH] ACPI:add _STA evaluating at do_acpi_find_child()
Date: Tue, 21 May 2013 12:13:22 +0800
Message-ID: <CAPb2CANquybfFOkvms1JebpOSFS_rF+3=4cCspKviZQNn2n5kg@mail.gmail.com>
References: <1369135173-4457-1-git-send-email-jeff.wu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f194.google.com ([209.85.214.194]:49463 "EHLO
	mail-ob0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715Ab3EUENX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 May 2013 00:13:23 -0400
Received: by mail-ob0-f194.google.com with SMTP id dn14so57438obc.9
        for <linux-acpi@vger.kernel.org>; Mon, 20 May 2013 21:13:22 -0700 (PDT)
In-Reply-To: <1369135173-4457-1-git-send-email-jeff.wu@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: jeff.wu@amd.com
Cc: lenb@kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org, lekensteyn@gmail.com, dagobertstaler@gmail.com, shane.huang@amd.com, aaron.lwe@gmail.com

I also found  the similar topic at mail list :
1.
[PATCH] ACPI: return first _ADR match for acpi_get_child
http://www.spinics.net/lists/linux-acpi/msg39739.html

2.ACPI: Rework acpi_get_child() to be more efficient" has been added
to the 3.8-stable tree
http://www.spinics.net/lists/stable/msg03621.html

2013/5/21  <jeff.wu@amd.com>:
> From: Jeff Wu <zlinuxkernel@gmail.com>
>
> Once do_acpi_find_child() found the first matching handle, it makes the acpi_get_child()
> loop stop and return the matching handle. But, at some of the platforms, a "_ADR" is
> with the multiple devices, and if one is enabled, the others will be disabled.
> Just like a case:
> Address : 0x1FFFF ; handle : SB_PCI0.SATA.DEV0
> Address : 0x1FFFF ; handle : SB_PCI0.SATA.DEV1
> Address : 0x1FFFF ; handle : SB_PCI0.SATA.DEV2
>
> If DEV0 and DEV1 are disabled and DEV2 is enabled, the target is to get DEV2 handle, but
> actually it always return the first disabled device DEV0 handle. So add a _STA evaluating
> at do_acpi_find_child() to check the device status. If the object exists, but it is disabled,
> acpi_get_child() will continue looping to get the correct handle that the object exists and
> is enabled.
>
>
> Signed-off-by: Jeff Wu <zlinuxkernel@gmail.com>
> ---
>  drivers/acpi/glue.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
> index 40a84cc..ace6c2e 100644
> --- a/drivers/acpi/glue.c
> +++ b/drivers/acpi/glue.c
> @@ -81,11 +81,14 @@ static struct acpi_bus_type *acpi_get_bus_type(struct device *dev)
>  static acpi_status do_acpi_find_child(acpi_handle handle, u32 lvl_not_used,
>                                       void *addr_p, void **ret_p)
>  {
> -       unsigned long long addr;
>         acpi_status status;
> +       unsigned long long addr = 0, sta = 0;
>
>         status = acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL, &addr);
>         if (ACPI_SUCCESS(status) && addr == *((u64 *)addr_p)) {
> +               status = acpi_bus_get_status_handle(handle, &sta);
> +               if (ACPI_SUCCESS(status) && !(sta & ACPI_STA_DEVICE_ENABLED))
> +                       return AE_CTRL_DEPTH;
>                 *ret_p = handle;
>                 return AE_CTRL_TERMINATE;
>         }
> --
> 1.8.1.2
>
>
