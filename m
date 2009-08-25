From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH V4 1/2] introduce ALS sysfs class
Date: Tue, 25 Aug 2009 10:45:01 +0200
Message-ID: <20090825084501.GL29763@elf.ucw.cz>
References: <1251184693.3483.95.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40276 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbZHYIpI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Aug 2009 04:45:08 -0400
Content-Disposition: inline
In-Reply-To: <1251184693.3483.95.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Greg KH <greg@kroah.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Tue 2009-08-25 15:18:13, Zhang Rui wrote:
> 
> ???Introduce ALS sysfs class.
> 
> ALS sysfs class provides a standard sysfs interface for
> Ambient Light Sensor devices.
> 
> please read Documentation/ABI/testing/sysfs-class-als for
> detailed sysfs designs.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

ACK.

> +What:		/sys/class/als/als[0-N]/display_adjustment
> +Date:		Aug. 2009
> +KernelVersion:	2.6.32
> +Contact:	Zhang Rui <rui.zhang@intel.com>
> +Description:	a relative percentages in order simplify the means
> +		by which these adjustments are applied in lieu of
> +		changes to the user???s display brightness preference.
> +		A value of 100% is used to indicate no display
> +		brightness adjustment.
> +		Values less than 100% indicate a negative adjustment
> +		(dimming); values greater than 100% indicate a positive
> +		adjustment (brightening).
> +		RO

And yes, I like the new interface much better.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
