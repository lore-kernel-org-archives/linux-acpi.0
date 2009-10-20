From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] acpi: thermal: [TRIVIAL] Add EOL to the
 trip_point_N_type strings
Date: Tue, 20 Oct 2009 14:16:52 +0800
Message-ID: <1256019412.3838.20.camel@rzhang-dt>
References: <1255686362-30022-1-git-send-email-amit.kucheria@canonical.com>
	 <37786d4b0910192311t7a9aad87i7adc62cf86bc29e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:64079 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424AbZJTGTy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Oct 2009 02:19:54 -0400
In-Reply-To: <37786d4b0910192311t7a9aad87i7adc62cf86bc29e2@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Amit Kucheria <amit.kucheria@canonical.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Acked-by: Zhang Rui <rui.zhang@intel.com>

thanks,
rui

On Tue, 2009-10-20 at 14:11 +0800, Amit Kucheria wrote:
> Rui,
> 
> This patch should perhaps have been cc'ed to you and the linux-acpi
> list as well.
> 
> Regards,
> Amit
> 
> ---------- Forwarded message ----------
> From:  <amit.kucheria@canonical.com>
> Date: Fri, Oct 16, 2009 at 12:46 PM
> Subject: [PATCH] acpi: thermal: [TRIVIAL] Add EOL to the
> trip_point_N_type strings
> To: List Linux Kernel <linux-kernel@vger.kernel.org>
> Cc: len.brown@intel.com, Amit Kucheria <amit.kucheria@canonical.com>
> 
> 
> From: Amit Kucheria <amit.kucheria@canonical.com>
> 
> Make the trip_point_N_type sysfs files return a string ending in EOL for
> consistency with other sysfs files.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@canonical.com>
> ---
>  drivers/thermal/thermal_sys.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index 4e83c29..6f8d8f9 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -180,15 +180,15 @@ trip_point_type_show(struct device *dev, struct
> device_attribute *attr,
> 
>        switch (type) {
>        case THERMAL_TRIP_CRITICAL:
> -               return sprintf(buf, "critical");
> +               return sprintf(buf, "critical\n");
>        case THERMAL_TRIP_HOT:
> -               return sprintf(buf, "hot");
> +               return sprintf(buf, "hot\n");
>        case THERMAL_TRIP_PASSIVE:
> -               return sprintf(buf, "passive");
> +               return sprintf(buf, "passive\n");
>        case THERMAL_TRIP_ACTIVE:
> -               return sprintf(buf, "active");
> +               return sprintf(buf, "active\n");
>        default:
> -               return sprintf(buf, "unknown");
> +               return sprintf(buf, "unknown\n");
>        }
>  }
> 
> --
> 1.6.3.3

