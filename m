From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH] ACPICA: Improve GPE detect
Date: Fri, 17 Dec 2010 21:23:13 +0100
Message-ID: <201012172123.13502.rjw@sisk.pl>
References: <1292399976.10384.187.camel@minggr.sh.intel.com> <4911F71203A09E4D9981D27F9D830858BF9AB116@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36453 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753020Ab0LQUYB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Dec 2010 15:24:01 -0500
In-Reply-To: <4911F71203A09E4D9981D27F9D830858BF9AB116@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Lin, Ming M" <ming.m.lin@intel.com>, lenb <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Wednesday, December 15, 2010, Moore, Robert wrote:
> +			if (!gpe_register_info->enable_for_run &&
> +				!gpe_register_info->enable_for_wake) {
> 
> I would bitwise OR them together first
> 
> +			if (!(gpe_register_info->enable_for_run |
> +				gpe_register_info->enable_for_wake)) {

Well, I think a || would be a little better (they are treated as flags rather
than bit patterns everywhere else), but I generally agree.

The patch looks good apart from this.

Thanks,
Rafael


> -----Original Message-----
> From: Lin, Ming M 
> Sent: Wednesday, December 15, 2010 12:00 AM
> To: Rafael J. Wysocki
> Cc: lenb; Moore, Robert; linux-acpi
> Subject: [RFC PATCH] ACPICA: Improve GPE detect
> 
> Hi, Rafael
> 
> Currently, the ACPICA GPE interrupt handler reads all the GPE registers to
> detect which GPEs, if any, have fired. This is done on each and every SCI,
> since there is no way to know up front if any GPEs have been raised.
> 
> However, since ACPICA internally keeps a GPE enable mask for every GPE
> register, it may be possible to ignore any GPE registers whose internal
> GPE enable mask is zero. This would eliminate reading the status and enable
> registers for that particular GPE register pair.
> 
> http://www.acpica.org/bugzilla/show_bug.cgi?id=884
> 
> I have tested suspend/resume and it works OK.
> What do you think about below simple patch?
> 
> Thanks.
> ---
>  drivers/acpi/acpica/evgpe.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
> index 7c339d3..49fab43 100644
> --- a/drivers/acpi/acpica/evgpe.c
> +++ b/drivers/acpi/acpica/evgpe.c
> @@ -373,6 +373,14 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info * gpe_xrupt_list)
>  
>  			gpe_register_info = &gpe_block->register_info[i];
>  
> +			if (!gpe_register_info->enable_for_run &&
> +				!gpe_register_info->enable_for_wake) {
> +
> +				/* Disabled for both "runtime" and "wakeup", move on */
> +
> +				continue;
> +			}
> +
>  			/* Read the Status Register */
>  
>  			status =
> 
> 
> 

