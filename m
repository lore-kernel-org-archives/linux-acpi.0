From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: thermal fixup for broken BIOS which has invalid trip points
Date: Tue, 11 Mar 2008 02:35:55 -0400
Message-ID: <200803110235.55358.lenb@kernel.org>
References: <1205114031.10256.193.camel@acpi-hp-zz.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47509 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699AbYCKGgW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Mar 2008 02:36:22 -0400
In-Reply-To: <1205114031.10256.193.camel@acpi-hp-zz.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

On Sunday 09 March 2008, Zhang, Rui wrote:
> thermal fixup for broken BIOS which has invalid trip points.
> http://bugzilla.kernel.org/show_bug.cgi?id=8544
> http://marc.info/?l=linux-kernel&m=120496222629983&w=2
> 
> Signed-off-by: Zhang Rui<rui.zhang@intel.com>
> ---
>  drivers/acpi/thermal.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/acpi/thermal.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/thermal.c
> +++ linux-2.6/drivers/acpi/thermal.c
> @@ -326,7 +326,9 @@ static int acpi_thermal_set_cooling_mode
>  #define ACPI_TRIPS_ACTIVE	0x08
>  #define ACPI_TRIPS_DEVICES	0x10
>  
> -#define ACPI_TRIPS_REFRESH_THRESHOLDS	(ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE)
> +#define ACPI_TRIPS_REFRESH_THRESHOLDS	(ACPI_TRIPS_PASSIVE |	\
> +					 ACPI_TRIPS_ACTIVE |	\
> +					 ACPI_TRIPS_DEVICES)
>  #define ACPI_TRIPS_REFRESH_DEVICES	ACPI_TRIPS_DEVICES
>  
>  #define ACPI_TRIPS_INIT      (ACPI_TRIPS_CRITICAL | ACPI_TRIPS_HOT |	\
> 
> 

I don't like re-evaluating _AL0 on notify x81 as a workaround
to notice that there _is_ no _AL0.  We should re-evaluate _AL0
on notify x82 -- per the spec.

We should print out a single exeception at boot time when
we realize that the BIOS has a bug of no _AL0 for the _AC0.
At run time, we should have no concept of a valid _AC0
and thus a notify x81 should not try to use it.

Can we do that?
Otherwise, I think we're obfuscating the code to workaround
a broken BIOS.

I think we need a test in linuxfirmware kit to verify
that there is an ALx for every ACx.

thanks,
-Len
