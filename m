From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH 0/3] Use acpi_video_unregister_backlight instead of
 acpi_video_unregister in platfrom backlight drivers
Date: Tue, 2 Jun 2015 22:28:08 +0800
Message-ID: <20150602142808.GA367@aaronlu.sh.intel.com>
References: <1433150708-8498-1-git-send-email-hdegoede@redhat.com>
 <87zj4ie8i9.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87zj4ie8i9.fsf@intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jun 02, 2015 at 12:59:10PM +0300, Jani Nikula wrote:
> On Mon, 01 Jun 2015, Hans de Goede <hdegoede@redhat.com> wrote:
> > Hi All,
> >
> > I'm working on cleaning up the currently somewhat convoluted logic to
> > select which backlight interfaces to register on x86 systems, see:
> > http://lists.freedesktop.org/archives/dri-devel/2014-December/074687.html
> >
> > For a rought outline (details will change in the actual patch-set).
> >
> > These 3 patches are a preparation for that work, as the behavior of the
> > current code is not always consistent (it changes depending on module
> > loading order in some cases). These 3 patches remove this inconsistency
> > which in some cases may result in a behavior change.
> >
> > This way the cleanup can have a consistent base to build upon, and I can
> > ensure that the cleanup itself does not cause any functional changes.
> 
> Thanks for doing this.
> 
> Slightly unrelated, but you'll end up calling:
> 
> acpi_video_unregister_backlight
> 	acpi_video_bus_unregister_backlight
> 		acpi_video_dev_unregister_backlight
> 			thermal_cooling_device_unregister
> 
> Uhm, err, what? What business does *that* have in the backlight
> unregister call chain?! Should that be untangled from the mess too?

I think it should be OK.
We currently will create a thermal cooling device for the ACPI backlight
device, its intention is that we can achieve some thermal purpose by
increasing or decreasing the backlight level(using the same set of
methods as the ACPI backlight one, though I'm not sure if it is being
used by anyone). When we are going to unregister the ACPI video
backlight interface, it most likely means that the interface doesn't
work so it doesn't make much sense to keep that thermal interface and
hence the thermal_cooling_device_unregister ends up being called here.

Regards,
Aaron

> 
> BR,
> Jani.
> 
> 
> >
> > I hope to post a v1 of the actual cleanup patch-set in 1-2 weeks.
> >
> > Regards,
> >
> > Hans
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > http://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Jani Nikula, Intel Open Source Technology Center
