From: Al Stone <al.stone@linaro.org>
Subject: Re: [PATCH v2 0/6] Hardware Reduced Mode cleanup for ACPI
Date: Fri, 22 Nov 2013 16:33:38 -0700
Message-ID: <528FE9D2.4050806@linaro.org>
References: <1385080915-23430-1-git-send-email-al.stone@linaro.org> <1706311.28Hh6vagbz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:61441 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756141Ab3KVXdk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Nov 2013 18:33:40 -0500
Received: by mail-ie0-f178.google.com with SMTP id lx4so3282479iec.37
        for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2013 15:33:40 -0800 (PST)
In-Reply-To: <1706311.28Hh6vagbz@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, linaro-kernel@lists.linaro.org, Olof Johansson <olof@lixom.net>

On 11/22/2013 04:18 PM, Rafael J. Wysocki wrote:
> On Thursday, November 21, 2013 05:41:49 PM al.stone@linaro.org wrote:
>> From: Al Stone <al.stone@linaro.org>
>>
>> This series of patches starts with Hanjun's patch to create a kernel
>> config item for CONFIG_ACPI_REDUCED_HARDWARE [0].  Building on that, I
>> then reviewed all of the code that touched any of several fields in the
>> FADT that the OSPM is supposed to ignore when ACPI is in Hardware Reduced
>> mode [1].  Any time there was a use of one of the fields to be ignored,
>> I evaluated whether or not the code was implementing Hardware Reduced
>> mode correctly.  Similarly, for each the flags in the FADT flags field
>> that are to be ignored in Hardware Reduced mode, the kernel code was again
>> scanned for proper usage.  The remainder of the patches are to fix all of
>> the situations I could find where the kernel would not behave correctly
>> in this ACPI mode.
>>
>> These seem to work just fine on the RTSM model for ARMv7, both with and
>> without ACPI enabled, and with and without ACPI_REDUCED_HARDWARE enabled;
>> similarly for the FVP model for ARMv8.  The patches for ACPI on ARM
>> hardware will be coming later but they presume that reduced HW mode is
>> functioning correctly.  In the meantime, there's no way I can think of
>> to test all possible scenarios so feedback would be greatly appreciated.
>>
>>
>> [0] List at https://wiki.linaro.org/LEG/Engineering/Kernel/ACPI/AcpiReducedHw#Section_5:_ACPI_Software_Programming_Model
>> [1] Please see the ACPI Specification v5.0 for details on Hardware Reduced
>>      mode.
>>
>>
>> Changes for v2:
>>     -- Remove patch that was outside of reduced HW mode changes
>>     -- Simplify CONFIG_ACPI_REDUCED_HARDWARE in Kconfig
>>     -- Simplify use of CONFIG_ACPI_REDUCED_HARDWARE in #ifdefs
>>     -- Ensure changelogs are present
>>     -- Combine and simplify previous patches 8 & 10
>>
>>
>> Al Stone (6):
>>    ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE to enable this ACPI mode
>>    ACPI: bus master reload not supported in reduced HW mode
>>    ACPI: HW reduced mode does not allow use of the FADT sci_interrupt
>>      field
>>    ACPI: ARM: exclude DMI calls
>>    ACPI: do not reserve memory regions for some FADT entries in HW
>>      reduced mode
>>    ACPI: in HW reduced mode, using FADT PM information is not allowed.
>
> As Olof noted in another thread, all ACPI patches related to ARM should be
> CCed to linux-arm-kernel.
>
> Can you please do that in the future?
>
> Rafael
>

Of course.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone@linaro.org
-----------------------------------
