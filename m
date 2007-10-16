From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: suspend: Wrong order of GPE restore.
Date: Tue, 16 Oct 2007 22:00:37 +0200
Message-ID: <200710162200.37765.rjw@sisk.pl>
References: <20071016185520.6279.92045.stgit@samsung>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36585 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934153AbXJPTpQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Oct 2007 15:45:16 -0400
In-Reply-To: <20071016185520.6279.92045.stgit@samsung>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Tuesday, 16 October 2007 20:55, Alexey Starikovskiy wrote:
> acpi_leave_sleep_state() should have correct list of wake and
> runtime GPEs, which is available only after disable_wakeup_device()
> is called.
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---

Ackedy-by: Rafael J. Wysocki <rjw@sisk.pl>

>  drivers/acpi/sleep/main.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
> index 5055acf..728d595 100644
> --- a/drivers/acpi/sleep/main.c
> +++ b/drivers/acpi/sleep/main.c
> @@ -170,8 +170,8 @@ static int acpi_pm_finish(suspend_state_t pm_state)
>  {
>  	u32 acpi_state = acpi_target_sleep_state;
>  
> -	acpi_leave_sleep_state(acpi_state);
>  	acpi_disable_wakeup_device(acpi_state);
> +	acpi_leave_sleep_state(acpi_state);
>  
>  	/* reset firmware waking vector */
>  	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
> @@ -256,8 +256,8 @@ static int acpi_hibernation_enter(void)
>  
>  static void acpi_hibernation_finish(void)
>  {
> -	acpi_leave_sleep_state(ACPI_STATE_S4);
>  	acpi_disable_wakeup_device(ACPI_STATE_S4);
> +	acpi_leave_sleep_state(ACPI_STATE_S4);
>  
>  	/* reset firmware waking vector */
>  	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
> 
> 
> 

-- 
"Premature optimization is the root of all evil." - Donald Knuth
