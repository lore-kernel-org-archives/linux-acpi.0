From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 6/8] hp-wmi: notify of a potential docking state change on
 resume
Date: Sun, 15 Mar 2009 23:45:50 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903152345350.30317@localhost.localdomain>
References: <200903041955.n24JtTPN028010@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:36266 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbZCPDp6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Mar 2009 23:45:58 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KGK00IK4YGFPQY0@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 15 Mar 2009 22:45:52 -0500 (CDT)
In-reply-to: <200903041955.n24JtTPN028010@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, elendil@planet.nl, mjg59@srcf.ucam.org

applied to acpi-test (for 2.6.30)

thanks,
Len Brown, Intel Open Source Technology Center

On Wed, 4 Mar 2009, akpm@linux-foundation.org wrote:

> From: Frans Pop <elendil@planet.nl>
> 
> It is possible that the system gets docked or undocked while it's
> suspended. Generate an input event on resume to notify user space
> if there was a state change.
> 
> As it is a switch, we can generate the event unconditionally; the
> input layer will only pass it on if there is an actual change.
> 
> Signed-off-by: Frans Pop <elendil@planet.nl>
> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/platform/x86/hp-wmi.c |   25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff -puN drivers/platform/x86/hp-wmi.c~hp-wmi-notify-of-a-potential-docking-state-change-on-resume drivers/platform/x86/hp-wmi.c
> --- a/drivers/platform/x86/hp-wmi.c~hp-wmi-notify-of-a-potential-docking-state-change-on-resume
> +++ a/drivers/platform/x86/hp-wmi.c
> @@ -53,6 +53,7 @@ MODULE_ALIAS("wmi:5FB7F034-2C63-45e9-BE9
>  
>  static int __init hp_wmi_bios_setup(struct platform_device *device);
>  static int __exit hp_wmi_bios_remove(struct platform_device *device);
> +static int hp_wmi_resume_handler(struct platform_device *device);
>  
>  struct bios_args {
>  	u32 signature;
> @@ -101,6 +102,7 @@ static struct platform_driver hp_wmi_dri
>  	},
>  	.probe = hp_wmi_bios_setup,
>  	.remove = hp_wmi_bios_remove,
> +	.resume = hp_wmi_resume_handler,
>  };
>  
>  static int hp_wmi_perform_query(int query, int write, int value)
> @@ -487,6 +489,29 @@ static int __exit hp_wmi_bios_remove(str
>  	return 0;
>  }
>  
> +static int hp_wmi_resume_handler(struct platform_device *device)
> +{
> +	struct key_entry *key;
> +
> +	/*
> +	 * Docking state may have changed while suspended, so trigger
> +	 * an input event for the current state. As this is a switch,
> +	 * the input layer will only actually pass it on if the state
> +	 * changed.
> +	 */
> +	for (key = hp_wmi_keymap; key->type != KE_END; key++) {
> +		switch (key->type) {
> +		case KE_SW:
> +			input_report_switch(hp_wmi_input_dev, key->keycode,
> +					    hp_wmi_dock_state());
> +			input_sync(hp_wmi_input_dev);
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int __init hp_wmi_init(void)
>  {
>  	int err;
> _
> 
