From: Thomas Renninger <trenn@suse.de>
Subject: Re: [ibm-acpi-devel] [PATCH 2/4] ACPI: thinkpad-acpi: support 16
	levels of brightness (v2)
Date: Tue, 09 Oct 2007 07:16:53 +0200
Message-ID: <1191907013.9847.69.camel@queen.suse.de>
References: <1191849179-24087-1-git-send-email-hmh@hmh.eng.br>
	 <1191849179-24087-3-git-send-email-hmh@hmh.eng.br>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:52955 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809AbXJIFRE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Oct 2007 01:17:04 -0400
In-Reply-To: <1191849179-24087-3-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Mon, 2007-10-08 at 10:12 -0300, Henrique de Moraes Holschuh wrote:
> Lenovo ThinkPads with ACPI Video brightness control often have 16
> brightness levels in EC, and not just eight levels like older ThinkPads.
> 
> We detect the number of brightness levels by the presence of a _BCL method
> with 18 entries (16 levels plus the on-battery and on-ac recommended
> levels).  If _BCL is not there, we assume eight levels (T60, for example).
> Otherwise we assume sixteen levels (T61, X61, etc).
This is broken by design, pls don't add this to a mainline kernel.

Correct is: If there is _BCL (and other video functions) don't touch any
video or brightness functionality.

Thinkpad_acpi should try to register for the acpi device with the
LNXVIDEO HID. If the probe/add function there is invoked, it can be sure
that video module tries to load and is handling the stuff in a defined
way and thinkpad_acpi should get its hands off.
AFAIK this would be the first case where two drivers register for the
same device, not sure whether it works out of the box. If the passed
device's driver_data or anything else is not touched, it should.

Here some more arguments from a Lenovo engineer (he doesn't want to have
his mail public, I ask whether I can pass his email to you privately
Henrique...):

-----------------------------------------------------------
ThinkPad has implemented _BCL/_BCM/_BQC method for Vista. 
These brightness control methods are not used on Windows XP. 

-------------
with Brightness Control method
- Press Fn+Home/End 
- ASL: Notify (video, 0x86/0x87) ( Increase/Decrease Brightness)
- OS: Call _BCM    <------ ??? Does this work?
- ASL: Indicate brightness change in config space of IGD. 
- Intel 965GM driver : Change the brightness setting 

--------------
without brightness control method
- Press Fn+Home/End 
- ASL: Indicate brightness change in config space of IGD. 
- Intel 965GM driver : Change the brightness setting    <--- I had
assumed the driver did nothing here. 

Now, I don't understand which point the brightness control is broken. 
Does Suse call _BCM , but not handle Notify (video, 0x86/0x87)
(Increase/Decrease Brightness) ?

> On which systems or more specific from what bios version of these
> models on should these acpi functions be used?

The BIOSs/Machine Type/Model/Support are too complicated. 
Why don't you use assume BIOS supports _BCL/_BCM/_BQC if these methods
are found in ACPI name space ?

T61/T61p/R61  -  Brightness control method : Any version 

                        BIOS                      EC
  1.22-1.06         1.22  (7LET52WW)          1.06  (7KHT22WW)
  1.21-1.06         1.21  (7LET51WW)          1.06  (7KHT22WW)
  1.14-1.06         1.14  (7LET44WW)          1.06  (7KHT22WW)
  1.10-1.06         1.10  (7LET40WW)          1.06  (7KHT22WW)
  1.09-1.05         1.09  (7LET39WW)          1.05  (7KHT21WW)
  1.07-1.04         1.07  (7LET37WW)          1.04  (7KHT20WW)
  1.07              1.07  (7LET37WW)          1.03  (7KHT19WW) 

R61 14.1 Wide, 15.4 Wide Brightness control method : Any version 
  1.22-1.06         1.22  (7KET72WW)          1.06  (7KHT22WW)
  1.21-1.06         1.21  (7KET71WW)          1.06  (7KHT22WW)
  1.14-1.06         1.14  (7KET64WW)          1.06  (7KHT22WW)
  1.10-1.06         1.10  (7KET60WW)          1.06  (7KHT22WW)
  1.09-1.05         1.09  (7KET59WW)          1.05  (7KHT21WW)
  1.07-1.04         1.07  (7KET57WW)          1.04  (7KHT20WW)
  1.07              1.07  (7KET57WW)          1.03  (7KHT19WW) 


