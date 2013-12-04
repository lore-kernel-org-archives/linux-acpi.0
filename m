From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [RFC part1 PATCH 1/7] ACPI: Make ACPI core running without PCI
 on ARM64
Date: Wed, 04 Dec 2013 22:08:47 +0800
Message-ID: <529F376F.8050005@linaro.org>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org> <1386088611-2801-2-git-send-email-hanjun.guo@linaro.org> <20131203164111.GA13447@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:40344 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932320Ab3LDOJB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Dec 2013 09:09:01 -0500
Received: by mail-pd0-f178.google.com with SMTP id y10so22536597pdj.9
        for <linux-acpi@vger.kernel.org>; Wed, 04 Dec 2013 06:09:00 -0800 (PST)
In-Reply-To: <20131203164111.GA13447@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@linaro.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <rob.herring@calxeda.com>, Mark Rutland <mark.rutland@arm.com>, Jon Masters <jonathan@jonmasters.org>, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>

On 2013=E5=B9=B412=E6=9C=8804=E6=97=A5 00:41, Matthew Garrett wrote:
> Given the number of #ifdefs you're adding, wouldn't it make more sens=
e
> to just add stub functions to include/linux/pci.h?

Thanks for the suggestion :)

I can add stub functions in include/linux/pci.h for raw_pci_read()/
raw_pci_write(), then can remove #ifdefs for acpi_os_read/write_pci_con=
figuration().

Thanks
Hanjun

>

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
