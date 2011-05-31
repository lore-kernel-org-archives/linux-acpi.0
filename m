From: =?utf-8?q?Old=C5=99ich_Jedli=C4=8Dka?= <oldium.pro@seznam.cz>
Subject: Re: [PATCH] ACPI: Fixes device power states array overflow
Date: Tue, 31 May 2011 23:09:45 +0200
Message-ID: <201105312309.46344.oldium.pro@seznam.cz>
References: <1306762961.2244.13.camel@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62361 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932326Ab1EaVJy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 31 May 2011 17:09:54 -0400
Received: by bwz15 with SMTP id 15so3998239bwz.19
        for <linux-acpi@vger.kernel.org>; Tue, 31 May 2011 14:09:52 -0700 (PDT)
In-Reply-To: <1306762961.2244.13.camel@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Dan Carpenter <error27@gmail.com>

Hi Lin,

On Monday 30 May 2011 at 15:42:41, Lin Ming wrote:
> Commit 28c2103 added new state ACPI_STATE_D3_COLD, so the device powe=
r
> states array must be expanded by one also.
>=20
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> ---
>  include/acpi/acpi_bus.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 3a10ef5..ff246e8 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -210,7 +210,7 @@ struct acpi_device_power_state {
>  struct acpi_device_power {
>  	int state;		/* Current state */
>  	struct acpi_device_power_flags flags;
> -	struct acpi_device_power_state states[4];	/* Power states (D0-D3) *=
/
> +	struct acpi_device_power_state states[5];	/* Power states (D0-D3Col=
d)=20
*/

Wouldn't it be better to use some constant, so that the same problem wo=
uld not=20
appear again in future - something like ACPI_D_STATE_COUNT or (maybe be=
tter)=20
ACPI_D_STATES_MAX+1 instead of magic number 5?

Cheers,
Old=C5=99ich.


>  };
>=20
>  /* Performance Management */
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
