From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC part1 PATCH 1/7] ACPI: Make ACPI core running without PCI on ARM64
Date: Thu, 5 Dec 2013 23:04:22 +0100
Message-ID: <201312052304.22302.arnd@arndb.de>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org> <20131203164111.GA13447@srcf.ucam.org> <529F376F.8050005@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:60565 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025Ab3LEWFZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Dec 2013 17:05:25 -0500
In-Reply-To: <529F376F.8050005@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, linaro-kernel@lists.linaro.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Al Stone <al.stone@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, patches@linaro.org, Olof Johansson <olof@lixom.net>, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@linaro.org>, Jon Masters <jonathan@jonmasters.org>, Bjorn Helgaas <bhelgaas@google.com>

On Wednesday 04 December 2013, Hanjun Guo wrote:
> On 2013=E5=B9=B412=E6=9C=8804=E6=97=A5 00:41, Matthew Garrett wrote:
> > Given the number of #ifdefs you're adding, wouldn't it make more se=
nse
> > to just add stub functions to include/linux/pci.h?
>=20
> Thanks for the suggestion :)
>=20
> I can add stub functions in include/linux/pci.h for raw_pci_read()/
> raw_pci_write(), then can remove #ifdefs for acpi_os_read/write_pci_c=
onfiguration().

Actually I wonder about the usefulness of this patch in either form: Si=
nce ACPI
on ARM64 is only for servers, I would very much expect them to always c=
ome with
PCI, either physical host bridges with attached devices, or logical PCI=
 functions
used to describe the on-SoC I/O devices. Even in case of virtual machin=
es, you'd
normally use PCI as the method to communicate data about the virtio cha=
nnels.

Can you name a realistic use-case where you'd want ACPI but not PCI?

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
