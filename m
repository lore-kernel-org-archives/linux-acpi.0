From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: clean up compiler warning about uninitialized field
Date: Thu, 21 Nov 2013 01:34:37 +0100
Message-ID: <4847936.0VUS4BmLTm@vostro.rjw.lan>
References: <1384987551-13154-1-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64453 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755176Ab3KUAV5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Nov 2013 19:21:57 -0500
In-Reply-To: <1384987551-13154-1-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: al.stone@linaro.org
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@lists.linaro.org, Al Stone <ahs3@redhat.com>

On Wednesday, November 20, 2013 03:45:51 PM al.stone@linaro.org wrote:
> From: Al Stone <ahs3@redhat.com>
> 
> Initialize pwr_btn_status as disabled which (a) makes sure it is
> in a proper state to start, and (b) cleans up a compiler warning
> about an uninitialized variable.
> 
> Signed-off-by: Al Stone <al.stone@linaro.org>

Queued up for the next ACPI pull request, thanks!

> ---
>  drivers/acpi/sleep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 14df305..721e949 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -525,7 +525,7 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
>  	 * generate wakeup events.
>  	 */
>  	if (ACPI_SUCCESS(status) && (acpi_state == ACPI_STATE_S3)) {
> -		acpi_event_status pwr_btn_status;
> +		acpi_event_status pwr_btn_status = ACPI_EVENT_FLAG_DISABLED;
>  
>  		acpi_get_event_status(ACPI_EVENT_POWER_BUTTON, &pwr_btn_status);
>  
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
