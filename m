From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 1/3] mfd: Add support for Cherry Trail Dollar Cove TI
 PMIC
Date: Thu, 7 Sep 2017 09:00:18 +0100
Message-ID: <20170907080018.zfrxvqbkdr74amwa@dell>
References: <20170904144340.27693-1-tiwai@suse.de>
 <20170904144340.27693-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37758 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751780AbdIGIAW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2017 04:00:22 -0400
Received: by mail-wm0-f49.google.com with SMTP id i198so5479wmf.0
        for <linux-acpi@vger.kernel.org>; Thu, 07 Sep 2017 01:00:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170904144340.27693-2-tiwai@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 04 Sep 2017, Takashi Iwai wrote:

> This patch adds the MFD driver for Dollar Cove (TI version) PMIC with
> ACPI INT33F5 that is found on some Intel Cherry Trail devices.
> The driver is based on the original work by Intel, found at:
>   https://github.com/01org/ProductionKernelQuilts
> 
> This is a minimal version for adding the basic resources.  Currently,
> only ACPI PMIC opregion and the external power-button are used.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=193891
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> v4->v5:
> * Minor coding-style fixes suggested by Lee
> * Put GPL text
> v3->v4:
> * no change for this patch
> v2->v3:
> * Rename dc_ti with chtdc_ti in all places
> * Driver/kconfig renames accordingly
> * Added acks by Andy and Mika
> v1->v2:
> * Minor cleanups as suggested by Andy
> 
>  drivers/mfd/Kconfig                   |  13 +++
>  drivers/mfd/Makefile                  |   1 +
>  drivers/mfd/intel_soc_pmic_chtdc_ti.c | 184 ++++++++++++++++++++++++++++++++++
>  3 files changed, 198 insertions(+)
>  create mode 100644 drivers/mfd/intel_soc_pmic_chtdc_ti.c

Applied for v4.15, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
