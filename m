From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: implement acpi_os_get_timer() according the spec
Date: Mon, 13 May 2013 13:38:46 +0200
Message-ID: <9521576.ePuIMg9qsX@vostro.rjw.lan>
References: <1368440871-27552-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:44445 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419Ab3EMLaP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 May 2013 07:30:15 -0400
In-Reply-To: <1368440871-27552-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org

On Monday, May 13, 2013 01:27:51 PM Mika Westerberg wrote:
> ACPI Timer() opcode should return monotonically increasing clock with 100ns
> granularity. Implement this with the help of ktime_get().
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

That looks reasobable.  Have you tested it?

Rafael


> ---
>  drivers/acpi/osl.c |   14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 586e7e9..2a22170 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -835,19 +835,7 @@ void acpi_os_stall(u32 us)
>   */
>  u64 acpi_os_get_timer(void)
>  {
> -	static u64 t;
> -
> -#ifdef	CONFIG_HPET
> -	/* TBD: use HPET if available */
> -#endif
> -
> -#ifdef	CONFIG_X86_PM_TIMER
> -	/* TBD: default to PM timer if HPET was not available */
> -#endif
> -	if (!t)
> -		printk(KERN_ERR PREFIX "acpi_os_get_timer() TBD\n");
> -
> -	return ++t;
> +	return ktime_to_ns(ktime_get()) / 100;
>  }
>  
>  acpi_status acpi_os_read_port(acpi_io_address port, u32 * value, u32 width)
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
