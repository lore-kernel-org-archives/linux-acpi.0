From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [for next][PATCH v2 2/2] platform/x86: Fix unmet dependency
 warning for SAMSUNG_Q10
Date: Thu, 24 Jan 2019 21:15:54 +0200
Message-ID: <CAHp75VdbEVUvf1+ySY=J02op-EbqSCkzegGfoO3RXmBRO-63hQ@mail.gmail.com>
References: <20190124175702.4801-1-okaya@kernel.org> <20190124175702.4801-2-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190124175702.4801-2-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>
Cc: linux-next <linux-next@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 24, 2019 at 7:57 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> Add BACKLIGHT_LCD_SUPPORT for SAMSUNG_Q10 to fix the
> warning: unmet direct dependencies detected for BACKLIGHT_CLASS_DEVICE.
>
> SAMSUNG_Q10 selects BACKLIGHT_CLASS_DEVICE but BACKLIGHT_CLASS_DEVICE
> depends on BACKLIGHT_LCD_SUPPORT.
>
> Copy BACKLIGHT_LCD_SUPPORT dependency into SAMSUNG_Q10 to fix:
>
> WARNING: unmet direct dependencies detected for BACKLIGHT_CLASS_DEVICE
>   Depends on [n]: HAS_IOMEM [=y] && BACKLIGHT_LCD_SUPPORT [=n]
>   Selected by [y]:
>   - SAMSUNG_Q10 [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y] && ACPI [=y]

Thanks for the fix.
One comment below though.

>  config SAMSUNG_Q10
>         tristate "Samsung Q10 Extras"
> -       depends on ACPI

> +       depends on ACPI && BACKLIGHT_LCD_SUPPORT

I would like rather see it on a separate line in both patches.

Rafael, you may take it if it feels comfortable.

>         select BACKLIGHT_CLASS_DEVICE
>         ---help---
>           This driver provides support for backlight control on Samsung Q10
> --
> 2.19.0
>


-- 
With Best Regards,
Andy Shevchenko
