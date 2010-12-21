From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 2/2] ACPI: Fixed some coding style issues in fan.c and battery.c
Date: Tue, 21 Dec 2010 21:41:41 -0200
Message-ID: <AANLkTi=Jg=hzNJoDAYm5H569+M7JmQXjYtHYU=JE+Hs2@mail.gmail.com>
References: <1292967680-14208-1-git-send-email-jan.fuesting@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f45.google.com ([209.85.214.45]:58420 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab0LUXln convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Dec 2010 18:41:43 -0500
In-Reply-To: <1292967680-14208-1-git-send-email-jan.fuesting@gmx.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?UTF-8?B?SmFuIEbDvHN0aW5n?= <jan.fuesting@gmx.de>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Dec 21, 2010 at 7:41 PM, Jan F=C3=BCsting <jan.fuesting@gmx.de>=
 wrote:
> Fixed some coding style issues in fan.c and battery.c
>
Which kind of coding style issues you have fixed? Looking at the diff
I couldn't figure out the *issues* as described in the commit message.
Care to resend describing which coding style issues you are fixing?

Also the diff shows a change only in batter.c. Did you forget
something (fan.c) ?

Thanks.

Ah, another thing, you have repeated the subject in the commit
message, if they almost the same except the ACPI, then no need to
repeat it in the commit message.

> Signed-off-by: Jan F=C3=BCsting <jan.fuesting@gmx.de>
> ---
> =C2=A0drivers/acpi/battery.c | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 16fc4df..35d0c6f 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -580,7 +580,7 @@ static void acpi_battery_quirks(struct acpi_batte=
ry *battery)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dmi_name_in_vendors("Acer") && battery=
->power_unit)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_bit(ACPI_B=
ATTERY_QUIRK_SIGNED16_CURRENT, &battery->flags);
> -}
> +}
>
> =C2=A0/*
> =C2=A0* According to the ACPI spec, some kinds of primary batteries c=
an
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
