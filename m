From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH v3 part1 06/11] ARM64 / ACPI: Introduce
 lowlevel suspend function
Date: Tue, 29 Apr 2014 16:46:33 +0800
Message-ID: <535F66E9.3030307@linaro.org>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org> <1398432017-8506-7-git-send-email-hanjun.guo@linaro.org> <20140428152240.GD31782@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:60898 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbaD2Iq4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2014 04:46:56 -0400
Received: by mail-pa0-f53.google.com with SMTP id ld10so6811656pab.12
        for <linux-acpi@vger.kernel.org>; Tue, 29 Apr 2014 01:46:56 -0700 (PDT)
In-Reply-To: <20140428152240.GD31782@e102568-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>, Olof Johansson <olof@lixom.net>

Hi Lorenzo,

On 2014-4-28 23:22, Lorenzo Pieralisi wrote:
> On Fri, Apr 25, 2014 at 02:20:12PM +0100, Hanjun Guo wrote:
>> acpi_wakeup_address is used on x86 as the address bios jumps into
>> when machine wakes up from suspend. As arm64 does not have such a
>> bios this mechanism will be provided by other means. But the define
>> is still required inside the acpi core.
>>
[...]
>>  #define cpu_physical_id(cpu) -1
>>  
>> +/* Low-level suspend routine. */
>> +extern int (*acpi_suspend_lowlevel)(void);
>> +#define acpi_wakeup_address (0)
> 
> I understand you want code to compile, but as I mentioned in another
> thread, I would focus more on understanding if these macros/hooks are
> really needed for ARM rather than defining them _just_ to make code
> compile. The fact that you are forced to define them makes me think
> there is something to be changed in ACPI core code instead of adding
> empty and probably useless macros/hooks for ARM which I have no idea
> whatsoever whether will ever be needed or not.

Ok, we will deep into ACPI core to find out how to handle it, thanks
for your suggestion.

Hanjun

