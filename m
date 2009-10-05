From: Stefan Bader <stefan.bader@canonical.com>
Subject: [Fwd: Re: [PATCH] acerhdf: Limit modalias matching to supported boards]
Date: Mon, 05 Oct 2009 14:05:07 +0200
Message-ID: <4AC9E0F3.5030605@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:43658 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758295AbZJEMFo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Oct 2009 08:05:44 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Borislav Petkov <petkovbb@gmail.com>, Peter Feuerer <peter@piie.net>

Len,

could you please pick this patch to prevent the acerhdf module to get loaded on 
the wrong hardware (causing only annoying warnings.

Thanks,
Stefan

-------- Original Message --------
Subject: Re: [PATCH] acerhdf: Limit modalias matching to supported boards
Date: Sat, 03 Oct 2009 18:47:33 +0200
From: Peter Feuerer <peter@piie.net>
To: Stefan Bader <stefan.bader@canonical.com>
CC: Borislav Petkov <petkovbb@googlemail.com>, linux-kernel@vger.kernel.org
References: <4AC34B83.6090402@canonical.com> 
<20090930212233.GB17712@liondog.tnic> 
<cone.1254466252.404216.3290.1000@onepiie> <4AC5B0F1.4030303@canonical.com> 
<9ea470500910020254j21fad1d3g1c825bcecdbb29fb@mail.gmail.com> 
<cone.1254477850.9043.3499.1000@onepiie> <4AC5D098.1010504@canonical.com>

Stefan Bader writes:

> Peter Feuerer wrote:
>> Borislav Petkov writes:
>> 
>>> On Fri, Oct 2, 2009 at 9:51 AM, Stefan Bader 
>>> <stefan.bader@canonical.com> wrote:
>>>>>> I search my acerhdf-inbox for the people who sent me the BIOS 
>>>>>> versions,
>>>>> maybe they still have the netbook and can me send the modalias 
>>>>> content. I'll
>>>>> hopefully find some time upcoming weekend.
>>>>>
>>>>> But, can't we simply assume, following dmi lines?
>>>>>
>>>>> MODULE_ALIAS("dmi:*:*Acer*:*AOA*:");
>>>>> MODULE_ALIAS("dmi:*:*Gateway*:*AOA*:");
>>>>> MODULE_ALIAS("dmi:*:*Packard Bell*:*AOA*:");
>>>>> MODULE_ALIAS("dmi:*:*Packard Bell*:*DOA*:");
>>>>>
>>>>> We have exactly those constellations within the BIOS settings table. 
>>>>> If I
>>>>> interpret the modalias line correctly, "pnAOA110" means "Product Name
>>>>> AOA110" and that's what we have already in the BIOS settings table. 
>>>>> So I
>>>>> think we do already have all information we need to create a 
>>>>> complete patch
>>>>> for the problem, or am I wrong?
>>>>
>>>> Right pn means that. I would strongly believe the above changes 
>>>> should be
>>>> good. I sometimes tend to be over-cautious. Attaching a refreshed patch
>>>> which includes them all.
>>>
>>> Well, acerhdf.c and dmi-id.c both do
>>> dmi_get_system_info(DMI_PRODUCT_NAME) when querying product name which
>>> means that the product names in the acerhdf table and the dmi-id ones
>>> are actually one and the same thing.
>>>
>>> IMO, we should just go ahead send it to Len. Stefan, you have my ACK.

Acked-by: Peter Feuerer <peter@piie.net>

Thank you Stefan!

regards,
--peter

-- 

When all other means of communication fail, try words!


