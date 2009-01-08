From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI: disable the ACPI backlight control on laptops
	with buggy _BCL methods
Date: Thu, 08 Jan 2009 11:11:17 +0800
Message-ID: <1231384277.20746.48.camel@rzhang-dt>
References: <1231383496.20746.44.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15748 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752147AbZAHDKD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Jan 2009 22:10:03 -0500
In-Reply-To: <1231383496.20746.44.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "trenn@suse.de" <trenn@suse.de>, apw@canonical.com

On Thu, 2009-01-08 at 10:58 +0800, Zhang, Rui wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> Subject: disable the ACPI backlight control on laptops with buggy _BCL methods
> 
> Some users used to control the backlight via the platform interface.
> But commit c3d6de698c84efdbdd3781b7058bcc339ab43da8 disables the platform
> backlight control if ACPI video backlight control is available.
> 
> This breaks the laptops with buggy _BCL/_BCM/_BQC methods. i.e. only ACPI
> backlight I/F are available on these laptops but they don't work.
> 
> With this patch applied, the ACPI backlight control are disabled instead
> on these laptops.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=12037
> http://bugzilla.kernel.org/show_bug.cgi?id=12235
> http://bugzilla.kernel.org/show_bug.cgi?id=12249
> http://bugzilla.kernel.org/show_bug.cgi?id=12302
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/311716
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/301524
> 
> CC: Thomas Renninger <trenn@suse.de>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
tested-by: Andy Whitcroft <apw@canonical.com>

