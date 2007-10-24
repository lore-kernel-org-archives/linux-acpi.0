From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 02/12] ACPI: suspend: Wrong order of GPE restore.
Date: Thu, 25 Oct 2007 00:07:12 +0200
Message-ID: <200710250007.12548.rjw@sisk.pl>
References: <20071022101535.2937.79385.stgit@samsung> <20071022101812.2937.49361.stgit@samsung>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43725 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756511AbXJXV73 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Oct 2007 17:59:29 -0400
In-Reply-To: <20071022101812.2937.49361.stgit@samsung>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Monday, 22 October 2007 12:18, Alexey Starikovskiy wrote:
> acpi_leave_sleep_state() should have correct list of wake and
> runtime GPEs, which is available only after disable_wakeup_device()
> is called.
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---
> 
>  drivers/acpi/sleep/main.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
> index 2f9d3c1..2c0b663 100644
> --- a/drivers/acpi/sleep/main.c
> +++ b/drivers/acpi/sleep/main.c
> @@ -167,8 +167,8 @@ static void acpi_pm_finish(void)
>  {
>  	u32 acpi_state = acpi_target_sleep_state;
>  
> -	acpi_leave_sleep_state(acpi_state);
>  	acpi_disable_wakeup_device(acpi_state);
> +	acpi_leave_sleep_state(acpi_state);
>  
>  	/* reset firmware waking vector */
>  	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
> @@ -272,8 +272,8 @@ static void acpi_hibernation_finish(void)
>  	 * enable it here.
>  	 */
>  	acpi_enable();
> -	acpi_leave_sleep_state(ACPI_STATE_S4);
>  	acpi_disable_wakeup_device(ACPI_STATE_S4);
> +	acpi_leave_sleep_state(ACPI_STATE_S4);
>  
>  	/* reset firmware waking vector */
>  	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

-- 
"Premature optimization is the root of all evil." - Donald Knuth
