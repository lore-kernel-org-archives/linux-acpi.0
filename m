From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: suspend: consolidate handling of Sx states addendum
Date: Fri, 21 Sep 2007 21:59:14 -0400
Message-ID: <200709212159.14418.lenb@kernel.org>
References: <200709211647.24861.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44035 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755909AbXIVCAA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Sep 2007 22:00:00 -0400
In-Reply-To: <200709211647.24861.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Frans Pop <elendil@planet.nl>, Andrew Morton <akpm@linux-foundation.org>

Applied.

thanks,
-Len

On Friday 21 September 2007 10:47, Rafael J. Wysocki wrote:
> From: Frans Pop <elendil@planet.nl>
> Date:   Thu Sep 20 22:27:44 2007 +0200
> 
> Make the S0 state be always reported as supported
> 
> Signed-off: Frans Pop <elendil@planet.nl>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/acpi/sleep/main.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6.23-rc7/drivers/acpi/sleep/main.c
> ===================================================================
> --- linux-2.6.23-rc7.orig/drivers/acpi/sleep/main.c
> +++ linux-2.6.23-rc7/drivers/acpi/sleep/main.c
> @@ -424,9 +424,11 @@ int __init acpi_sleep_init(void)
>  	if (acpi_disabled)
>  		return 0;
>  
> -printk(KERN_INFO PREFIX "(supports");
> +	sleep_states[ACPI_STATE_S0] = 1;
> +	printk(KERN_INFO PREFIX "(supports S0");
> +
>  #ifdef CONFIG_SUSPEND
> -	for (i = ACPI_STATE_S0; i < ACPI_STATE_S4; i++) {
> +	for (i = ACPI_STATE_S1; i < ACPI_STATE_S4; i++) {
>  		status = acpi_get_sleep_type_data(i, &type_a, &type_b);
>  		if (ACPI_SUCCESS(status)) {
>  			sleep_states[i] = 1;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
