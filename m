From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] acpi: video: enhance the quirk detect logic of _BQC
Date: Mon, 22 Apr 2013 14:19:02 +0200
Message-ID: <5871154.Sa0zIVPm1q@vostro.rjw.lan>
References: <5160D237.50307@intel.com> <1366210490.2091.47.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:40616 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753010Ab3DVMLB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Apr 2013 08:11:01 -0400
In-Reply-To: <1366210490.2091.47.camel@rzhang1-mobl4>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Aaron Lu <aaron.lu@intel.com>, Artem Savkov <artem.savkov@gmail.com>, Cheppes <cheppes@mailinator.com>, Luis Medinas <lmedinas@gmail.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On Wednesday, April 17, 2013 10:54:50 PM Zhang Rui wrote:
> On Sun, 2013-04-07 at 09:56 +0800, Aaron Lu wrote:
> > Currently we decide if the _BQC is using index by first setting the
> > level to maximum, and then check if _BQC returned maximum; if not, we
> > say it is using index.
> > 
> > This is not true for some buggy systems, where the _BQC method will
> > always return a constant value(e.g. 0 or 100 for the two broken system)
> > and thus break the current logic. So this patch tries to enhance the
> > quirk detect logic for _BQC: we do this by picking a test_level, it can
> > be the maximum level or the mininum one based on some condition. And we
> > don't make the assumption that if _BQC returned a value that is not what
> > we just set, it must be using an index. Instead, we will compare the
> > value returned from _BQC and if it doesn't match, see if the returned
> > value is an index. And if still no, clear the capability of _BQC.
> > 
> > Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=42861
> > Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=56011
> > Reported-and-tested-by: Artem Savkov <artem.savkov@gmail.com>
> > Reported-by: Luis Medinas <lmedinas@gmail.com>
> > Reported-by: Cheppes <cheppes@mailinator.com>
> > Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> 
> Acked-by: Zhang Rui <rui.zhang@intel.com>

Applied.

Thanks,
Rafael


> > ---
> > Thanks Cheppes <cheppes@mailinator.com> for the suggestion of choosing
> > different levels to test, and also for the help of in code comment
> > correction.
> > 
> >  drivers/acpi/video.c | 67 ++++++++++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 57 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> > index 3cdd047..306ea2a 100644
> > --- a/drivers/acpi/video.c
> > +++ b/drivers/acpi/video.c
> > @@ -632,6 +632,56 @@ acpi_video_cmp_level(const void *a, const void *b)
> >  }
> >  
> >  /*
> > + * Decides if _BQC/_BCQ for this system is usable
> > + *
> > + * We do this by changing the level first and then read out the current
> > + * brightness level, if the value does not match, find out if it is using
> > + * index. If not, clear the _BQC/_BCQ capability.
> > + */
> > +static int acpi_video_bqc_quirk(struct acpi_video_device *device,
> > +				int max_level, int current_level)
> > +{
> > +	struct acpi_video_device_brightness *br = device->brightness;
> > +	int result;
> > +	unsigned long long level;
> > +	int test_level;
> > +
> > +	/* don't mess with existing known broken systems */
> > +	if (bqc_offset_aml_bug_workaround)
> > +		return 0;
> > +
> > +	/*
> > +	 * Some systems always report current brightness level as maximum
> > +	 * through _BQC, we need to test another value for them.
> > +	 */
> > +	test_level = current_level == max_level ? br->levels[2] : max_level;
> > +
> > +	result = acpi_video_device_lcd_set_level(device, test_level);
> > +	if (result)
> > +		return result;
> > +
> > +	result = acpi_video_device_lcd_get_level_current(device, &level, true);
> > +	if (result)
> > +		return result;
> > +
> > +	if (level != test_level) {
> > +		/* buggy _BQC found, need to find out if it uses index */
> > +		if (level < br->count) {
> > +			if (br->flags._BCL_reversed)
> > +				level = br->count - 3 - level;
> > +			if (br->levels[level + 2] == test_level)
> > +				br->flags._BQC_use_index = 1;
> > +		}
> > +
> > +		if (!br->flags._BQC_use_index)
> > +			device->cap._BQC = device->cap._BCQ = 0;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +
> > +/*
> >   *  Arg:	
> >   *  	device	: video output device (LCD, CRT, ..)
> >   *
> > @@ -742,18 +792,15 @@ acpi_video_init_brightness(struct acpi_video_device *device)
> >  	if (result)
> >  		goto out_free_levels;
> >  
> > -	/*
> > -	 * Set the level to maximum and check if _BQC uses indexed value
> > -	 */
> > -	result = acpi_video_device_lcd_set_level(device, max_level);
> > -	if (result)
> > -		goto out_free_levels;
> > -
> > -	result = acpi_video_device_lcd_get_level_current(device, &level, true);
> > +	result = acpi_video_bqc_quirk(device, max_level, level_old);
> >  	if (result)
> >  		goto out_free_levels;
> > -
> > -	br->flags._BQC_use_index = (level == max_level ? 0 : 1);
> > +	/*
> > +	 * cap._BQC may get cleared due to _BQC is found to be broken
> > +	 * in acpi_video_bqc_quirk, so check again here.
> > +	 */
> > +	if (!device->cap._BQC)
> > +		goto set_level;
> >  
> >  	if (use_bios_initial_backlight) {
> >  		level = acpi_video_bqc_value_to_level(device, level_old);
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
