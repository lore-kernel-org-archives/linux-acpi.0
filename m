From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 10/12] PNP / ACPI: add support for GpioInt resource type
Date: Mon, 29 May 2017 11:26:54 +0200
Message-ID: <CACRpkdaZmU5Zpr3Tuq0LfXpoj4R7yvGd7COtzWCr3pPVs1j3DQ@mail.gmail.com>
References: <20170523170327.18055-1-andriy.shevchenko@linux.intel.com> <20170523170327.18055-11-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170523170327.18055-11-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jagadish Krishnamoorthy <jagadish.krishnamoorthy@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, May 23, 2017 at 7:03 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> From: Jagadish Krishnamoorthy <jagadish.krishnamoorthy@intel.com>
>
> The PNP ACPI driver parses ACPI interrupt resource but not
> GpioInt resource. When the firmware passes GpioInt resource
> for IRQ the PNP ACPI driver ignores it and hence the interrupt for
> the particular driver will not work.
> One such example is 8042 keyboard which uses PNP driver for obtaining
> the interrupt resource. On Intel Braswell project GpioInt is used
> instead of interrupt resource and the keyboard driver fails to
> register interrupt.
> Fix the issue by parsing GpioInt resource type.
>
> Signed-off-by: Jagadish Krishnamoorthy <jagadish.krishnamoorthy@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Fixed the paranthesis pointed out by Mika and applied
with his review tag.

Yours,
Linus Walleij
