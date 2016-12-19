From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPICA: use designated initializers
Date: Mon, 19 Dec 2016 06:06:21 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CDFF348@SHSMSX101.ccr.corp.intel.com>
References: <20161217010425.GA140581@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:46388 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750920AbcLSGGZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Dec 2016 01:06:25 -0500
In-Reply-To: <20161217010425.GA140581@beast>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

Hi,

> From: Kees Cook [mailto:keescook@chromium.org]
> Subject: [PATCH] ACPICA: use designated initializers
> 
> Prepare to mark sensitive kernel structures for randomization by making
> sure they're using designated initializers. These were identified during
> allyesconfig builds of x86, arm, and arm64, with most initializer fixes
> extracted from grsecurity.

This commit is not suitable for ACPICA upstream.
It's not portable. Please drop.

Thanks
Lv

> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/acpi/acpica/hwxfsleep.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
> index f76e0eab32b8..25cd5c66e102 100644
> --- a/drivers/acpi/acpica/hwxfsleep.c
> +++ b/drivers/acpi/acpica/hwxfsleep.c
> @@ -70,11 +70,12 @@ static acpi_status acpi_hw_sleep_dispatch(u8 sleep_state, u32 function_id);
>  /* Legacy functions are optional, based upon ACPI_REDUCED_HARDWARE */
> 
>  static struct acpi_sleep_functions acpi_sleep_dispatch[] = {
> -	{ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_sleep),
> -	 acpi_hw_extended_sleep},
> -	{ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake_prep),
> -	 acpi_hw_extended_wake_prep},
> -	{ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake), acpi_hw_extended_wake}
> +	{ .legacy_function = ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_sleep),
> +	  .extended_function = acpi_hw_extended_sleep },
> +	{ .legacy_function = ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake_prep),
> +	  .extended_function = acpi_hw_extended_wake_prep },
> +	{ .legacy_function = ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake),
> +	  .extended_function = acpi_hw_extended_wake }
>  };
> 
>  /*
> --
> 2.7.4
> 
> 
> --
> Kees Cook
> Nexus Security
