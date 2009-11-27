From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Thinkpad X200s
Date: Fri, 27 Nov 2009 20:11:34 -0200
Message-ID: <20091127221134.GC21775@khazad-dum.debian.net>
References: <4B0FB618.7020204@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:47032 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752282AbZK0WLb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Nov 2009 17:11:31 -0500
Content-Disposition: inline
In-Reply-To: <4B0FB618.7020204@collabora.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ian Molton <ian.molton@collabora.co.uk>
Cc: linux-acpi@vger.kernel.org

On Fri, 27 Nov 2009, Ian Molton wrote:
> The problem seems to be the rfkill layer getting out of sync with ACPIs
> idea of the hardware state.

Hmm... did rfkill drop the suspend/resume support perchance?

> If the laptop is suspended with WWAN enabled, it will wake up with it
> disabled, requiring a toggle of the physical WWAN switch or a prod in
> /sys to get it going again.

Yes.  rfkill is suposed to do proper suspend/resume in the class level,
which would call back thinkpad-acpi and request the radio to be turned on.

> I wrote a little patch that "cures" this issue (attached), however it is
> far from perfect.

Indeed, and it is NAK'd.  Let's fix it properly :-)

> For example, even with this patch, when the side switch is used, it
> overrides the soft setting for the devices completely, so if for example
> the WWAN was off, then toggling the switch changes its rfkill state from
> 0 -> 2, and then from 2 -> 1

...

> It *appears* from the code that it should be possible to get the device
> to power up in the state it was last in, but I cant make mine do it.

Depends only on rfkill, and whatever is handling EV_SW SW_RFKILL_ALL in your
Linux distribution.  Sometime ago, you could give rfkill-input a parameter
to change its mode to do just what you want.  I don't know if that's still
possible.

So, at least for this part of the issue, you have to turn your eyes to
rfkill and userspace.

> I've also noticed that on recent kernels, I get an extra rfkillswitch
> for hci0 (bluetooth) in addition to the ACPI one. This vanishes if power
> is toggled using the ACPI rfkill softswitch, however bluetooth continues
> to work (when enabled).

Yes.  The thinkpad-acpi rfkill switch powers down the bluetooth hardware,
thus it disappears.

> +static int wan_resume(pm_message_t state)
> +{
> +	int status;
> +	printk("res\n");
> +	acpi_evalf(hkey_handle, &status, "GWAN", "d");
> +	printk("r%d stat.\n", status);
> +        printk("l%d stat.\n", laststat);
> +	if(laststat & TP_ACPI_WANCARD_RADIOSSW) {
> +	acpi_evalf(hkey_handle, NULL, "SWAN", "vd", TP_ACPI_WANCARD_RADIOSSW);
> +	acpi_evalf(hkey_handle, &status, "GWAN", "d");
> +	printk("r%d stat.\n", status);
> +	tpacpi_rfk_update_swstate_all();
> +	}

This is the right idea, done wrong.  I will fix it properly.  Just let me
check if it needs fixing in thinkpad-acpi or in rfkill, because if it is in
rfkill, they might have broken other drivers.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
