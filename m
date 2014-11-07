From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: Re: [Linaro-acpi] [RFC PATCH 3/4] arm64, acpi, pci: Add arch specific
 functions for mmconfig driver.
Date: Fri, 07 Nov 2014 15:39:32 +0100
Message-ID: <545CD9A4.3080900@linaro.org>
References: <1415366876-30811-1-git-send-email-tomasz.nowicki@linaro.org> <1415366876-30811-4-git-send-email-tomasz.nowicki@linaro.org> <16660879.6KxQndPqBW@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:43301 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbaKGOjl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Nov 2014 09:39:41 -0500
Received: by mail-wg0-f49.google.com with SMTP id x13so3847502wgg.22
        for <linux-acpi@vger.kernel.org>; Fri, 07 Nov 2014 06:39:40 -0800 (PST)
In-Reply-To: <16660879.6KxQndPqBW@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linaro-acpi@lists.linaro.org
Cc: catalin.marinas@arm.com, will.deacon@arm.com, bhelgaas@google.com, Liviu.Dudau@arm.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net, linux-pci@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 07.11.2014 15:12, Arnd Bergmann wrote:
> On Friday 07 November 2014 14:27:55 Tomasz Nowicki wrote:
>> These calls allow to map/unmap PCI config space ranges (which are specified in
>> MMCFG ACPI table).
>>
>> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>
>
> Nothing in this patch looks arm64 specific, and most of it looks like a
> copy of the x86 code.

Yes, most of the logic was borrowed from mmconfig_64.c file, 
mmconfig_32.c looks differently, though. It is not simple to merge them 
both. IMO, we have two choices:
1. Refactor and move mmconfig_64.c out of x86 to e.g. drivers/acpi/ and 
let it be default.
2. Stay with solution presented in this patch.
3. Thoughts ?

Regards,
Tomasz
