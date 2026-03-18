Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4DE26FD97
	for <linux-acpi@vger.kernel.org>; Wed, 18 Mar 2026 02:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773801714; cv=none; b=QjRa3A1bQ0T16uK1Ua2EOx8EKVELgYJHfRxmS8hoqhB1EPVLij/jBCSsC7VTbLIHAaaqDf4QOGU8lW6m2oHWHB//sSAulqTI4jFqS2Ew3u7y8Z8InkKY/ZxM0HaGutGY39YyyHewUpQe4VedfdBTN4WlBuCVEopA598a/UM7gJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773801714; c=relaxed/simple;
	bh=9jgzk/5eMgOmv0bWJ5NpAyaocGYky0h+AHcPfl79Uvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VQec4xZ0jog866Q2eTS/LvDQEynk5+gO+1P4OM853zwR541D+s0Ufo/oS2uxZgl54KkkvHl/B9yatx15aABW5M8PMl8t3MuUZ92Y3b8+TrtMqtIez9yM2Yl/F8bLCLFfCoOdzEBnNRnw2mfp1FDo8kbU/UZBQHXNWpgCpXdDYRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3gxkJlK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3gxkJlK"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b04e6a989eso25801145ad.3
        for <linux-acpi@vger.kernel.org>; Tue, 17 Mar 2026 19:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773801713; x=1774406513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0MHjrnk7whazUP9sHgfBhP1L9WIAZO2yLQ1N5+LwcOk=;
        b=J3gxkJlK1I44WizJ+CaUFW8taaCku1d78gMpl6dgcVidfPW099tdXRaWv56ycsrKVC
         pRo57EiEo9vLGcTeA+dzl6ibHZJSn0SI5NpnJVcfnYiC9g1Y5KeNrGEcWhKIVKcsD1kc
         tb8NjMud5GY85zGoiGFFazlj9ZNYl90nBHRYMFXOUP5yEzWgekUo1kDDaSNSrugPjgW0
         gOXQu23Pi52Q5M8UNN5EqYMajPH/VzR3ZBkiKPzBeLc7NkN/CGUBwCr3w8yqP+VlLtNK
         HKbJgZp4hmUFR1YmUoRIL4kJPrEITEqzK+kJ3dB7LCzB5i/YaUskq+qMbJd1nTFjHro1
         PS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773801713; x=1774406513;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0MHjrnk7whazUP9sHgfBhP1L9WIAZO2yLQ1N5+LwcOk=;
        b=O4dNNMSjBamnKFKHmkbHfzIX1S+djISMhnPwcwwR/muzK3Af8j+jqzW+/BWWeQA8So
         5eNd7L1POYQVUtmPNblr2DG7eL6YlUdo8PBUBULKfIdmT6JOFtUi63R2FFPNUxtlZHZd
         uV9sMszZGmSBDqmKzLEVLtYQFxz+e3rJ3mhaGFHHjIkWoDFW+ZTNAFNf7GGxHUcM3+VU
         0eyopl9RIb8Zg9+vZaMxUZCCk7xVoHQwcZWA78BVcEb70PERtEg2XIMaQDxgp5KMkAcb
         C3FFWD+WZPiDhWY+ZgwhqRWvsl9IkXgpIAJ732SQz5hYsdHvAFNTfqfR1Nji9caCP6aF
         hI9A==
X-Forwarded-Encrypted: i=1; AJvYcCVRkz5K3H+8MUP4JHIqvdXHbiur734jOGg7VwCtpzOSTgg8Yle0gXs85l38ELUyJSeBhb6VLsdaFJlO@vger.kernel.org
X-Gm-Message-State: AOJu0YyzKM29xzdIi+9NhSZsu6Hbw8OEADDJffq0Jj8tJd5wpEPdFlmZ
	6HjWoVO9keQnNu0uKl68EdynYy/Cs9ntDGHCBPE73Hlj5BU7rFJOKJMG
X-Gm-Gg: ATEYQzzJb+9J/jRq/R1sBUI+JEKV2MFYGWQTsKZ/vbZl/pQrZTV4sm7BsQsqGR6BbaN
	IGZknN0ECrpUXjHCjgWUle3fhrVk2Q3qlYtq+DginQxo8D0z5LWBLFR57EgZF0YZicETL17q5/z
	2pCPeE2dWmjLGsYNqYFaVx2/51d/cDRdjheqIgYiP1ygoqD3FarHnNZTm9NHzkpnRDzXOBcrr8T
	EkI6i5AgYLIiDCdIbv88aaLeW6QII66Y3cqqLwe5+97M/e9vFlgRjsSTixVE0ER/v/lxD8M97fU
	Vh1thbIWUVNtHTgVCNNvSE8KllU09JRDoeECvzzXoRvODCvdz7XI50iU4xtGWEAEfdBJd6KY1IR
	1NBuYuhDDZyqXOeCSjjQJb+FmzG84Yvuxm97fd/jrxvNE0i/zUggPbKTO9ZXaAQot1lDK1dSTXX
	ATokoxakJQzM3QD3k1XWjcz4nPGaBw57hVKRyqRN9Dn72xFnbp/+CrTA+ujvkNBqNEe13zCGgb
