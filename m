From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [Update][PATCH 3/3] ACPI / platform: Initialize ACPI handles of
 platform devices in advance
Date: Tue, 20 Nov 2012 10:08:29 -0800
Message-ID: <20121120180829.GB12328@kroah.com>
References: <1352977397-2280-1-git-send-email-mika.westerberg@linux.intel.com>
 <1758879.PKgPhTGcB7@vostro.rjw.lan>
 <4036218.zBRlg5OZsZ@vostro.rjw.lan>
 <1481164.jTUTJPBIOQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1481164.jTUTJPBIOQ@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Jean Delvare <khali@linux-fr.org>, ben-linux@fluff.org, w.sang@pengutronix.de, linux-kernel@vger.kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, mathias.nyman@linux.intel.com, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 20, 2012 at 02:01:01AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The current platform device creation and registration code in
> acpi_create_platform_device() is quite convoluted.  This function
> takes an ACPI device node as an argument and eventually calls
> platform_device_register_resndata() to create and register a
> platform device object on the basis of the information contained
> in that code.  However, it doesn't associate the new platform
> device with the ACPI node directly, but instead it relies on
> acpi_platform_notify(), called from within device_add(), to find
> that ACPI node again with the help of acpi_platform_find_device()
> and acpi_platform_match() and then attach the new platform device
> to it.  This causes an additional ACPI namespace walk to happen and
> is clearly suboptimal.
> 
> Use the observation that it is now possible to initialize the ACPI
> handle of a device before calling device_add() for it to make this
> code more straightforward.  Namely, add a new field to struct
> platform_device_info allowing us to pass the ACPI handle of interest
> to platform_device_register_full(), which will then use it to
> initialize the new device's ACPI handle before registering it.
> This will cause acpi_platform_notify() to use the ACPI handle from
> the device structure directly instead of using the .find_device()
> routine provided by the device's bus type.  In consequence,
> acpi_platform_bus, acpi_platform_find_device(), and
> acpi_platform_match() are not necessary any more, so remove them.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
