From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 4/4] sony-laptop: enumerate rfkill devices using SN06
Date: Wed, 16 Dec 2009 22:30:04 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912162221030.10371@localhost.localdomain>
References: <1260976116-6369-1-git-send-email-malattia@linux.it>
 <1260976116-6369-2-git-send-email-malattia@linux.it>
 <1260976116-6369-3-git-send-email-malattia@linux.it>
 <1260976116-6369-4-git-send-email-malattia@linux.it>
 <1260976116-6369-5-git-send-email-malattia@linux.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_F8FOevH29+KH0+c848n2QQ)"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:58541 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933084AbZLQDaR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 22:30:17 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUS00ALG1Q5VAT4@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 21:30:06 -0600 (CST)
In-reply-to: <1260976116-6369-5-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_F8FOevH29+KH0+c848n2QQ)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

Mattia,
The mystery is (partially) solved.

This one wouldn't merge b/c in my mailbox it has a copy of the
1st patch appended to it.  I don't know how that happened,
maybe the the formail processing I use to delete
duplicates in my mailbox got confused, as the message
does not have this issue in the list archives.

Anyway, with that repaired, this 4th patch joins
the previous 3 in the acpi-test tree.

thanks,
Len Brown, Intel Open Source Technology Center

On Thu, 17 Dec 2009, Mattia Dongili wrote:

