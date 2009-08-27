From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] fujitsu-laptop: support led-class as module
Date: Thu, 27 Aug 2009 18:53:27 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908271851120.23436@localhost.localdomain>
References: <200908250511.n7P5BqSY006903@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:59383 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbZH0Wxm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Aug 2009 18:53:42 -0400
Received: from localhost.localdomain ([64.140.212.33])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KP2000QZ4X4G1F3@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 27 Aug 2009 17:53:34 -0500 (CDT)
In-reply-to: <200908250511.n7P5BqSY006903@turbo.physics.adelaide.edu.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: linux-acpi@vger.kernel.org


On Tue, 25 Aug 2009, Jonathan Woithe wrote:

> Hi Len
> 
> Please consider slipping this in to 2.6.31-rc since it's a fairly trivial
> bug fix to ensure that fujitsu-laptop uses the LEDS class even when the LEDS
> class been compiled as a module.  If that's not possible or viewed as
> inappropriate then let's go for 2.6.32.
> 
> Thanks
>   jonathan
> 
> 
> From: Stephen Gildea <stepheng+linux@gildea.com>

Note that a From-override works only if it is the 1st line of the body.

> Support fujitsu::logolamp with led-class built as a module instead of
> being compiled in.
> 
> Signed-off-by: Stephen Gildea <stepheng+linux@gildea.com>
> Acked-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
> 
> ---

Note that everything above this ---
gets put into the check-in commant
and evertying below (until the patch) is thrown away.

(unless i manually edit like i did this time, but would
 rather not have to do)

applied.
thanks
-Len Brown, Intel Open Source Technology Center

> A friend pointed out to me that fujitsu-laptop LED support doesn't
> work with CONFIG_LEDS_CLASS=m.  We require CONFIG_LEDS_CLASS=y.
> He noticed this because his distro ships led-class as a module, not
> compiled in as my kernels are built.
> 
> It appears this straightforward patch against 2.6.31-rc7 fixes the
> problem.
> 
>  < Stephen
> 
> 
> diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
> index 218b9a1..4c8897a 100644
> --- a/drivers/platform/x86/fujitsu-laptop.c
> +++ b/drivers/platform/x86/fujitsu-laptop.c
> @@ -66,7 +66,7 @@
>  #include <linux/kfifo.h>
>  #include <linux/video_output.h>
>  #include <linux/platform_device.h>
> -#ifdef CONFIG_LEDS_CLASS
> +#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
>  #include <linux/leds.h>
>  #endif
>  
> @@ -96,7 +96,7 @@
>  /* FUNC interface - responses */
>  #define UNSUPPORTED_CMD 0x80000000
>  
> -#ifdef CONFIG_LEDS_CLASS
> +#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
>  /* FUNC interface - LED control */
>  #define FUNC_LED_OFF	0x1
>  #define FUNC_LED_ON	0x30001
> @@ -176,7 +176,7 @@ static struct fujitsu_hotkey_t *fujitsu_hotkey;
>  
>  static void acpi_fujitsu_hotkey_notify(struct acpi_device *device, u32 event);
>  
> -#ifdef CONFIG_LEDS_CLASS
> +#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
>  static enum led_brightness logolamp_get(struct led_classdev *cdev);
>  static void logolamp_set(struct led_classdev *cdev,
>  			       enum led_brightness brightness);
> @@ -257,7 +257,7 @@ static int call_fext_func(int cmd, int arg0, int arg1, int arg2)
>  	return out_obj.integer.value;
>  }
>  
> -#ifdef CONFIG_LEDS_CLASS
> +#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
>  /* LED class callbacks */
>  
>  static void logolamp_set(struct led_classdev *cdev,
> @@ -911,7 +911,7 @@ static int acpi_fujitsu_hotkey_add(struct acpi_device *device)
>  	printk(KERN_INFO "fujitsu-laptop: BTNI: [0x%x]\n",
>  		call_fext_func(FUNC_BUTTONS, 0x0, 0x0, 0x0));
>  
> -	#ifdef CONFIG_LEDS_CLASS
> +	#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
>  	if (call_fext_func(FUNC_LEDS, 0x0, 0x0, 0x0) & LOGOLAMP_POWERON) {
>  		result = led_classdev_register(&fujitsu->pf_device->dev,
>  						&logolamp_led);
> @@ -1204,7 +1204,7 @@ fail_acpi:
>  
>  static void __exit fujitsu_cleanup(void)
>  {
> -	#ifdef CONFIG_LEDS_CLASS
> +	#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
>  	if (fujitsu_hotkey->logolamp_registered != 0)
>  		led_classdev_unregister(&logolamp_led);
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
