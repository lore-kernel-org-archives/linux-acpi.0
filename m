From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2] ACPI: move acpi_no_s4_hw_signature() declaration into #ifdef CONFIG_HIBERNATION
Date: Thu, 25 Oct 2012 00:12:14 +0200
Message-ID: <3347827.kTploBzWyH@vostro.rjw.lan>
References: <1350365052-27304-1-git-send-email-yuanhan.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1350365052-27304-1-git-send-email-yuanhan.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yuanhan Liu <yuanhan.liu@linux.intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, fengguang.wu@intel.com
List-Id: linux-acpi@vger.kernel.org

On Tuesday 16 of October 2012 13:24:12 Yuanhan Liu wrote:
> acpi_no_s4_hw_signature is defined in #ifdef CONFIG_HIBERNATION block=
,
> but the current code put the declaration in #ifdef CONFIG_PM_SLEEP bl=
ock.
>=20
> I happened to meet this issue when I turned off PM_SLEEP config manua=
lly:
> arch/x86/kernel/acpi/sleep.c:100:4: error: implicit declaration of fu=
nction =E2=80=98acpi_no_s4_hw_signature=E2=80=99 [-Werror=3Dimplicit-fu=
nction-declaration]
>=20
> v2: take better title and add build error message suggested by Fenggu=
ang
>=20
> Signed-off-by: Yuanhan Liu <yuanhan.liu@linux.intel.com>
> Reviewed-by: Fengguang Wu <fengguang.wu@intel.com>

Applied to linux-pm.git/acpi-next as v3.8 material.

Thanks,
Rafael


> ---
>  include/linux/acpi.h |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>=20
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 90be989..a468429 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -257,8 +257,11 @@ int acpi_check_region(resource_size_t start, res=
ource_size_t n,
> =20
>  int acpi_resources_are_enforced(void);
> =20
> -#ifdef CONFIG_PM_SLEEP
> +#ifdef CONFIG_HIBERNATION
>  void __init acpi_no_s4_hw_signature(void);
> +#endif
> +
> +#ifdef CONFIG_PM_SLEEP
>  void __init acpi_old_suspend_ordering(void);
>  void __init acpi_nvs_nosave(void);
>  #endif /* CONFIG_PM_SLEEP */
>=20
--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
