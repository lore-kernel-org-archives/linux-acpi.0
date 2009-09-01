From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V6 1/2] introduce ALS sysfs class
Date: Tue, 1 Sep 2009 20:47:00 +0200
Message-ID: <200909012047.00606.rjw@sisk.pl>
References: <1251789947.3483.215.camel@rzhang-dt> <1251793844.3483.228.camel@rzhang-dt> <20090901084306.GD9942@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:58260 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985AbZIASp7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Sep 2009 14:45:59 -0400
In-Reply-To: <20090901084306.GD9942@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>

On Tuesday 01 September 2009, Pavel Machek wrote:
> On Tue 2009-09-01 16:30:44, Zhang Rui wrote:
> > On Tue, 2009-09-01 at 16:11 +0800, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > Introduce ALS sysfs class.
> > > > 
> > > > ALS sysfs class provides a standard sysfs interface for
> > > > Ambient Light Sensor devices.
> > > > 
> > > > please read Documentation/ABI/testing/sysfs-class-als for
> > > > detailed sysfs designs.
> > > 
> > > Thanks for fixing the interface!
> > > 
> > > > +static ssize_t
> > > > +illuminance_show(struct device *dev, struct device_attribute *attr, char *buf)
> > > > +{
> > > > +	struct als_device *als = to_als_device(dev);
> > > > +	int illuminance;
> > > > +	int result;
> > > > +
> > > > +	result = als->ops->get_illuminance(als, &illuminance);
> > > > +	if (result)
> > > > +		return result;
> > > > +
> > > > +	if (!illuminance)
> > > > +		return sprintf(buf, "Illuminance below the supported range\n");
> > > > +	else if (illuminance == -1)
> > > > +		return sprintf(buf, "Illuminance above the supported range\n");
> > > > +	else if (illuminance < -1)
> > > > +		return -ERANGE;
> > > > +	else
> > > > +		return sprintf(buf, "%d\n", illuminance);
> > > > +}
> > > 
> > > that's nor particulary clean. One value per file and all that. Could
> > > we simply return errnos in _all_ the error cases? (Docs would suggest
> > > this contains integer so string is definitely unexpected).
> > > 
> > IMO, 0 and -1 are not errors. they just suggest that the Ambient Light
> > illuminance is beyond the device support range, while the device is
> > still working normally.
> > what about exporting these values (0 and -1) to user space directly?
> 
> Returning 0 for "below" range and 99999999 for "above" range would be
> nice, yes. 

Why not 0 and "all ones" or 0 and -1.

Is there anything wrong with -1 in particular?

Best,
Rafael
