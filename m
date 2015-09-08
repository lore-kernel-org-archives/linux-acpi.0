From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 5/6] ACPI / gpio: Split acpi_get_gpiod_by_index()
Date: Wed, 09 Sep 2015 00:28:56 +0200
Message-ID: <1757645.CZ0PiXAgmU@vostro.rjw.lan>
References: <1596179.pGEt0Ullqu@vostro.rjw.lan> <8402685.WoxEi8zV68@vostro.rjw.lan> <CACRpkda7x45R+10aXGrafHMWPbr=6_Cxjpvcga5aK1Mn-fzZ1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkda7x45R+10aXGrafHMWPbr=6_Cxjpvcga5aK1Mn-fzZ1g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Darren Hart <darren.hart@intel.com>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, David Woodhouse <dwmw2@infradead.org>, Dustin Byford <dustin@cumulusnetworks.com>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, September 08, 2015 11:20:51 AM Linus Walleij wrote:
> On Thu, Aug 27, 2015 at 4:41 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> 
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Split acpi_get_gpiod_by_index() into three smaller routines to
> > allow the subsequent change of the generic firmware node properties
> > code to be more strarightforward.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Feel free to merge this through the ACPI tree if it's a dependency.

It is, so I'll do that.

Thanks for the ACKs!

Rafael
