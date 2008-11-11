From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Add DMI callback for Lifebook S6420
Date: Tue, 11 Nov 2008 15:09:31 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811111509010.4480@localhost.localdomain>
References: <20081109042005.4FF551008C@gold.linx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:46909 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbYKKUJl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Nov 2008 15:09:41 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KA600JJVQMEBKJ8@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 11 Nov 2008 14:08:39 -0600 (CST)
In-reply-to: <20081109042005.4FF551008C@gold.linx.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tony Vroon <tony@linx.net>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Peter Gruber <nokos@gmx.net>, linux-acpi@vger.kernel.org

applied to acpi-test

thanks,
-len

On Sun, 9 Nov 2008, Tony Vroon wrote:

> The Lifebook S6420 is the ICH9M-based follow-up to the S6410. The application panel 
> contains the following keys: lock, mobility center, eco, info.
> Whilst key 4 might be more appropriate for help then key 2, I've done things the 
> S6410 way. I can confirm that backlight control is functional, and that the lock key 
> activates the Gnome screensaver as expected.
> This should apply cleanly to acpi-test.
> 
> Signed-off-by: Tony Vroon <tony@linx.net>
> 
> diff --git a/drivers/misc/fujitsu-laptop.c b/drivers/misc/fujitsu-laptop.c
> index 2c7504f..a7dd3e9 100644
> --- a/drivers/misc/fujitsu-laptop.c
> +++ b/drivers/misc/fujitsu-laptop.c
> @@ -464,6 +464,14 @@ static int dmi_check_cb_s6410(const struct dmi_system_id *id)
>  	return 0;
>  }
>  
> +static int dmi_check_cb_s6420(const struct dmi_system_id *id)
> +{
> +	dmi_check_cb_common(id);
> +	fujitsu->keycode1 = KEY_SCREENLOCK;	/* "Lock" */
> +	fujitsu->keycode2 = KEY_HELP;	/* "Mobility Center" */
> +	return 0;
> +}
> +
>  static int dmi_check_cb_p8010(const struct dmi_system_id *id)
>  {
>  	dmi_check_cb_common(id);
> @@ -482,6 +490,13 @@ static struct dmi_system_id fujitsu_dmi_table[] = {
>  		     },
>  	 .callback = dmi_check_cb_s6410},
>  	{
> +	 .ident = "Fujitsu Siemens S6420",
> +	 .matches = {
> +		     DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
> +		     DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK S6420"),
> +		     },
> +	 .callback = dmi_check_cb_s6420},
> +	{
>  	 .ident = "Fujitsu LifeBook P8010",
>  	 .matches = {
>  		     DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
