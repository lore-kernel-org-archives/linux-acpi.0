From: Greg KH <greg@kroah.com>
Subject: Re: [RFC PATCH V2 1/2] introduce ALS sysfs class
Date: Thu, 6 Aug 2009 11:53:22 -0700
Message-ID: <20090806185322.GB28664@kroah.com>
References: <1249547498.2670.499.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756479AbZHFS54@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1249547498.2670.499.camel@rzhang-dt>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Matthew Garrett <mjg59@srcf.ucam.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 06, 2009 at 04:31:38PM +0800, Zhang Rui wrote:
> 
> Introduce ALS sysfs class device.
> 
> ALS sysfs class device provides a standard sysfs interface
> for Ambient Light Sensor devices.
> 
> Only two sysfs I/F are introduced currently.
> /sys/class/als/alsX/illuminance:
> 	indicates the amount of light incident upon a specified surface area.
> /sys/class/als/alsX/mappings:
> 	exports ambient light illuminance to display luminance mappings
> 	that can be used by an OS to calibrate its ambient light policy
> 	for a given sensor configuration.
> 	The OS can use this information to extrapolate an ALS response curve
> 	- noting that these values may be treated differently depending on the
> 	OS implementation but should be used in some form to calibrate ALS policy.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  Documentation/als/sysfs.txt |  138 ++++++++++++++++++++++

This needs to be in Documentation/ABI instead.

thanks,

greg k-h
