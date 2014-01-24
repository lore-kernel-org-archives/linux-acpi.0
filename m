From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 03/20] ARM64 / ACPI: Introduce the skeleton of _PDC related
 for ARM64
Date: Fri, 24 Jan 2014 23:35:27 +0800
Message-ID: <52E2883F.1070007@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org> <1389961514-13562-4-git-send-email-hanjun.guo@linaro.org> <20140123180335.GK27520@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140123180335.GK27520@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, "patches@linaro.org" <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Al Stone <al.stone@>
List-Id: linux-acpi@vger.kernel.org

Hi Catalin,

On 2014=E5=B9=B401=E6=9C=8824=E6=97=A5 02:03, Catalin Marinas wrote:
> On Fri, Jan 17, 2014 at 12:24:57PM +0000, Hanjun Guo wrote:
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -0,0 +1,32 @@
>> +/*
>> + *  Copyright (C) 2013, Al Stone <al.stone@linaro.org>
>> + *
>> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~
>> + *
>> + *  This program is free software; you can redistribute it and/or m=
odify
>> + *  it under the terms of the GNU General Public License as publish=
ed by
>> + *  the Free Software Foundation; either version 2 of the License, =
or
>> + *  (at your option) any later version.
>> + *
>> + *  This program is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *  GNU General Public License for more details.
>> + *
>> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~
>> + */
>> +
>> +#ifndef _ASM_ARM64_ACPI_H
>> +#define _ASM_ARM64_ACPI_H
> Nitpick: please use __ASM_ACPI_H as a guard for consistency (the same
> for all the other patches introducing new header files).

ok, will update this patch.

Hanjun
>
