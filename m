From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [PATCH v2] ACPI: move acpi_no_s4_hw_signature() declaration into
 #ifdef CONFIG_HIBERNATION
Date: Tue, 16 Oct 2012 14:24:53 +0800
Message-ID: <20121016062453.GA1505@localhost>
References: <1350365052-27304-1-git-send-email-yuanhan.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:38958 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752794Ab2JPGZM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Oct 2012 02:25:12 -0400
Content-Disposition: inline
In-Reply-To: <1350365052-27304-1-git-send-email-yuanhan.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yuanhan Liu <yuanhan.liu@linux.intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Oct 16, 2012 at 01:24:12PM +0800, Yuanhan Liu wrote:
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

This should be more clear:

=46ix build error on !CONFIG_PM_SLEEP:

arch/x86/kernel/acpi/sleep.c:100:4: error: implicit declaration of func=
tion =E2=80=98acpi_no_s4_hw_signature=E2=80=99

The root cause is, acpi_no_s4_hw_signature() is defined in
#ifdef CONFIG_HIBERNATION block, but the current code put the
declaration in #ifdef CONFIG_PM_SLEEP block.

Thanks,
=46engguang

> v2: take better title and add build error message suggested by Fenggu=
ang
>=20
> Signed-off-by: Yuanhan Liu <yuanhan.liu@linux.intel.com>
> Reviewed-by: Fengguang Wu <fengguang.wu@intel.com>
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
> --=20
> 1.7.7.6
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
