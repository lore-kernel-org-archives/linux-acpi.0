From: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 6/7] ACPI: thinkpad-acpi: dequeue all
	pending hot key events at once
Date: Thu, 20 Sep 2007 20:42:22 -0400
Message-ID: <200709202042.22724.lenb@kernel.org>
References: <11902962603691-git-send-email-hmh@hmh.eng.br>
	<11902962613565-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11902962613565-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thursday 20 September 2007 09:50, Henrique de Moraes Holschuh wrote:
> Receive all pending hot key events at once from a single notification, and
> don't complain if the queue is empty.
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
> ---
>  drivers/misc/thinkpad_acpi.c |   52 ++++++++++++++++++++++++++++-------------
>  1 files changed, 35 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
> index 9a61140..de415fe 100644
> --- a/drivers/misc/thinkpad_acpi.c
> +++ b/drivers/misc/thinkpad_acpi.c
> @@ -1196,9 +1196,31 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
>  {
>  	u32 hkey;
>  	unsigned int keycode, scancode;
> -	int send_acpi_ev = 0;
> +	int send_acpi_ev;
> +
> +	if (event != 0x80) {
> +		printk(IBM_ERR "unknown hotkey notification event %d\n", event);
> +		/* forward it to userspace, maybe it knows how to handle it */
> +		acpi_bus_generate_proc_event(ibm->acpi->device, event, 0);
> +		acpi_bus_generate_netlink_event(ibm->acpi->device->pnp.device_class,
> +						ibm->acpi->device->dev.bus_id,
> +						event, 0);

If this is really an event due to an hotkey (emphasis on the word KEY:-),
why is it being sent via netlink instead of via input?

thanks,
-Len

> +		return;
> +	}
> +
> +	while (1) {
> +		if (!acpi_evalf(hkey_handle, &hkey, "MHKP", "d")) {
> +			printk(IBM_ERR "failed to retrieve hot key event\n");
> +			return;
> +		}
> +
> +		if (hkey == 0) {
> +			/* queue empty */
> +			return;
> +		}
> +
> +		send_acpi_ev = 0;
>  
> -	if (event == 0x80 && acpi_evalf(hkey_handle, &hkey, "MHKP", "d")) {
>  		switch (hkey >> 12) {
>  		case 1:
>  			/* 0x1000-0x1FFF: key presses */
> @@ -1220,8 +1242,8 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
>  			 * eat up known LID events */
>  			if (hkey != 0x5001 && hkey != 0x5002) {
>  				printk(IBM_ERR
> -					"unknown LID-related hotkey event: 0x%04x\n",
> -					hkey);
> +				       "unknown LID-related hotkey event: 0x%04x\n",
> +				       hkey);
>  				send_acpi_ev = 1;
>  			}
>  			break;
> @@ -1240,21 +1262,17 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
>  			printk(IBM_NOTICE "unhandled HKEY event 0x%04x\n", hkey);
>  			send_acpi_ev = 1;
>  		}
> -	} else {
> -		printk(IBM_ERR "unknown hotkey notification event %d\n", event);
> -		hkey = 0;
> -		send_acpi_ev = 1;
> -	}
>  
> -	/* Legacy events */
> -	if (send_acpi_ev || hotkey_report_mode < 2)
> -		acpi_bus_generate_proc_event(ibm->acpi->device, event, hkey);
> +		/* Legacy events */
> +		if (send_acpi_ev || hotkey_report_mode < 2)
> +			acpi_bus_generate_proc_event(ibm->acpi->device, event, hkey);
>  
> -	/* netlink events */
> -	if (send_acpi_ev) {
> -		acpi_bus_generate_netlink_event(ibm->acpi->device->pnp.device_class,
> -						ibm->acpi->device->dev.bus_id,
> -						event, hkey);
> +		/* netlink events */
> +		if (send_acpi_ev) {
> +			acpi_bus_generate_netlink_event(ibm->acpi->device->pnp.device_class,
> +							ibm->acpi->device->dev.bus_id,
> +							event, hkey);
> +		}
>  	}
>  }
>  

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
