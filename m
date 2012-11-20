From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 3/3] i2c / ACPI: add ACPI enumeration support
Date: Tue, 20 Nov 2012 15:57:17 +0200
Message-ID: <20121120135717.GA3867@intel.com>
References: <1352977397-2280-1-git-send-email-mika.westerberg@linux.intel.com>
 <1353407384-26880-1-git-send-email-mika.westerberg@linux.intel.com>
 <1353407384-26880-4-git-send-email-mika.westerberg@linux.intel.com>
 <2231474.figQz3Mgq6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2231474.figQz3Mgq6@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: grant.likely@secretlab.ca, linus.walleij@linaro.org, w.sang@pengutronix.de, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, lenb@kernel.org, broonie@opensource.wolfsonmicro.com, khali@linux-fr.org, ben-linux@fluff.org, bhelgaas@google.com, mathias.nyman@linux.intel.com, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 20, 2012 at 02:06:46PM +0100, Rafael J. Wysocki wrote:
> On Tuesday, November 20, 2012 12:29:44 PM Mika Westerberg wrote:
> > ACPI 5 introduced I2cSerialBus resource that makes it possible to enumerate
> > and configure the I2C slave devices behind the I2C controller. This patch
> > adds helper functions to support I2C slave enumeration.
> > 
> > An ACPI enabled I2C controller driver only needs to call acpi_i2c_register_devices()
> > in order to get its slave devices enumerated, created and bound to the
> > corresponding ACPI handle.
> 
> My comments from the SPI patch apply here too almost verbatim. :-)

OK.

Thanks for the comments. I'll wait a bit to get comments from other
subsystem maintainers (I hope they comment something) and then do v4 with
all comments addressed.