> SN06 makes sure we get back a longer buffer which seems to be necessary
> going forward as the SNC devices describes more and more devices (or
> features more precisely). Moreover SN06 should be called with only the
> descriptor offset to make sure we hit the rfkill controlling function
> (F124 or F135) with a 0 argument to get a full list of features.
> 
> Signed-off-by: Mattia Dongili <malattia@linux.it>
> Tested-by: Miguel Rodríguez Pérez <miguelrp@gmail.com>
> ---
>  drivers/platform/x86/sony-laptop.c |   76 +++++++++++++++++++++++++++---------
>  1 files changed, 57 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
> index cc7d30d..178faa2 100644
> --- a/drivers/platform/x86/sony-laptop.c
> +++ b/drivers/platform/x86/sony-laptop.c
> @@ -1161,35 +1161,73 @@ static void sony_nc_rfkill_update()
>  	}
>  }
>  
> -static int sony_nc_rfkill_setup(struct acpi_device *device)
> +static void sony_nc_rfkill_setup(struct acpi_device *device)
>  {
> -	int result, ret;
> +	int offset;
> +	u8 dev_code, i;
> +	acpi_status status;
> +	struct acpi_object_list params;
> +	union acpi_object in_obj;
> +	union acpi_object *device_enum;
> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>  
> -	if (sony_find_snc_handle(0x124) == -1) {
> -		if (sony_find_snc_handle(0x135) == -1)
> -			return -1;
> +	offset = sony_find_snc_handle(0x124);
> +	if (offset == -1) {
> +		offset = sony_find_snc_handle(0x135);
> +		if (offset == -1)
> +			return;
>  		else
>  			sony_rfkill_handle = 0x135;
>  	} else
>  		sony_rfkill_handle = 0x124;
> +	dprintk("Found rkfill handle: 0x%.4x\n", sony_rfkill_handle);
>  
> -	ret = sony_call_snc_handle(sony_rfkill_handle, 0xb00, &result);
> -	if (ret) {
> -		printk(KERN_INFO DRV_PFX
> -		       "Unable to enumerate rfkill devices: %x\n", ret);
> -		return ret;
> +	/* need to read the whole buffer returned by the acpi call to SN06
> +	 * here otherwise we may miss some features
> +	 */
> +	params.count = 1;
> +	params.pointer = &in_obj;
> +	in_obj.type = ACPI_TYPE_INTEGER;
> +	in_obj.integer.value = offset;
> +	status = acpi_evaluate_object(sony_nc_acpi_handle, "SN06", &params,
> +			&buffer);
> +	if (ACPI_FAILURE(status)) {
> +		dprintk("Radio device enumeration failed\n");
> +		return;
>  	}
>  
> -	if (result & 0x1)
> -		sony_nc_setup_rfkill(device, SONY_WIFI);
> -	if (result & 0x2)
> -		sony_nc_setup_rfkill(device, SONY_BLUETOOTH);
> -	if (result & 0x1c)
> -		sony_nc_setup_rfkill(device, SONY_WWAN);
> -	if (result & 0x20)
> -		sony_nc_setup_rfkill(device, SONY_WIMAX);
> +	device_enum = (union acpi_object *) buffer.pointer;
> +	if (!device_enum || device_enum->type != ACPI_TYPE_BUFFER) {
> +		printk(KERN_ERR "Invalid SN06 return object 0x%.2x\n",
> +				device_enum->type);
> +		goto out_no_enum;
> +	}
>  
> -	return 0;
> +	/* the buffer is filled with magic numbers describing the devices
> +	 * available, 0xff terminates the enumeration
> +	 */
> +	while ((dev_code = *(device_enum->buffer.pointer + i)) != 0xff &&
> +			i < device_enum->buffer.length) {
> +		i++;
> +		dprintk("Radio devices, looking at 0x%.2x\n", dev_code);
> +
> +		if (dev_code == 0 && !sony_rfkill_devices[SONY_WIFI])
> +			sony_nc_setup_rfkill(device, SONY_WIFI);
> +
> +		if (dev_code == 0x10 && !sony_rfkill_devices[SONY_BLUETOOTH])
> +			sony_nc_setup_rfkill(device, SONY_BLUETOOTH);
> +
> +		if ((0xf0 & dev_code) == 0x20 &&
> +				!sony_rfkill_devices[SONY_WWAN])
> +			sony_nc_setup_rfkill(device, SONY_WWAN);
> +
> +		if (dev_code == 0x30 && !sony_rfkill_devices[SONY_WIMAX])
> +			sony_nc_setup_rfkill(device, SONY_WIMAX);
> +	}
> +
> +out_no_enum:
> +	kfree(buffer.pointer);
> +	return;
>  }
>  
>  static int sony_nc_add(struct acpi_device *device)
> -- 
> 1.6.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

unexpected content begins here.

> 
> Cc: "Matthew W. S. Bell" <matthew@bells23.org.uk>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Mattia Dongili <malattia@linux.it>
> 
> ---
>  drivers/platform/x86/sony-laptop.c |    4 ++++
>  include/linux/sonypi.h             |    1 +
>  2 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
> index a2a742c..9710f70 100644
> --- a/drivers/platform/x86/sony-laptop.c
> +++ b/drivers/platform/x86/sony-laptop.c
> @@ -232,6 +232,7 @@ static int sony_laptop_input_index[] = {
>  	56,	/* 69 SONYPI_EVENT_VOLUME_INC_PRESSED */
>  	57,	/* 70 SONYPI_EVENT_VOLUME_DEC_PRESSED */
>  	-1,	/* 71 SONYPI_EVENT_BRIGHTNESS_PRESSED */
> +	58,	/* 72 SONYPI_EVENT_MEDIA_PRESSED */
>  };
>  
>  static int sony_laptop_input_keycode_map[] = {
> @@ -293,6 +294,7 @@ static int sony_laptop_input_keycode_map[] = {
>  	KEY_F15,	/* 55 SONYPI_EVENT_SETTINGKEY_PRESSED */
>  	KEY_VOLUMEUP,	/* 56 SONYPI_EVENT_VOLUME_INC_PRESSED */
>  	KEY_VOLUMEDOWN,	/* 57 SONYPI_EVENT_VOLUME_DEC_PRESSED */
> +	KEY_MEDIA,	/* 58 SONYPI_EVENT_MEDIA_PRESSED */
>  };
>  
>  /* release buttons after a short delay if pressed */
> @@ -890,6 +892,8 @@ static struct sony_nc_event sony_100_events[] = {
>  	{ 0x0C, SONYPI_EVENT_FNKEY_RELEASED },
>  	{ 0x9f, SONYPI_EVENT_CD_EJECT_PRESSED },
>  	{ 0x1f, SONYPI_EVENT_ANYBUTTON_RELEASED },
> +	{ 0xa1, SONYPI_EVENT_MEDIA_PRESSED },
> +	{ 0x21, SONYPI_EVENT_ANYBUTTON_RELEASED },
>  	{ 0, 0 },
>  };
>  
> diff --git a/include/linux/sonypi.h b/include/linux/sonypi.h
> index 34c4475..4f95c1a 100644
> --- a/include/linux/sonypi.h
> +++ b/include/linux/sonypi.h
> @@ -111,6 +111,7 @@
>  #define SONYPI_EVENT_VOLUME_INC_PRESSED		69
>  #define SONYPI_EVENT_VOLUME_DEC_PRESSED		70
>  #define SONYPI_EVENT_BRIGHTNESS_PRESSED		71
> +#define SONYPI_EVENT_MEDIA_PRESSED		72
>  
>  /* get/set brightness */
>  #define SONYPI_IOCGBRT		_IOR('v', 0, __u8)
> -- 
> 1.6.5.4
> 

--Boundary_(ID_F8FOevH29+KH0+c848n2QQ)--
