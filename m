From: David Cohen <david.a.cohen@linux.intel.com>
Subject: Re: [RFC PATCH] gpio: support for GPIO forwarding
Date: Tue, 24 Feb 2015 12:34:59 -0800
Message-ID: <20150224203459.GC13094@psi-dev26.jf.intel.com>
References: <1418890998-23811-1-git-send-email-heikki.krogerus@linux.intel.com>
 <CAAVeFuJUxad0dJ9vK1DaDJPDLM+rc5b77=PgcJT5+Bv1=iWGxg@mail.gmail.com>
 <CACRpkdZzCX0O1wX=W5RbjLcqOF_R3HMTT1w59oFu=JfPauLNuw@mail.gmail.com>
 <4078818.ecVtLF3hjd@vostro.rjw.lan>
 <CAAVeFuJjMDfz7TZexkYnYrCGkAmRwubs32UhSPO-4qZWbMJjuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAVeFuJjMDfz7TZexkYnYrCGkAmRwubs32UhSPO-4qZWbMJjuQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Courbot <gnurou@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Darren Hart <dvhart@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

> If we decide to go ahead with the solution proposed by this patch for
> practical reasons (which are good reasons indeed), I still have one
> problem with its current form.
> 
> As the discussion highlighted, this is an ACPI problem, so I'd very
> much like it to be confined to the ACPI GPIO code, to be enabled only
> when ACPI is, and to use function names that start with acpi_gpio. The
> current implementation leverages platform lookup, making said lookup
> less efficient in the process and bringing confusion about its
> purpose. Although the two processes are indeed similar, they are
> separate things: one is a legitimate way to map GPIOs, the other is a
> fixup for broken firmware.
> 
> I suppose we all agree this is a hackish fix, so let's confine it as
> much as we can.

Are we considering MFD cases hackish as well?
i.e. if we have a driver that needs to register children devices and this
driver needs to pass GPIO to a child.

Br, David
