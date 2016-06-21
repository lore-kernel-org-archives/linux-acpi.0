From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: Execute the _PTS method when system reboot
Date: Wed, 22 Jun 2016 01:56:24 +0200
Message-ID: <2611430.1T9CgX71hW@vostro.rjw.lan>
References: <1462772495-71113-1-git-send-email-hehy1@lenovo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462772495-71113-1-git-send-email-hehy1@lenovo.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ocean HY1 He <hehy1@lenovo.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Tanaka <dtanaka@lenovo.com>, Nagananda Chumbalkar <nchumbalkar@lenovo.com>
List-Id: linux-acpi@vger.kernel.org

On Monday, May 09, 2016 05:50:11 AM Ocean HY1 He wrote:
> The _PTS control method is defined in the section 7.4.1 of acpi 6.0
> spec. The _PTS control method is executed by the OS during the sleep
> transition process for S1, S2, S3, S4, and for orderly S5 shutdown.
> The sleeping state value (For example, 1, 2, 3, 4 or 5 for the S5
> soft-off state) is passed to the _PTS control method. This method
> is called after OSPM has notified native device drivers of the sleep
> state transition and before the OSPM has had a chance to fully
> prepare the system for a sleep state transition.
> 
> The _PTS control method provides the BIOS a mechanism for performing
> some housekeeping, such as writing the sleep type value to the embedded
> controller, before entering the system sleeping state.
> 
> According to section 7.5 of acpi 6.0 spec, _PTS should run after _TTS.
> 
> Thus, a _PTS block notifier is added to the reboot notifier list so that
> the _PTS object will also be evaluated when the system reboot.

So I understand why it may be necessary to evaluate _PTS before entering S5,
but I'm totally unsure about reboot.

What does reboot have to do with S5?

> Signed-off-by: Ocean He <hehy1@lenovo.com>
> Signed-off-by: Nagananda Chumbalkar <nchumbalkar@lenovo.com>
> ---
>  drivers/acpi/sleep.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 2a8b596..8b290fb 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -55,6 +55,26 @@ static struct notifier_block tts_notifier = {
>  	.priority	= 0,
>  };
>  
> +static int pts_notify_reboot(struct notifier_block *this,
> +			unsigned long code, void *x)
> +{
> +	acpi_status status;
> +
> +	status = acpi_execute_simple_method(NULL, "\\_PTS", ACPI_STATE_S5);
> +	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
> +		/* It won't break anything. */
> +		printk(KERN_NOTICE "Failure in evaluating _PTS object\n");
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block pts_notifier = {
> +	.notifier_call	= pts_notify_reboot,
> +	.next		= NULL,
> +	.priority	= 0,
> +};
> +
>  static int acpi_sleep_prepare(u32 acpi_state)
>  {
>  #ifdef CONFIG_ACPI_SLEEP
> @@ -896,5 +916,12 @@ int __init acpi_sleep_init(void)
>  	 * object can also be evaluated when the system enters S5.
>  	 */
>  	register_reboot_notifier(&tts_notifier);
> +
> +	/*
> +	 * According to section 7.5 of acpi 6.0 spec, _PTS should run after
> +	 * _TTS when the system enters S5.
> +	 */
> +	register_reboot_notifier(&pts_notifier);

Why do you have to add a second notifier?

Why can't _TTS and _PTS be evaluated from one notifier?

> +
>  	return 0;
>  }
> 

Thanks,
Rafael
