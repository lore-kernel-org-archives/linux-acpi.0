From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [patch 5/7] asus-acpi: remove duplicate comparison of asus_model
	strings
Date: Wed, 3 Feb 2010 09:14:49 +0100
Message-ID: <71cd59b01002030014y21ec9863i3f3a86c295c6078a@mail.gmail.com>
References: <201002022237.o12MbveE018693@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:43203 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755338Ab0BCIOv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Feb 2010 03:14:51 -0500
Received: by fg-out-1718.google.com with SMTP id 16so140947fgg.1
        for <linux-acpi@vger.kernel.org>; Wed, 03 Feb 2010 00:14:50 -0800 (PST)
In-Reply-To: <201002022237.o12MbveE018693@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, roel.kluin@gmail.com, sziwan@users.sourceforge.net

On Tue, Feb 2, 2010 at 11:37 PM,  <akpm@linux-foundation.org> wrote:
> From: Roel Kluin <roel.kluin@gmail.com>
>
> These tests already occur elsewhere
>
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> Cc: Corentin Chary <corentincj@iksaif.net>
> Cc: Karol Kozimor <sziwan@users.sourceforge.net>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
> =A0drivers/platform/x86/asus_acpi.c | =A0 =A03 +--
> =A01 file changed, 1 insertion(+), 2 deletions(-)
>
> diff -puN drivers/platform/x86/asus_acpi.c~asus-acpi-remove-duplicate=
-comparison-of-asus_model-strings drivers/platform/x86/asus_acpi.c
> --- a/drivers/platform/x86/asus_acpi.c~asus-acpi-remove-duplicate-com=
parison-of-asus_model-strings
> +++ a/drivers/platform/x86/asus_acpi.c
> @@ -1225,9 +1225,8 @@ static int asus_model_match(char *model)
> =A0 =A0 =A0 =A0else if (strncmp(model, "M2N", 3) =3D=3D 0 ||
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strncmp(model, "M3N", 3) =3D=3D 0 ||
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strncmp(model, "M5N", 3) =3D=3D 0 ||
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strncmp(model, "M6N", 3) =3D=3D 0 ||
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strncmp(model, "S1N", 3) =3D=3D 0 ||
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strncmp(model, "S5N", 3) =3D=3D 0 ||=
 strncmp(model, "W1N", 3) =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strncmp(model, "S5N", 3) =3D=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return xxN;
> =A0 =A0 =A0 =A0else if (strncmp(model, "M1", 2) =3D=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return M1A;
> _
>

Ack,

Roel, are you still using this driver ? Have you a good reason to use
it instead of asus-laptop ?


--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
