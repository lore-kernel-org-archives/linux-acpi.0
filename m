From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Subject: Re: [PATCH 2.6.26-rc] ACPI Thermal Zone driver breaks lm-sensors 2 userspace
Date: Mon, 23 Jun 2008 13:06:57 -0400
Message-ID: <20080623170657.GK7306@mars.solarsys.private>
References: <485FBBE6.9000104@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760047AbYFWRLu@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <485FBBE6.9000104@keyaccess.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Hans de Goede <j.w.r.degoede@hhs.nl>, Zhang Rui <rui.zhang@intel.com>, Jean Delvare <khali@linux-fr.org>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Linus, Rene, et al:

* Rene Herman <rene.herman@keyaccess.nl> [2008-06-23 17:06:14 +0200]:
> drivers/thermal/thermal_sys.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index 6098787..c21e03c 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -357,7 +357,7 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
> 
> 	INIT_LIST_HEAD(&hwmon->tz_list);
> 	strlcpy(hwmon->type, tz->type, THERMAL_NAME_LENGTH);
> -	hwmon->device = hwmon_device_register(NULL);
> +	hwmon->device = hwmon_device_register(&tz->device);
> 	if (IS_ERR(hwmon->device)) {
> 		result = PTR_ERR(hwmon->device);
> 		goto free_mem;

NACK.

1) The bug is in libsensors (2.10), not the kernel.

- but more importantly -

2) This patch is broken.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
