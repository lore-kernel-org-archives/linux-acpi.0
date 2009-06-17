From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [PATCH]: ACPI: Add the reference count to avoid unloading ACPI
	video bus twice
Date: Wed, 17 Jun 2009 11:09:48 +0800
Message-ID: <1245208188.3583.181.camel@localhost.localdomain>
References: <1245122593.3583.117.camel@localhost.localdomain>
	 <20090616145058.GA18154@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:58501 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932538AbZFQDIe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jun 2009 23:08:34 -0400
In-Reply-To: <20090616145058.GA18154@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2009-06-16 at 22:50 +0800, Alex Chiang wrote:
> Hi Yakui,
> 
> * yakui_zhao <yakui.zhao@intel.com>:
> > From: Zhao Yakui <yakui.zhao@intel.com>
> > 
> > Sometimes both acpi video and i915 driver are compiled as modules.
> > And there exists the strict dependency between the two drivers.
> > The acpi video bus will be unloaded in course of unloading the i915 driver.
> > If we unload the acpi video driver, then the kernel oops will be triggered.
> > 
> > Add the reference count to avoid unloading the ACPI video bus twice.
> > The reference count should be checked before unregistering the acpi video bus.
> > If the reference count is already zero, it won't unregister it again.
> > And after the acpi video bus is already unregistered, the reference count
> > will be set to zero.
> 
> Your implementation below isn't really a reference count, so I
> don't think you should call it that in your changelog.
It is only a register count, which indicates whether the acpi video bus
is registered or not.
And it is not a the reference count for module.

Thanks.
> 
> Since you are talking about refcounts, have you tried using
> try_module_get()? 
> 
> Thanks.
> 
> /ac
> 
> > 
> > http://bugzilla.kernel.org/show_bug.cgi?id=13396
> > 
> > Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> > ---
> >  drivers/acpi/video.c                 |   41 +++++++++++++++++++++++++++++------
> >  drivers/gpu/drm/i915/i915_opregion.c |    2 -
> >  include/acpi/video.h                 |    4 +--
> >  3 files changed, 38 insertions(+), 9 deletions(-)
> > 
> > Index: linux-2.6/drivers/acpi/video.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/acpi/video.c	2009-06-16 10:25:12.000000000 +0800
> > +++ linux-2.6/drivers/acpi/video.c	2009-06-16 11:09:57.000000000 +0800
> > @@ -76,6 +76,7 @@
> >  static int brightness_switch_enabled = 1;
> >  module_param(brightness_switch_enabled, bool, 0644);
> >  
> > +static int register_count = 0;
> >  static int acpi_video_bus_add(struct acpi_device *device);
> >  static int acpi_video_bus_remove(struct acpi_device *device, int type);
> >  static int acpi_video_resume(struct acpi_device *device);
> > @@ -2318,6 +2319,13 @@
> >  int acpi_video_register(void)
> >  {
> >  	int result = 0;
> > +	if (register_count) {
> > +		/*
> > +		 * if the function of acpi_video_register is already called,
> > +		 * don't register the acpi_vide_bus again and return no error.
> > +		 */
> > +		return 0;
> > +	}
> >  
> >  	acpi_video_dir = proc_mkdir(ACPI_VIDEO_CLASS, acpi_root_dir);
> >  	if (!acpi_video_dir)
> > @@ -2329,10 +2337,35 @@
> >  		return -ENODEV;
> >  	}
> >  
> > +	/*
> > +	 * When the acpi_video_bus is loaded successfully, increase
> > +	 * the counter reference.
> > +	 */
> > +	register_count = 1;
> > +
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL(acpi_video_register);
> >  
> > +void acpi_video_unregister(void)
> > +{
> > +	if (!register_count) {
> > +		/*
> > +		 * If the acpi video bus is already unloaded, don't
> > +		 * unload it again and return directly.
> > +		 */
> > +		return;
> > +	}
> > +	acpi_bus_unregister_driver(&acpi_video_bus);
> > +
> > +	remove_proc_entry(ACPI_VIDEO_CLASS, acpi_root_dir);
> > +
> > +	register_count = 0;
> > +
> > +	return;
> > +}
> > +EXPORT_SYMBOL(acpi_video_unregister);
> > +
> >  /*
> >   * This is kind of nasty. Hardware using Intel chipsets may require
> >   * the video opregion code to be run first in order to initialise
> > @@ -2350,16 +2383,12 @@
> >  	return acpi_video_register();
> >  }
> >  
> > -void acpi_video_exit(void)
> > +static void __exit acpi_video_exit(void)
> >  {
> > -
> > -	acpi_bus_unregister_driver(&acpi_video_bus);
> > -
> > -	remove_proc_entry(ACPI_VIDEO_CLASS, acpi_root_dir);
> > +	acpi_video_unregister();
> >  
> >  	return;
> >  }
> > -EXPORT_SYMBOL(acpi_video_exit);
> >  
> >  module_init(acpi_video_init);
> >  module_exit(acpi_video_exit);
> > Index: linux-2.6/drivers/gpu/drm/i915/i915_opregion.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/gpu/drm/i915/i915_opregion.c	2009-06-16 10:25:12.000000000 +0800
> > +++ linux-2.6/drivers/gpu/drm/i915/i915_opregion.c	2009-06-16 10:29:50.000000000 +0800
> > @@ -419,7 +419,7 @@
> >  		return;
> >  
> >  	if (!suspend)
> > -		acpi_video_exit();
> > +		acpi_video_unregister();
> >  
> >  	opregion->acpi->drdy = 0;
> >  
> > Index: linux-2.6/include/acpi/video.h
> > ===================================================================
> > --- linux-2.6.orig/include/acpi/video.h	2009-06-16 10:25:12.000000000 +0800
> > +++ linux-2.6/include/acpi/video.h	2009-06-16 11:07:43.000000000 +0800
> > @@ -3,10 +3,10 @@
> >  
> >  #if (defined CONFIG_ACPI_VIDEO || defined CONFIG_ACPI_VIDEO_MODULE)
> >  extern int acpi_video_register(void);
> > -extern int acpi_video_exit(void);
> > +extern void acpi_video_unregister(void);
> >  #else
> >  static inline int acpi_video_register(void) { return 0; }
> > -static inline void acpi_video_exit(void) { return; }
> > +static inline void acpi_video_unregister(void) { return; }
> >  #endif
> >  
> >  #endif
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

