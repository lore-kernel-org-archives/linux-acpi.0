From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v1 06/11] platform/x86: apple-gmux: hide PCI specific code
Date: Sat, 22 Dec 2018 09:31:51 +0100
Message-ID: <cd2719f6-9bf2-b3c0-dfef-0e28d43e73a1@kernel.org>
References: <20181222001452.7474-1-okaya@kernel.org>
 <20181222001452.7474-7-okaya@kernel.org>
 <20181222080317.qicyihyauia6n63w@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181222080317.qicyihyauia6n63w@wunner.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 12/22/2018 9:03 AM, Lukas Wunner wrote:
> On Sat, Dec 22, 2018 at 12:14:47AM +0000, Sinan Kaya wrote:
>> Code is scanning PCI bus to find out if it is switchable or not. If
>> CONFIG_PCI is not set, assume unswitchable.
>>
>> Signed-off-by: Sinan Kaya <okaya@kernel.org>
>> ---
>>   drivers/platform/x86/apple-gmux.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
>> index fd2ffebc868f..b552b54bf58b 100644
>> --- a/drivers/platform/x86/apple-gmux.c
>> +++ b/drivers/platform/x86/apple-gmux.c
>> @@ -742,8 +742,12 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
>>   	 * If Thunderbolt is present, the external DP port is not fully
>>   	 * switchable. Force its AUX channel to the discrete GPU.
>>   	 */
>> +#ifdef CONFIG_PCI
>>   	gmux_data->external_switchable =
>>   		!bus_for_each_dev(&pci_bus_type, NULL, NULL, is_thunderbolt);
>> +#else
>> +	gmux_data->external_switchable = false;
>> +#endif
>>   	if (!gmux_data->external_switchable)
>>   		gmux_write8(gmux_data, GMUX_PORT_SWITCH_EXTERNAL, 3);
> 
> This driver is only used on 2008+ MacBook Pros and the 2013+ Mac Pro,
> all of which have PCI and are pretty much unusable with CONFIG_PCI=n.
> 
> So it is okay to just add "depends on PCI" for this driver, as you did
> with other drivers, and I think that's preferrable to an #ifdef.
> 
> You can also drop the "platform/x86: " prefix from the subject if you
> like, all previous commits to this driver just use "apple-gmux: ".
> 
> If you are okay with these changes, feel free to add my Reviewed-by
> when respinning.
> 

This is how I updated this patch:

commit 867d96cb6b75124b7ce11014425b8c57a8350e61 (HEAD)
Author: Sinan Kaya <okaya@kernel.org>
Date:   Fri Dec 21 23:24:13 2018 +0000

     apple-gmux: Make PCI dependency explicit

     This driver depends on the PCI infrastructure but the dependency has not
     been explicitly called out.

     Signed-off-by: Sinan Kaya <okaya@kernel.org>
     Reviewed-by: Lukas Wunner <lukas@wunner.de>

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index b36ea14b41ad..86b75fa55dbc 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1136,6 +1136,7 @@ config SAMSUNG_Q10
  config APPLE_GMUX
         tristate "Apple Gmux Driver"
         depends on ACPI
+       depends on PCI
         depends on PNP
         depends on BACKLIGHT_CLASS_DEVICE
         depends on BACKLIGHT_APPLE=n || BACKLIGHT_APPLE


> Thanks,
> 
> Lukas
> 
