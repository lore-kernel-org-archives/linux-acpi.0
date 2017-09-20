From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: ACPI support for optee driver
Date: Wed, 20 Sep 2017 13:39:18 +0300
Message-ID: <20170920103918.GA4630@lahna.fi.intel.com>
References: <CAL-zptO3xg4k_B_S1SfKOghHGAUjqp56W9vqDdV3xgpUJ6b8dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:47380 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751497AbdITKnt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 Sep 2017 06:43:49 -0400
Content-Disposition: inline
In-Reply-To: <CAL-zptO3xg4k_B_S1SfKOghHGAUjqp56W9vqDdV3xgpUJ6b8dQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mayuresh Chitale <mchitale@apm.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, linux-acpi@vger.kernel.org

On Wed, Sep 20, 2017 at 02:17:38PM +0530, Mayuresh Chitale wrote:
> Hi,
> 
> I am working on adding APCI support to optee kernel driver and was
> considering implementing it in the following way:
> 
> - An optee device node would be added to the bios as follows:
> Device(OPTE) {
>       Name(_HID, ...)
>       Name(_CID, ...)
>       Name(_DDN, ...)
>       Name (_DSD, Package () {
>           Package () {
>             Package (2) {"method", "smc"}
>           }

This _DSD is malformed as it is missing UUID.

>       })
>     }
> 
> - The optee kernel driver would then search for \\SB.OPTE device using
> acpi_get_handle and parse the node to get the conduit method.

You can use the standard device_property_* (see
include/linux/property.h) accessors which fully support _DSD device
properties.

> I was wondering if this is the correct way to implement it and if so
> do I need to get the OPTE device registered?  Your feedback is really
> appreciated.

There is something documented here:

Documentation/acpi/DSD-properties-rules.txt
