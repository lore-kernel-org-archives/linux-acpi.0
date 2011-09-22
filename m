From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH] acpi: Fix possible recursive locking in hwregs.c
Date: Thu, 22 Sep 2011 08:59:57 +0800
Message-ID: <CAF1ivSbZf5zgJphyaLeUZfSgz-oPvAY0bG6V2OMeWPS60nsxxQ@mail.gmail.com>
References: <1316628589.7341.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:63572 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098Ab1IVA76 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Sep 2011 20:59:58 -0400
In-Reply-To: <1316628589.7341.11.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rakib Mullick <rakib.mullick@gmail.com>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

On Thu, Sep 22, 2011 at 2:09 AM, Rakib Mullick <rakib.mullick@gmail.com=
> wrote:
> Calling pm-suspend might trigger a recursive lock in it's code path. =
In function acpi_hw_clear_acpi_status,
> acpi_os_release_lock holds the lock acpi_gbl_hardware_lock before cal=
ling acpi_hw_register_write(), then
> without releasing acpi_gbl_hardware_lock, this function calls acpi_ev=
_walk_gpe_list, which also tries to
> hold acpi_gbl_hardware_lock and thus causes possible recursive lock.

No, acpi_ev_walk_gpe_list holds acpi_gbl_gpe_lock.

Lin Ming

>
> Following patch fixes this scenario by just releasing acpi_gbl_hardwa=
re_lock before calling acpi_ev_walk_gpe_list.
>
> [This patch was created against 3.0-rc3. Since kernel.org is down, I =
don't have the updated tree. So, before applying
> it might require some adjustment.]
>
> Signed-off-by: Rakib Mullick <rakib.mullick@gmail.com>
> ---
>
> diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwreg=
s.c
> index 55accb7..e3110ac 100644
> --- a/drivers/acpi/acpica/hwregs.c
> +++ b/drivers/acpi/acpica/hwregs.c
> @@ -269,6 +269,9 @@ acpi_status acpi_hw_clear_acpi_status(void)
>
> =A0 =A0 =A0 =A0status =3D acpi_hw_register_write(ACPI_REGISTER_PM1_ST=
ATUS,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0ACPI_BITMASK_ALL_FIXED_STATUS);
> +
> + =A0 =A0 =A0 acpi_os_release_lock(acpi_gbl_hardware_lock, lock_flags=
);
> +
> =A0 =A0 =A0 =A0if (ACPI_FAILURE(status)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto unlock_and_exit;
> =A0 =A0 =A0 =A0}
> @@ -278,7 +281,6 @@ acpi_status acpi_hw_clear_acpi_status(void)
> =A0 =A0 =A0 =A0status =3D acpi_ev_walk_gpe_list(acpi_hw_clear_gpe_blo=
ck, NULL);
>
> =A0 =A0 =A0 unlock_and_exit:
> - =A0 =A0 =A0 acpi_os_release_lock(acpi_gbl_hardware_lock, lock_flags=
);
> =A0 =A0 =A0 =A0return_ACPI_STATUS(status);
> =A0}
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
