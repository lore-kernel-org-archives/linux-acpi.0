From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] ACPI / PMIC: Add opregion driver for Intel CHT
 WhiskeyCove PMIC
Date: Mon, 27 Feb 2017 23:50:54 +0200
Message-ID: <CAHp75VfY3zu94ivvvfDU51RCUwRdXucQ_aKLR9GcPnPXMEWp1Q@mail.gmail.com>
References: <20170227202628.5737-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35652 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751341AbdB0WTu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Feb 2017 17:19:50 -0500
Received: by mail-qk0-f173.google.com with SMTP id u188so120766249qkc.2
        for <linux-acpi@vger.kernel.org>; Mon, 27 Feb 2017 14:19:49 -0800 (PST)
In-Reply-To: <20170227202628.5737-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Bin Gao <bin.gao@intel.com>, Felipe Balbi <felipe.balbi@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Mon, Feb 27, 2017 at 10:26 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Add opregion driver for Intel CHT WhiskeyCove PMIC, based on various
> non upstreamed CHT WhiskeyCove PMIC patches. This does not include
> support for the Thermal opregion (DPTF) due to lacking documentation.

Couple of nitpicks.

> @@ -0,0 +1,232 @@
> +/*
> + * intel_pmic_chtwc.c - Intel CHT Whiskey Cove PMIC operation region driver

I would remove file name. You never know if it's going to be renamed or not.

> +static int intel_cht_wc_pmic_update_power(struct regmap *regmap, int reg,
> +               int bit, bool on)
> +{

> +       u8 mask = bit;
> +
> +       return regmap_update_bits(regmap, reg, mask, on ? 1 : 0);

Hmm... Just leave one line?

> +}

-- 
With Best Regards,
Andy Shevchenko
