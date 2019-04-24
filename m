From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] gpio: sch: Add interrupt support
Date: Wed, 24 Apr 2019 11:18:02 +0300
Message-ID: <20190424081802.GV2654@lahna.fi.intel.com>
References: <cover.1555579429.git.jan.kiszka@siemens.com>
 <c9f40465c6effc7b8efd6cbf8461d71d80c80033.1555579429.git.jan.kiszka@siemens.com>
 <20190424075816.GU2654@lahna.fi.intel.com>
 <8999d3f8-d169-eb85-bd2f-08c99d184ea2@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8999d3f8-d169-eb85-bd2f-08c99d184ea2@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 24, 2019 at 10:12:42AM +0200, Jan Kiszka wrote:
> On 24.04.19 09:58, Mika Westerberg wrote:
> > +Rafael and linux-acpi.
> > 
> > On Thu, Apr 18, 2019 at 11:23:49AM +0200, Jan Kiszka wrote:
> > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > > 
> > > Validated on the Quark platform, this adds interrupt support on rising
> > > and/or falling edges.
> > 
> > The irqchip parts look good to me but but the ACPI SCI handling seems
> > weird. This is typically handled by ACPI core based on the values read
> > from FADT ACPI table. What does it contain on this Quark platform?
> 
> There is no FADT on the original Quark firmware, nor did we add one. As we
> are talking about existing devices, possibly not only Quarks, I was going
> down the ACPI-independent way to hook into the interrupt. But I'm open to
> learn about better alternatives.

Hmm, if it does not have FADT table why would you need SCI then? Is this
implementing some real use case?
