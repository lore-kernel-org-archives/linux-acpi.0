From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 1/3] Introduce interface to report BIOS bugs
Date: Thu, 21 Aug 2008 09:19:07 -0600
Message-ID: <200808210919.07642.bjorn.helgaas@hp.com>
References: <1219251726-24746-1-git-send-email-trenn@suse.de> <200808201237.43338.bjorn.helgaas@hp.com> <200808211552.06054.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:23771 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760476AbYHUPTL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Aug 2008 11:19:11 -0400
In-Reply-To: <200808211552.06054.trenn@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-kernel@vger.kernel.org, ak@linux.intel.com, len.brown@intel.com, arjan@linux.intel.com, linux-acpi@vger.kernel.org, Christian Kornacker <ckornacker@suse.de>

On Thursday 21 August 2008 07:52:04 am Thomas Renninger wrote:
> On Wednesday 20 August 2008 20:37:42 Bjorn Helgaas wrote:

> > Maybe even something as simple as:
> >
> >     #define FW_BUG	"[FW bug]: "
> >
> > would be sufficient, with the idea that people could do this:
> >
> >     dev_err(&dev->dev, FW_BUG "interrupts left enabled\n");
> >
> > I think the user-space value derives from having a consistent string
> > to grep for, so this gives you that.  I'm not sure what value we get
> > from adding the new FW_PRINT_CRIT()/FW_PRINT_WARN() interfaces in the
> > kernel.
> 
> What about this one:
> pr_fw_err() or dev_fw_err() on harmful firmware bugs
> and
> pr_fw_info() on non-harmful but ugly BIOS constructs
> which should not exist, violate the spec or could make
> trouble in the future (maybe Firmware is really better...):
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index d24a47f..3204cea 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -538,6 +538,9 @@ extern const char *dev_driver_string(struct device *dev);
>  #define dev_info(dev, format, arg...)		\
>  	dev_printk(KERN_INFO , dev , format , ## arg)
>  
> +#define dev_fw_err(dev, format, arg...)		\
> +	dev_printk(KERN_ERR "[BIOS Bug] ", dev , format , ## arg)
> +
>  #ifdef DEBUG
>  #define dev_dbg(dev, format, arg...)		\
>  	dev_printk(KERN_DEBUG , dev , format , ## arg)
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 2651f80..b20f618 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -303,6 +303,12 @@ static inline char *pack_hex_byte(char *buf, u8 byte)
>  #define pr_info(fmt, arg...) \
>  	printk(KERN_INFO fmt, ##arg)
>  
> +#define pr_fw_err(fmt, arg...) \
> +	printk(KERN_ERR "[BIOS Bug]" fmt, ##arg)
> +
> +#define pr_fw_info(fmt, arg...) \
> +	printk(KERN_INFO "[BIOS]" fmt, ##arg)
> +
>  #ifdef DEBUG
>  /* If you are writing a driver, please use dev_dbg instead */
>  #define pr_debug(fmt, arg...) \

What value do we gain by defining dev_fw_err(), pr_fw_err(), and
pr_fw_info(), versus just defining FW_BUG?  If they're useful
for something, fine; it's just that I don't know yet what they add.

Bjorn
