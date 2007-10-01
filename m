From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] ACPICA: hw: Don't carry spinlock over suspend
Date: Mon, 1 Oct 2007 22:38:08 +0200
Message-ID: <200710012238.09274.rjw@sisk.pl>
References: <20070930183936.32654.44391.stgit@samsung> <20070930183942.32654.16220.stgit@samsung>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57976 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752392AbXJAUXP (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Mon, 1 Oct 2007 16:23:15 -0400
In-Reply-To: <20070930183942.32654.16220.stgit@samsung>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Sunday, 30 September 2007 20:39, Alexey Starikovskiy wrote:
> ACPI uses acpi_get_register() in order to get into suspend.
> This function is guarded by acpi_gbl_hardware_lock, which will be carried
> into resume phase.
> At resume interrupts are enabled and first ACPI interrupt deadlocks on this
> lock.

Ouch.  That might have bitten quite some people, I guess.

> Solution seems to be to not lock register read, as there are no concurrent
> activity at this point.
> 
> Reference: http://bugzilla.kernel.org/show_bug.cgi?id=7499
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>

Do you think it's -stable material?

Greetings,
Rafael


> ---
> 
>  drivers/acpi/hardware/hwsleep.c |    3 ++-
>  include/acpi/acpixf.h           |    2 ++
>  2 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/hardware/hwsleep.c b/drivers/acpi/hardware/hwsleep.c
> index 4d0c677..c0577ca 100644
> --- a/drivers/acpi/hardware/hwsleep.c
> +++ b/drivers/acpi/hardware/hwsleep.c
> @@ -398,7 +398,8 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
>  	/* Wait until we enter sleep state */
>  
>  	do {
> -		status = acpi_get_register(ACPI_BITREG_WAKE_STATUS, &in_value);
> +		status = acpi_get_register_unlocked(ACPI_BITREG_WAKE_STATUS,
> +						    &in_value);
>  		if (ACPI_FAILURE(status)) {
>  			return_ACPI_STATUS(status);
>  		}
> diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
> index 3d7ab9e..9512f04 100644
> --- a/include/acpi/acpixf.h
> +++ b/include/acpi/acpixf.h
> @@ -314,6 +314,8 @@ acpi_resource_to_address64(struct acpi_resource *resource,
>   */
>  acpi_status acpi_get_register(u32 register_id, u32 * return_value);
>  
> +acpi_status acpi_get_register_unlocked(u32 register_id, u32 *return_value);
> +
>  acpi_status acpi_set_register(u32 register_id, u32 value);
>  
>  acpi_status
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

-- 
"Premature optimization is the root of all evil." - Donald Knuth