R61 15.1 Normal screen Brightness control method : Any version 
  1.07              1.07  (7QET25WW)          1.00  (7QHT15WW)
  1.04              1.04  (7QET22WW)          1.00  (7QHT15WW)
T60/T60p -  Brightness control method : 79ETC1WW or later
                   BIOS            EC 
  2.17         2.17   (79ETD7WW)    1.07   (79HT50WW)
  2.16         2.16   (79ETD6WW)    1.07   (79HT50WW)
  2.15         2.15   (79ETD5WW)    1.07   (79HT50WW)
  2.14         2.14   (79ETD4WW)    1.07   (79HT50WW)
  2.13         2.13   (79ETD3WW)    1.07   (79HT50WW)
  2.12         2.12   (79ETD2WW)    1.07   (79HT50WW)
  2.11         2.11   (79ETD1WW)    1.07   (79HT50WW)
  2.09         2.09   (79ETC9WW)    1.07   (79HT50WW)    <--------
(New) 
Vista support
  2.07         2.07   (79ETC7WW)    1.07   (79HT50WW)
  2.06         2.06   (79ETC6WW)    1.07   (79HT50WW)
  2.05         2.05   (79ETC5WW)    1.07   (79HT50WW)
  2.04         2.04   (79ETC4WW)    1.07   (79HT50WW)
  2.03         2.03   (79ETC3WW)    1.07   (79HT50WW)
  2.01         2.01   (79ETC1WW)    1.07   (79HT50WW)    <--------- 
Brightness control method

--------------------
  1.11         1.11   (79ET67WW)    1.05b  (79HT48WW)
  1.09         1.09a  (79ET65WW)    1.05b  (79HT48WW)
  1.07         1.07   (79ET62WW)    1.04   (79HT45WW)
  1.06         1.06   (79ET61WW)    1.04   (79HT45WW)
  1.05         1.05a  (79ET60WW)    1.02   (79HT43WW)
  1.04         1.04   (79ET58WW)    1.02   (79HT43WW)
  1.03         1.03   (79ET57WW)    1.02   (79HT43WW)
  1.02         1.02   (79ET56WW)    1.01   (79HT42WW)
  1.01         1.01a  (79ET55WW)    1.01   (79HT42WW)
  1.00         1.00h  (79ET52WW)    1.00c  (79HT39WW)

T60/60p Wide screen model - Brightness control method : Any version

  1.11              1.11  (7IET30WW)          1.07  (79HT50WW)
  1.10              1.10  (7IET29WW)          1.07  (79HT50WW)
  1.09              1.09  (7IET28WW)          1.07  (79HT50WW)
  1.08              1.08  (7IET27WW)          1.07  (79HT50WW)
  1.07              1.07  (7IET26WW)          1.07  (79HT50WW)
  1.06              1.06  (7IET25WW)          1.07  (79HT50WW)
  1.04              1.04  (7IET23WW)          1.07  (79HT50WW)
  na                  1.03  (7IET22WW)          1.07  (79HT50WW)
  1.01              1.01  (7IET20WW)          1.07  (79HT50WW)
  1.00              1.00  (7IET19WW)          1.07  (79HT50WW) 


X61/X61s -  Brightness control method : Any version
  1.06              1.06  (7NET25WW)          1.02  (7MHT24WW)
  1.05              1.05  (7NET24WW)          1.02  (7MHT24WW)
  1.03              1.03  (7NET22WW)          1.02  (7MHT24WW)
  1.02              1.02  (7NET21WW)          1.01  (7MHT23WW)


X61 Tablet  Brightness control method : Any version
  1.04              1.04  (7SET18WW)          1.02  (7RHT16WW)
  1.03              1.03  (7SET17WW)          1.01  (7RHT15WW) 

X60/X60s -  Brightness control method : 7BETB9WW or later
  2.13         2.13  (7BETD2WW)     1.13  (7BHT40WW)
  2.12         2.12  (7BETD1WW)     1.13  (7BHT40WW)
  2.11         2.11  (7BETD0WW)     1.13  (7BHT40WW)
  2.10         2.10  (7BETC9WW)     1.13  (7BHT40WW)
  2.09         2.09  (7BETC8WW)     1.10  (7BHT37WW)
  2.07         2.07  (7BETC6WW)     1.10  (7BHT37WW)
  2.06         2.06  (7BETC5WW)     1.10  (7BHT37WW)   <-- (New) Vista 
