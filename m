From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: Re: RFC: APEI hardware reduced profile
Date: Thu, 27 Mar 2014 10:05:42 +0100
Message-ID: <5333E9E6.6010701@linaro.org>
References: <5332C32A.5070301@linaro.org> <6220935.TPfvPdvLIs@vostro.rjw.lan> <20140326121047.65176d7e@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:32825 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834AbaC0JFm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Mar 2014 05:05:42 -0400
Received: by mail-ee0-f43.google.com with SMTP id e53so2580308eek.30
        for <linux-acpi@vger.kernel.org>; Thu, 27 Mar 2014 02:05:41 -0700 (PDT)
In-Reply-To: <20140326121047.65176d7e@samsung.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mauro Carvalho Chehab <m.chehab@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linaro-acpi <linaro-acpi@lists.linaro.org>, Tony <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>, linux-edac@vger.kernel.org, x86@kernel.org

On 03/26/14 16:10, Mauro Carvalho Chehab wrote:
> Em Wed, 26 Mar 2014 15:55:07 +0100
> "Rafael J. Wysocki" <rjw@rjwysocki.net> escreveu:
>
>> On Wednesday, March 26, 2014 01:08:10 PM Tomasz Nowicki wrote:
>>> Hi,
>>
>> Hi,
>>
>> This is a question for Tony, Boris and Mauro (CCed now).
>>
>>> Currently APEI depends on x86 architecture. It is because of many x86
>>> specific features like "IA-32 Architecture Corrected Machine Check
>>> " error source or NMI hardware error notification. However, many other
>>> features like "PCI Express Device AER Structure" or GHES via external
>>> interrupt can be still used perfectly by other architectures. So my idea
>>> is to move x86 dependency away form Kconfig to APEI areas where it
>>> really applies to.
>>>
>>> I have started refactoring ghes.c driver in that direction. And here
>>> comes my confusion, how should we treat x86 related parts, as fixed
>>> profile? (which means we could use ACPI_REDUCED_HARDWARE or
>>> CONFIG_ACPI_REDUCED_HARDWARE_ONLY define). I would like to ask for your
>>> opinion.
>
> That's a good question, and probably depends on how are you mapping the
> ACPI changes. For example, are you moving acpi out of /arch?
>
> As I answered to a similar questioning, IMHO, the better would be to
> have the hardware error report mechanisms on /drivers/ras, and have
> there some Kconfig items that would depend on X86 to enable certain
> drivers.
>
> Also, I don't like to have something like ACPI_REDUCED_foo. IMHO, the
> better would be to do the reverse: to have Kconfig symbols enabling the
> extra X86-specific functionality, and have them mapped into separate
> files/drivers, with proper KConfig names, like ACPI_X86 or ACPI_X86_NMI.
>
> Yet, it would be better if you could be a little more specific about
> what are your plans and what are the common/not-common features that
> you're mapping.

Yes and sorry, I should have been more specific here.

After scanning APEI code it seems like NMI notification of GHES implies 
APEI x86 dependency for Kconfig, so I am targeting ghes.c.

I agree that ACPI_REDUCED_foo is not suitable for that purpose. However, 
ACPI_X86_NMI sounds good to me. I also have been thinking of moving NMI 
code (from ghes.c) to separate file but NMI and IRQ context are tightly 
coupled. That convinced me to leave it in ghes.c for now but I need to 
look at it closer.

Thanks,
Tomasz
