From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 04/15] ACPI: Document ACPI device specific properties
Date: Wed, 01 Oct 2014 09:59:14 +0200
Message-ID: <1979325.jM0BQzDCTX@wuerfel>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com> <1852462.V1jlbi8OPt@vostro.rjw.lan> <5597683.oi0VxOogFu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:50039 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbaJAH7Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Oct 2014 03:59:25 -0400
In-Reply-To: <5597683.oi0VxOogFu@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Grant Likely <grant.likely@linaro.org>, Aaron Lu <aaron.lu@intel.com>, Darren Hart <dvhart@linux.intel.com>

On Wednesday 01 October 2014 04:11:20 Rafael J. Wysocki wrote:
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> This document describes the data format and interfaces of ACPI device
> specific properties.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Darren Hart <dvhart@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Overall looks sane, but I wonder if we should try harder to not duplicate
some of the mistakes we made in the DT bindings. Two points in particular
stick out:

> +2.3 Strings
> +-----------
> +String properties can be used to describe many things like labels for GPIO
> +buttons, compability ids, etc.
> +
> +A string property looks like this:
> +
> +	Package () {"pwm-names", "backlight"},

The way we name things in DT using separate "foos" and "foo-names" properties
is a bit quirky. Those are always defined on a per-subsystem level, not
a per-device level though, so it should be possible to come up with a
better representation in ACPI.

Since the device driver should never look into the "foo-names" property
itself but just pass down the name into the subsystem, the "foo" subsystem
could instead have a way to add an (optional) name for each reference.

This is something the DT syntax doesn't allow because you can't have
both a phandle and a string in a single property but I think the ACPI
packages can do it, and it wouldn't change the basic structure.

> +The referenced ACPI device is returned in args->adev if found.
> +
> +In addition to simple object references it is also possible to have object
> +references with arguments. These are represented in ASL as follows:
> +
> +	Device (\_SB.PCI0.PWM)
> +	{
> +		Name (_DSD, Package () {
> +			ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +			Package () {
> +				Package () {"#pwm-cells", 2}
> +			}
> +		})
> +	}
> +

Similarly, the "#foo-cells" syntax is an artifact of the limitations of the
DT syntax, and I'd assume there would be a better way to encode this
in ACPI. Also, a "cell" in Open Firmware is defined as a big-endian
32-bit value, which doesn't directly correspond to something in ACPI,
and the '#' character is an artifact of the use of the Forth language
in Open Firmware, which you also don't have here.

	Arnd
