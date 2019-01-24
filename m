From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [for next][PATCH 1/2] platform/x86: Fix unmet dependency warning
 for ACPI_CMPC
Date: Thu, 24 Jan 2019 21:16:47 +0200
Message-ID: <CAHp75VdJLQ-J_VruUmou9-PafScqNHGzu8+52ZTy-HtG98gbmg@mail.gmail.com>
References: <20190121224644.26903-1-okaya@kernel.org> <3681650.SPxszaOeRQ@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3681650.SPxszaOeRQ@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sinan Kaya <okaya@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, linux-next <linux-next@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 24, 2019 at 12:54 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Monday, January 21, 2019 11:46:43 PM CET Sinan Kaya wrote:
> > Add BACKLIGHT_LCD_SUPPORT for ACPI_CMPC to fix the
> > warning: unmet direct dependencies detected for BACKLIGHT_CLASS_DEVICE.
> >
> > ACPI_CMPC selects BACKLIGHT_LCD_SUPPORT but BACKLIGHT_LCD_SUPPORT
> > depends on BACKLIGHT_LCD_SUPPORT.
> >
> > Copy this dependency into ACPI_CMPC.

> Andy/Darren, these two seem to be for you, but I can take them too as
> related to ACPI tagentially, so please let me know.

Answered to v2. One comment still to be addressed, otherwise feel free
to take them.

-- 
With Best Regards,
Andy Shevchenko
