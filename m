From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v5] ACPI: utils: Add new acpi_dev_present helper
Date: Tue, 11 Apr 2017 12:55:46 +0300
Message-ID: <20170411095546.GU2957@lahna.fi.intel.com>
References: <20170410185529.2994-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:49846 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751619AbdDKKAK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Apr 2017 06:00:10 -0400
Content-Disposition: inline
In-Reply-To: <20170410185529.2994-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org

On Mon, Apr 10, 2017 at 08:55:29PM +0200, Hans de Goede wrote:
> acpi_dev_found just iterates over all ACPI-ids and sees if one matches.
> This means that it will return true for devices which are in the dsdt
> but disabled (their _STA method returns 0).
> 
> For some drivers it is useful to be able to check if a certain HID
> is not only present in the namespace, but also actually present as in
> acpi_device_is_present() will return true for the device. For example
> because if a certain device is present then the driver will want to use
> an extcon or IIO adc channel provided by that device.
> 
> This commit adds a new acpi_dev_present helper which drivers can use
> to this end.
> 
> Like acpi_dev_found, acpi_dev_present take a HID as argument, but
> it also has 2 extra optional arguments to only check for an ACPI
> device with a specific UID and/or HRV value. This makes it more
> generic and allows it to replace custom code doing similar checks
> in several places.
> 
> Arguably acpi_dev_present is what acpi_dev_found should have been, but
> there are too many users to just change acpi_dev_found without the risk
> of breaking something.
> 
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
