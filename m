From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/3] spi / ACPI: add ACPI enumeration support
Date: Mon, 5 Nov 2012 16:53:15 +0200
Message-ID: <20121105145315.GI24532@intel.com>
References: <1351928793-14375-1-git-send-email-mika.westerberg@linux.intel.com>
 <CACRpkdaZqka7g2ECAyD_bKhnoULhCP6cTJwMyEsTuVxiUiHy+A@mail.gmail.com>
 <20121105150326.3bbf69df@endymion.delvare>
 <1925265.4Cx64DgKbB@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1925265.4Cx64DgKbB@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jean Delvare <khali@linux-fr.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, grant.likely@secretlab.ca, ben-linux@fluff.org, w.sang@pengutronix.de, mathias.nyman@linux.intel.com, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 05, 2012 at 03:19:58PM +0100, Rafael J. Wysocki wrote:
> 
> In the ACPI namespace we have device nodes and serial interfaces below them.
> In the above case we see that a single device node supports two different
> interfaces and in that case we probably should create two different
> struct i2c_adapter objects for the same ACPI device node.
> 
> Mika, what do you think?

I agree.

Only problem I see is that then we have two I2C adapter devices with the
same ACPI ID (and hence the same i2c_client->name). I wonder what the I2C
core thinks about that.
