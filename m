From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] misc: Add dell-laptop driver
Date: Tue, 2 Dec 2008 12:22:22 -0800
Message-ID: <20081202122222.5873ee86.akpm@linux-foundation.org>
References: <20081127163357.GA22846@srcf.ucam.org>
	<20081127163444.GB22846@srcf.ucam.org>
	<20081202115029.2b9d1153.akpm@linux-foundation.org>
	<20081202200544.GA31620@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45258 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751632AbYLBUW7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Dec 2008 15:22:59 -0500
In-Reply-To: <20081202200544.GA31620@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, Matt_Domsch@dell.com, greg@kroah.com, linux-acpi@vger.kernel.org, rpurdie@rpsys.net, ivdoorn@gmail.com

On Tue, 2 Dec 2008 20:05:45 +0000
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> > > +#ifdef CONFIG_ACPI
> > > +	if (acpi_video_backlight_support())
> > > +		return 0;
> > > +#endif
> > 
> > Do we need the ifdefs here?  It looks like include/linux/acpi.h tries
> > to provide a suitable 0-returning stub?
> 
> They're protected by #ifdef CONFIG_ACPI_VIDEO, but it looks like acpi.h 
> is empty if CONFIG_ACPI isn't set?

No, acpi.h has a _few_ ACPI=n stubs:

: static inline int early_acpi_boot_init(void)
: {
: 	return 0;
: }
: static inline int acpi_boot_init(void)
: {
: 	return 0;
: }
: 
: static inline int acpi_boot_table_init(void)
: {
: 	return 0;
: }
: 
: static inline int acpi_mps_check(void)
: {
: 	return 0;
: }
: 
: static inline int acpi_check_resource_conflict(struct resource *res)
: {
: 	return 0;
: }
: 
: static inline int acpi_check_region(resource_size_t start, resource_size_t n,
: 				    const char *name)
: {
: 	return 0;
: }
: 
: static inline int acpi_check_mem_region(resource_size_t start,
: 					resource_size_t n, const char *name)
: {
: 	return 0;
: }

So it seems that acpi_video_backlight_support() should be added to this
list.  Except it already has a stub, in the wrong place.  This whole block:

: #if defined(CONFIG_ACPI_VIDEO) || defined(CONFIG_ACPI_VIDEO_MODULE)
: 
: extern long acpi_video_get_capabilities(acpi_handle graphics_dev_handle);
: extern long acpi_is_video_device(struct acpi_device *device);
: extern int acpi_video_backlight_support(void);
: extern int acpi_video_display_switch_support(void);
: 
: #else
: 
: static inline long acpi_video_get_capabilities(acpi_handle graphics_dev_handle)
: {
: 	return 0;
: }
: 
: static inline long acpi_is_video_device(struct acpi_device *device)
: {
: 	return 0;
: }
: 
: static inline int acpi_video_backlight_support(void)
: {
: 	return 0;
: }
: 
: static inline int acpi_video_display_switch_support(void)
: {
: 	return 0;
: }
: 
: #endif /* defined(CONFIG_ACPI_VIDEO) || defined(CONFIG_ACPI_VIDEO_MODULE) */
: 

needs to be moved outside the `#ifdef CONFIG_ACPI' altogether.  Then you
can drop the ifdef.
