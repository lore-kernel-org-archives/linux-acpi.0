From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 3/3] ACPI: thinkpad-acpi: fix LED handling on older
 ThinkPads
Date: Wed, 04 Jun 2008 00:42:10 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806040041430.14187@localhost.localdomain>
References: <1212546971-29736-1-git-send-email-hmh@hmh.eng.br>
 <1212546971-29736-4-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:41429 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbYFDFm1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Jun 2008 01:42:27 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K1X003U492CA72E@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 03 Jun 2008 23:42:13 -0500 (CDT)
In-reply-to: <1212546971-29736-4-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

this one didn't apply on top of the other two?

On Tue, 3 Jun 2008, Henrique de Moraes Holschuh wrote:

> The less tested codepaths for LED handling, used on ThinkPads 570, 600e/x,
> 770e, 770x, A21e, A2xm/p, T20-22, X20 and maybe a few others, would write
> data to kernel memory it had no business touching, for leds number 3 and
> above.  If one is lucky, that illegal write would cause an OOPS, but
> chances are it would silently corrupt a byte.
> 
> The problem was introduced in commit af116101, "ACPI: thinkpad-acpi: add
> sysfs led class support to thinkpad leds (v3.2)".
> 
> Fix the bug by refactoring the entire code to be far more obvious on what
> it wants to do.  Also do some defensive "constification".
> 
> Issue reported by Karol Lewandowski <lmctlx@gmail.com> (he's an lucky guy
> and got an OOPS instead of silent corruption :-) ).
> 
> Root cause of the OOPS identified by Adrian Bunk <bunk@kernel.org>.
> Thanks, Adrian!
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Tested-by: Karol Lewandowski <lmctlx@gmail.com>
> Cc: Adrian Bunk <bunk@kernel.org>
> ---
>  drivers/misc/thinkpad_acpi.c |   55 +++++++++++++++++++++--------------------
>  1 files changed, 28 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
> index 58973da..b596929 100644
> --- a/drivers/misc/thinkpad_acpi.c
> +++ b/drivers/misc/thinkpad_acpi.c
> @@ -3853,7 +3853,7 @@ static const char * const tpacpi_led_names[TPACPI_LED_NUMLEDS] = {
>  	"tpacpi::standby",
>  };
>  
> -static int led_get_status(unsigned int led)
> +static int led_get_status(const unsigned int led)
>  {
>  	int status;
>  	enum led_status_t led_s;
> @@ -3877,41 +3877,42 @@ static int led_get_status(unsigned int led)
>  	/* not reached */
>  }
>  
> -static int led_set_status(unsigned int led, enum led_status_t ledstatus)
> +static int led_set_status(const unsigned int led,
> +			  const enum led_status_t ledstatus)
>  {
>  	/* off, on, blink. Index is led_status_t */
> -	static const int led_sled_arg1[] = { 0, 1, 3 };
> -	static const int led_exp_hlbl[] = { 0, 0, 1 };	/* led# * */
> -	static const int led_exp_hlcl[] = { 0, 1, 1 };	/* led# * */
> -	static const int led_led_arg1[] = { 0, 0x80, 0xc0 };
> +	static const unsigned int led_sled_arg1[] = { 0, 1, 3 };
> +	static const unsigned int led_led_arg1[] = { 0, 0x80, 0xc0 };
>  
>  	int rc = 0;
>  
>  	switch (led_supported) {
>  	case TPACPI_LED_570:
> -			/* 570 */
> -			led = 1 << led;
> -			if (!acpi_evalf(led_handle, NULL, NULL, "vdd",
> -					led, led_sled_arg1[ledstatus]))
> -				rc = -EIO;
> -			break;
> +		/* 570 */
> +		if (led > 7)
> +			return -EINVAL;
> +		if (!acpi_evalf(led_handle, NULL, NULL, "vdd",
> +				(1 << led), led_sled_arg1[ledstatus]))
> +			rc = -EIO;
> +		break;
>  	case TPACPI_LED_OLD:
> -			/* 600e/x, 770e, 770x, A21e, A2xm/p, T20-22, X20 */
> -			led = 1 << led;
> -			rc = ec_write(TPACPI_LED_EC_HLMS, led);
> -			if (rc >= 0)
> -				rc = ec_write(TPACPI_LED_EC_HLBL,
> -					      led * led_exp_hlbl[ledstatus]);
> -			if (rc >= 0)
> -				rc = ec_write(TPACPI_LED_EC_HLCL,
> -					      led * led_exp_hlcl[ledstatus]);
> -			break;
> +		/* 600e/x, 770e, 770x, A21e, A2xm/p, T20-22, X20 */
> +		if (led > 7)
> +			return -EINVAL;
> +		rc = ec_write(TPACPI_LED_EC_HLMS, (1 << led));
> +		if (rc >= 0)
> +			rc = ec_write(TPACPI_LED_EC_HLBL,
> +				      (ledstatus == TPACPI_LED_BLINK) << led);
> +		if (rc >= 0)
> +			rc = ec_write(TPACPI_LED_EC_HLCL,
> +				      (ledstatus != TPACPI_LED_OFF) << led);
> +		break;
>  	case TPACPI_LED_NEW:
> -			/* all others */
> -			if (!acpi_evalf(led_handle, NULL, NULL, "vdd",
> -					led, led_led_arg1[ledstatus]))
> -				rc = -EIO;
> -			break;
> +		/* all others */
> +		if (!acpi_evalf(led_handle, NULL, NULL, "vdd",
> +				led, led_led_arg1[ledstatus]))
> +			rc = -EIO;
> +		break;
>  	default:
>  		rc = -ENXIO;
>  	}
> -- 
> 1.5.5.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
