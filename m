From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2.6.29] fujitsu-laptop: Simplify SBLL/SBL2 backlight
 handling
Date: Fri, 09 Jan 2009 01:06:37 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901090105540.4091@localhost.localdomain>
References: <20090107101124.6884E10077@gold.linx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:35805 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986AbZAIGHA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 01:07:00 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD600LGEWZ4LJ67@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 00:06:41 -0600 (CST)
In-reply-to: <20090107101124.6884E10077@gold.linx.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tony Vroon <tony@linx.net>
Cc: Peter Gruber <nokos@gmx.net>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Stephen Gildea <stepheng+linux@gildea.com>, Julian Brown <jules@panic.cs-bristol.org.uk>, linux-acpi@vger.kernel.org

applied

--
Len Brown, Intel Open Source Technology Center

On Wed, 7 Jan 2009, Tony Vroon wrote:

> GBLS and GBLL only differ in the clearing of the GHKS flag, so there is no need 
> to have two backlight level readouts. Also, per Peter Gruber, the need for the 
> BLNF check has disappeared.
> As a result, cleanups can be made in the code. This has been tested on the both 
> the S6410 and the S6420 platforms and causes no functionality regressions, on 
> the console without X or within X. One module parameter to disable the hotkeys 
> is dropped, as we only ever took one codepath anyway.
> 
> (Len, this applies on top of "Add BL power, LED control and radio state information")
> 
> Signed-off-by: Tony Vroon <tony@linx.net>
> Tested-by: Peter Gruber <nokos@gmx.net>
> Acked-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
> 
> --- linux-2.6/drivers/misc/fujitsu-laptop.c.upstream	2009-01-05 20:34:42.000000000 +0000
> +++ linux-2.6/drivers/misc/fujitsu-laptop.c	2009-01-05 20:59:36.000000000 +0000
> @@ -155,7 +155,6 @@
>  
>  static struct fujitsu_t *fujitsu;
>  static int use_alt_lcd_levels = -1;
> -static int disable_brightness_keys = -1;
>  static int disable_brightness_adjust = -1;
>  
>  /* Device used to access other hotkeys on the laptop */
> @@ -413,36 +412,11 @@
>  	return fujitsu->max_brightness;
>  }
>  
> -static int get_lcd_level_alt(void)
> -{
> -	unsigned long long state = 0;
> -	acpi_status status = AE_OK;
> -
> -	vdbg_printk(FUJLAPTOP_DBG_TRACE, "get lcd level via GBLS\n");
> -
> -	status =
> -	    acpi_evaluate_integer(fujitsu->acpi_handle, "GBLS", NULL, &state);
> -	if (status < 0)
> -		return status;
> -
> -	fujitsu->brightness_level = state & 0x0fffffff;
> -
> -	if (state & 0x80000000)
> -		fujitsu->brightness_changed = 1;
> -	else
> -		fujitsu->brightness_changed = 0;
> -
> -	return fujitsu->brightness_level;
> -}
> -
>  /* Backlight device stuff */
>  
>  static int bl_get_brightness(struct backlight_device *b)
>  {
> -	if (use_alt_lcd_levels)
> -		return get_lcd_level_alt();
> -	else
> -		return get_lcd_level();
> +	return get_lcd_level();
>  }
>  
>  static int bl_update_status(struct backlight_device *b)
> @@ -509,10 +483,7 @@
>  
>  	int ret;
>  
> -	if (use_alt_lcd_levels)
> -		ret = get_lcd_level_alt();
> -	else
> -		ret = get_lcd_level();
> +	ret = get_lcd_level();
>  	if (ret < 0)
>  		return ret;
>  
> @@ -537,10 +508,7 @@
>  	if (ret < 0)
>  		return ret;
>  
> -	if (use_alt_lcd_levels)
> -		ret = get_lcd_level_alt();
> -	else
> -		ret = get_lcd_level();
> +	ret = get_lcd_level();
>  	if (ret < 0)
>  		return ret;
>  
> @@ -622,24 +590,16 @@
>  static void dmi_check_cb_common(const struct dmi_system_id *id)
>  {
>  	acpi_handle handle;
> -	int have_blnf;
>  	printk(KERN_INFO "fujitsu-laptop: Identified laptop model '%s'.\n",
>  	       id->ident);
> -	have_blnf = ACPI_SUCCESS
> -	    (acpi_get_handle(NULL, "\\_SB.PCI0.GFX0.LCD.BLNF", &handle));
>  	if (use_alt_lcd_levels == -1) {
> -		vdbg_printk(FUJLAPTOP_DBG_TRACE, "auto-detecting usealt\n");
> -		use_alt_lcd_levels = 1;
> -	}
> -	if (disable_brightness_keys == -1) {
> -		vdbg_printk(FUJLAPTOP_DBG_TRACE,
> -			    "auto-detecting disable_keys\n");
> -		disable_brightness_keys = have_blnf ? 1 : 0;
> -	}
> -	if (disable_brightness_adjust == -1) {
> -		vdbg_printk(FUJLAPTOP_DBG_TRACE,
> -			    "auto-detecting disable_adjust\n");
> -		disable_brightness_adjust = have_blnf ? 0 : 1;
> +		if (ACPI_SUCCESS(acpi_get_handle(NULL,
> +				"\\_SB.PCI0.LPCB.FJEX.SBL2", &handle)))
> +			use_alt_lcd_levels = 1;
> +		else
> +			use_alt_lcd_levels = 0;
> +		vdbg_printk(FUJLAPTOP_DBG_TRACE, "auto-detected usealt as "
> +			"%i\n", use_alt_lcd_levels);
>  	}
>  }
>  
> @@ -768,19 +728,14 @@
>  
>  	/* do config (detect defaults) */
>  	use_alt_lcd_levels = use_alt_lcd_levels == 1 ? 1 : 0;
> -	disable_brightness_keys = disable_brightness_keys == 1 ? 1 : 0;
>  	disable_brightness_adjust = disable_brightness_adjust == 1 ? 1 : 0;
>  	vdbg_printk(FUJLAPTOP_DBG_INFO,
> -		    "config: [alt interface: %d], [key disable: %d], [adjust disable: %d]\n",
> -		    use_alt_lcd_levels, disable_brightness_keys,
> -		    disable_brightness_adjust);
> +		    "config: [alt interface: %d], [adjust disable: %d]\n",
> +		    use_alt_lcd_levels, disable_brightness_adjust);
>  
>  	if (get_max_brightness() <= 0)
>  		fujitsu->max_brightness = FUJITSU_LCD_N_LEVELS;
> -	if (use_alt_lcd_levels)
> -		get_lcd_level_alt();
> -	else
> -		get_lcd_level();
> +	get_lcd_level();
>  
>  	return result;
>  
> @@ -831,43 +786,23 @@
>  	case ACPI_FUJITSU_NOTIFY_CODE1:
>  		keycode = 0;
>  		oldb = fujitsu->brightness_level;
> -		get_lcd_level();  /* the alt version always yields changed */
> +		get_lcd_level();
>  		newb = fujitsu->brightness_level;
>  
>  		vdbg_printk(FUJLAPTOP_DBG_TRACE,
>  			    "brightness button event [%i -> %i (%i)]\n",
>  			    oldb, newb, fujitsu->brightness_changed);
>  
> -		if (oldb == newb && fujitsu->brightness_changed) {
> -			keycode = 0;
> -			if (disable_brightness_keys != 1) {
> -				if (oldb == 0) {
> -					acpi_bus_generate_proc_event
> -					    (fujitsu->dev,
> -					     ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS,
> -					     0);
> -					keycode = KEY_BRIGHTNESSDOWN;
> -				} else if (oldb ==
> -					   (fujitsu->max_brightness) - 1) {
> -					acpi_bus_generate_proc_event
> -					    (fujitsu->dev,
> -					     ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS,
> -					     0);
> -					keycode = KEY_BRIGHTNESSUP;
> -				}
> -			}
> -		} else if (oldb < newb) {
> +		if (oldb < newb) {
>  			if (disable_brightness_adjust != 1) {
>  				if (use_alt_lcd_levels)
>  					set_lcd_level_alt(newb);
>  				else
>  					set_lcd_level(newb);
>  			}
> -			if (disable_brightness_keys != 1) {
> -				acpi_bus_generate_proc_event(fujitsu->dev,
> -					ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS, 0);
> -				keycode = KEY_BRIGHTNESSUP;
> -			}
> +			acpi_bus_generate_proc_event(fujitsu->dev,
> +				ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS, 0);
> +			keycode = KEY_BRIGHTNESSUP;
>  		} else if (oldb > newb) {
>  			if (disable_brightness_adjust != 1) {
>  				if (use_alt_lcd_levels)
> @@ -875,13 +810,9 @@
>  				else
>  					set_lcd_level(newb);
>  			}
> -			if (disable_brightness_keys != 1) {
> -				acpi_bus_generate_proc_event(fujitsu->dev,
> -					ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS, 0);
> -				keycode = KEY_BRIGHTNESSDOWN;
> -			}
> -		} else {
> -			keycode = KEY_UNKNOWN;
> +			acpi_bus_generate_proc_event(fujitsu->dev,
> +				ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS, 0);
> +			keycode = KEY_BRIGHTNESSDOWN;
>  		}
>  		break;
>  	default:
> @@ -1336,9 +1267,6 @@
>  module_param(use_alt_lcd_levels, uint, 0644);
>  MODULE_PARM_DESC(use_alt_lcd_levels,
>  		 "Use alternative interface for lcd_levels (needed for Lifebook s6410).");
> -module_param(disable_brightness_keys, uint, 0644);
> -MODULE_PARM_DESC(disable_brightness_keys,
> -		 "Disable brightness keys (eg. if they are already handled by the generic ACPI_VIDEO device).");
>  module_param(disable_brightness_adjust, uint, 0644);
>  MODULE_PARM_DESC(disable_brightness_adjust, "Disable brightness adjustment .");
>  #ifdef CONFIG_FUJITSU_LAPTOP_DEBUG
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
