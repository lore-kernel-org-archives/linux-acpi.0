From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH] ACPI / GPIO: Pass index to acpi_get_gpiod_by_index()
 when using properties
Date: Sun, 02 Nov 2014 20:49:37 -0800
Message-ID: <54570961.1080004@linux.intel.com>
References: <1414494927-204923-1-git-send-email-mika.westerberg@linux.intel.com>	<2740724.5yjNTKs1RY@vostro.rjw.lan> <20141101111143.86AC1C409FE@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35066 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974AbaKCEuF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 2 Nov 2014 23:50:05 -0500
In-Reply-To: <20141101111143.86AC1C409FE@trevor.secretlab.ca>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Alexandre Courbot <acourbot@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org



On 11/1/14 4:11, Grant Likely wrote:
> On Tue, 28 Oct 2014 22:59:57 +0100
> , "Rafael J. Wysocki" <rjw@rjwysocki.net>
>  wrote:
>> On Tuesday, October 28, 2014 01:15:27 PM Mika Westerberg wrote:
>>> acpi_dev_add_driver_gpios() makes it possible to set up mapping between
>>> properties and ACPI GpioIo resources in a driver, so we can take index
>>> parameter in acpi_find_gpio() into use with _DSD device properties now.
>>>
>>> This index can be used to select a GPIO from a property with multiple
>>> GPIOs:
>>>
>>>   Package () {
>>>   	"data-gpios",
>>>   	Package () {
>>>   		\_SB.GPIO, 0, 0, 0,
>>>   		\_SB.GPIO, 1, 0, 0,
>>>   		\_SB.GPIO, 2, 0, 1,
>>>   	}
>>>   }
>>>
>>> In order to retrieve the last GPIO from a driver we can simply do:
>>>
>>>   desc = devm_gpiod_get_index(dev, "data", 2);
>>>
>>> and so on.
>>>
>>> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>
>> Cool. :-)
>>
>> Any objections anyone?
> 
> Actually, I do. Not in the idea, but in the implementation. The way this gets encoded:
> 
> 	Package () {
> 		\_SB.GPIO, 0, 0, 0,
> 		\_SB.GPIO, 1, 0, 0,
> 		\_SB.GPIO, 2, 0, 1,
> 	}
> 
> Means that decoding each GPIO tuple requires the length of a tuple to be
> fixed, or to implement a DT-like #gpio-cells. If it is fixed, then there
> is no way to expand the binding later. Can this be done in the following
> way instead?
> 
> 	Package () {
> 		Package () { \_SB.GPIO, 0, 0, 0 },
> 		Package () { \_SB.GPIO, 1, 0, 0 },
> 		Package () { \_SB.GPIO, 2, 0, 1 },
> 	}
> 
> This is one of the biggest pains in device tree. We don't have any way
> to group tuples so it requires looking up stuff across the tree to
> figure out how to parse each multi-item property.
> 
> I know that last year we talked about how bios vendors would get
> complicated properties wrong, but I think there is little risk in this
> case. If the property is encoded wrong, the driver simply won't work and
> it is unlikely to get shipped before being fixed.

This particular nesting of Packages is expressly prohibited by the
Device Properties UUID for the reasons you mention.

http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf

2.1 Data Format Definition
...
" a Package consisting entirely of Integer, String, or Reference objects
(and
specifically not containing a nested Package)."

That said, I am not fond of the many properties mixed in as a single
Package. We discussed this at some length while this was being proposed,
and this was deemed the lesser evil.

-- 
Darren Hart
Intel Open Source Technology Center
