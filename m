From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC part1 PATCH 5/7] ARM64 / ACPI: Introduce arm_core.c and its related head file
Date: Thu, 5 Dec 2013 04:38:04 +0100
Message-ID: <201312050438.05117.arnd@arndb.de>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org> <1386088611-2801-6-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:64589 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620Ab3LEDiu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Dec 2013 22:38:50 -0500
In-Reply-To: <1386088611-2801-6-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Hanjun Guo <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Matthew Garrett <mjg59@srcf.ucam.org>, linaro-kernel@lists.linaro.org, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, patches@linaro.org, Linus Walleij <linus.walleij@linaro.org>, Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org, Jon Masters <jonathan@jonmasters.org>, Grant Likely <grant.likely@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>

On Tuesday 03 December 2013, Hanjun Guo wrote:
> +static unsigned int gsi_to_irq(unsigned int gsi)
> +{
> +       int irq = irq_create_mapping(NULL, gsi);
> +
> +       return irq;
> +}

I think this could use a comment regarding your plans for IRQ domains.

Do you expect that all ACPI systems would have only a single GIC IRQ
controller and a single domain, or do you plan to add irqdomain code
later?

	Arnd
