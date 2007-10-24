From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 01/12] ACPI: sleep: Fix GPE suspend cleanup
Date: Thu, 25 Oct 2007 00:10:36 +0200
Message-ID: <200710250010.37185.rjw@sisk.pl>
References: <20071022101535.2937.79385.stgit@samsung> <20071022101805.2937.92527.stgit@samsung>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43728 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756708AbXJXV7f (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Oct 2007 17:59:35 -0400
In-Reply-To: <20071022101805.2937.92527.stgit@samsung>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Monday, 22 October 2007 12:18, Alexey Starikovskiy wrote:
> Commit 9b039330808b83acac3597535da26f47ad1862ce removed 
> acpi_gpe_sleep_prepare(), the only function used at S5 transition
> Add call to generic acpi_enable_wake_device().
> 
> Reference: https://bugzilla.novell.com/show_bug.cgi?id=299882
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
> ---

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

>  drivers/acpi/sleep/main.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/sleep/main.c b/drivers/acpi/sleep/main.c
> index f3d3867..2f9d3c1 100644
> --- a/drivers/acpi/sleep/main.c
> +++ b/drivers/acpi/sleep/main.c
> @@ -410,6 +410,7 @@ static void acpi_power_off(void)
>  	/* acpi_sleep_prepare(ACPI_STATE_S5) should have already been called */
>  	printk("%s called\n", __FUNCTION__);
>  	local_irq_disable();
> +	acpi_enable_wakeup_device(ACPI_STATE_S5);
>  	acpi_enter_sleep_state(ACPI_STATE_S5);
>  }
>  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

-- 
"Premature optimization is the root of all evil." - Donald Knuth
