From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 0/3] Dollar Cove TI PMIC support for Intel Cherry Trail
Date: Thu, 24 Aug 2017 12:27:32 +0300
Message-ID: <CAHp75VetbVbe15eCzuzyXHx-t-oWZDEEw4PLu4YKg94fvhpDmw@mail.gmail.com>
References: <20170824081141.5018-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35226 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbdHXJ1d (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Aug 2017 05:27:33 -0400
In-Reply-To: <20170824081141.5018-1-tiwai@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, Aug 24, 2017 at 11:11 AM, Takashi Iwai <tiwai@suse.de> wrote:
> Hi,
>
> this is the revised patch set to add the support for Dollar Cove TI
> PMIC found on some Intel Cherry Trail laptops / tablets.  All drivers
> are based on the original code from Intel downstream patches, with
> lots of rewrites and cleanups.  MFD driver is implemented as a
> stand-alone like a few other variants, and the input driver got a diet
> in a minimalistic form.
>
> The patch set has been tested on ASUS E100H and E200H, as well as on
> HP x210.
>
> v1->v2:
> - Minor cleanups in mfd driver code as suggested by Andy
> - Move power-button driver to platform/x86, driver renames accordingly
> - Add missing wake-irq cleanup to power-button driver
> - get_raw_temp cleanup in opregion driver, mention about register
>   endianess
>
>

Global comment to the series, we agreed with Hans to follow the
pattern for Intel PMIC driver (module / file) names:

intel_XXX_<PLATFORM><PMIC>, where <PLATFORM> is 3 letter encoded Intel
platform name, like cht for CherryTrail and <PMIC> is two letter
abbreviation from ZZZ Cove, like wc for Whiskey Cove.

Here I understand that there is a potential of two PMIC variants for
the same platform DC from Intel, DC from TI. I dunno if former will be
a case in the future, though we may use something like

 intel_XXX_chtdc_ti

for the latter one.

> thanks,
>
> Takashi
>
> ===
>
> Takashi Iwai (3):
>   mfd: Add support for Cherry Trail Dollar Cove TI PMIC
>   platform/x86: Add support for Dollar Cove TI power button
>   ACPI / PMIC: Add opregion driver for Intel Dollar Cove TI PMIC
>
>  drivers/acpi/Kconfig                      |   6 +
>  drivers/acpi/Makefile                     |   1 +
>  drivers/acpi/pmic/intel_pmic_dc_ti.c      | 139 +++++++++++++++++++++++
>  drivers/mfd/Kconfig                       |  13 +++
>  drivers/mfd/Makefile                      |   1 +
>  drivers/mfd/intel_soc_pmic_dc_ti.c        | 182 ++++++++++++++++++++++++++++++
>  drivers/platform/x86/Kconfig              |   8 ++
>  drivers/platform/x86/Makefile             |   1 +
>  drivers/platform/x86/intel_dc_ti_pwrbtn.c |  96 ++++++++++++++++
>  9 files changed, 447 insertions(+)
>  create mode 100644 drivers/acpi/pmic/intel_pmic_dc_ti.c
>  create mode 100644 drivers/mfd/intel_soc_pmic_dc_ti.c
>  create mode 100644 drivers/platform/x86/intel_dc_ti_pwrbtn.c
>
> --
> 2.14.0
>



-- 
With Best Regards,
Andy Shevchenko
