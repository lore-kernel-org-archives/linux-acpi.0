From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH] ACPICA / hwreg: Use acpi_gbl_reduced_hardware to prevent
 accessing PM registers
Date: Mon, 16 Sep 2013 10:40:17 +0800
Message-ID: <52366F91.30204@linaro.org>
References: <1379066741-23689-1-git-send-email-hanjun.guo@linaro.org> <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEBC6A@ORSMSX103.amr.corp.intel.com> <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEC15B@ORSMSX103.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:36062 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932171Ab3IPCm0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Sep 2013 22:42:26 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so3473963pbc.21
        for <linux-acpi@vger.kernel.org>; Sun, 15 Sep 2013 19:42:25 -0700 (PDT)
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E36FEEC15B@ORSMSX103.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "'Rafael J. Wysocki'" <rjw@sisk.pl>, 'Len Brown' <lenb@kernel.org>, "Box, David E" <david.e.box@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, "'linux-acpi@vger.kernel.org'" <linux-acpi@vger.kernel.org>, "'patches@linaro.org'" <patches@linaro.org>, "'linaro-kernel@lists.linaro.org'" <linaro-kernel@lists.linaro.org>, "'linaro-acpi@lists.linaro.org'" <linaro-acpi@lists.linaro.org>

On 2013-9-14 4:16, Moore, Robert wrote:
> 
> 
>> -----Original Message-----
>> From: Moore, Robert
>> Sent: Friday, September 13, 2013 6:08 AM
>> To: Hanjun Guo; Rafael J. Wysocki; Len Brown
>> Cc: Zheng, Lv; linux-acpi@vger.kernel.org; patches@linaro.org; linaro-
>> kernel@lists.linaro.org; linaro-acpi@lists.linaro.org
>> Subject: RE: [PATCH] ACPICA / hwreg: Use acpi_gbl_reduced_hardware to
>> prevent accessing PM registers
>>
>> NOT_IMPLEMENTED refers to the software only; therefore AE_SUPPORT should
>> be returned.
>>
>> Otherwise, seems like this may be a good idea.
> 
> 
> On the other hand, could one not argue that the host OS should darn well know that
> it is executing on a hardware-reduced platform and not call these functions in the
> first place?

Well, there is a macro ACPI_REDUCED_HARDWARE and used to switch off the
compiling of these functions on hardware-reduced platform, if
ACPI_REDUCED_HARDWARE is TRUE, those functions will never be called.

But is that reasonable? When somebody want to use the ACPI code on
hardware-reduced platform, they should introduce a patch just like:

- #define ACPI_REDUCED_HARDWARE           FALSE
+ #define ACPI_REDUCED_HARDWARE           TRUE
in include/acpi/acconfig.h

and this patch does not exist in upstream, and it will never be accepted by
upstream too, it is weird. so we should proposal another way.

I thought about introducing a kernel config such as CONFIG_ACPI_REDUCED_HARDWARE
to enable ACPI_REDUCED_HARDWARE, but it is just the same as a macro, and I drop
it.

So, this is a problem should be solved for hardware-reduced platform, use falg
acpi_gbl_reduced_hardware seems a good solution.

Thanks
Hanjun

> 
> Bob

