From: Tim Gardner <timg-l6nL5VImRDY@public.gmane.org>
Subject: Re: [PATCH] dell-laptop: Fix rfkill state queries
Date: Fri, 31 Jul 2009 07:19:28 -0600
Message-ID: <4A72EF60.1090501@tpi.com>
References: <1249007138-27354-1-git-send-email-mjg@redhat.com>
Reply-To: timg-l6nL5VImRDY@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1249007138-27354-1-git-send-email-mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Matthew Garrett wrote:
> The current code in dell-laptop is confused about the hardware rfkill
> state. Fix it up such that it's always reported correctly.
> 
> Signed-off-by: Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/platform/x86/dell-laptop.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
> index 74909c4..9061111 100644
> --- a/drivers/platform/x86/dell-laptop.c
> +++ b/drivers/platform/x86/dell-laptop.c
> @@ -197,8 +197,8 @@ static void dell_rfkill_query(struct rfkill *rfkill, void *data)
>  	dell_send_request(&buffer, 17, 11);
>  	status = buffer.output[1];
>  
> -	if (status & BIT(bit))
> -		rfkill_set_hw_state(rfkill, !!(status & BIT(16)));
> +	rfkill_set_sw_state(rfkill, !!(status & BIT(bit)));
> +	rfkill_set_hw_state(rfkill, !(status & BIT(16)));
>  }
>  
>  static const struct rfkill_ops dell_rfkill_ops = {

This works on an Inspiron 1420 and XPS1330 as far as I was able to test.
The physical rfkill switch sets 'Hard blocked: yes' for 'phy0: Wireless
LAN', and everything returns to normal 'blocked: no' when the switch is
disabled. I was not able to figure out how to get BIT(16) cleared. Is
that a keyboard function? Anyways,

Tested-by: Tim Gardner <tim.gardner-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>

rtg
-- 
Tim Gardner timg-l6nL5VImRDY@public.gmane.org www.tpi.com
OR 503-601-0234 x102 MT 406-443-5357
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
