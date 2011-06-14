From: Lin Ming <minggr@gmail.com>
Subject: Re: [PATCH v2] ACPI: Fixes device power states array overflow
Date: Tue, 14 Jun 2011 10:53:30 +0800
Message-ID: <BANLkTimJff7w3+KRZRCC3O0F4M_aT8rFjA@mail.gmail.com>
References: <1306943642.2873.10.camel@hp6530s>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:45168 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665Ab1FNCxc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Jun 2011 22:53:32 -0400
Received: by vxi39 with SMTP id 39so4128284vxi.19
        for <linux-acpi@vger.kernel.org>; Mon, 13 Jun 2011 19:53:31 -0700 (PDT)
In-Reply-To: <1306943642.2873.10.camel@hp6530s>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Dan Carpenter <error27@gmail.com>, Old <oldium.pro@seznam.cz>

On Wed, Jun 1, 2011 at 11:54 PM, Lin Ming <ming.m.lin@intel.com> wrote:
> Commit 28c2103 added new state ACPI_STATE_D3_COLD, so the device powe=
r
> states array must be expanded by one also.
>
> v2: Use ACPI_D_STATE_COUNT instead of number 5 for the array size.
>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Suggested-by: Old=C5=99ich Jedli=C4=8Dka <oldium.pro@seznam.cz>
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> ---
> =C2=A0include/acpi/acpi_bus.h | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 3a10ef5..6cd5b64 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -210,7 +210,7 @@ struct acpi_device_power_state {
> =C2=A0struct acpi_device_power {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int state; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* Current state */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct acpi_device_power_flags flags;
> - =C2=A0 =C2=A0 =C2=A0 struct acpi_device_power_state states[4]; =C2=A0=
 =C2=A0 =C2=A0 /* Power states (D0-D3) */
> + =C2=A0 =C2=A0 =C2=A0 struct acpi_device_power_state states[ACPI_D_S=
TATE_COUNT]; =C2=A0 =C2=A0 =C2=A0/* Power states (D0-D3Cold) */
> =C2=A0};
>
> =C2=A0/* Performance Management */
> --
> 1.7.2.3

Len,

Would you apply this one?

Thanks,
Lin Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
