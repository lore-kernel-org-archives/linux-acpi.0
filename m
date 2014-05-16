From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH 2/4] acpi-video: Add an acpi_video_unregister_backlight
 function
Date: Fri, 16 May 2014 10:26:25 +0800
Message-ID: <53757751.8090808@intel.com>
References: <1400152956-9053-1-git-send-email-hdegoede@redhat.com> <1400152956-9053-3-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:39357 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752316AbaEPC03 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 May 2014 22:26:29 -0400
In-Reply-To: <1400152956-9053-3-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Lee Chun-Yi <jlee@suse.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Matthew Garrett <matthew.garrett@nebula.com>, Massimiliano <massi.ergosum@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org

On 05/15/2014 07:22 PM, Hans de Goede wrote:
> Add an acpi_video_unregister_backlight function, which only unregisters
> the backlight device, and leaves the acpi_notifier in place. Some acpi_vendor
> driver need this as they don't want the acpi_video# backlight device, but do
> need the acpi-video driver for hotkey handling.
> 
> Chances are that this new acpi_video_unregister_backlight() is actually
> what existing acpi_vendor drivers have wanted all along. Currently acpi_vendor
> drivers which want to disable the acpi_video# backlight device, make 2 calls:
> 
> acpi_video_dmi_promote_vendor();
> acpi_video_unregister();
> 
> The intention here is to make things independent of when acpi_video_register()
> gets called. As acpi_video_register() will get called on acpi-video load time
> on non intel gfx machines, while it gets called on i915 load time on intel
> gfx machines.
> 
> This leads to the following 2 interesting scenarios:
> 
> a) intel gfx:
> 1) acpi-video module gets loaded (as it is a dependency of acpi_vendor and i915)
> 2) acpi-video does NOT call acpi_video_register()
> 3) acpi_vendor loads (lets assume it loads before i915), calls
> acpi_video_dmi_promote_vendor(); which sets ACPI_VIDEO_BACKLIGHT_DMI_VENDOR
> 4) calls acpi_video_unregister -> not registered, nop
> 5) i915 loads, calls acpi_video_register
> 6) acpi_video_register registers the acpi_notifier for the hotkeys,
>    does NOT register a backlight device because of ACPI_VIDEO_BACKLIGHT_DMI_VENDOR
> 
> b) non intel gfx
> 1) acpi-video module gets loaded (as it is a dependency acpi_vendor)
> 2) acpi-video calls acpi_video_register()
> 3) acpi_video_register registers the acpi_notifier for the hotkeys,
>    and a backlight device
> 4) acpi_vendor loads, calls acpi_video_dmi_promote_vendor()
> 5) calls acpi_video_unregister, this unregisters BOTH the acpi_notifier for
>    the hotkeys AND the backlight device
> 
> So here we have possibly the same acpi_vendor module, making the same calls,
> but with different results, in one cases acpi-video does handle hotkeys,
> in the other it does not.
> 
> Note that the a) scenario turns into b) if we assume the i915 module loads
> before the vendor_acpi module, so we also have different behavior depending
> on module loading order!
> 
> So as said I believe that quite a few existing acpi_vendor modules really
> always want the behavior of a), hence this patch adds a new
> acpi_video_unregister_backlight() which gives the behavior of a) independent
> of module loading order.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Aaron Lu <aaron.lu@intel.com>
