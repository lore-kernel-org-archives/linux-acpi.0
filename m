From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 09/13] ACPI: thinkpad-acpi: handle HKEY thermal and battery
 alarms
Date: Thu, 15 Jan 2009 13:45:19 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901151342011.4737@localhost.localdomain>
References: <1231650070-21722-10-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:11995 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754174AbZAOTHF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Jan 2009 14:07:05 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KDI00KAJZVO62L0@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 15 Jan 2009 12:40:37 -0600 (CST)
In-reply-to: <1231650070-21722-10-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

While useful to a techie, it is hard to imagine that these will
become useful to a generic Linux GUI some day that is used by
regular people.

As thermals on thinkpads are handled by the EC, the question
will become what does the OS (kernel and user) do with these
other than notify...  Presumably the platform specific driver
on Windows knows what to do, or knows what not to do...

I suppose we'll figure out what to do when we see these
actually happen w/ any frequency on test machines --
which quite possibly will never.

Len Brown, Intel Open Source Technology Center

On Sun, 11 Jan 2009, Henrique de Moraes Holschuh wrote:

> Handle some HKEY events that are actually firmware alarms.  For
> now, we do the simple thing: log specific messages to the log and let
> the thinkpad-specific event pass to userspace.
> 
> In the future, these events will be migrated to generic notifications
> and subsystems.
> 
> These alarms are NOT available on all ThinkPads.  E.g. the T43 only
> issues 0x6011 and 0x6012.
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> ---
>  drivers/platform/x86/thinkpad_acpi.c |   63 +++++++++++++++++++++++++++++++--
>  1 files changed, 59 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index d833ee6..c4e4b64 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -174,10 +174,12 @@ enum {
>  
>  /* Debugging */
>  #define TPACPI_LOG TPACPI_FILE ": "
> -#define TPACPI_ERR	   KERN_ERR    TPACPI_LOG
> -#define TPACPI_NOTICE KERN_NOTICE TPACPI_LOG
> -#define TPACPI_INFO   KERN_INFO   TPACPI_LOG
> -#define TPACPI_DEBUG  KERN_DEBUG  TPACPI_LOG
> +#define TPACPI_ALERT	KERN_ALERT  TPACPI_LOG
> +#define TPACPI_CRIT	KERN_CRIT   TPACPI_LOG
> +#define TPACPI_ERR	KERN_ERR    TPACPI_LOG
> +#define TPACPI_NOTICE	KERN_NOTICE TPACPI_LOG
> +#define TPACPI_INFO	KERN_INFO   TPACPI_LOG
> +#define TPACPI_DEBUG	KERN_DEBUG  TPACPI_LOG
>  
>  #define TPACPI_DBG_ALL		0xffff
>  #define TPACPI_DBG_INIT		0x0001
> @@ -2614,6 +2616,15 @@ static bool hotkey_notify_wakeup(const u32 hkey,
>  		*ignore_acpi_ev = true;
>  		break;
>  
> +	case 0x2313: /* Battery on critical low level (S3) */
> +	case 0x2413: /* Battery on critical low level (S4) */
> +		printk(TPACPI_ALERT
> +			"EMERGENCY WAKEUP: battery almost empty\n");
> +		/* how to auto-heal: */
> +		/* 2313: woke up from S3, go to S4/S5 */
> +		/* 2413: woke up from S4, go to S5 */
> +		break;
> +
>  	default:
>  		return false;
>  	}
> @@ -2659,6 +2670,45 @@ static bool hotkey_notify_usrevent(const u32 hkey,
>  	}
>  }
>  
> +static bool hotkey_notify_thermal(const u32 hkey,
> +				 bool *send_acpi_ev,
> +				 bool *ignore_acpi_ev)
> +{
> +	/* 0x6000-0x6FFF: thermal alarms */
> +	*send_acpi_ev = true;
> +	*ignore_acpi_ev = false;
> +
> +	switch (hkey) {
> +	case 0x6011:
> +		printk(TPACPI_CRIT
> +			"THERMAL ALARM: battery is too hot!\n");
> +		/* recommended action: warn user through gui */
> +		return true;
> +	case 0x6012:
> +		printk(TPACPI_ALERT
> +			"THERMAL EMERGENCY: battery is extremely hot!\n");
> +		/* recommended action: immediate sleep/hibernate */
> +		return true;
> +	case 0x6021:
> +		printk(TPACPI_CRIT
> +			"THERMAL ALARM: "
> +			"a sensor reports something is too hot!\n");
> +		/* recommended action: warn user through gui, that */
> +		/* some internal component is too hot */
> +		return true;
> +	case 0x6022:
> +		printk(TPACPI_ALERT
> +			"THERMAL EMERGENCY: "
> +			"a sensor reports something is extremely hot!\n");
> +		/* recommended action: immediate sleep/hibernate */
> +		return true;
> +	default:
> +		printk(TPACPI_ALERT
> +			 "THERMAL ALERT: unknown thermal alarm received\n");
> +		return false;
> +	}
> +}
> +
>  static void hotkey_notify(struct ibm_struct *ibm, u32 event)
>  {
>  	u32 hkey;
> @@ -2731,6 +2781,11 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
>  			known_ev = hotkey_notify_usrevent(hkey, &send_acpi_ev,
>  						 &ignore_acpi_ev);
>  			break;
> +		case 6:
> +			/* 0x6000-0x6FFF: thermal alarms */
> +			known_ev = hotkey_notify_thermal(hkey, &send_acpi_ev,
> +						 &ignore_acpi_ev);
> +			break;
>  		case 7:
>  			/* 0x7000-0x7FFF: misc */
>  			if (tp_features.hotkey_wlsw && hkey == 0x7000) {
> -- 
> 1.5.6.5
> 
