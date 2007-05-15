From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: Remove possible recursion from thermal driver
Date: Tue, 15 May 2007 16:26:02 -0400
Message-ID: <200705151626.02687.lenb@kernel.org>
References: <8f8ff01d0705142254r97c8dd9h8aa82eb67e44ae5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45341 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754550AbXEOU1d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 May 2007 16:27:33 -0400
In-Reply-To: <8f8ff01d0705142254r97c8dd9h8aa82eb67e44ae5f@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>


> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -1106,7 +1106,6 @@ static void acpi_thermal_notify(acpi_handle handle, u32 event, void *data)
> 		break;
> 	case ACPI_THERMAL_NOTIFY_THRESHOLDS:
> 		acpi_thermal_get_trip_points(tz);
>-		acpi_thermal_check(tz);
> 		acpi_bus_generate_event(device, event, 0);
> 		break;
> 	case ACPI_THERMAL_NOTIFY_DEVICES:

I don't think we can do this.
When the thresholds change, there must be a check to compare the temperature
with the thresholds -- otherwise what good was it to change the thresholds?

-Len
