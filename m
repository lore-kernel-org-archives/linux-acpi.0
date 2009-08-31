From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH V5 1/2] introduce ALS sysfs class
Date: Mon, 31 Aug 2009 10:34:49 +0200
Message-ID: <20090831083449.GB11117@elf.ucw.cz>
References: <1251706028.3483.160.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60057 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488AbZHaIe4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Aug 2009 04:34:56 -0400
Content-Disposition: inline
In-Reply-To: <1251706028.3483.160.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>

Hi!

> @@ -0,0 +1,32 @@
> +What:		/sys/class/als/als[0-N]/desc
> +Date:		Aug. 2009
> +KernelVersion:	2.6.32
> +Contact:	Zhang Rui <rui.zhang@intel.com>
> +Description:	Strings which descibes the current Ambient Light Sensor
> +		device. This is given by native ALS driver as part of
> +		registration. e.g: "acpi_als" for ACPI ALS devices.
> +		RO

Normal way to do that (backlight class does it, for example) is to
have acpi_als instead of als0, and get rid of desc field.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
