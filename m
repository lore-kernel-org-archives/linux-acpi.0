From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [Resend PATCH V3 7/8] usb/acpi: add the support of usb hub
 ports' acpi binding without attached devices.
Date: Sat, 12 May 2012 09:26:29 -0700
Message-ID: <20120512162629.GB6264@kroah.com>
References: <1336723712-7686-1-git-send-email-tianyu.lan@intel.com>
 <1336723712-7686-8-git-send-email-tianyu.lan@intel.com>
 <20120512001548.GA31948@kroah.com>
 <4FAE8906.9050606@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53232 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579Ab2ELQ0f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 May 2012 12:26:35 -0400
Received: by dady13 with SMTP id y13so4272525dad.19
        for <linux-acpi@vger.kernel.org>; Sat, 12 May 2012 09:26:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FAE8906.9050606@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, mjg59@srcf.ucam.org, mfm@muteddisk.com

On Sun, May 13, 2012 at 12:00:06AM +0800, Lan Tianyu wrote:
> On 2012/5/12 8:15, Greg KH wrote:
> >On Fri, May 11, 2012 at 04:08:31PM +0800, Lan Tianyu wrote:
> >>The usb port is a device in the acpi table but it's not in the linux
> >>usb subsystem. USB hub port doesn't have struct device. So the acpi
> >>glue framework only can cover the usb port connected with usb device
> >>and store the acpi handle to struct device.archdata.acpi_handle. This
> >>patch adds the member platform_data in the struct usb_hub_port and
> >>gets the hub port's acpi_handle and store it in the port's platform_data
> >>to resolve no attached device no binding problem. The acpi method "_UPC"
> >>and "_PLD" can be accessed without attached device.
> >No, that's a hack.  Please do this correctly and use the real structures
> >here, not an unsigned long.
> >
> >Why not make the hub a real struct device?  That would solve this
> >problem, right?
> You mean make the hub ports a real struct device. Yeah. But that may be
> a little complex.  The device tree and sys fs hierarchy will be changed.

heiarchy's can always be changed, nothing should rely on a specific
location in a tree as things can move around, right?  But be careful
about udev, it might have some "what is the parent" rules about usb
devices that think that usb devices are always in a tree.

Actually, a USB hub is a device, why not just put the port information
on them, as sub devices.  You don't have to hang the children USB
devices off of those port devices, unless you test to find that
everything works properly.  That would not change any hiearchy in sysfs
at all, right?

> >  struct usb_hub_port {
> >  	void			*port_owner;
> >  	struct usb_device	*child;
> >+	unsigned long		platform_data;
> How about this?
> 
> struct usb_hub_port {
>  	void			*port_owner;
>  	struct usb_device	*child;
> +	#ifdef CONFIG_ACPI
> +	acpi_handle		port_acpi_handle;
> +	#endif

Ok, that's better, don't you agree?  It shows exactly what you are
trying to do here, and should ensure type safety.

greg k-h
