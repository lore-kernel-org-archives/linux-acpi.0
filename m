From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 3/4] ACPI / gpio: Add hogging support
Date: Thu, 20 Oct 2016 14:09:30 +0200
Message-ID: <CACRpkdYTUy9u0_VWQ6CuriD+__H8EkR_MyarXMFdJ9hbZwYUgw@mail.gmail.com>
References: <20160929133944.158596-1-mika.westerberg@linux.intel.com> <20160929133944.158596-4-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160929133944.158596-4-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Sep 29, 2016 at 3:39 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> GPIO hogging means that the GPIO controller can "hog" and configure certain
> GPIOs without need for a driver or userspace to do that. This is useful in
> open-connected boards where BIOS cannot possibly know beforehand which
> devices will be connected to the board.
>
> This adds GPIO hogging mechanism to ACPI analogous to Device Tree.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Overall nice to have the hogs in ACPI too!

Again here my comment is to break out device_property() and fwnode_*
accessing code to a file shared between ACPI and OF.

If it makes sense.

Because the idea was not to invent those abstractions in order to
just use them with ACPI I hope.

The problem is that some of the code seems to be ACPI-specific,
so if it doesn't work out, I'm also OK to keep it like this.

Yours,
Linus Walleij
