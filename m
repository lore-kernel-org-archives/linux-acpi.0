From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [RFC part2 PATCH 8/9] ACPI / ARM64: Update acpi_register_gsi
 to register with the core IRQ subsystem
Date: Thu, 05 Dec 2013 22:01:28 +0800
Message-ID: <52A08738.8060701@linaro.org>
References: <1386088753-2850-1-git-send-email-hanjun.guo@linaro.org> <1386088753-2850-9-git-send-email-hanjun.guo@linaro.org> <201312050448.10312.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:60779 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699Ab3LEOBv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Dec 2013 09:01:51 -0500
Received: by mail-pd0-f180.google.com with SMTP id q10so24641721pdj.39
        for <linux-acpi@vger.kernel.org>; Thu, 05 Dec 2013 06:01:50 -0800 (PST)
In-Reply-To: <201312050448.10312.arnd@arndb.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Matthew Garrett <mjg59@srcf.ucam.org>, linaro-kernel@lists.linaro.org, patches@linaro.org, Linus Walleij <linus.walleij@linaro.org>, Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org, Amit Daniel Kachhap <amit.daniel@samsung.com>, Jon Masters <jonathan@jonmasters.org>, Grant Likely <grant.likely@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>

On 2013=E5=B9=B412=E6=9C=8805=E6=97=A5 11:48, Arnd Bergmann wrote:
> On Tuesday 03 December 2013, Hanjun Guo wrote:
>> +       /*
>> +        * ACPI have no bindings to indicate SPI or PPI, so we
>> +        * use different mappings from DT in ACPI.
>> +        *
>> +        * For FDT
>> +        * PPI interrupt: in the range [0, 15];
>> +        * SPI interrupt: in the range [0, 987];
>> +        *
>> +        * For ACPI, using identity mapping for hwirq:
>> +        * PPI interrupt: in the range [16, 31];
>> +        * SPI interrupt: in the range [32, 1019];
> This difference might cause endless confusion. Can't you register PPI=
 and SPI as
> separate IRQ controllers to have the same number space that we normal=
ly have?

In ACPI, they used a conception named GSI (Global System Interrupts)
for irq, GSI number can not be the same even if there are muti GICs,
so I use the identity mapping for hwirq for ACPI.

Thanks you very much for your comments :)

Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
