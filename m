From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: Re: [PATCH 2/2] net, thunder, bgx: Add support for ACPI binding.
Date: Fri, 07 Aug 2015 12:52:41 +0200
Message-ID: <55C48DF9.70406@linaro.org>
References: <1438907590-29649-1-git-send-email-ddaney.cavm@gmail.com> <1438907590-29649-3-git-send-email-ddaney.cavm@gmail.com> <55C467A0.4020601@linaro.org> <20150807104320.GQ1820@rric.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:33806 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbbHGKwp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Aug 2015 06:52:45 -0400
Received: by labd1 with SMTP id d1so6095443lab.1
        for <linux-acpi@vger.kernel.org>; Fri, 07 Aug 2015 03:52:43 -0700 (PDT)
In-Reply-To: <20150807104320.GQ1820@rric.localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Richter <robert.richter@caviumnetworks.com>
Cc: David Daney <ddaney.cavm@gmail.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, linux-mips@linux-mips.org, Sunil Goutham <sgoutham@cavium.com>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, David Daney <david.daney@cavium.com>

On 07.08.2015 12:43, Robert Richter wrote:
> On 07.08.15 10:09:04, Tomasz Nowicki wrote:
>> On 07.08.2015 02:33, David Daney wrote:
>
> ...
>
>>> +#else
>>> +
>>> +static int bgx_init_acpi_phy(struct bgx *bgx)
>>> +{
>>> +	return -ENODEV;
>>> +}
>>> +
>>> +#endif /* CONFIG_ACPI */
>>> +
>>>   #if IS_ENABLED(CONFIG_OF_MDIO)
>>>
>>>   static int bgx_init_of_phy(struct bgx *bgx)
>>> @@ -882,7 +1010,12 @@ static int bgx_init_of_phy(struct bgx *bgx)
>>>
>>>   static int bgx_init_phy(struct bgx *bgx)
>>>   {
>>> -	return bgx_init_of_phy(bgx);
>>> +	int err = bgx_init_of_phy(bgx);
>>> +
>>> +	if (err != -ENODEV)
>>> +		return err;
>>> +
>>> +	return bgx_init_acpi_phy(bgx);
>>>   }
>>>
>>
>> If kernel can work with DT and ACPI (both compiled in), it should take only
>> one path instead of probing DT and ACPI sequentially. How about:
>>
>> @@ -902,10 +925,9 @@ static int bgx_probe(struct pci_dev *pdev, const struct
>> pci_device_id *ent)
>>   	bgx_vnic[bgx->bgx_id] = bgx;
>>   	bgx_get_qlm_mode(bgx);
>>
>> -	snprintf(bgx_sel, 5, "bgx%d", bgx->bgx_id);
>> -	np = of_find_node_by_name(NULL, bgx_sel);
>> -	if (np)
>> -		bgx_init_of(bgx, np);
>> +	err = acpi_disabled ? bgx_init_of_phy(bgx) : bgx_init_acpi_phy(bgx);
>> +	if (err)
>> +		goto err_enable;
>>
>>   	bgx_init_hw(bgx);
>
> I would not pollute bgx_probe() with acpi and dt specifics, and instead
> keep bgx_init_phy(). The typical design pattern for this is:
>
> static int bgx_init_phy(struct bgx *bgx)
> {
> #ifdef CONFIG_ACPI
>          if (!acpi_disabled)
>                  return bgx_init_acpi_phy(bgx);
> #endif
>          return bgx_init_of_phy(bgx);
> }
>
> This adds acpi runtime detection (acpi=no), does not call dt code in
> case of acpi, and saves the #else for bgx_init_acpi_phy().
>

I am fine with keeping it in bgx_init_phy(), however we can drop there 
#ifdefs since both of bgx_init_{acpi,of}_phy calls have empty stub for 
!ACPI and !OF case. Like that:

static int bgx_init_phy(struct bgx *bgx)
{

         if (!acpi_disabled)
                 return bgx_init_acpi_phy(bgx);
	else
         	return bgx_init_of_phy(bgx);
}

Tomasz
