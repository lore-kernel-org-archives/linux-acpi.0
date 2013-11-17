From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 11/12] ACPI: use of ACPI_FADT_32BIT_TIMER is not allowed in HW reduced mode
Date: Sun, 17 Nov 2013 23:26:48 +0100
Message-ID: <1401228.IWQJyQWsXM@vostro.rjw.lan>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org> <1384047382-20623-12-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60678 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752509Ab3KQWON (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 17 Nov 2013 17:14:13 -0500
In-Reply-To: <1384047382-20623-12-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: al.stone@linaro.org
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>

On Saturday, November 09, 2013 06:36:21 PM al.stone@linaro.org wrote:
> From: Al Stone <ahs3@redhat.com>

I'm reading the patch as "the timer resolution in HW reduced mode is always
32-bit".  Is my reading correct?

> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>  drivers/acpi/acpica/utxface.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
> index be322c8..fe94b3e 100644
> --- a/drivers/acpi/acpica/utxface.c
> +++ b/drivers/acpi/acpica/utxface.c
> @@ -187,7 +187,8 @@ acpi_status acpi_get_system_info(struct acpi_buffer * out_buffer)
>  
>  	/* Timer resolution - 24 or 32 bits  */
>  
> -	if (acpi_gbl_FADT.flags & ACPI_FADT_32BIT_TIMER) {
> +	if (!acpi_gbl_reduced_hardware &&
> +	    (acpi_gbl_FADT.flags & ACPI_FADT_32BIT_TIMER)) {
>  		info_ptr->timer_resolution = 24;
>  	} else {
>  		info_ptr->timer_resolution = 32;
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
