From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 01/12] ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE to
 enable this ACPI mode
Date: Wed, 27 Nov 2013 17:02:57 +0800
Message-ID: <5295B541.5070902@linaro.org>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org> <1384047382-20623-2-git-send-email-al.stone@linaro.org> <1AE640813FDE7649BE1B193DEA596E880248C95D@SHSMSX101.ccr.corp.intel.com> <528F2A4F.90908@linaro.org> <1AE640813FDE7649BE1B193DEA596E880248D23D@SHSMSX101.ccr.corp.intel.com> <1AE640813FDE7649BE1B193DEA596E880248D268@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:63151 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831Ab3K0JCw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Nov 2013 04:02:52 -0500
Received: by mail-pd0-f182.google.com with SMTP id v10so9544232pde.27
        for <linux-acpi@vger.kernel.org>; Wed, 27 Nov 2013 01:02:52 -0800 (PST)
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E880248D268@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "al.stone@linaro.org" <al.stone@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Al Stone <ahs3@redhat.com>

Hi Lv,

Sorry for the late reply, I have some comments below.

On 2013-11-25 16:14, Zheng, Lv wrote:
[...]
>>>>> +#ifdef CONFIG_ACPI_REDUCED_HARDWARE
>>>>> +#define ACPI_REDUCED_HARDWARE TRUE
>>>>> +#endif
>>>>> +
>>>>
>>>> Maybe you put this here because of my previous wrong comment.
>>>>
>>>> For ACPICA environments that work like Kconfigs for Linux, it is good to define them before including any ACPICA files.
>>>> While putting things here cannot cover <asm/acpi.h>.
>>>
>>> Good catch! thanks for the reminding.
>>>
>>>>
>>>> Normally, I will do:
>>>>
>>>> ...
>>>>
>>>> #ifdef __KERNEL__
>>>>
>>>> /* some comment */
>>>> (one empty line as ACPICA enforces 1 empty line after 1 line comment and no empty lines after a block of comments)
>>>> #ifdef CONFIG_ACPI_REDUCED_HARDWARE
>>>> #define ACPI_REDUCED_HARDWARE(spaces not tabs here according to ACPICA's coding style)TRUE
>>>> #endif
>>>>
>>>> #include <linux/string.h>
>>>
>>> There is a problem when I try yours suggestion, it is a compiling warning:
>>>
>>> warning: "TRUE" is not defined
>>>
>>> And I find that "TRUE" is defined in include/acpi/actypes.
>>>
>>> So, is this ok to you?
>>
>> ... How ugly the TRUE is.
>> OK, you can keep your original code as this is really not a real issue, just a tricky point.
>> I'll try to offer a cleanup after another ACPICA cleanup that tries to modify all "#if" condition related TRUE into "1" in ACPICA.
> 
> I checked ACPICA code base and found there is really nothing need to be cleaned up.
> 
> Why not:
> +#ifdef CONFIG_ACPI_REDUCED_HARDWARE
> +#define ACPI_REDUCED_HARDWARE 1
> +#endif

In include/acpi/acconfig.h:

#ifndef ACPI_REDUCED_HARDWARE
#define ACPI_REDUCED_HARDWARE           FALSE
#endif

In order to make the code consistent, I used "TRUE" here.

But it is ok to me to use "1" here, will update in next version.

Thanks
Hanjun
