From: "Anderson, Brandon" <Brandon.Anderson@amd.com>
Subject: RE: [Linaro-acpi] [PATCH V2 3/4] ACPI/ARM: Add ACPI to AMBA SPI
 driver
Date: Fri, 22 Nov 2013 20:17:34 +0000
Message-ID: <CE40542A5D952D47989966E71788B184037DE90C@satlexdag05.amd.com>
References: <1385143964-22938-1-git-send-email-brandon.anderson@amd.com>
 <1385143964-22938-4-git-send-email-brandon.anderson@amd.com>
 <CACxGe6sfaWgZ59E5n_5Ozv6CQ8Z76dyy346Uz0Lf2E0GdKYrZw@mail.gmail.com>
 <528FBAB4.20107@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:43298 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756160Ab3KVURk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Nov 2013 15:17:40 -0500
In-Reply-To: <528FBAB4.20107@linaro.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <al.stone@linaro.org>, Grant Likely <grant.likely@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, linaro-acpi <linaro-acpi@lists.linaro.org>



-----Original Message-----
From: Al Stone [mailto:al.stone@linaro.org] 
Sent: Friday, November 22, 2013 2:13 PM
To: Grant Likely; Anderson, Brandon
Cc: Rafael J. Wysocki; Russell King - ARM Linux; ACPI Devel Mailing List; linaro-acpi
Subject: Re: [Linaro-acpi] [PATCH V2 3/4] ACPI/ARM: Add ACPI to AMBA SPI driver

On 11/22/2013 12:52 PM, Grant Likely wrote:
> On Fri, Nov 22, 2013 at 6:12 PM, Brandon Anderson 
> <brandon.anderson@amd.com> wrote:
>> Neither Foundation nor RTSM have a SPI device, but here are the 
>> necessary driver changes as an example of how to use 
>> acpi_amba_dsm_lookup() to get non-standard parameters from ACPI.
>>
>> This was tested by wiring up a SPI device into an RTSM Fast Model.
>>
>>
>> Signed-off-by: Brandon Anderson <brandon.anderson@amd.com>
>> ---
>>   drivers/spi/spi-pl022.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 53 insertions(+)
>>
>> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c index 
>> 9c511a9..1d0a8ec 100644
>> --- a/drivers/spi/spi-pl022.c
>> +++ b/drivers/spi/spi-pl022.c
>> @@ -43,6 +43,7 @@
>>   #include <linux/gpio.h>
>>   #include <linux/of_gpio.h>
>>   #include <linux/pinctrl/consumer.h>
>> +#include <linux/amba/acpi.h>
>>
>>   /*
>>    * This macro is used to define some register default values.
>> @@ -2069,6 +2070,55 @@ pl022_platform_data_dt_get(struct device *dev)
>>          return pd;
>>   }
>>
>> +#ifdef CONFIG_ACPI
>> +static struct pl022_ssp_controller * 
>> +acpi_pl022_get_platform_data(struct device *dev) {
>> +       struct pl022_ssp_controller *pd, *ret;
>> +       struct acpi_amba_dsm_entry entry;
>> +
>> +       pd = devm_kzalloc(dev, sizeof(struct pl022_ssp_controller), GFP_KERNEL);
>> +       if (!pd) {
>> +               dev_err(dev, "cannot allocate platform data memory\n");
>> +               return NULL;
>> +       }
>> +       ret = pd;
>> +
>> +       pd->bus_id = -1;
>> +       pd->enable_dma = 1;
>> +       if (acpi_amba_dsm_lookup(ACPI_HANDLE(dev), "num-cs", 0, &entry) == 0) {
>> +               if (kstrtou8(entry.value, 0, &pd->num_chipselect) != 0) {
>> +                       dev_err(dev, "invalid 'num-cs' in ACPI definition\n");
>> +                       ret = NULL;
>> +               }
>> +               kfree(entry.key);
>> +               kfree(entry.value);
>> +       }
>> +       if (acpi_amba_dsm_lookup(ACPI_HANDLE(dev),
>> +                       "autosuspend-delay", 0, &entry) == 0) {
>> +               if (kstrtoint(entry.value, 0, &pd->autosuspend_delay) != 0) {
>> +                       dev_err(dev, "invalid 'autosuspend-delay' in ACPI definition\n");
>> +                       ret = NULL;
>> +               }
>> +               kfree(entry.key);
>> +               kfree(entry.value);
>> +       }
>> +       if (acpi_amba_dsm_lookup(ACPI_HANDLE(dev), "rt", 0, &entry) == 0) {
>> +               pd->rt = (entry.value && strcmp(entry.value, "1") == 0);
>> +               kfree(entry.key);
>> +               kfree(entry.value);
>> +       }
>> +
>> +       return ret;
>> +}
>
> As discussed in the ACPI vs DT thread. The kinds of lookups here are 
> identical to the DT property lookups except that the function name is 
> different and the property name is needlessly different. That's 
> madness. In all of the trivial cases the DT and ACPI lookup code 
> should be identical. We need a property value lookup function that 
> both DT and ACPI can use.
>
> g.

Agreed.  I'm in the process of prototyping this code and my plan is to have something available for comment the week after next (unless I get _really_ bored Thanksgiving weekend...).

Great, Al! 

I agree, and Russell King has made the same comment. This patch in the series can be dropped with no ill effect, as it is an example only. Or modified to use a common lookup function once it is available.

--
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone@linaro.org
-----------------------------------


