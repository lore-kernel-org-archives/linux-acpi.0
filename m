From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] gpio / ACPI: Allow shared GPIO event to be read via operation region
Date: Sat, 31 Oct 2015 03:51:21 +0100
Message-ID: <4111039.FBWfxG0hG5@vostro.rjw.lan>
References: <1446199325-48095-1-git-send-email-mika.westerberg@linux.intel.com> <CACRpkdaywq+j6k4vKBexJGahb9S2M1=vg3Dwsrh6fDUTD+LgxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdaywq+j6k4vKBexJGahb9S2M1=vg3Dwsrh6fDUTD+LgxQ@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, Aaron Lu <aaron.lu@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Friday, October 30, 2015 09:17:41 PM Linus Walleij wrote:
> On Fri, Oct 30, 2015 at 11:02 AM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> 
> > In Microsoft Surface3 the GPIO detecting lid state is shared between GPIO
> > event and operation region. Below is simplied version of the DSDT from
> > Surface3 including relevant parts:
> (...)
> > To be able to go through acpi_gpio->events list for operation region access
> > we need to make sure the list is properly initialized whenever GPIO chip is
> > registered.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=106571
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> I wonder what an operation region is, maybe it's something you can eat.

That's a way for AML to access things.

Basically, if it wants to access a resource, it has to declare "I will be using
X bytes at location Y in address space Z" and the OS is supposed to provide
a handler for that.

Thanks,
Rafael

