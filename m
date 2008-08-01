From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 02/11] Check for ACPI backlight support otherwise use
	vendor ACPI drivers
Date: Fri, 01 Aug 2008 09:27:36 +0800
Message-ID: <1217554056.2969.149.camel@rzhang-dt>
References: <1216205553-8486-1-git-send-email-trenn@suse.de>
	 <1216205553-8486-3-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32589 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753337AbYHAB3x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Jul 2008 21:29:53 -0400
In-Reply-To: <1216205553-8486-3-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: ak@linux.intel.com, mjg59@srcf.ucam.org, jwoithe@physics.adelaide.edu.au, hmh@hmh.eng.br, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it

On Wed, 2008-07-16 at 18:52 +0800, Thomas Renninger wrote:

> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 5b049cd..fb8e2df 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -931,36 +931,6 @@ static void acpi_device_get_busid(struct
> acpi_device *device,
>         }
>  }
> 
> -static int
> -acpi_video_bus_match(struct acpi_device *device)
> -{
> -       acpi_handle h_dummy;
> -
> -       if (!device)
> -               return -EINVAL;
> -
> -       /* Since there is no HID, CID for ACPI Video drivers, we have
> -        * to check well known required nodes for each feature we
> support.
> -        */
This comment is wrong.
CID for ACPI video bus device is LNXVIDEO.

thanks,
rui

