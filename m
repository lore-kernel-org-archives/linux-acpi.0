From: Al Stone <al.stone@linaro.org>
Subject: Re: [PATCH] ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE_ONLY to
 enforce this ACPI mode
Date: Thu, 16 Jan 2014 11:35:29 -0700
Message-ID: <52D82671.6000200@linaro.org>
References: <1389731822-21336-1-git-send-email-al.stone@linaro.org> <15081767.3kxW799CSQ@wuerfel> <52D7414C.7080206@linaro.org> <201401161155.27592.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:42310 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbaAPSfb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Jan 2014 13:35:31 -0500
Received: by mail-pa0-f49.google.com with SMTP id hz1so3001604pad.8
        for <linux-acpi@vger.kernel.org>; Thu, 16 Jan 2014 10:35:30 -0800 (PST)
In-Reply-To: <201401161155.27592.arnd@arndb.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linaro-kernel@lists.linaro.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hanjun Guo <hanjun.guo@linaro.org>, patches@linaro.org, linaro-acpi@lists.linaro.org

On 01/16/2014 03:55 AM, Arnd Bergmann wrote:
> On Thursday 16 January 2014, Al Stone wrote:
>> On 01/14/2014 02:26 PM, Arnd Bergmann wrote:
>>> On Tuesday 14 January 2014 13:37:02 al.stone@linaro.org wrote:
>>>> +config ACPI_REDUCED_HARDWARE_ONLY
>>>> +       bool "Hardware-reduced ACPI support only"
>>>> +       def_bool n
>>>> +       depends on ACPI && EXPERT
>>>
>>> I think this will cause a Kconfig warning if you try to select this
>>> on ARM64 without turning on EXPERT as well.
>>>
>>> It should be ok if you express it as
>>>
>>> config ACPI_REDUCED_HARDWARE_ONLY
>>>          bool "Hardware-reduced ACPI support only" if EXPERT
>>>          def_bool n
>>>          depends on ACPI
>>>
>>>
>>>        Arnd
>>>
>>
>> I am very puzzled.  I went back and re-did my configs from
>> before, tried a few new ones, and tried with both expressions
>> above, but I could not get a Kconfig warning.  Do you have an
>> example .config that shows the warning?
>>
>
> I don't have a source tree that allows turning on ACPI on arm64
> to easily test this. To clarify: the warning will only happen if
> you also add this piece to arch/arm64/Kconfig:
>
> 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>
> 	Arnd
>

Right; I assumed I had to have that SELECT.  My apologies -- I
still cannot reproduce the warning.  I'll resubmit the patch
incorporating the suggestion, though, since the result ends up
being the same -- you must have ACPI and EXPERT selected in order
to enable ACPI_REDUCED_HARDWARE_ONLY.

Thanks.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone@linaro.org
-----------------------------------
