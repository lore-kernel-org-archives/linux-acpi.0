From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH V6 1/2] introduce ALS sysfs class
Date: Tue, 1 Sep 2009 10:43:06 +0200
Message-ID: <20090901084306.GD9942@elf.ucw.cz>
References: <1251789947.3483.215.camel@rzhang-dt> <20090901081114.GA9942@elf.ucw.cz> <1251793844.3483.228.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753323AbZIAInR@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1251793844.3483.228.camel@rzhang-dt>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>
List-Id: linux-acpi@vger.kernel.org

On Tue 2009-09-01 16:30:44, Zhang Rui wrote:
> On Tue, 2009-09-01 at 16:11 +0800, Pavel Machek wrote:
> > Hi!
> > 
> > > Introduce ALS sysfs class.
> > > 
> > > ALS sysfs class provides a standard sysfs interface for
> > > Ambient Light Sensor devices.
> > > 
> > > please read Documentation/ABI/testing/sysfs-class-als for
> > > detailed sysfs designs.
> > 
> > Thanks for fixing the interface!
> > 
> > > +static ssize_t
> > > +illuminance_show(struct device *dev, struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct als_device *als = to_als_device(dev);
> > > +	int illuminance;
> > > +	int result;
> > > +
> > > +	result = als->ops->get_illuminance(als, &illuminance);
> > > +	if (result)
> > > +		return result;
> > > +
> > > +	if (!illuminance)
> > > +		return sprintf(buf, "Illuminance below the supported range\n");
> > > +	else if (illuminance == -1)
> > > +		return sprintf(buf, "Illuminance above the supported range\n");
> > > +	else if (illuminance < -1)
> > > +		return -ERANGE;
> > > +	else
> > > +		return sprintf(buf, "%d\n", illuminance);
> > > +}
> > 
> > that's nor particulary clean. One value per file and all that. Could
> > we simply return errnos in _all_ the error cases? (Docs would suggest
> > this contains integer so string is definitely unexpected).
> > 
> IMO, 0 and -1 are not errors. they just suggest that the Ambient Light
> illuminance is beyond the device support range, while the device is
> still working normally.
> what about exporting these values (0 and -1) to user space directly?

Returning 0 for "below" range and 99999999 for "above" range would be
nice, yes. 

> > 
> > > +static ssize_t
> > > +adjustment_show(struct device *dev, struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct als_device *als = to_als_device(dev);
> > > +	int illuminance, adjustment;
> > > +	int result;
> > > +
> > > +	result = als->ops->get_illuminance(als, &illuminance);
> > > +	if (result)
> > > +		return result;
> > > +
> > > +	if (illuminance < 0 && illuminance != -1)
> > > +		return sprintf(buf, "Current illuminance invalid\n");
> > > +
> > > +	result = als_get_adjustment(als, illuminance, &adjustment);
> > > +	if (result)
> > > +		return result;
> > > +
> > > +	return sprintf(buf, "%d%%\n", adjustment);
> > > +}
> > 
> > You should not return strings... and in this case it is not clear how
> > the code works. You fill the buf, but then return...? 
> 
> As the adjustment is a percentage value, I added a '%' postfix so that
> users won't be confused.
> yes, it's okay to just export the integer, e.g. "100" instead of "100%".

The "%" postfix is okay, but returning "Current illuminance invalid"
is ugly. Better return -EINVAL or -EIO or something.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
