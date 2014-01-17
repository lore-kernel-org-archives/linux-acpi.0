From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: Re: [PATCH 12/20] ARM64 / ACPI: Use Parked Address in GIC structure
 for spin table SMP initialisation
Date: Fri, 17 Jan 2014 15:35:43 +0100
Message-ID: <52D93FBF.2010609@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org> <1389961514-13562-13-git-send-email-hanjun.guo@linaro.org> <201401171515.21250.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:55577 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbaAQOgD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Jan 2014 09:36:03 -0500
Received: by mail-we0-f175.google.com with SMTP id p61so4528154wes.6
        for <linux-acpi@vger.kernel.org>; Fri, 17 Jan 2014 06:36:01 -0800 (PST)
In-Reply-To: <201401171515.21250.arnd@arndb.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Hanjun Guo <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org, Charles.Garcia-Tobin@arm.com

On 01/17/14 15:15, Arnd Bergmann wrote:
> On Friday 17 January 2014, Hanjun Guo wrote:
>> +/* Parked Address in ACPI GIC structure */
>> +static u64 parked_address[NR_CPUS];
>
> Please use the per_cpu infrastructure rather than NR_CPUS long arrays.
Actually, per_cpu areas are initialized a bit later. If we really want 
to use here per_cpu, then we need to implement early_per_cpu 
Frankenstein like x86 does.

Tomasz
