From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH] fix warning: us_to_pm_timer_ticks defined but not used
Date: Sat, 24 Jul 2010 10:57:17 +0200
Message-ID: <20100724105717.430d0ae6@schatten.dmk.lab>
References: <1279900743-4733-1-git-send-email-florian@mickler.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ist.d-labs.de ([213.239.218.44]:44374 "EHLO mx01.d-labs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625Ab0GXI53 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 24 Jul 2010 04:57:29 -0400
In-Reply-To: <1279900743-4733-1-git-send-email-florian@mickler.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: florian@mickler.org
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Venkatesh Pallipadi <venki@google.com>, Suresh Siddha <suresh.b.siddha@intel.com>, linux-kernel@vger.kernel.org

On Fri, 23 Jul 2010 17:59:02 +0200
florian@mickler.org wrote:

> Move it under the same ifdef as its sole caller is.
> 
> Signed-off-by: Florian Mickler <florian@mickler.org>
> ---
>  drivers/acpi/processor_idle.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index b1b3856..8525070 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -80,10 +80,6 @@ module_param(nocst, uint, 0000);
>  static unsigned int latency_factor __read_mostly = 2;
>  module_param(latency_factor, uint, 0644);
>  
> -static u64 us_to_pm_timer_ticks(s64 t)
> -{
> -	return div64_u64(t * PM_TIMER_FREQUENCY, 1000000);
> -}
>  /*
>   * IBM ThinkPad R40e crashes mysteriously when going into C2 or C3.
>   * For now disable this. Probably a bug somewhere else.
> @@ -685,6 +681,12 @@ static int acpi_processor_get_power_info(struct acpi_processor *pr)
>  }
>  
>  #ifdef CONFIG_ACPI_PROCFS
> +
> +static u64 us_to_pm_timer_ticks(s64 t)
> +{
> +	return div64_u64(t * PM_TIMER_FREQUENCY, 1000000);
> +}
> +
>  static int acpi_processor_power_seq_show(struct seq_file *seq, void *offset)
>  {
>  	struct acpi_processor *pr = seq->private;

Ah, I just saw the Patch from KOSAKI Motohiro ([patch 1/2] acpi: fix
unused function warning) to the same effect. 
I should have checked the mailinglist before sending this :)

Sorry for the noise,

Flo
