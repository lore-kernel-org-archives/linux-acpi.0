From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH] Add DMI callback for Lifebook S6420
Date: Mon, 10 Nov 2008 08:52:29 +1030 (CST)
Message-ID: <200811092222.mA9MMTCb021246@turbo.physics.adelaide.edu.au>
References: <20081109042005.4FF551008C@gold.linx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:52190 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755919AbYKIWWy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Nov 2008 17:22:54 -0500
In-Reply-To: <20081109042005.4FF551008C@gold.linx.net> from "Tony Vroon" at Nov 09, 2008 04:20:05 AM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tony Vroon <tony@linx.net>
Cc: Len Brown <lenb@kernel.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Peter Gruber <nokos@gmx.net>, linux-acpi@vger.kernel.org

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

Ack.

Signed-off-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

jonathan
