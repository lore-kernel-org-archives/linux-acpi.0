From: "Mani, Rajmohan" <rajmohan.mani@intel.com>
Subject: RE: [PATCH v5 0/3] TPS68470 PMIC drivers
Date: Mon, 21 Aug 2017 22:58:27 +0000
Message-ID: <6F87890CF0F5204F892DEA1EF0D77A5972FA69A3@FMSMSX114.amr.corp.intel.com>
References: <1500648378-10294-1-git-send-email-rajmohan.mani@intel.com>
 <3425487.LgIRMVflim@aspire.rjw.lan>
 <CAHp75VdtEh8MAFjQN2LWVFbJj7_bPrhjo77SEsCYVmuOCWvOfQ@mail.gmail.com>
 <2076994.J7nKrPWSDx@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:63303 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751575AbdHUW63 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 21 Aug 2017 18:58:29 -0400
In-Reply-To: <2076994.J7nKrPWSDx@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Len Brown <lenb@kernel.org>, "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>

Hi Andy,

> > >> > This is the patch series for TPS68470 PMIC that works as a camera PMIC.
> > >> >
> > >> > The patch series provide the following 3 drivers, to help configure the
> voltage regulators, clocks and GPIOs provided by the TPS68470 PMIC, to be
> able to use the camera sensors connected to this PMIC.
> > >> >
> > >> > TPS68470 MFD driver:
> > >> > This is the multi function driver that initializes the TPS68470 PMIC and
> supports the GPIO and Op Region functions.
> > >> >
> > >> > TPS68470 GPIO driver:
> > >> > This is the PMIC GPIO driver that will be used by the OS GPIO layer,
> when the BIOS / firmware triggered GPIO access is done.
> > >> >
> > >> > TPS68470 Op Region driver:
> > >> > This is the driver that will be invoked, when the BIOS / firmware
> configures the voltage / clock for the sensors / vcm devices connected to the
> PMIC.
> > >> >
> > >>
> > >> All three patches are good to me (we did few rounds of internal
> > >> review before posting v4)
> > >>
> > >> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > >
> > > OK, so how should they be routed?
> >
> > Good question. I don't know how last time PMIC drivers were merged,
> > here I think is just sane to route vi MFD with immutable branch
> > created.
> 
> OK
> 
> I will assume that the series will go in through MFD then.
> 

Now that the MFD and GPIO patches of v6 of this series have been applied on respective trees, can you advise the next steps for the ACPI / PMIC Opregion driver?

Thanks
Raj
