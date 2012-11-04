From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/3] ACPI 5 support for GPIO, SPI and I2C
Date: Sun, 4 Nov 2012 19:29:10 +0100
Message-ID: <CACRpkdb0jmiBBi+W0U7h5PfVF-kYP+Ui-nOzWxBazMHxupruwA@mail.gmail.com>
References: <1351928793-14375-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1351928793-14375-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: linux-kernel@vger.kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, broonie@opensource.wolfsonmicro.com, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, mathias.nyman@linux.intel.com, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Nov 3, 2012 at 8:46 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> With ACPI 5 we can now describe how devices are connected to their bus
> using new resources: SPISerialBus and I2CSerialBus. Also it is now possible
> to add GPIO connections for the devices with the help of GpioIO and GpioInt
> resources.
>
> This series adds support for these new resources.

I would very much like Grant to review and merge these patches, since he
is way more familiar with these concepts than me, but I'll have a quick
glance for syntax and semantics...

Yours,
Linus Walleij
