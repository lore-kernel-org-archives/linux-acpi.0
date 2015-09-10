From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: New Surface 3 (atom x7) having problems with ACPI regions
Date: Thu, 10 Sep 2015 11:46:50 +0800
Message-ID: <55F0FD2A.7050900@intel.com>
References: <CAN+gG=FMjShOWf6LXwDd5Fps-ME4cDCtN2h6bTZRvOifhAMRtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:46607 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752692AbbIJDpK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Sep 2015 23:45:10 -0400
In-Reply-To: <CAN+gG=FMjShOWf6LXwDd5Fps-ME4cDCtN2h6bTZRvOifhAMRtQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bastien Nocera <hadess@hadess.net>

On 09/09/2015 09:51 PM, Benjamin Tissoires wrote:
> Hey,
> 
> Bastien (CC-ed) has troubles having the touchscreen of the new Surface
> 3 (atom based) showing up.
> He raised a kernel bugzilla [1] and the dmesg shows:
> ACPI Error: Region GeneralPurposeIo (ID=8) has no handler (20150619/exfldio-297)
> 
> Which seems to interrupt the parsing of the DSDT.
> 
> I am not sure about the status of ACPI regions in the latest acpi tree
> so I prefer asking here. Does this error actually prevents the
> touchscreen to be loaded by i2c-hid or is there something else
> preventing the enumeration?

There is GPIO operation region handler support in the kernel and
according to the dsdt table provided in bugzilla, Surface 3 is using
cherryview GPIO controller(_HID INT33FF) that is supported by the
pinctrl-cherryview driver. The problem here is, the device node NTRG is
accessing some GPIO operation region field in its _STA control method
and since _STA for ACPI device node is called very early, before any of
the GPIO drivers(where the GPIO operation region handler is installed)
are probed, the error message appeared.

I'm not so sure of the below part:
"
The failure of executing the _STA control method will cause the device
node not having the acpi_device structure created and then in the SPI
ACPI enumerate function acpi_spi_add_device, it will not be created and
used.
"

I guess we need to handle _STA for the _DEP case someway.

Regards,
Aaron

> Cheers,
> Benjamin
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=104291
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