X-Received: by 2002:a17:903:984:b0:2b0:55cf:5e9c with SMTP id d9443c01a7336-2b06e394ab3mr16457405ad.30.1773801712827;
        Tue, 17 Mar 2026 19:41:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e41aad6sm9212475ad.16.2026.03.17.19.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 19:41:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ba47dff2-7fbd-4173-93bc-3f26f21bd94c@roeck-us.net>
Date: Tue, 17 Mar 2026 19:41:51 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: processor: Fix previous
 acpi_processor_errata_piix4() fix
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Tuo Li <islituo@gmail.com>, linux-kernel@vger.kernel.org
References: <20260111163214.202262-1-islituo@gmail.com>
 <938e2206-def5-4b7a-9b2c-d1fd37681d8a@roeck-us.net>
 <5975693.DvuYhMxLoT@rafael.j.wysocki>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <5975693.DvuYhMxLoT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/17/26 13:39, Rafael J. Wysocki wrote:
> On Tuesday, March 17, 2026 6:26:59 PM CET Guenter Roeck wrote:
>> Hi,
>>
>> On Mon, Jan 12, 2026 at 12:32:14AM +0800, Tuo Li wrote:
>>> In acpi_processor_errata_piix4(), the pointer dev is first assigned an IDE
>>> device and then reassigned an ISA device:
>>>
>>>    dev = pci_get_subsys(..., PCI_DEVICE_ID_INTEL_82371AB, ...);
>>>    dev = pci_get_subsys(..., PCI_DEVICE_ID_INTEL_82371AB_0, ...);
>>>
>>> If the first lookup succeeds but the second fails, dev becomes NULL. This
>>> leads to a potential null-pointer dereference when dev_dbg() is called:
>>>
>>>    if (errata.piix4.bmisx)
>>>      dev_dbg(&dev->dev, ...);
>>>
>>> To prevent this, use two temporary pointers and retrieve each device
>>> independently, avoiding overwriting dev with a possible NULL value.
>>>
>>>
>>> Signed-off-by: Tuo Li <islituo@gmail.com>
>>
>> AI review feedback inline below.
>>
>> I don't know if the device lifetime issue is real, but the now unconditional
>> debug message is definitely a functional change and potentially misleading.
>>
>> Either case, why not just move the debug messages into the code setting
>> errata.piix4.bmisx and errata.piix4.fdma ?
>>
>> Thanks,
>> Guenter
>>
>>> ---
>>> v3:
>>> * Initialize the new variables to NULL and drop redundant checks.
>>>    Thanks Rafael J. Wysocki for helpful advice.
>>> v2:
>>> * Add checks for ide_dev and isa_dev before dev_dbg()
>>>    Thanks Rafael J. Wysocki for helpful advice.
>>> ---
>>>   drivers/acpi/acpi_processor.c | 27 ++++++++++++++-------------
>>>   1 file changed, 14 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
>>> index 7ec1dc04fd11..de256e3adeed 100644
>>> --- a/drivers/acpi/acpi_processor.c
>>> +++ b/drivers/acpi/acpi_processor.c
>>> @@ -50,6 +50,7 @@ static int acpi_processor_errata_piix4(struct pci_dev *dev)
>>>   {
>>>   	u8 value1 = 0;
>>>   	u8 value2 = 0;
>>> +	struct pci_dev *ide_dev = NULL, *isa_dev = NULL;
>>>   
>>>   
>>>   	if (!dev)
>>> @@ -107,12 +108,12 @@ static int acpi_processor_errata_piix4(struct pci_dev *dev)
>>>   		 * each IDE controller's DMA status to make sure we catch all
>>>   		 * DMA activity.
>>>   		 */
>>> -		dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
>>> +		ide_dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
>>>   				     PCI_DEVICE_ID_INTEL_82371AB,
>>>   				     PCI_ANY_ID, PCI_ANY_ID, NULL);
>>> -		if (dev) {
>>> -			errata.piix4.bmisx = pci_resource_start(dev, 4);
>>> -			pci_dev_put(dev);
>>> +		if (ide_dev) {
>>> +			errata.piix4.bmisx = pci_resource_start(ide_dev, 4);
>>> +			pci_dev_put(ide_dev);
>>>   		}
>>>   
>>>   		/*
>>> @@ -124,24 +125,24 @@ static int acpi_processor_errata_piix4(struct pci_dev *dev)
>>>   		 * disable C3 support if this is enabled, as some legacy
>>>   		 * devices won't operate well if fast DMA is disabled.
>>>   		 */
>>> -		dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
>>> +		isa_dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
>>>   				     PCI_DEVICE_ID_INTEL_82371AB_0,
>>>   				     PCI_ANY_ID, PCI_ANY_ID, NULL);
>>> -		if (dev) {
>>> -			pci_read_config_byte(dev, 0x76, &value1);
>>> -			pci_read_config_byte(dev, 0x77, &value2);
>>> +		if (isa_dev) {
>>> +			pci_read_config_byte(isa_dev, 0x76, &value1);
>>> +			pci_read_config_byte(isa_dev, 0x77, &value2);
>>>   			if ((value1 & 0x80) || (value2 & 0x80))
>>>   				errata.piix4.fdma = 1;
>>> -			pci_dev_put(dev);
>>> +			pci_dev_put(isa_dev);
>>>   		}
>>>   
>>>   		break;
>>>   	}
>>>   
>>> -	if (errata.piix4.bmisx)
>>> -		dev_dbg(&dev->dev, "Bus master activity detection (BM-IDE) erratum enabled\n");
>>> -	if (errata.piix4.fdma)
>>> -		dev_dbg(&dev->dev, "Type-F DMA livelock erratum (C3 disabled)\n");
>>> +	if (ide_dev)
>>> +		dev_dbg(&ide_dev->dev, "Bus master activity detection (BM-IDE) erratum enabled\n");
>>
>> Is it safe to dereference ide_dev here? It looks like pci_dev_put(ide_dev)
>> was already called above, which drops the reference and might lead to a
>> use-after-free.
>>
>> Also, does this change the logging behavior? The original code checked
>> errata.piix4.bmisx before logging, but now it logs as long as ide_dev
>> was found, even if the erratum is not actually enabled.
> 
> Well, it has a point.
> 
> The patch below should fix this.
> 
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v1] ACPI: processor: Fix previous acpi_processor_errata_piix4() fix
> 
> After commi f132e089fe89 ("ACPI: processor: Fix NULL-pointer dereference
> in acpi_processor_errata_piix4()"), device pointers may be dereferenced
> after dropping references to the device objects pointed to by them,
> which may cause a use-after-free to occur.
> 
> Moreover, debug messages about enabling the errata may be printed
> if the errata flags corresponding to them are unset.
> 
> Address all of these issues by moving message printing to the points
> in the code where the errata flags are set.
> 
> Fixes: f132e089fe89 ("ACPI: processor: Fix NULL-pointer dereference in acpi_processor_errata_piix4()")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/linux-acpi/938e2206-def5-4b7a-9b2c-d1fd37681d8a@roeck-us.net/
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/acpi/acpi_processor.c |   15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -113,6 +113,10 @@ static int acpi_processor_errata_piix4(s
>   				     PCI_ANY_ID, PCI_ANY_ID, NULL);
>   		if (ide_dev) {
>   			errata.piix4.bmisx = pci_resource_start(ide_dev, 4);
> +			if (errata.piix4.bmisx)
> +				dev_dbg(&ide_dev->dev,
> +					"Bus master activity detection (BM-IDE) erratum enabled\n");
> +
>   			pci_dev_put(ide_dev);
>   		}
>   
> @@ -131,20 +135,17 @@ static int acpi_processor_errata_piix4(s
>   		if (isa_dev) {
>   			pci_read_config_byte(isa_dev, 0x76, &value1);
>   			pci_read_config_byte(isa_dev, 0x77, &value2);
> -			if ((value1 & 0x80) || (value2 & 0x80))
> +			if ((value1 & 0x80) || (value2 & 0x80)) {
>   				errata.piix4.fdma = 1;
> +				dev_dbg(&isa_dev->dev,
> +					"Type-F DMA livelock erratum (C3 disabled)\n");
> +			}
>   			pci_dev_put(isa_dev);
>   		}
>   
>   		break;
>   	}
>   
> -	if (ide_dev)
> -		dev_dbg(&ide_dev->dev, "Bus master activity detection (BM-IDE) erratum enabled\n");
> -
> -	if (isa_dev)
> -		dev_dbg(&isa_dev->dev, "Type-F DMA livelock erratum (C3 disabled)\n");
> -
>   	return 0;
>   }
>   
> 
> 
> 

