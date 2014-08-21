From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v2 08/18] ARM64 / ACPI: Get the enable method for SMP
 initialization in ACPI way
Date: Thu, 21 Aug 2014 11:06:54 +0800
Message-ID: <53F5624E.3010102@linaro.org>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org> <1407166105-17675-9-git-send-email-hanjun.guo@linaro.org> <20140818142733.GT20043@localhost> <53F30B99.4000704@linaro.org> <20140820145219.GO24600@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:50649 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779AbaHUDI1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Aug 2014 23:08:27 -0400
Received: by mail-pa0-f44.google.com with SMTP id eu11so13479816pac.31
        for <linux-acpi@vger.kernel.org>; Wed, 20 Aug 2014 20:08:27 -0700 (PDT)
In-Reply-To: <20140820145219.GO24600@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <Mark.Rutland@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Will Deacon <Will.Deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 2014-8-20 22:52, Catalin Marinas wrote:
> On Tue, Aug 19, 2014 at 09:32:25AM +0100, Hanjun Guo wrote:
>> On 2014-8-18 22:27, Catalin Marinas wrote:
>>> On Mon, Aug 04, 2014 at 04:28:15PM +0100, Hanjun Guo wrote:
>>>> +#ifdef CONFIG_ACPI
>>>> +/*
>>>> + * Get a cpu's boot method in the ACPI way.
>>>> + */
>>>> +static char * __init acpi_get_cpu_boot_method(void)
>>>> +{
>>>> +	/*
>>>> +	 * For ACPI 5.1, only two kind of methods are provided,
>>>> +	 * Parking protocol and PSCI, but Parking protocol is
>>>> +	 * specified for ARMv7 only, so make PSCI as the only method
>>>> +	 * for SMP initialization before the ACPI spec or Parking
>>>> +	 * protocol spec is updated.
>>>> +	 */
>>>> +	switch (smp_boot_protocol()) {
>>>> +	case ACPI_SMP_BOOT_PSCI:
>>>> +		return "psci";
>>>> +	case ACPI_SMP_BOOT_PARKING_PROTOCOL:
>>>> +	default:
>>>> +		return NULL;
>>>> +	}
>>>> +}
>>>
>>> Actually, do we even need to define smp_boot_protocol()? Is it used
>>> anywhere else apart from this patch (I still haven't gone through all
>>> patches)?
>>
>> It is just used in this patch. I think we can make the ACPI boot protocol
>> scalable in this way, if we support another boot protocol in ACPI in the
>> future, we can easily update the function to support it, does it make sense?
> 
> Not really. You just add additional code, enums, functions when all you
> do is check for acpi_psci_present() (or whatever new protocol you would
> get). If the enum is never going to be used outside this file, don't
> bother with additional functions.
> 
> BTW, it would be nicer if the acpi related functions are contained in as
> fewer files as possible. So here you could keep
> acpi_get_cpu_boot_method() in the acpi.c file. It only returns a string.

ok, I will update them.

Thanks
Hanjun


