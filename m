From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 18/20] clocksource / acpi: Add macro CLOCKSOURCE_ACPI_DECLARE
Date: Mon, 20 Jan 2014 17:08:32 +0800
Message-ID: <52DCE790.6080809@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org> <1389961514-13562-19-git-send-email-hanjun.guo@linaro.org> <201401171521.35940.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:45728 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083AbaATJIs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Jan 2014 04:08:48 -0500
Received: by mail-pb0-f50.google.com with SMTP id rq2so6733836pbb.23
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jan 2014 01:08:47 -0800 (PST)
In-Reply-To: <201401171521.35940.arnd@arndb.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org, Charles.Garcia-Tobin@arm.com, Amit Daniel Kachhap <amit.daniel@samsung.com>

On 2014-1-17 22:21, Arnd Bergmann wrote:
> On Friday 17 January 2014, Hanjun Guo wrote:
>>
>> From: Amit Daniel Kachhap <amit.daniel@samsung.com>
>>
>> This macro does the same job as CLOCKSOURCE_OF_DECLARE. The device
>> name from the ACPI timer table is matched with all the registered
>> timer controllers and matching initialisation routine is invoked.
> 
> I wouldn't anticipate this infrastructure to be required. Shouldn't all
> ARMv8 machines have an architected timer?

I not sure of this, could anyone can give some guidance? if only arch
timer is available for ARM64, this will make thing very simple.

Thanks
Hanjun
