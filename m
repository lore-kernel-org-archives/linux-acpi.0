From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH] ACPICA / hwreg: Use acpi_gbl_reduced_hardware to prevent
 accessing PM registers
Date: Sun, 22 Sep 2013 10:50:53 +0800
Message-ID: <523E5B0D.3010104@linaro.org>
References: <1379066741-23689-1-git-send-email-hanjun.guo@linaro.org> <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEBC6A@ORSMSX103.amr.corp.intel.com> <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEC15B@ORSMSX103.amr.corp.intel.com> <52366F91.30204@linaro.org> <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEC56A@ORSMSX103.amr.corp.intel.com> <523972F4.9070703@linaro.org> <94F2FBAB4432B54E8AACC7DFDE6C92E36FEFA437@ORSMSX102.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:49008 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596Ab3IVCxN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Sep 2013 22:53:13 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so2218186pab.13
        for <linux-acpi@vger.kernel.org>; Sat, 21 Sep 2013 19:53:12 -0700 (PDT)
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E36FEFA437@ORSMSX102.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, "'Rafael J. Wysocki'" <rjw@sisk.pl>
Cc: 'Len Brown' <lenb@kernel.org>, "Box, David E" <david.e.box@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, "'linux-acpi@vger.kernel.org'" <linux-acpi@vger.kernel.org>, "'patches@linaro.org'" <patches@linaro.org>, "'linaro-kernel@lists.linaro.org'" <linaro-kernel@lists.linaro.org>, "'linaro-acpi@lists.linaro.org'" <linaro-acpi@lists.linaro.org>

Hi Bob,

Sorry for the late reply, I had being on holiday last few days.

On 2013-9-18 23:09, Moore, Robert wrote:
> 
> 
>> -----Original Message-----
>> From: Hanjun Guo [mailto:hanjun.guo@linaro.org]
>> Sent: Wednesday, September 18, 2013 2:32 AM
>> To: Moore, Robert
>> Cc: 'Rafael J. Wysocki'; 'Len Brown'; Box, David E; Zheng, Lv; 'linux-
>> acpi@vger.kernel.org'; 'patches@linaro.org'; 'linaro-
>> kernel@lists.linaro.org'; 'linaro-acpi@lists.linaro.org'
>> Subject: Re: [PATCH] ACPICA / hwreg: Use acpi_gbl_reduced_hardware to
>> prevent accessing PM registers
>>
>> On 2013-9-17 1:26, Moore, Robert wrote:
>>> + #define ACPI_REDUCED_HARDWARE           TRUE
>>>
>>> The intent of this feature is of course, to remove all code that is not
>> needed -- specifically for hardware-reduced machines where the size of the
>> kernel is important.
>>>
>>> On a larger machine, the hardware-reduced flag should be sufficient.
>> However, I would think that the host OS would look at this flag and
>> realize that it should not be doing certain ACPI hardware-related things
>> up front, rather than later when it finds out that a write to some ACPI
>> hardware fails because the hardware isn't there.
>>
>> Do you mean we should change the ACPI device driver instead of changing
>> the ACPICA code? that would be a hard job, because hardware ACPI is used
>> everywhere.
>>
> 
> 
> I don't really know the answer to this, but something tells me that bad things 
> may happen when a driver expects the ACPI hardware to be there, and it finds 
> out that it isn't, simply by calling one of the ACPI hardware interfaces.
> 
> Or, we could word it this way: if a driver is expecting the ACPI hardware to 
> exist, and we are running on a hardware-reduced platform, why is the driver
> being loaded in the first place?

ok, that would be a reasonable solution.

Oh, things get complicated now, could some linux experts have comments here
please?

> 
> BTW, hardware-reduced is not restricted to ARM platforms.

Thanks for reminding, may be some other platforms (not only x86, IA64, ARM)
will use ACPI in the future.

Thanks
Hanjun

> 

