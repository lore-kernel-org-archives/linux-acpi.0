From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: 4e231fa "ACPI video: ignore buggy _BQC" - causes regression for
 _BQC_use_index workaround?
Date: Mon, 14 Sep 2009 10:16:39 +0100
Message-ID: <4AAE09F7.90700@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:37244 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbZINJQj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Sep 2009 05:16:39 -0400
Received: by fxm17 with SMTP id 17so690942fxm.37
        for <linux-acpi@vger.kernel.org>; Mon, 14 Sep 2009 02:16:41 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Scott Howard <showard314@gmail.com>, Vladimir Serbinenko <phcoder@gmail.com>, Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

I'm looking at cleaning up the ACPI video driver, and found what looks
like a regression in 2.6.31.  This is all from code inspection; I don't
have the hardware.  I think it will not hurt users, but it should still
be looked at.

The new "ignore buggy _BQC" workaround appears to override the
_BQC_use_index workaround.  This means that on some systems the sysfs
"actual_brightness" attribute will return a cached value, where
previously it would query the hardware for an up-to-date value.

> @@ -618,8 +619,15 @@ acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
> 
> 			}
> 			*level += bqc_offset_aml_bug_workaround;
> -			device->brightness->curr = *level;
> -			return 0;
> +			for (i = 2; i < device->brightness->count; i++)
> +				if (device->brightness->levels[i] == *level) {
> +					device->brightness->curr = *level;
> +					return 0;
> +			}
> +			/* BQC returned an invalid level. Stop using it.  */
> +			ACPI_WARNING((AE_INFO, "%s returned an invalid level",
> +						buf));
> +			device->cap._BQC = device->cap._BCQ = 0;


I believe this change will break the detection of _BQC_use_index in
acpi_video_init_brightness():

    /*
     * Set the level to maximum and check if _BQC uses indexed value
     */
    result = acpi_video_device_lcd_set_level(device, max_level);
    if (result)
        goto out_free_levels;

    result = acpi_video_device_lcd_get_level_current(device, &level);
    if (result)
        goto out_free_levels;

    br->flags._BQC_use_index = (level == max_level ? 0 : 1);


If _BQC returns an index, then the value it returns won't be present in
_BCL.   The initial call to get_level_current() will consider the _BQC
value invalid and disable _BQC  - because we haven't had a chance to set
_BQC_use_index yet.

I think the _BQC_use_index detection needs a "raw" version of
get_level_current(), which omits the validity check.  Would you like a
patch?

Regards
Alan
