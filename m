From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH V6 1/2] introduce ALS sysfs class
Date: Tue, 1 Sep 2009 10:11:15 +0200
Message-ID: <20090901081114.GA9942@elf.ucw.cz>
References: <1251789947.3483.215.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59868 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbZIAILU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Sep 2009 04:11:20 -0400
Content-Disposition: inline
In-Reply-To: <1251789947.3483.215.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>

Hi!

> Introduce ALS sysfs class.
> 
> ALS sysfs class provides a standard sysfs interface for
> Ambient Light Sensor devices.
> 
> please read Documentation/ABI/testing/sysfs-class-als for
> detailed sysfs designs.

Thanks for fixing the interface!

> +static ssize_t
> +illuminance_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct als_device *als = to_als_device(dev);
> +	int illuminance;
> +	int result;
> +
> +	result = als->ops->get_illuminance(als, &illuminance);
> +	if (result)
> +		return result;
> +
> +	if (!illuminance)
> +		return sprintf(buf, "Illuminance below the supported range\n");
> +	else if (illuminance == -1)
> +		return sprintf(buf, "Illuminance above the supported range\n");
> +	else if (illuminance < -1)
> +		return -ERANGE;
> +	else
> +		return sprintf(buf, "%d\n", illuminance);
> +}

that's nor particulary clean. One value per file and all that. Could
we simply return errnos in _all_ the error cases? (Docs would suggest
this contains integer so string is definitely unexpected).


> +static ssize_t
> +adjustment_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct als_device *als = to_als_device(dev);
> +	int illuminance, adjustment;
> +	int result;
> +
> +	result = als->ops->get_illuminance(als, &illuminance);
> +	if (result)
> +		return result;
> +
> +	if (illuminance < 0 && illuminance != -1)
> +		return sprintf(buf, "Current illuminance invalid\n");
> +
> +	result = als_get_adjustment(als, illuminance, &adjustment);
> +	if (result)
> +		return result;
> +
> +	return sprintf(buf, "%d%%\n", adjustment);
> +}

You should not return strings... and in this case it is not clear how
the code works. You fill the buf, but then return...? Better stick to
integers.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
