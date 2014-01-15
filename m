From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH V2] ACPI/Battery: Add a _BIX quirk for NEC LZ750/LS
Date: Wed, 15 Jan 2014 14:47:21 +0000
Message-ID: <20140115144720.GA23218@srcf.ucam.org>
References: <1389019837-13619-1-git-send-email-tianyu.lan@intel.com>
 <5255063.SeYbBZqxVQ@vostro.rjw.lan>
 <20140114212406.GA25438@srcf.ucam.org>
 <4100200.O09E65sAKi@vostro.rjw.lan>
 <52D69E57.5020208@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49470 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbaAOOrc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jan 2014 09:47:32 -0500
Content-Disposition: inline
In-Reply-To: <52D69E57.5020208@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, fcr@adinet.com.uy, l@dorileo.org, "Zheng, Lv" <lv.zheng@intel.com>, robert.moore@intel.com

On Wed, Jan 15, 2014 at 10:42:31PM +0800, Lan Tianyu wrote:
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index fbf1ace..e98fa83 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -770,7 +770,7 @@ static int acpi_battery_add(struct acpi_device *device)
>         device->driver_data = battery;
>         mutex_init(&battery->lock);
>         mutex_init(&battery->sysfs_lock);
> -       if (acpi_has_method(battery->device->handle, "_BIX"))
> +       if (acpi_evaluate_object(device->handle, "_BIX", NULL, &buffer);)
>                 set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);

Doesn't acpi_evaluate_object() return 0 on success? I think:

if (ACPI_SUCESS(acpi_evaluate_object(device->handle, "_BIX", NULL, 
&buffer))

But maybe we should check for existence first and give an FW_BUG message 
to indicate an invalid _BIX?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
