From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [RFC PATCH 1/6] ACPICA: Hardware: Reduce divergences for sleep
 functions.
Date: Thu, 29 May 2014 12:24:55 +0200
Message-ID: <20140529102455.GA18151@ugly.fritz.box>
References: <38907770.bupFXhytsS@vostro.rjw.lan>
 <cover.1401210684.git.lv.zheng@intel.com>
 <f8980f7d9788d609314a8ac5b6b4b1ef4a39bd89.1401210685.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from byte.kde.org ([212.110.188.12]:36939 "EHLO
	byte1.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbaE2LBA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 29 May 2014 07:01:00 -0400
Content-Disposition: inline
In-Reply-To: <f8980f7d9788d609314a8ac5b6b4b1ef4a39bd89.1401210685.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <zetalog@gmail.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

series confirmed to work on top of linux-pm-next.

On Wed, May 28, 2014 at 01:27:37AM +0800, Lv Zheng wrote:
> From: Lv Zheng <lv.zheng@intel.com>
> 
> This patch is generated to reduce source code differences between Linux and
> ACPICA so that further sleep related modifications can be applied directly
> without human interventions. Lv Zheng.
> 
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Cc: Oswald Buddenhagen <ossi@kde.org>
> ---
>  drivers/acpi/acpica/hwxfsleep.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
> index 6921c7f..103d9a7 100644
> --- a/drivers/acpi/acpica/hwxfsleep.c
> +++ b/drivers/acpi/acpica/hwxfsleep.c
> @@ -138,7 +138,6 @@ acpi_status acpi_set_firmware_waking_vector64(u64 physical_address)
>  {
>  	ACPI_FUNCTION_TRACE(acpi_set_firmware_waking_vector64);
>  
> -
>  	/* Determine if the 64-bit vector actually exists */
>  
>  	if ((acpi_gbl_FACS->length <= 32) || (acpi_gbl_FACS->version < 1)) {
> @@ -154,7 +153,6 @@ acpi_status acpi_set_firmware_waking_vector64(u64 physical_address)
>  
>  ACPI_EXPORT_SYMBOL(acpi_set_firmware_waking_vector64)
>  #endif
> -
>  /*******************************************************************************
>   *
>   * FUNCTION:    acpi_enter_sleep_state_s4bios
> -- 
> 1.7.10
> 
> 
