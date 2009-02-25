From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/4] asus-laptop: restore acpi_generate_proc_event()
Date: Wed, 25 Feb 2009 18:14:13 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902251814100.19092@localhost.localdomain>
References: <1234722621-14498-1-git-send-email-corentincj@iksaif.net>
 <1234722621-14498-2-git-send-email-corentincj@iksaif.net>
 <1234722621-14498-3-git-send-email-corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:43737 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757165AbZBYXOc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Feb 2009 18:14:32 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KFN00F039VRIJXS@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 25 Feb 2009 17:14:16 -0600 (CST)
In-reply-to: <1234722621-14498-3-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentincj@iksaif.net>
Cc: linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org

applied

--
Len Brown, Intel Open Source Technology Center

On Sun, 15 Feb 2009, Corentin Chary wrote:

> Restore acpi_generate_proc_event() for backward
> compatibility with old acpi scripts.
> 
> Signed-off-by: Corentin Chary <corentincj@iksaif.net>
> ---
>  drivers/platform/x86/asus-laptop.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
> index 56af6cf..eeafc6c 100644
> --- a/drivers/platform/x86/asus-laptop.c
> +++ b/drivers/platform/x86/asus-laptop.c
> @@ -815,6 +815,7 @@ static int asus_setkeycode(struct input_dev *dev, int scancode, int keycode)
>  static void asus_hotk_notify(acpi_handle handle, u32 event, void *data)
>  {
>  	static struct key_entry *key;
> +	u16 count;
>  
>  	/* TODO Find a better way to handle events count. */
>  	if (!hotk)
> @@ -832,9 +833,11 @@ static void asus_hotk_notify(acpi_handle handle, u32 event, void *data)
>  		lcd_blank(FB_BLANK_POWERDOWN);
>  	}
>  
> +	count = hotk->event_count[event % 128]++;
> +	acpi_bus_generate_proc_event(hotk->device, event, count);
>  	acpi_bus_generate_netlink_event(hotk->device->pnp.device_class,
>  					dev_name(&hotk->device->dev), event,
> -					hotk->event_count[event % 128]++);
> +					count);
>  
>  	if (hotk->inputdev) {
>  		key = asus_get_entry_by_scancode(event);
> -- 
> 1.6.1.2
> 
> 
