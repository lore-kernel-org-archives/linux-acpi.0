From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH 0/3] Use acpi_video_unregister_backlight instead of acpi_video_unregister in platfrom backlight drivers
Date: Tue, 02 Jun 2015 12:59:10 +0300
Message-ID: <87zj4ie8i9.fsf@intel.com>
References: <1433150708-8498-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:35043 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756165AbbFBJ44 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Jun 2015 05:56:56 -0400
In-Reply-To: <1433150708-8498-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>
Cc: Aaron Lu <aaron.lu@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>

On Mon, 01 Jun 2015, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi All,
>
> I'm working on cleaning up the currently somewhat convoluted logic to
> select which backlight interfaces to register on x86 systems, see:
> http://lists.freedesktop.org/archives/dri-devel/2014-December/074687.html
>
> For a rought outline (details will change in the actual patch-set).
>
> These 3 patches are a preparation for that work, as the behavior of the
> current code is not always consistent (it changes depending on module
> loading order in some cases). These 3 patches remove this inconsistency
> which in some cases may result in a behavior change.
>
> This way the cleanup can have a consistent base to build upon, and I can
> ensure that the cleanup itself does not cause any functional changes.

Thanks for doing this.

Slightly unrelated, but you'll end up calling:

acpi_video_unregister_backlight
	acpi_video_bus_unregister_backlight
		acpi_video_dev_unregister_backlight
			thermal_cooling_device_unregister

Uhm, err, what? What business does *that* have in the backlight
unregister call chain?! Should that be untangled from the mess too?

BR,
Jani.


>
> I hope to post a v1 of the actual cleanup patch-set in 1-2 weeks.
>
> Regards,
>
> Hans
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Jani Nikula, Intel Open Source Technology Center
