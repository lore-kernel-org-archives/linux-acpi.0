From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [Intel-gfx] [PATCH 0/3] Kconfig dependencies: acpi-video, backlight and thermal
Date: Mon, 31 Jul 2017 14:28:58 +0300
Message-ID: <87tw1sj151.fsf@nikula.org>
References: <20170726135312.2214309-1-arnd@arndb.de> <20170726144041.plcrr6bg2hkh4q52@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19904 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751017AbdGaLYG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 31 Jul 2017 07:24:06 -0400
In-Reply-To: <20170726144041.plcrr6bg2hkh4q52@phenom.ffwll.local>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>
Cc: devel@driverdev.osuosl.org, Daniel Drake <dsd@laptop.org>, Jens Frederich <jfrederich@gmail.com>, nouveau@lists.freedesktop.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ben Skeggs <bskeggs@redhat.com>, Russell King <linux+etnaviv@armlinux.org.uk>, Daniel Vetter <daniel.vetter@intel.com>, Andy Shevchenko <andy@infradead.org>, intel-gfx@lists.freedesktop.org, Darren Hart <dvhart@infradead.org>, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>

On Wed, 26 Jul 2017, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Wed, Jul 26, 2017 at 03:53:09PM +0200, Arnd Bergmann wrote:
>> Hi everyone,
>> 
>> It took me a while to figure this out properly, as I kept getting
>> circular or missing dependencies with video drivers.
>> 
>> This set of three patches should simplify the situation a bit,
>> mostly by cleaning up the dependencies around CONFIG_ACPI_VIDEO.
>> With all three patches applied, I no longer run into those related
>> warnings. If everyone agrees on the general direction, I hope
>> we can merge all three through the DRM tree.
>> 
>> I originally had another larger patch in the series to replace all
>> of the 'select BACKLIGHT_LCD_SUPPORT; select BACKLIGHT_CLASS_DEVICE'
>> statements with 'depends on LCD_CLASS_DEVICE', that would clean
>> it up some more, but it is also a more invasive change that we
>> can do separately at some point.
>
> Looks reasonable, but I think it'd be good to get Jani Nikula's explicit
> ack on this, since he dugg around a lot in this area. And he's on vacation
> this week.

I didn't dig through all the details, but looks good to me and
definitely an improvement in drm Kconfigs.

Acked-by: Jani Nikula <jani.nikula@intel.com>



> -Daniel
>
>> 
>>        Arnd
>> 
>> Arnd Bergmann (3):
>>   backlight: always select BACKLIGHT_LCD_SUPPORT for
>>     BACKLIGHT_CLASS_DEVICE
>>   ACPI/DRM: rework ACPI_VIDEO Kconfig dependencies
>>   drm/etnaviv: add thermal dependency
>> 
>>  drivers/acpi/Kconfig              |  7 +++++--
>>  drivers/gpu/drm/etnaviv/Kconfig   |  1 +
>>  drivers/gpu/drm/gma500/Kconfig    |  5 +----
>>  drivers/gpu/drm/i915/Kconfig      |  7 +------
>>  drivers/gpu/drm/nouveau/Kconfig   | 10 ++--------
>>  drivers/platform/x86/Kconfig      |  9 ++++-----
>>  drivers/staging/olpc_dcon/Kconfig |  1 +
>>  7 files changed, 15 insertions(+), 25 deletions(-)
>> 
>> To: dri-devel@lists.freedesktop.org
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Len Brown <lenb@kernel.org>
>> Cc: Lucas Stach <l.stach@pengutronix.de>
>> Cc: Russell King <linux+etnaviv@armlinux.org.uk>
>> Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
>> Cc: David Airlie <airlied@linux.ie>
>> Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
>> Cc: Daniel Vetter <daniel.vetter@intel.com>
>> Cc: Jani Nikula <jani.nikula@linux.intel.com>
>> Cc: Ben Skeggs <bskeggs@redhat.com>
>> Cc: Darren Hart <dvhart@infradead.org>
>> Cc: Andy Shevchenko <andy@infradead.org>
>> Cc: Jens Frederich <jfrederich@gmail.com>
>> Cc: Daniel Drake <dsd@laptop.org>
>> Cc: Jon Nettleton <jon.nettleton@gmail.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: linux-acpi@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: etnaviv@lists.freedesktop.org
>> Cc: intel-gfx@lists.freedesktop.org
>> Cc: nouveau@lists.freedesktop.org
>> Cc: platform-driver-x86@vger.kernel.org
>> Cc: devel@driverdev.osuosl.org
>> 
>> -- 
>> 2.9.0
>> 
>> _______________________________________________
>> Intel-gfx mailing list
>> Intel-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Jani Nikula, Intel Open Source Technology Center
