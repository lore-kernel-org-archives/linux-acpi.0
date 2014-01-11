From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI:remove panic in case hardware has changed after S4
Date: Sat, 11 Jan 2014 02:21 +0100
Message-ID: <2113463.Fi9CX9afPJ@vostro.rjw.lan>
References: <1389347514-8112-1-git-send-email-oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50903 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751149AbaAKBHI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Jan 2014 20:07:08 -0500
In-Reply-To: <1389347514-8112-1-git-send-email-oliver@neukum.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: oliver@neukum.org
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, trenn@suse.de, Oliver Neukum <oneukum@suse.de>

On Friday, January 10, 2014 10:51:53 AM oliver@neukum.org wrote:
> From: Oliver Neukum <oneukum@suse.de>
> 
> Some BIOSes change hardware based on the state of
> a laptop's lid. If the lid is closed, the touchpad is
> disabled and the checksum changes. Windows 8 no longer
> aborts resume if the checksum has changed.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.de>

Queued up for 3.14, thanks!

> ---
>  drivers/acpi/sleep.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 9c1a435..14744e5 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -664,11 +664,9 @@ static void acpi_hibernation_leave(void)
>  	/* Reprogram control registers */
>  	acpi_leave_sleep_state_prep(ACPI_STATE_S4);
>  	/* Check the hardware signature */
> -	if (facs && s4_hardware_signature != facs->hardware_signature) {
> -		printk(KERN_EMERG "ACPI: Hardware changed while hibernated, "
> -			"cannot resume!\n");
> -		panic("ACPI S4 hardware signature mismatch");
> -	}
> +	if (facs && s4_hardware_signature != facs->hardware_signature)
> +		printk(KERN_CRIT "ACPI: Hardware changed while hibernated, "
> +			"success doubtful!\n");
>  	/* Restore the NVS memory area */
>  	suspend_nvs_restore();
>  	/* Allow EC transactions to happen. */
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
