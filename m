From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 1/1] ACPI: compal-laptop: use rfkill switch subsystem
Date: Wed, 2 Jul 2008 23:14:33 -0300
Message-ID: <20080703021433.GC20410@khazad-dum.debian.net>
References: <20080702214524.2ba4a001@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:37347 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752669AbYGCCOj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jul 2008 22:14:39 -0400
Content-Disposition: inline
In-Reply-To: <20080702214524.2ba4a001@debian>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>
Cc: ak@linux.intel.com, Len Brown <lenb@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Wed, 02 Jul 2008, Cezary Jackiewicz wrote:
> Removing unnecessary attributes, use rfkill switch subsystem.
> 
> It depends on the rfkill changes in net-next-2.6.

[...]

> +static int wlan_rfk_set(void *data, enum rfkill_state state)
>  {
> -	u8 result;
> +	u8 result, value;
>  
>  	ec_read(COMPAL_EC_COMMAND_WIRELESS, &result);
>  
> -	return sprintf(buf, "%i\n", result);
> +	if ((result & KILLSWITCH_MASK) == 0)
> +		return 0;
> +	else {
> +		if (state == RFKILL_STATE_ON)
> +			value = (u8) (result | WLAN_MASK);
> +		else
> +			value = (u8) (result & ~WLAN_MASK);
> +		ec_write(COMPAL_EC_COMMAND_WIRELESS, value);
> +	}
> +
> +	return 0;
>  }

That doesn't look like a new-style (i.e. what is in net-next-2.6) rfkill
support.  Could you take a look on the new (and I sure hope, vastly
improved) Documentation/rfkill.txt in net-next-2.6, and switch the driver to
RFKILL_STATE_UNBLOCKED, RFKILL_STATE_SOFT_BLOCKED, etc?  After a quick look,
it looks like Compal won't need RFKILL_STATE_HARD_BLOCKED  (thinkpad-acpi
does, because some thinkpads have a master wireless kill switch), but
still...

The new documentation describes how your rfk_get and rfk_set methods should
operate, etc.  So it is a good idea to read it all, and then check if what
the driver is doing matches it.

> +	(*rfk)->name = name;
> +	(*rfk)->get_state = get_state;
> +	(*rfk)->toggle_radio = toggle_radio;
> +	(*rfk)->user_claim_unsupported = 1;

Better update (*rfk)->state here, too.  Right now, rfkill won't do it for
you (maybe it should, as there is a get_state method.  But it doesn't, yet).

BTW, if it is a read/write rfkill controller, why do you set
user_claim_unsupported to true?  Just asking, this is not necessarily an
error, but it looks odd to me.

"user-claiming" a rfkill controller just means stuff like rfkill-input are
to stay clear from it (except for emergency power-off commands).  The
hardware and firmware can still toggle it behind the kernel's back.

> -	compalbl_device = backlight_device_register("compal-laptop", NULL, NULL,
> -						&compalbl_ops);
> +	compalbl_device = backlight_device_register(COMPAL_DRIVER_NAME,
> +						NULL, NULL, &compalbl_ops);

Frankly, I'd prefer if you had done this kind of cleanup in a previous,
separate patch.  Easier to read and review if we are looking just at rfkill
changes, just at cleanups, just at backlight changes... etc.

>  	compalbl_device->props.max_brightness = COMPAL_LCD_LEVEL_MAX-1;
> +	compalbl_device->props.brightness = get_lcd_level();

See above.

BTW, it is a good idea to Cc linux-wireless on rfkill patches, and you
*really* should be CCing the rfkill maintainer on any patches dealing with
rfkill IMHO.  That way, you get more reviews, rfkill isn't (unfortunately)
easy to use.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
