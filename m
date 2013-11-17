From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 03/12] ACPI: clean up compiler warning about uninitialized field
Date: Sun, 17 Nov 2013 22:58:30 +0100
Message-ID: <4042434.RvYhsSOGPS@vostro.rjw.lan>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org> <1384047382-20623-4-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56276 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751324Ab3KQVpz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 17 Nov 2013 16:45:55 -0500
In-Reply-To: <1384047382-20623-4-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: al.stone@linaro.org
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>

On Saturday, November 09, 2013 06:36:13 PM al.stone@linaro.org wrote:
> From: Al Stone <ahs3@redhat.com>

Any changelog?  Some people use git logs to check what patches do and that
is not particularly clear from the subject.

Besides, this looks like a genuine fix not related directly to HW reduced,
in which case why don't you submit it separately?

> Signed-off-by: Al Stone <al.stone@linaro.org>
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
