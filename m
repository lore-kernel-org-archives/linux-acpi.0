From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPIi / lpat: Fix typos and kernel-doc style
Date: Wed, 26 Jul 2017 20:59:29 +0200
Message-ID: <2216383.aA2G1z59Fu@aspire.rjw.lan>
References: <1500662682-29595-1-git-send-email-sumeet.r.pawnikar@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60958 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751011AbdGZTH3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Jul 2017 15:07:29 -0400
In-Reply-To: <1500662682-29595-1-git-send-email-sumeet.r.pawnikar@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Saturday, July 22, 2017 12:14:42 AM Sumeet Pawnikar wrote:
> This patch fix the typos in function header of
> acpi_lpat_raw_to_temp and acpi_lpat_temp_to_raw.
> 
> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> ---
>  drivers/acpi/acpi_lpat.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_lpat.c b/drivers/acpi/acpi_lpat.c
> index c1c4877..2cd9f73 100644
> --- a/drivers/acpi/acpi_lpat.c
> +++ b/drivers/acpi/acpi_lpat.c
> @@ -25,7 +25,7 @@
>   * @raw: the raw value, used as a key to get the temerature from the
>   *       above mapping table
>   *
> - * A positive converted temperarure value will be returned on success,
> + * A positive converted temperature value will be returned on success,
>   * a negative errno will be returned in error cases.
>   */
>  int acpi_lpat_raw_to_temp(struct acpi_lpat_conversion_table *lpat_table,
> @@ -55,11 +55,11 @@ int acpi_lpat_raw_to_temp(struct acpi_lpat_conversion_table *lpat_table,
>   * acpi_lpat_temp_to_raw(): Return raw value from temperature through
>   * LPAT conversion table
>   *
> - * @lpat: the temperature_raw mapping table
> + * @lpat_table: the temperature_raw mapping table
>   * @temp: the temperature, used as a key to get the raw value from the
>   *        above mapping table
>   *
> - * A positive converted temperature value will be returned on success,
> + * The raw value will be returned on success,
>   * a negative errno will be returned in error cases.
>   */
>  int acpi_lpat_temp_to_raw(struct acpi_lpat_conversion_table *lpat_table,
> 

Applied, thanks!

