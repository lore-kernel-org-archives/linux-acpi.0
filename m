From: Alexandre Courbot <acourbot@nvidia.com>
Subject: Re: [PATCH] ACPI / GPIO: Pass index to acpi_get_gpiod_by_index()
 when using properties
Date: Wed, 29 Oct 2014 16:41:47 +0900
Message-ID: <54509A3B.5090709@nvidia.com>
References: <1414494927-204923-1-git-send-email-mika.westerberg@linux.intel.com> <2740724.5yjNTKs1RY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15289 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbaJ2HmL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Oct 2014 03:42:11 -0400
In-Reply-To: <2740724.5yjNTKs1RY@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Darren Hart <dvhart@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/29/2014 06:59 AM, Rafael J. Wysocki wrote:
> On Tuesday, October 28, 2014 01:15:27 PM Mika Westerberg wrote:
>> acpi_dev_add_driver_gpios() makes it possible to set up mapping between
>> properties and ACPI GpioIo resources in a driver, so we can take index
>> parameter in acpi_find_gpio() into use with _DSD device properties now.
>>
>> This index can be used to select a GPIO from a property with multiple
>> GPIOs:
>>
>>    Package () {
>>    	"data-gpios",
>>    	Package () {
>>    		\_SB.GPIO, 0, 0, 0,
>>    		\_SB.GPIO, 1, 0, 0,
>>    		\_SB.GPIO, 2, 0, 1,
>>    	}
>>    }
>>
>> In order to retrieve the last GPIO from a driver we can simply do:
>>
>>    desc = devm_gpiod_get_index(dev, "data", 2);
>>
>> and so on.
>>
>> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> Cool. :-)
>
> Any objections anyone?

Looks good to me!

Acked-by: Alexandre Courbot <acourbot@nvidia.com>

Since this looks like a bug fix, shouldn't this be squashed into the 
relevant patch of the device-properties set?
