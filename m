From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [Resend PATCH V3 7/8] usb/acpi: add the support of usb hub ports'
 acpi binding without attached devices.
Date: Sun, 13 May 2012 00:00:06 +0800
Message-ID: <4FAE8906.9050606@intel.com>
References: <1336723712-7686-1-git-send-email-tianyu.lan@intel.com> <1336723712-7686-8-git-send-email-tianyu.lan@intel.com> <20120512001548.GA31948@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:7594 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753552Ab2ELQAK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 May 2012 12:00:10 -0400
In-Reply-To: <20120512001548.GA31948@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: lenb@kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, mjg59@srcf.ucam.org, mfm@muteddisk.com

On 2012/5/12 8:15, Greg KH wrote:
> On Fri, May 11, 2012 at 04:08:31PM +0800, Lan Tianyu wrote:
>> The usb port is a device in the acpi table but it's not in the linux
>> usb subsystem. USB hub port doesn't have struct device. So the acpi
>> glue framework only can cover the usb port connected with usb device
>> and store the acpi handle to struct device.archdata.acpi_handle. This
>> patch adds the member platform_data in the struct usb_hub_port and
>> gets the hub port's acpi_handle and store it in the port's platform_data
>> to resolve no attached device no binding problem. The acpi method "_UPC"
>> and "_PLD" can be accessed without attached device.
> No, that's a hack.  Please do this correctly and use the real structures
> here, not an unsigned long.
>
> Why not make the hub a real struct device?  That would solve this
> problem, right?
You mean make the hub ports a real struct device. Yeah. But that may be
a little complex.  The device tree and sys fs hierarchy will be changed.
>   struct usb_hub_port {
>   	void			*port_owner;
>   	struct usb_device	*child;
> +	unsigned long		platform_data;
How about this?

struct usb_hub_port {
  	void			*port_owner;
  	struct usb_device	*child;
+	#ifdef CONFIG_ACPI
+	acpi_handle		port_acpi_handle;
+	#endif

> Yeah, no, that's not ok, sorry.  We use real pointers because we can,
> don't use opaque types here, where you are really putting a pointer in
> here.  Be specific.
>
> I'm not going to accept this patch, sorry.  Please rework it, and I'm
> guessing, the one after this.
All right.
> I'll go test the other patches in this series now...
Great thanks for your  patience to me(a freshman). :)
> greg k-h


-- 
Best Regards
Tianyu Lan
linux kernel enabling team

