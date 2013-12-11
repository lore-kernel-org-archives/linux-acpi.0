From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC part2 PATCH 8/9] ACPI / ARM64: Update acpi_register_gsi to register with the core IRQ subsystem
Date: Wed, 11 Dec 2013 06:23:04 +0100
Message-ID: <201312110623.04341.arnd@arndb.de>
References: <1385999094-3152-1-git-send-email-hanjun.guo@linaro.org> < 1385999094-3152-9-git-send-email-hanjun.guo@linaro.org> <20131210130521.3FE89C40A27@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:55536 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719Ab3LKFXg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Dec 2013 00:23:36 -0500
In-Reply-To: <20131210130521.3FE89C40A27@trevor.secretlab.ca>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Grant Likely <grant.likely@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Mark Rutland <mark.rutland@arm.com>, Matthew Garrett <mjg59@srcf.ucam.org>, linaro-kernel@lists.linaro.org, patches@linaro.org, linaro-acpi@lists.linaro.org, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, linux-acpi@vger.kernel.org, Amit Daniel Kachhap <amit.daniel@samsung.com>, Olof Johansson <olof@lixom.net>, Bjorn Helgaas <bhelgaas@google.com>

On Tuesday 10 December 2013, Grant Likely wrote:
> > --- a/drivers/acpi/plat/arm-core.c
> > +++ b/drivers/acpi/plat/arm-core.c
> > @@ -90,7 +90,7 @@ enum acpi_irq_model_id acpi_irq_model = ACPI_IRQ_MODEL_GIC;
> >  
> >  static unsigned int gsi_to_irq(unsigned int gsi)
> >  {
> > -     int irq = irq_create_mapping(NULL, gsi);
> > +     int irq = irq_find_mapping(NULL, gsi);
> 
> I suspect this will break FDT users that depend on the old behaviour.

I think not, given this is only in drivers/acpi and gets added in one
of the prior patches of the same series.

	Arnd