> ---
>  drivers/acpi/video_detect.c |   83 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 77 insertions(+), 6 deletions(-)
> 
> Index: linux-2.6/drivers/acpi/video_detect.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/video_detect.c
> +++ linux-2.6/drivers/acpi/video_detect.c
> @@ -44,17 +44,88 @@ static long acpi_video_support;
>  static bool acpi_video_caps_checked;
>  
>  static acpi_status
> +acpi_backlight_validate_bcl(acpi_handle handle)
> +{
> +	union acpi_object *obj, *obj2;
> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +	int level_ac = 0, level_battery = 0;
> +	int i, count;
> +	int *levels;
> +	acpi_status status;
> +
> +
> +	status = acpi_evaluate_object(handle, "_BCL", NULL, &buffer);
> +	if (!ACPI_SUCCESS(status))
> +		return status;
> +	obj = (union acpi_object *)buffer.pointer;
> +	if (!obj || (obj->type != ACPI_TYPE_PACKAGE)) {
> +		printk(KERN_ERR PREFIX "Invalid _BCL data\n");
> +		status = AE_BAD_DATA;
> +		goto out;
> +	}
> +
> +	if (obj->package.count < 2) {
> +		status = AE_BAD_DATA;
> +		goto out;
> +	}
> +
> +        levels = kzalloc(obj->package.count * sizeof(*levels), GFP_KERNEL);
> +	if (!levels) {
> +		status = AE_NO_MEMORY;
> +		goto out;
> +	}
> +
> +	for (i = 0, count = 0; i < obj->package.count; i++) {
> +		obj2 = (union acpi_object *)&obj->package.elements[i];
> +		if (obj2->type != ACPI_TYPE_INTEGER) {
> +			printk(KERN_ERR PREFIX "Invalid data\n");
> +			continue;
> +		}
> +		levels[i] = (u32) obj2->integer.value;
> +		count ++;
> +        }
> +
> +        if (count < 2) {
> +		status = AE_BAD_DATA;
> +		goto out_free_levels;
> +	}
> +
> +	for (i = 2, level_ac = levels[0], level_battery = levels[1]; i < count; i ++) {
> +		if (levels[0] == levels[i])
> +			level_ac = 1;
> +		if (levels[1] == levels[i])
> +			level_battery = 1;
> +	}
> +
> +	if (!level_ac || !level_battery) {
> +		printk(KERN_ERR PREFIX "Invalid _BCL package\n");
> +		status = AE_BAD_DATA;
> +		goto out_free_levels;
> +	}
> +
> +        ACPI_DEBUG_PRINT((ACPI_DB_INFO, "found %d brightness levels\n", count));
> +
> +out_free_levels:
> +	kfree(levels);
> +out:
> +        kfree(obj);
> +        return status;
> +}
> +
> +static acpi_status
>  acpi_backlight_cap_match(acpi_handle handle, u32 level, void *context,
>  			  void **retyurn_value)
>  {
>  	long *cap = context;
> -	acpi_handle h_dummy;
> +	acpi_handle h_dummy1, h_dummy2;
>  
> -	if (ACPI_SUCCESS(acpi_get_handle(handle, "_BCM", &h_dummy)) &&
> -	    ACPI_SUCCESS(acpi_get_handle(handle, "_BCL", &h_dummy))) {
> -		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found generic backlight "
> -				  "support\n"));
> -		*cap |= ACPI_VIDEO_BACKLIGHT;
> +	if (ACPI_SUCCESS(acpi_get_handle(handle, "_BCM", &h_dummy1)) &&
> +	    ACPI_SUCCESS(acpi_get_handle(handle, "_BCL", &h_dummy2))) {
> +		if (ACPI_SUCCESS(acpi_backlight_validate_bcl(h_dummy2))) {
> +			ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found generic backlight "
> +					  "support\n"));
> +			*cap |= ACPI_VIDEO_BACKLIGHT;
> +		}
>  		/* We have backlight support, no need to scan further */
>  		return AE_CTRL_TERMINATE;
>  	}
> 
> email message attachment
> > -------- Forwarded Message --------
> > From: Zhang, Rui <rui.zhang@intel.com>
> > Subject: don't use buggy _BCL/_BCM/_BQC for backlight control
> > Date: Thu, 8 Jan 2009 10:56:50 +0800
> > 
> > Some users used to control the backlight via the platform interface.
> > But commit c3d6de698c84efdbdd3781b7058bcc339ab43da8 disables the platform
> > backlight control if ACPI video backlight control is available.
> > 
> > This breaks the laptops with buggy _BCL/_BCM/_BQC methods. i.e. only ACPI
> > backlight I/F are available on these laptops but they don't work.
> > 
> > With this patch applied, the ACPI backlight control are disabled instead
> > on these laptops.
> > 
> > http://bugzilla.kernel.org/show_bug.cgi?id=12037
> > http://bugzilla.kernel.org/show_bug.cgi?id=12235
> > http://bugzilla.kernel.org/show_bug.cgi?id=12249
> > http://bugzilla.kernel.org/show_bug.cgi?id=12302
> > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/311716
> > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/301524
> > 
> > CC: Thomas Renninger <trenn@suse.de>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/acpi/video_detect.c |   83 ++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 77 insertions(+), 6 deletions(-)
> > 
> > Index: linux-2.6/drivers/acpi/video_detect.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/acpi/video_detect.c
> > +++ linux-2.6/drivers/acpi/video_detect.c
> > @@ -44,17 +44,88 @@ static long acpi_video_support;
> >  static bool acpi_video_caps_checked;
> >  
> >  static acpi_status
> > +acpi_backlight_validate_bcl(acpi_handle handle)
> > +{
> > +	union acpi_object *obj, *obj2;
> > +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> > +	int level_ac = 0, level_battery = 0;
> > +	int i, count;
> > +	int *levels;
> > +	acpi_status status;
> > +
> > +
> > +	status = acpi_evaluate_object(handle, "_BCL", NULL, &buffer);
> > +	if (!ACPI_SUCCESS(status))
> > +		return status;
> > +	obj = (union acpi_object *)buffer.pointer;
> > +	if (!obj || (obj->type != ACPI_TYPE_PACKAGE)) {
> > +		printk(KERN_ERR PREFIX "Invalid _BCL data\n");
> > +		status = AE_BAD_DATA;
> > +		goto out;
> > +	}
> > +
> > +	if (obj->package.count < 2) {
> > +		status = AE_BAD_DATA;
> > +		goto out;
> > +	}
> > +
> > +        levels = kzalloc(obj->package.count * sizeof(*levels), GFP_KERNEL);
> > +	if (!levels) {
> > +		status = AE_NO_MEMORY;
> > +		goto out;
> > +	}
> > +
> > +	for (i = 0, count = 0; i < obj->package.count; i++) {
> > +		obj2 = (union acpi_object *)&obj->package.elements[i];
> > +		if (obj2->type != ACPI_TYPE_INTEGER) {
> > +			printk(KERN_ERR PREFIX "Invalid data\n");
> > +			continue;
> > +		}
> > +		levels[i] = (u32) obj2->integer.value;
> > +		count ++;
> > +        }
> > +
> > +        if (count < 2) {
> > +		status = AE_BAD_DATA;
> > +		goto out_free_levels;
> > +	}
> > +
> > +	for (i = 2, level_ac = levels[0], level_battery = levels[1]; i < count; i ++) {
> > +		if (levels[0] == levels[i])
> > +			level_ac = 1;
> > +		if (levels[1] == levels[i])
> > +			level_battery = 1;
> > +	}
> > +
> > +	if (!level_ac || !level_battery) {
> > +		printk(KERN_ERR PREFIX "Invalid _BCL package\n");
> > +		status = AE_BAD_DATA;
> > +		goto out_free_levels;
> > +	}
> > +
> > +        ACPI_DEBUG_PRINT((ACPI_DB_INFO, "found %d brightness levels\n", count));
> > +
> > +out_free_levels:
> > +	kfree(levels);
> > +out:
> > +        kfree(obj);
> > +        return status;
> > +}
> > +
> > +static acpi_status
> >  acpi_backlight_cap_match(acpi_handle handle, u32 level, void *context,
> >  			  void **retyurn_value)
> >  {
> >  	long *cap = context;
> > -	acpi_handle h_dummy;
> > +	acpi_handle h_dummy1, h_dummy2;
> >  
> > -	if (ACPI_SUCCESS(acpi_get_handle(handle, "_BCM", &h_dummy)) &&
> > -	    ACPI_SUCCESS(acpi_get_handle(handle, "_BCL", &h_dummy))) {
> > -		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found generic backlight "
> > -				  "support\n"));
> > -		*cap |= ACPI_VIDEO_BACKLIGHT;
> > +	if (ACPI_SUCCESS(acpi_get_handle(handle, "_BCM", &h_dummy1)) &&
> > +	    ACPI_SUCCESS(acpi_get_handle(handle, "_BCL", &h_dummy2))) {
> > +		if (ACPI_SUCCESS(acpi_backlight_validate_bcl(h_dummy2))) {
> > +			ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found generic backlight "
> > +					  "support\n"));
> > +			*cap |= ACPI_VIDEO_BACKLIGHT;
> > +		}
> >  		/* We have backlight support, no need to scan further */
> >  		return AE_CTRL_TERMINATE;
> >  	}