support
  2.05         2.05  (7BETC4WW)     1.10  (7BHT37WW)
  2.04         2.04  (7BETC3WW)     1.09  (7BHT36WW)
  2.03         2.03  (7BETC2WW)     1.09  (7BHT36WW)
  2.02         2.02  (7BETC1WW)     1.09  (7BHT36WW)
  2.00f        2.00f (7BETB9WW)     1.08  (7BHT35WW)  <--Brightness 
control method

--------------------------------
  1.10         1.10  (7BET50WW)     1.08  (7BHT35WW)
  1.09         1.09  (7BET49WW)     1.07  (7BHT34WW)
  1.06         1.06  (7BET46WW)     1.04  (7BHT31WW)
  1.03         1.05  (7BET45WW)     1.04  (7BHT31WW)
  1.01         1.04  (7BET44WW)     1.02  (7BHT29WW)
  1.00         1.03  (7BET43WW)     1.01  (7BHT28WW)


X60 Tablet -  Brightness control method : Any version
  1.03         1.03  (7JET18WW)     1.03  (7JHT12WW)
  1.04         1.04  (7JET19WW)     1.03  (7JHT12WW)
  1.05         1.05  (7JET20WW)     1.03  (7JHT12WW)   <--(New) Vista 
support
  1.07         1.07  (7JET22WW)     1.03  (7JHT12WW)
  1.08         1.08  (7JET23WW)     1.03  (7JHT12WW)
  1.09         1.09  (7JET24WW)     1.04  (7JHT13WW)
  1.10         1.10  (7JET25WW)     1.04  (7JHT13WW)


R61e  -  Brightness control method : Any version
1.03-1.06         1.03  (7PET16WW)          1.06  (7KHT22WW)

R60 (MT 9455/9457/9459)  -  Brightness control method : 7CETB6WW or
later
  2.19         2.19  (7CETC9WW)     1.10  (7CHT22WW)
  2.18         2.18  (7CETC8WW)     1.10  (7CHT22WW)
  2.17         2.17  (7CETC7WW)     1.09  (7CHT21WW)
  2.16         2.16  (7CETC6WW)     1.09  (7CHT21WW)
  2.14         2.14  (7CETC4WW)     1.09  (7CHT21WW)
  2.11         2.11  (7CETC1WW)     1.09  (7CHT21WW)  <--(New) Vista 
support 
  2.10         2.10  (7CETC0WW)     1.09  (7CHT21WW)
  2.08         2.08  (7CETB8WW)     1.09  (7CHT21WW)
  2.07         2.07  (7CETB7WW)     1.09  (7CHT21WW)
  2.06         2.06  (7CETB6WW)     1.09  (7CHT21WW)  <--------- 
Brightness control method

--------------------------------
  1.05         1.05  (7CET50WW)     1.07  (7CHT19WW)
  1.04-01      1.04  (7CET49WW)     1.04  (7CHT16WW)
  1.04         1.04  (7CET49WW)     1.02  (7CHT14WW)
  1.00         1.02  (7CET47WW)     1.02  (7CHT14WW)

R60e  -  Brightness control method :  7EETB6WW or later
  2.17         2.17  (7EETC7WW)     1.07  (7EHT15WW)
  2.16         2.16  (7EETC6WW)     1.07  (7EHT15WW)
  2.15         2.15  (7EETC5WW)     1.07  (7EHT15WW)
  2.14         2.14  (7EETC4WW)     1.07  (7EHT15WW)
  2.12         2.09  (7EETC2WW)     1.07  (7EHT15WW)
  2.09         2.09  (7EETB9WW)     1.07  (7EHT15WW)  <--(New) Vista 
support 
  2.07         2.07  (7EETB7WW)     1.07  (7EHT15WW)
  2.06         2.06  (7EETB6WW)     1.07  (7EHT15WW)  <--------- 
Brightness control method

--------------------------------
  1.04         1.04  (7EET18WW)     1.05  (7EHT13WW) 
  1.03         1.03  (7EET17WW)     1.02  (7EHT10WW)
  1.00         1.02  (7EET16WW)     1.02  (7EHT10WW)

