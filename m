From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI : Dummy acpi_video_register should return error code
Date: Mon, 04 Jul 2016 15:01:18 +0200
Message-ID: <13496771.R4ZFavZ3pc@vostro.rjw.lan>
References: <1466621761-7283-1-git-send-email-arvind.yadav.cs@gmail.com> <3183729.cNSdjc2YjN@vostro.rjw.lan> <aad366c0-7531-6820-f378-84020ceb45fc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60247 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753555AbcGDM4p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jul 2016 08:56:45 -0400
In-Reply-To: <aad366c0-7531-6820-f378-84020ceb45fc@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: robert.moore@intel.com, lv.zheng@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org

On Thursday, June 23, 2016 09:35:01 AM Aaron Lu wrote:
> On 06/23/2016 05:05 AM, Rafael J. Wysocki wrote:
> > On Thursday, June 23, 2016 12:26:01 AM Arvind Yadav wrote:
> >> The inline acpi_video_register stub simply allows compilation on systems
> >> with CONFIG_ACPI_VIDEO disabled. the dummy acpi_video_register does not
> >> register an acpi_bus_driver at all. The inline acpi_video_register should
> >> return to indicate lack of support when attempting to register an
> >> acpi_bus_driver on such a system with CONFIG_ACPI_VIDEO disabled.
> >>
> >> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> >> ---
> >>  include/acpi/video.h | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/include/acpi/video.h b/include/acpi/video.h
> >> index 5731ccb..4536bd3 100644
> >> --- a/include/acpi/video.h
> >> +++ b/include/acpi/video.h
> >> @@ -54,7 +54,7 @@ extern int acpi_video_get_levels(struct acpi_device *device,
> >>  				 struct acpi_video_device_brightness **dev_br,
> >>  				 int *pmax_level);
> >>  #else
> >> -static inline int acpi_video_register(void) { return 0; }
> >> +static inline int acpi_video_register(void) { return -ENODEV; }
> >>  static inline void acpi_video_unregister(void) { return; }
> >>  static inline int acpi_video_get_edid(struct acpi_device *device, int type,
> >>  				      int device_id, void **edid)
> > 
> > Aaron, what do you think?
>  
> The only place that cares about the return value of acpi_video_register
> is in acpi_video_init where CONFIG_ACPI_VIDEO must be defined, all other
> places do not care about the return value so this change shouldn't cause
> any problems and returning -ENODEV sounds more reasonable than 0 here.
> 
> Reviewed-by: Aaron Lu <aaron.lu@intel.com>

Patch applied, thanks!

