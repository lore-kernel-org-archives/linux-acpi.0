From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH v4 0/3] ACPI 5 support for GPIO, SPI and I2C
Date: Wed, 21 Nov 2012 22:54:50 +0100
Message-ID: <20121121225450.026dcaf6@endymion.delvare>
References: <1353407384-26880-1-git-send-email-mika.westerberg@linux.intel.com>
	<1353435212-15325-1-git-send-email-mika.westerberg@linux.intel.com>
	<79636467.nuLQX2FqW5@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <79636467.nuLQX2FqW5@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: grant.likely@secretlab.ca, linus.walleij@linaro.org, w.sang@pengutronix.de, Mika Westerberg <mika.westerberg@linux.intel.com>, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, lenb@kernel.org, broonie@opensource.wolfsonmicro.com, ben-linux@fluff.org, bhelgaas@google.com, mathias.nyman@linux.intel.com, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 21 Nov 2012 22:31:15 +0100, Rafael J. Wysocki wrote:
> > Mathias Nyman (1):
> >   gpio / ACPI: add ACPI support
> > 
> > Mika Westerberg (2):
> >   spi / ACPI: add ACPI enumeration support
> >   i2c / ACPI: add ACPI enumeration support
> 
> This patchset has been around for quite a while and went through a few
> iterations, so I think it's as good as it gets at this point.
> 
> I wonder if the GPIO / SPI / I2C maintainers have any objections against it or
> would like the patches to be modified somehow?

I'd say go ahead, any issue that shows up can be fixed afterward.

> If not, then I'd like to take it for v3.8 into the linux-pm.git tree, because
> the patches depend on some changes already in that tree.  Hopefully, that's OK.

Yes.

-- 
Jean Delvare
