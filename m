From: Greg KH <greg@kroah.com>
Subject: Re: [RFC PATCH V2 1/2] introduce ALS sysfs class
Date: Thu, 6 Aug 2009 11:56:02 -0700
Message-ID: <20090806185602.GC28664@kroah.com>
References: <1249547498.2670.499.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756509AbZHFS6R@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1249547498.2670.499.camel@rzhang-dt>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Matthew Garrett <mjg59@srcf.ucam.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 06, 2009 at 04:31:38PM +0800, Zhang Rui wrote:
> +#define PREFIX "ALS: "

This is not used.

> +	/* sys I/F */
> +	result = device_create_file(&als->device, &dev_attr_illuminance);
> +	if (result)
> +		goto unregister_device;
> +
> +	result = device_create_file(&als->device, &dev_attr_desc);
> +	if (result)
> +		goto unregister_device;

These should be default attributes for the device, that way they get
created before userspace is told the device is there, removing any race
conditions you will have otherwise.

> +
> +	return als;
> +
> +unregister_device:
> +	device_unregister(&als->device);
> +	return ERR_PTR(result);

And you weren't cleaning up the file if the second one failed.

thanks,

greg k-h
