From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 3/3] ACPI / PMIC: Add opregion driver for Intel Dollar
 Cove TI PMIC
Date: Fri, 25 Aug 2017 18:24:19 +0300
Message-ID: <CAHp75VeuEcBpQ6qcH+c=GYgNndjoLEn=C9NSJvOcYVgraOLWkQ@mail.gmail.com>
References: <20170825134443.14843-1-tiwai@suse.de> <20170825134443.14843-4-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:37423 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933386AbdHYPYV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Aug 2017 11:24:21 -0400
In-Reply-To: <20170825134443.14843-4-tiwai@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Jones <lee.jones@linaro.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, Hans de Goede <hdegoede@redhat.com>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Aug 25, 2017 at 4:44 PM, Takashi Iwai <tiwai@suse.de> wrote:

One really minor nit (fine if it will be ignored):

> +config CHTDC_TI_PMIC_OPREGION

CHTDC_TI_PMIC_OPREGION -> CHT_DC_TI_PMIC_OPREGION

>  obj-$(CONFIG_XPOWER_PMIC_OPREGION) += pmic/intel_pmic_xpower.o
>  obj-$(CONFIG_BXT_WC_PMIC_OPREGION) += pmic/intel_pmic_bxtwc.o
>  obj-$(CONFIG_CHT_WC_PMIC_OPREGION) += pmic/intel_pmic_chtwc.o
> +obj-$(CONFIG_CHTDC_TI_PMIC_OPREGION) += pmic/intel_pmic_chtdc_ti.o

Ditto (as you can notice by above context).

-- 
With Best Regards,
Andy Shevchenko
