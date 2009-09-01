From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH V6 1/2] introduce ALS sysfs class
Date: Tue, 01 Sep 2009 16:30:44 +0800
Message-ID: <1251793844.3483.228.camel@rzhang-dt>
References: <1251789947.3483.215.camel@rzhang-dt>
	 <20090901081114.GA9942@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:43192 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676AbZIAIc4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Sep 2009 04:32:56 -0400
In-Reply-To: <20090901081114.GA9942@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>

On Tue, 2009-09-01 at 16:11 +0800, Pavel Machek wrote:
> Hi!
> 
> > Introduce ALS sysfs class.
> > 
> > ALS sysfs class provides a standard sysfs interface for
> > Ambient Light Sensor devices.
> > 
> > please read Documentation/ABI/testing/sysfs-class-als for
> > detailed sysfs designs.
> 
> Thanks for fixing the interface!
> 
> > +static ssize_t
> > +illuminance_show(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +	struct als_device *als = to_als_device(dev);
> > +	int illuminance;
> > +	int result;
> > +
> > +	result = als->ops->get_illuminance(als, &illuminance);
> > +	if (result)
> > +		return result;
> > +
> > +	if (!illuminance)
> > +		return sprintf(buf, "Illuminance below the supported range\n");
> > +	else if (illuminance == -1)
> > +		return sprintf(buf, "Illuminance above the supported range\n");
> > +	else if (illuminance < -1)
> > +		return -ERANGE;
> > +	else
> > +		return sprintf(buf, "%d\n", illuminance);
> > +}
> 
> that's nor particulary clean. One value per file and all that. Could
> we simply return errnos in _all_ the error cases? (Docs would suggest
> this contains integer so string is definitely unexpected).
> 
IMO, 0 and -1 are not errors. they just suggest that the Ambient Light
illuminance is beyond the device support range, while the device is
still working normally.
what about exporting these values (0 and -1) to user space directly?

> 
> > +static ssize_t
> > +adjustment_show(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +	struct als_device *als = to_als_device(dev);
> > +	int illuminance, adjustment;
> > +	int result;
> > +
> > +	result = als->ops->get_illuminance(als, &illuminance);
> > +	if (result)
> > +		return result;
> > +
> > +	if (illuminance < 0 && illuminance != -1)
> > +		return sprintf(buf, "Current illuminance invalid\n");
> > +
> > +	result = als_get_adjustment(als, illuminance, &adjustment);
> > +	if (result)
> > +		return result;
> > +
> > +	return sprintf(buf, "%d%%\n", adjustment);
> > +}
> 
> You should not return strings... and in this case it is not clear how
> the code works. You fill the buf, but then return...? 

As the adjustment is a percentage value, I added a '%' postfix so that
users won't be confused.
yes, it's okay to just export the integer, e.g. "100" instead of "100%".

thanks,
rui

