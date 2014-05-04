From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v3 part1 02/11] ARM64 / ACPI: Introduce the skeleton of
 _PDC related for ARM64
Date: Sun, 04 May 2014 16:58:12 +0800
Message-ID: <53660124.6020604@linaro.org>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>	<1398432017-8506-3-git-send-email-hanjun.guo@linaro.org> <20140429093941.02167C4095B@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:43084 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282AbaEDI6i (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 May 2014 04:58:38 -0400
Received: by mail-pd0-f179.google.com with SMTP id g10so4673345pdj.10
        for <linux-acpi@vger.kernel.org>; Sun, 04 May 2014 01:58:38 -0700 (PDT)
In-Reply-To: <20140429093941.02167C4095B@trevor.secretlab.ca>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Olof Johansson <olof@lixom.net>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, Charles.Garcia-Tobin@arm.com, linaro-acpi@lists.linaro.org, Al Stone <al.stone@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>

On 2014-4-29 17:39, Grant Likely wrote:
> On Fri, 25 Apr 2014 21:20:08 +0800, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> The _PDC (Processor Driver Capabilities) object provides OSPM a
>> mechanism to convey to the platform the capabilities supported
>> by OSPM for processor power management.
>>
>> OSPM evaluates _PDC prior to evaluating any other processor
>> power management objects returning configuration information.
>>
>> This patch introduces the skeleton of _PDC related file to make
>> ACPI core can be compiled on ARM64, and should be revisited when
>> implementing CPU power control.
>>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  arch/arm64/include/asm/acpi.h |   37 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 37 insertions(+)
>>  create mode 100644 arch/arm64/include/asm/acpi.h
>>
>> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
>> new file mode 100644
>> index 0000000..e3e990e
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -0,0 +1,37 @@
>> +/*
>> + *  Copyright (C) 2013~2014, Al Stone <al.stone@linaro.org>
> 
> Not really a correct copyright assignement. The copyright is held by
> Linaro, but the author is Al. It should instead read:
> 
>  * Copyright (C0 2013-2014, Linaro Ltd.
>  * Author: Al Stone <al.stone@linaro.org>
> 
> Acked-by: Grant Likely <grant.likely@linaro.org>

We will update this patch accordingly.

Thanks
Hanjun

