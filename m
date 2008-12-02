From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/2] misc: Add dell-laptop driver
Date: Tue, 2 Dec 2008 20:05:45 +0000
Message-ID: <20081202200544.GA31620@srcf.ucam.org>
References: <20081127163357.GA22846@srcf.ucam.org> <20081127163444.GB22846@srcf.ucam.org> <20081202115029.2b9d1153.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:50675 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbYLBUF4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Dec 2008 15:05:56 -0500
Content-Disposition: inline
In-Reply-To: <20081202115029.2b9d1153.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Matt_Domsch@dell.com, greg@kroah.com, linux-acpi@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, Ivo van Doorn <ivdoorn@gmail.com>

On Tue, Dec 02, 2008 at 11:50:29AM -0800, Andrew Morton wrote:
> > +struct calling_interface_buffer {
> > +	u16 class;
> > +	u16 select;
> > +	volatile u32 input[4];
> > +	volatile u32 output[4];
> > +} __attribute__ ((packed));
> 
> We have that little __packed helper for this.

Ok. I've switched to that, although the __attribute__ notation seems to 
be the dominant form in the kernel right now.

> > +static struct dmi_system_id __initdata dell_device_table[] = {
> 
> this can be made const.

Done.

> > +	da_num_tokens += tokens;
> > +}
> 
> OK.  No locking is needed for updates to the global state?

The parse function is called once during module init, before the driver 
is registered. On the other hand, that makes me realise that we leak it 
if something else fails, so I've fixed that up as well.

> > +#ifdef CONFIG_ACPI
> > +	if (acpi_video_backlight_support())
> > +		return 0;
> > +#endif
> 
> Do we need the ifdefs here?  It looks like include/linux/acpi.h tries
> to provide a suitable 0-returning stub?

They're protected by #ifdef CONFIG_ACPI_VIDEO, but it looks like acpi.h 
is empty if CONFIG_ACPI isn't set?

> > +			dell_backlight_device = NULL;
> > +			ret = PTR_ERR(dell_backlight_device);
> 
> The above two statements are in the wrong order.

Good catch, thanks.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
