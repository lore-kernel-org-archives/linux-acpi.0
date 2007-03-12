From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI: resolve GPE immediate wakeup regression
Date: Mon, 12 Mar 2007 13:06:59 -0400
Message-ID: <200703121306.59437.lenb@kernel.org>
References: <45F0C018.2020409@madrabbit.org> <200703121142.46705.lenb@kernel.org> <45F58707.1@madrabbit.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56131 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030727AbXCLRPI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Mar 2007 13:15:08 -0400
In-Reply-To: <45F58707.1@madrabbit.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ray Lee <ray-lk@madrabbit.org>
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Vladimir Lebedev <vladimir.p.lebedev@intel.com>, linux-acpi@vger.kernel.org

On Monday 12 March 2007 12:59, Ray Lee wrote:
> Len Brown wrote:
> > On Saturday 10 March 2007 01:18, Ray Lee wrote:
> >> Ray Lee wrote:
> >>> In 2.6.21-rc1,2,3, my laptop will fully suspend to ram, but then
> >>> *immediately* resumes back from suspension. (It resumes just fine, as well.)
> >> [...]
> >>> HP/Compaq NX6125 system, AMD64, dmesg attached.
> > 
> > I'd rather not break the Acer, if possible.
> > 
> > Ray, Please test the incremental patch below.
> 
> Tested and Alexey's patch (copied below) fixes the problem. I added a
> signed-off-by just in case; feel free to yank it if inappropriate.
> Regardless, please apply.
> 
> Thanks Len, Alexey.

Thanks for testing Ray,
I'll apply this one.

-Len

> ---
> Subject: ACPI: resolve GPE immediate wakeup regression
> From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
> 
> Removing disabling of GPEs from enter_sleep function causes regression
> on nx6125.
> Doing disable_all_gpes both in prepare to sleep and in enter sleep
> resolves regression,
> while still fixes Acer notebooks.
> 
> Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
> Signed-off-by: Ray Lee <ray-lk@madrabbit.org>
> ---
> 
>  drivers/acpi/hardware/hwsleep.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/hardware/hwsleep.c
> b/drivers/acpi/hardware/hwsleep.c
> index 8fa9312..c84b1fa 100644
> --- a/drivers/acpi/hardware/hwsleep.c
> +++ b/drivers/acpi/hardware/hwsleep.c
> @@ -300,6 +300,11 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8
> sleep_state)
>  	/*
>  	 * 2) Enable all wakeup GPEs
>  	 */
> +	status = acpi_hw_disable_all_gpes();
> +	if (ACPI_FAILURE(status)) {
> +		return_ACPI_STATUS(status);
> +	}
> +
>  	acpi_gbl_system_awake_and_running = FALSE;
> 
>  	status = acpi_hw_enable_all_wakeup_gpes();
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
