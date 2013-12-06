From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: Re: [Linaro-acpi] [RFC part1 PATCH 1/7] ACPI: Make ACPI core running
 without PCI on ARM64
Date: Fri, 06 Dec 2013 16:04:52 +0100
Message-ID: <52A1E794.1040008@linaro.org>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org> <20131203164111.GA13447@srcf.ucam.org> <529F376F.8050005@linaro.org> <201312052304.22302.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201312052304.22302.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Bjorn Helgaas <bhelgaas@google.com>, linaro-kernel@lists.linaro.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, patches@linaro.org, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org, Olof Johansson <olof@lixom.net>, Rob Herring <rob.herring@calxeda.com>
List-Id: linux-acpi@vger.kernel.org

On 05.12.2013 23:04, Arnd Bergmann wrote:
> On Wednesday 04 December 2013, Hanjun Guo wrote:
>> On 2013=E5=B9=B412=E6=9C=8804=E6=97=A5 00:41, Matthew Garrett wrote:
>>> Given the number of #ifdefs you're adding, wouldn't it make more se=
nse
>>> to just add stub functions to include/linux/pci.h?
>>
>> Thanks for the suggestion :)
>>
>> I can add stub functions in include/linux/pci.h for raw_pci_read()/
>> raw_pci_write(), then can remove #ifdefs for acpi_os_read/write_pci_=
configuration().
>
> Actually I wonder about the usefulness of this patch in either form: =
Since ACPI
> on ARM64 is only for servers, I would very much expect them to always=
 come with
> PCI, either physical host bridges with attached devices, or logical P=
CI functions
> used to describe the on-SoC I/O devices. Even in case of virtual mach=
ines, you'd
> normally use PCI as the method to communicate data about the virtio c=
hannels.
>
> Can you name a realistic use-case where you'd want ACPI but not PCI?

Yes you can describe SoC I/O devices using logical PCI functions only i=
f=20
they are on PCI, correct me if I am wrong. Also, devices can be placed=20
only on IOMEM (like for ARM SoC) and it is hard to predict which way=20
vendors chose. So way don't let it be configurable? ACPI spec says=20
nothing like PCI is needed for ACPI, AFAIK.

Tomasz
