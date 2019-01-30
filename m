From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [for next][PATCH v3 1/2] platform/x86: Fix unmet dependency warning for ACPI_CMPC
Date: Thu, 31 Jan 2019 00:56:08 +0100
Message-ID: <309800316.xPVQqezZ0x@aspire.rjw.lan>
References: <20190124193101.24519-1-okaya@kernel.org> <CAHp75VerwCxYqozQmaJZL8tcbfDFLBp+nTheP0Ran4qWPqTcLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VerwCxYqozQmaJZL8tcbfDFLBp+nTheP0Ran4qWPqTcLw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Sinan Kaya <okaya@kernel.org>
Cc: linux-next <linux-next@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thursday, January 24, 2019 10:32:56 PM CET Andy Shevchenko wrote:
> On Thu, Jan 24, 2019 at 9:31 PM Sinan Kaya <okaya@kernel.org> wrote:
> >
> > Add BACKLIGHT_LCD_SUPPORT for ACPI_CMPC to fix the
> > warning: unmet direct dependencies detected for BACKLIGHT_CLASS_DEVICE.
> >
> > ACPI_CMPC selects BACKLIGHT_CLASS_DEVICE but BACKLIGHT_CLASS_DEVICE
> > depends on BACKLIGHT_LCD_SUPPORT.
> >
> > Copy BACKLIGHT_LCD_SUPPORT dependency into ACPI_CMPC to fix
> >
> > WARNING: unmet direct dependencies detected for BACKLIGHT_CLASS_DEVICE
> >   Depends on [n]: HAS_IOMEM [=y] && BACKLIGHT_LCD_SUPPORT [=n]
> >   Selected by [y]:
> >   - ACPI_CMPC [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y] && ACPI [=y] && INPUT [=y] && (RFKILL [=n] || RFKILL [=n]=n)
> >
> 
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> for both patches in case Rafael takes care of them.

So both applied, thanks!
