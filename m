From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio / ACPI: Allow shared GPIO event to be read via
 operation region
Date: Fri, 30 Oct 2015 21:17:41 +0100
Message-ID: <CACRpkdaywq+j6k4vKBexJGahb9S2M1=vg3Dwsrh6fDUTD+LgxQ@mail.gmail.com>
References: <1446199325-48095-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1446199325-48095-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexandre Courbot <gnurou@gmail.com>, Aaron Lu <aaron.lu@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Oct 30, 2015 at 11:02 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> In Microsoft Surface3 the GPIO detecting lid state is shared between GPIO
> event and operation region. Below is simplied version of the DSDT from
> Surface3 including relevant parts:
(...)
> To be able to go through acpi_gpio->events list for operation region access
> we need to make sure the list is properly initialized whenever GPIO chip is
> registered.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=106571
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

I wonder what an operation region is, maybe it's something you can eat.
But I trust you Mika, so patch applied. Maybe I should get a surface, it
seems cool.

Yours,
Linus Walleij
