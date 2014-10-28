From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH] ACPI / GPIO: Pass index to acpi_get_gpiod_by_index()
 when using properties
Date: Tue, 28 Oct 2014 08:57:46 -0700
Message-ID: <544FBCFA.4070400@linux.intel.com>
References: <1414494927-204923-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55865 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754268AbaJ1P75 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Oct 2014 11:59:57 -0400
In-Reply-To: <1414494927-204923-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org



On 10/28/14 4:15, Mika Westerberg wrote:
> acpi_dev_add_driver_gpios() makes it possible to set up mapping between
> properties and ACPI GpioIo resources in a driver, so we can take index
> parameter in acpi_find_gpio() into use with _DSD device properties now.
> 
> This index can be used to select a GPIO from a property with multiple
> GPIOs:
> 
>   Package () {
>   	"data-gpios",
>   	Package () {
>   		\_SB.GPIO, 0, 0, 0,
>   		\_SB.GPIO, 1, 0, 0,
>   		\_SB.GPIO, 2, 0, 1,
>   	}
>   }
> 
> In order to retrieve the last GPIO from a driver we can simply do:
> 
>   desc = devm_gpiod_get_index(dev, "data", 2);
> 
> and so on.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Nice, that was a gap that had been gnawing at me. Thanks Mika :-)

Acked-by: Darren Hart <dvhart@linux.intel.com>

-- 
Darren Hart
Intel Open Source Technology Center
