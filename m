From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: respect const qualifier
Date: Mon, 21 Apr 2014 22:44:59 +0200
Message-ID: <3334700.hi79274ifW@vostro.rjw.lan>
References: <1397750006-17463-1-git-send-email-semen.protsenko@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54101 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754577AbaDUU2k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Apr 2014 16:28:40 -0400
In-Reply-To: <1397750006-17463-1-git-send-email-semen.protsenko@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Semen Protsenko <semen.protsenko@linaro.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday, April 17, 2014 06:53:26 PM Semen Protsenko wrote:
> This patch fixes next warning:
>=20
> <------------------------------- cut here ---------------------------=
------>
> drivers/acpi/property.c: In function =E2=80=98acpi_free_properties=E2=
=80=99:
> drivers/acpi/property.c:35:2: warning: passing argument 1 of =E2=80=98=
acpi_os_free=E2=80=99
>                               discards =E2=80=98const=E2=80=99 qualif=
ier from pointer
>                               target type [enabled by default]
>=20
>   ACPI_FREE(adev->properties);
> <------------------------------- cut here ---------------------------=
------>

This is not a mainline kernel problem, surely?

>=20
> The problem is next:
>=20
>  - acpi_free_properties() calls ACPI_FREE(), passing "const *"
>    parameter to it
>  - ACPI_FREE() is macro for acpi_os_free()
>  - acpi_os_free() takes "void *" parameter
>  - acpi_os_free() calls kfree()
>  - but kfree() requires "const void *" parameter
>=20
> So acpi_os_free() should require "const void *" parameter as well.
>=20
> Signed-off-by: Semen Protsenko <semen.protsenko@linaro.org>
> ---
>  include/acpi/platform/aclinux.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/=
aclinux.h
> index 93c55ed..c6fa763 100644
> --- a/include/acpi/platform/aclinux.h
> +++ b/include/acpi/platform/aclinux.h
> @@ -174,7 +174,7 @@ static inline void *acpi_os_allocate_zeroed(acpi_=
size size)
>  #define ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_allocate_zeroed
>  #define USE_NATIVE_ALLOCATE_ZEROED
> =20
> -static inline void acpi_os_free(void *memory)
> +static inline void acpi_os_free(const void *memory)
>  {
>  	kfree(memory);
>  }
>=20

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