# Z60m/Z60t/Z61m/Z61e/Z61t/Z61p don't support Brightness Control method.
-----------------------------------------------------------


    Thomas

> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> ---
>  Documentation/thinkpad-acpi.txt |   61 +++++++++++++++-----------
>  drivers/misc/thinkpad_acpi.c    |   93 ++++++++++++++++++++++++++++++++++----
>  drivers/misc/thinkpad_acpi.h    |    3 +-
>  3 files changed, 120 insertions(+), 37 deletions(-)
> 
> diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
> index 3b95bba..4db98b3 100644
> --- a/Documentation/thinkpad-acpi.txt
> +++ b/Documentation/thinkpad-acpi.txt
> @@ -923,19 +923,26 @@ sysfs backlight device "thinkpad_screen"
>  This feature allows software control of the LCD brightness on ThinkPad
>  models which don't have a hardware brightness slider.
>  
> -It has some limitations: the LCD backlight cannot be actually turned on or off
> -by this interface, and in many ThinkPad models, the "dim while on battery"
> -functionality will be enabled by the BIOS when this interface is used, and
> -cannot be controlled.
> -
> -The backlight control has eight levels, ranging from 0 to 7.  Some of the
> -levels may not be distinct.
> -
> -There are two interfaces to the firmware for brightness control, EC and CMOS.
> -To select which one should be used, use the brightness_mode module parameter:
> -brightness_mode=1 selects EC mode, brightness_mode=2 selects CMOS mode,
> -brightness_mode=3 selects both EC and CMOS.  The driver tries to autodetect
> -which interface to use.
> +It has some limitations: the LCD backlight cannot be actually turned on or
> +off by this interface, and in many ThinkPad models, the "dim while on
> +battery" functionality will be enabled by the BIOS when this interface is
> +used, and cannot be controlled.
> +
> +On IBM (and some of the earlier Lenovo) ThinkPads, the backlight control
> +has eight brightness levels, ranging from 0 to 7.  Some of the levels
> +may not be distinct.  Later Lenovo models that implement the ACPI
> +display backlight brightness control methods have 16 levels, ranging
> +from 0 to 15.
> +
> +There are two interfaces to the firmware for direct brightness control,
> +EC and CMOS.  To select which one should be used, use the
> +brightness_mode module parameter: brightness_mode=1 selects EC mode,
> +brightness_mode=2 selects CMOS mode, brightness_mode=3 selects both EC
> +and CMOS.  The driver tries to autodetect which interface to use.
> +
> +When display backlight brightness controls are available through the
> +standard ACPI interface, it is best to use it instead of this direct
> +ThinkPad-specific interface.
>  
>  Procfs notes:
>  
> @@ -947,11 +954,11 @@ Procfs notes:
>  
>  Sysfs notes:
>  
> -The interface is implemented through the backlight sysfs class, which is poorly
> -documented at this time.
> +The interface is implemented through the backlight sysfs class, which is
> +poorly documented at this time.
>  
> -Locate the thinkpad_screen device under /sys/class/backlight, and inside it
> -there will be the following attributes:
> +Locate the thinkpad_screen device under /sys/class/backlight, and inside
> +it there will be the following attributes:
>  
>  	max_brightness:
>  		Reads the maximum brightness the hardware can be set to.
> @@ -961,17 +968,19 @@ there will be the following attributes:
>  		Reads what brightness the screen is set to at this instant.
>  
>  	brightness:
> -		Writes request the driver to change brightness to the given
> -		value.  Reads will tell you what brightness the driver is trying
> -		to set the display to when "power" is set to zero and the display
> -		has not been dimmed by a kernel power management event.
> +		Writes request the driver to change brightness to the
> +		given value.  Reads will tell you what brightness the
> +		driver is trying to set the display to when "power" is set
> +		to zero and the display has not been dimmed by a kernel
> +		power management event.
>  
>  	power:
> -		power management mode, where 0 is "display on", and 1 to 3 will
> -		dim the display backlight to brightness level 0 because
> -		thinkpad-acpi cannot really turn the backlight off.  Kernel
> -		power management events can temporarily increase the current
> -		power management level, i.e. they can dim the display.
> +		power management mode, where 0 is "display on", and 1 to 3
> +		will dim the display backlight to brightness level 0
> +		because thinkpad-acpi cannot really turn the backlight
> +		off.  Kernel power management events can temporarily
> +		increase the current power management level, i.e. they can
> +		dim the display.
>  
> 
>  Volume control -- /proc/acpi/ibm/volume
> diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
> index 37891a8..2a573db 100644
> --- a/drivers/misc/thinkpad_acpi.c
> +++ b/drivers/misc/thinkpad_acpi.c
> @@ -3114,6 +3114,68 @@ static struct backlight_ops ibm_backlight_data = {
>  
>  static struct mutex brightness_mutex;
>  
> +static int __init tpacpi_query_bcl_levels(acpi_handle handle)
> +{
> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *obj;
> +	int rc;
> +
> +	if (ACPI_SUCCESS(acpi_evaluate_object(handle, NULL, NULL, &buffer))) {
> +		obj = (union acpi_object *)buffer.pointer;
> +		if (!obj || (obj->type != ACPI_TYPE_PACKAGE)) {
> +			printk(IBM_ERR "Invalid _BCL data\n");
> +			rc = 0;
> +		} else {
> +			if (obj->package.count >= 2)
> +				rc = obj->package.count - 2;
> +			else
> +				rc = 0;
> +		}
> +	} else {
> +		return 0;
> +	}
> +
> +	kfree(buffer.pointer);
> +	return rc;
> +}
> +
> +static acpi_status __init brightness_find_bcl(acpi_handle handle, u32 lvl,
> +					void *context, void **rv)
> +{
> +	char name[ACPI_PATH_SEGMENT_LENGTH];
> +	struct acpi_buffer buffer = { sizeof(name), &name };
> +
> +	if (ACPI_SUCCESS(acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer)) &&
> +	    !strncmp("_BCL", name, sizeof(name) - 1)) {
> +		if (tpacpi_query_bcl_levels(handle) == 16) {
> +			*rv = handle;
> +			return AE_CTRL_TERMINATE;
> +		} else {
> +			return AE_OK;
> +		}
> +	} else {
> +		return AE_OK;
> +	}
> +}
> +
> +static int __init brightness_check_levels(void)
> +{
> +	int status;
> +	void *found_node = NULL;
> +
> +	if (!vid_handle) {
> +		IBM_ACPIHANDLE_INIT(vid);
> +	}
> +	if (!vid_handle)
> +		return 0;
> +
> +	/* Search for a _BCL method with 16 levels */
> +	status = acpi_walk_namespace(ACPI_TYPE_METHOD, vid_handle, 3,
> +					brightness_find_bcl, NULL, &found_node);
> +
> +	return (ACPI_SUCCESS(status) && found_node != NULL);
> +}
> +
>  static int __init brightness_init(struct ibm_init_struct *iibm)
>  {
>  	int b;
> @@ -3135,10 +3197,17 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
>  	if (brightness_mode > 3)
>  		return -EINVAL;
>  
> +	tp_features.bright_16levels =
> +			thinkpad_id.vendor == PCI_VENDOR_ID_LENOVO &&
> +			brightness_check_levels();
> +
>  	b = brightness_get(NULL);
>  	if (b < 0)
>  		return 1;
>  
> +	if (tp_features.bright_16levels)
> +		printk(IBM_INFO "detected a 16-level brightness capable ThinkPad\n");
> +
>  	ibm_backlight_device = backlight_device_register(
>  					TPACPI_BACKLIGHT_DEV_NAME, NULL, NULL,
>  					&ibm_backlight_data);
> @@ -3148,7 +3217,8 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
>  	}
>  	vdbg_printk(TPACPI_DBG_INIT, "brightness is supported\n");
>  
> -	ibm_backlight_device->props.max_brightness = 7;
> +	ibm_backlight_device->props.max_brightness =
> +				(tp_features.bright_16levels)? 15 : 7;
>  	ibm_backlight_device->props.brightness = b;
>  	backlight_update_status(ibm_backlight_device);
>  
> @@ -3184,13 +3254,14 @@ static int brightness_get(struct backlight_device *bd)
>  	if (brightness_mode & 1) {
>  		if (!acpi_ec_read(brightness_offset, &lec))
>  			return -EIO;
> -		lec &= 7;
> +		lec &= (tp_features.bright_16levels)? 0x0f : 0x07;
>  		level = lec;
>  	};
>  	if (brightness_mode & 2) {
>  		lcmos = (nvram_read_byte(TP_NVRAM_ADDR_BRIGHTNESS)
>  			 & TP_NVRAM_MASK_LEVEL_BRIGHTNESS)
>  			>> TP_NVRAM_POS_LEVEL_BRIGHTNESS;
> +		lcmos &= (tp_features.bright_16levels)? 0x0f : 0x07;
>  		level = lcmos;
>  	}
>  
> @@ -3211,7 +3282,7 @@ static int brightness_set(int value)
>  	int cmos_cmd, inc, i, res;
>  	int current_value;
>  
> -	if (value > 7)
> +	if (value > ((tp_features.bright_16levels)? 15 : 7))
>  		return -EINVAL;
>  
>  	res = mutex_lock_interruptible(&brightness_mutex);
> @@ -3227,7 +3298,7 @@ static int brightness_set(int value)
>  	cmos_cmd = value > current_value ?
>  			TP_CMOS_BRIGHTNESS_UP :
>  			TP_CMOS_BRIGHTNESS_DOWN;
> -	inc = value > current_value ? 1 : -1;
> +	inc = (value > current_value)? 1 : -1;
>  
>  	res = 0;
>  	for (i = current_value; i != value; i += inc) {
> @@ -3256,10 +3327,11 @@ static int brightness_read(char *p)
>  	if ((level = brightness_get(NULL)) < 0) {
>  		len += sprintf(p + len, "level:\t\tunreadable\n");
>  	} else {
> -		len += sprintf(p + len, "level:\t\t%d\n", level & 0x7);
> +		len += sprintf(p + len, "level:\t\t%d\n", level);
>  		len += sprintf(p + len, "commands:\tup, down\n");
>  		len += sprintf(p + len, "commands:\tlevel <level>"
> -			       " (<level> is 0-7)\n");
> +			       " (<level> is 0-%d)\n",
> +			       (tp_features.bright_16levels) ? 15 : 7);
>  	}
>  
>  	return len;
> @@ -3270,18 +3342,19 @@ static int brightness_write(char *buf)
>  	int level;
>  	int new_level;
>  	char *cmd;
> +	int max_level = (tp_features.bright_16levels) ? 15 : 7;
>  
>  	while ((cmd = next_cmd(&buf))) {
>  		if ((level = brightness_get(NULL)) < 0)
>  			return level;
> -		level &= 7;
>  
>  		if (strlencmp(cmd, "up") == 0) {
> -			new_level = level == 7 ? 7 : level + 1;
> +			new_level = level == (max_level)?
> +						max_level : level + 1;
>  		} else if (strlencmp(cmd, "down") == 0) {
> -			new_level = level == 0 ? 0 : level - 1;
> +			new_level = level == 0? 0 : level - 1;
>  		} else if (sscanf(cmd, "level %d", &new_level) == 1 &&
> -			   new_level >= 0 && new_level <= 7) {
> +			   new_level >= 0 && new_level <= max_level) {
>  			/* new_level set */
>  		} else
>  			return -EINVAL;
> diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
> index c5fdd68..de0f343 100644
> --- a/drivers/misc/thinkpad_acpi.h
> +++ b/drivers/misc/thinkpad_acpi.h
> @@ -84,7 +84,7 @@
>  
>  /* ThinkPad CMOS NVRAM constants */
>  #define TP_NVRAM_ADDR_BRIGHTNESS       0x5e
> -#define TP_NVRAM_MASK_LEVEL_BRIGHTNESS 0x07
> +#define TP_NVRAM_MASK_LEVEL_BRIGHTNESS 0x0f
>  #define TP_NVRAM_POS_LEVEL_BRIGHTNESS 0
>  
>  #define onoff(status,bit) ((status) & (1 << (bit)) ? "on" : "off")
> @@ -246,6 +246,7 @@ static struct {
>  	u32 hotkey_wlsw:1;
>  	u32 light:1;
>  	u32 light_status:1;
> +	u32 bright_16levels:1;
>  	u32 wan:1;
>  	u32 fan_ctrl_status_undef:1;
>  	u32 input_device_registered:1;


