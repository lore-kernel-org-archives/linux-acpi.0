From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH 0/3] ACPI: Provide consistent PNPID match handling
Date: Tue, 26 Mar 2013 08:42:53 -0600
Message-ID: <1364308973.11659.100.camel@misato.fc.hp.com>
References: <1362432643-25636-1-git-send-email-toshi.kani@hp.com>
	 <13382693.0xFuY5WfEP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <13382693.0xFuY5WfEP@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, yinghai@kernel.org, jiang.liu@huawei.com, isimatu.yasuaki@jp.fujitsu.com
List-Id: linux-acpi@vger.kernel.org

On Tue, 2013-03-26 at 14:11 +0100, Rafael J. Wysocki wrote:
> On Monday, March 04, 2013 02:30:40 PM Toshi Kani wrote:
> > When installing/removing a notify handler to/from an ACPI device
> > object, ACPI core tries to match its associated scan handler to
> > see if it supports hotplug.  However, the matching logic of the
> > notify handler is different from the matching logic of attaching
> > a scan handler to an ACPI device object.  This inconsistency can
> > lead a mismatch and prevents ACPI scan handlers from supporting
> > non-HID devices, such as processor objects.
> > 
> > This patchset first updates PNPID setup interfaces to be independent
> > from acpi_device, and then updates the matching logic of the notify
> > handlers to be consistent with the attach handling.
> > 
> > This patchset is based on linux-pm.git/bleeding-edge.
> 
> All patches in the series applied to linux-pm.git/linux-next.

Great!  Thanks Rafael!
-Toshi


> 
> Thanks,
> Rafael
> 
> 
> > ---
> > Toshi Kani (3):
> >   ACPI: Remove acpi_device dependency in acpi_device_set_id()
> >   ACPI: Update PNPID set/free interfaces
> >   ACPI: Update PNPID match handling for notify
> > 
> > ---
> >  drivers/acpi/internal.h               |   2 +-
> >  drivers/acpi/power.c                  |   2 +-
> >  drivers/acpi/scan.c                   | 203 +++++++++++++++++++---------------
> >  drivers/acpi/video_detect.c           |  25 ++---
> >  drivers/gpu/drm/i915/intel_opregion.c |   4 +-
> >  include/acpi/acpi_bus.h               |  14 ++-
> >  include/linux/acpi.h                  |   4 +-
> >  7 files changed, 138 insertions(+), 116 deletions(-)
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
