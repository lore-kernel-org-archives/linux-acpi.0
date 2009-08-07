From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] acpi: fix acpi_device_{install,remove}_notify_handler() for _HID-less devices
Date: Fri, 7 Aug 2009 15:09:17 +0200
Message-ID: <200908071509.17402.bzolnier@gmail.com>
References: <200908062141.52501.bzolnier@gmail.com> <1249606433.7301.23.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756177AbZHGNKO@vger.kernel.org>
In-Reply-To: <1249606433.7301.23.camel@minggr.sh.intel.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>, "Brown, Len" <len.brown@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org


Hi,

On Friday 07 August 2009 02:53:53 Lin Ming wrote:
> On Fri, 2009-08-07 at 03:41 +0800, Bartlomiej Zolnierkiewicz wrote:
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] acpi: fix acpi_device_{install,remove}_notify_handler() for _HID-less devices
> 
> Hi,
> 
> The patch in -mm tree titled
> "acpi-fix-null-bug-for-hid-uid-string-2.patch"
> has fixed this regression.
> Would you please give it a try?
> 
> The patch attached below.
> 
> Subject: acpi: fix NULL bug for HID/UID string
> From: Hugh Dickins <hugh.dickins@tiscali.co.uk>
> 
> acpi_device->pnp.hardware_id and unique_id are now allocated pointers,
> replacing the previous arrays.  acpi_device_install_notify_handler()
> oopsed on the NULL hid when probing the video device, and perhaps other
> uses are vulnerable too.  So initialize those pointers to empty strings
> when there is no hid or uid.  Also, free hardware_id and unique_id when
> when acpi_device is going to be freed.
> 
> Signed-off-by: Hugh Dickins <hugh.dickins@tiscali.co.uk>
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> Cc: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Hugh's patch also fixes the problem and I like it more than mine version
(BTW mmotm still contains older acpi-fix-null-bug-for-hid-uid-string.patch
not acpi-fix-null-bug-for-hid-uid-string-2.patch).

Andrew, could mmotm be somehow integrated with -next (the above bug was
fixed in mmotm two weeks ago already)?  If you're worried about affecting
-next's quality, worry not, it really can't be much worse than it is now
(at least we would have all outstanding patches really in the one place)..

Thanks,
Bart
