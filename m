From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: New Surface 3 (atom x7) having problems with ACPI regions
Date: Thu, 10 Sep 2015 15:35:56 +0800
Message-ID: <20150910073556.GA6863@aaronlu.sh.intel.com>
References: <CAN+gG=FMjShOWf6LXwDd5Fps-ME4cDCtN2h6bTZRvOifhAMRtQ@mail.gmail.com>
 <55F0FD2A.7050900@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:61907 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751462AbbIJHeN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Sep 2015 03:34:13 -0400
Content-Disposition: inline
In-Reply-To: <55F0FD2A.7050900@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bastien Nocera <hadess@hadess.net>, Yu Chen <yu.c.chen@intel.com>

On Thu, Sep 10, 2015 at 11:46:50AM +0800, Aaron Lu wrote:
> I'm not so sure of the below part:
> "
> The failure of executing the _STA control method will cause the device
> node not having the acpi_device structure created and then in the SPI
> ACPI enumerate function acpi_spi_add_device, it will not be created and
> used.
> "

With the above said, I wonder if the following patch which ignores the
error return of the _STA and set status to 0 makes any difference?


diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index ec256352f423..418c8a7cec91 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2293,7 +2293,7 @@ static int acpi_bus_type_and_status(acpi_handle handle, int *type,
 		*type = ACPI_BUS_TYPE_DEVICE;
 		status = acpi_bus_get_status_handle(handle, sta);
 		if (ACPI_FAILURE(status))
-			return -ENODEV;
+			*sta = 0;
 		break;
 	case ACPI_TYPE_PROCESSOR:
 		*type = ACPI_BUS_TYPE_PROCESSOR;
