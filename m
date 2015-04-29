From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] i2c / ACPI: Assign IRQ for devices that have GpioInt
 automatically
Date: Wed, 29 Apr 2015 13:02:49 +0300
Message-ID: <20150429100249.GR1534@lahna.fi.intel.com>
References: <1430233507-29389-1-git-send-email-mika.westerberg@linux.intel.com>
 <1430233507-29389-3-git-send-email-mika.westerberg@linux.intel.com>
 <20150429095605.GA2470@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150429095605.GA2470@katana>
Sender: linux-gpio-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Octavian Purdila <octavian.purdila@intel.com>, Robert Dolca <robert.dolca@intel.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 29, 2015 at 11:56:06AM +0200, Wolfram Sang wrote:
> 
> > -	if (!client->irq && dev->of_node) {
> > -		int irq = of_irq_get(dev->of_node, 0);
> > +	if (client->irq <= 0) {
> > +		int irq = -ENOENT;
> 
> Why the move from !client->irq to <= 0? If I didn't miss something,
> interrupt numbers are still a sleeping dog with all the unsigned vs
> signed fuzz. If this change is needed, this needs proper description and
> ideally a seperate patch.

It is there because ACPI parts of I2C client enumeration code
initializes client->irq with -1. Alternatively we can change that code
to use 0 for missing IRQ.
