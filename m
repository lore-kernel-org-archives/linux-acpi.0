From: Graeme Gregory <graeme.gregory@linaro.org>
Subject: Re: [PATCH v8 05/21] ACPI / sleep: Introduce sleep_arm.c
Date: Tue, 3 Feb 2015 16:18:22 +0000
Message-ID: <20150203161821.GB24474@xora-haswell.xora.org.uk>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-6-git-send-email-hanjun.guo@linaro.org>
 <1685897.h4vAPfoguo@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:61965 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965894AbbBCQSU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Feb 2015 11:18:20 -0500
Received: by mail-we0-f181.google.com with SMTP id k48so45959387wev.12
        for <linux-acpi@vger.kernel.org>; Tue, 03 Feb 2015 08:18:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1685897.h4vAPfoguo@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, phoenix.liyi@huawei.com, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, Mark Langsdorf <mlangsdo@redhat.com>, wangyijing@huaw

On Mon, Feb 02, 2015 at 11:18:24PM +0100, Rafael J. Wysocki wrote:
> On Monday, February 02, 2015 08:45:33 PM Hanjun Guo wrote:
> > From: Graeme Gregory <graeme.gregory@linaro.org>
> > 
> > ACPI 5.1 does not currently support S states for ARM64 hardware but
> > ACPI code will call acpi_target_system_state() for device power
> > managment, so introduce sleep_arm.c to allow other drivers to function
> > until S states are defined.
> > 
> > CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> > Tested-by: Yijing Wang <wangyijing@huawei.com>
> > Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> > Tested-by: Jon Masters <jcm@redhat.com>
> > Tested-by: Timur Tabi <timur@codeaurora.org>
> > Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> > Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> > Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> > ---
> >  drivers/acpi/Makefile    |  4 ++++
> >  drivers/acpi/sleep_arm.c | 28 ++++++++++++++++++++++++++++
> >  2 files changed, 32 insertions(+)
> >  create mode 100644 drivers/acpi/sleep_arm.c
> > 
> > diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> > index f74317c..bcec54e 100644
> > --- a/drivers/acpi/Makefile
> > +++ b/drivers/acpi/Makefile
> > @@ -23,7 +23,11 @@ acpi-y				+= nvs.o
> >  
> >  # Power management related files
> >  acpi-y				+= wakeup.o
> > +ifeq ($(ARCH), arm64)
> > +acpi-y				+= sleep_arm.o
> > +else # X86, IA64
> >  acpi-y				+= sleep.o
> > +endif
> >  acpi-y				+= device_pm.o
> >  acpi-$(CONFIG_ACPI_SLEEP)	+= proc.o
> >  
> > diff --git a/drivers/acpi/sleep_arm.c b/drivers/acpi/sleep_arm.c
> > new file mode 100644
> > index 0000000..54578ef
> > --- /dev/null
> > +++ b/drivers/acpi/sleep_arm.c
> > @@ -0,0 +1,28 @@
> > +/*
> > + *  ARM64 Specific Sleep Functionality
> > + *
> > + *  Copyright (C) 2013-2014, Linaro Ltd.
> > + *      Author: Graeme Gregory <graeme.gregory@linaro.org>
> > + *
> > + *  This program is free software; you can redistribute it and/or modify
> > + *  it under the terms of the GNU General Public License version 2 as
> > + *  published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/acpi.h>
> > +
> > +/*
> > + * Currently the ACPI 5.1 standard does not define S states in a
> > + * manner which is usable for ARM64. These two stubs are sufficient
> > + * that system initialises and device PM works.
> > + */
> > +u32 acpi_target_system_state(void)
> > +{
> > +	return ACPI_STATE_S0;
> > +}
> > +EXPORT_SYMBOL_GPL(acpi_target_system_state);
> > +
> > +int __init acpi_sleep_init(void)
> > +{
> > +	return -ENOSYS;
> > +}
> > 
> 
> Why does this need to be in drivers/acpi/ ?
> 
Sorry it doesn't it got left behind when we moved some other stuff.

Graeme

