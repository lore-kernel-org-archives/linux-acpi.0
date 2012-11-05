From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 0/3] ACPI 5 support for GPIO, SPI and I2C
Date: Mon, 5 Nov 2012 11:23:45 +0200
Message-ID: <20121105092345.GB24532@intel.com>
References: <1351928793-14375-1-git-send-email-mika.westerberg@linux.intel.com>
 <CACRpkdb0jmiBBi+W0U7h5PfVF-kYP+Ui-nOzWxBazMHxupruwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:64378 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832Ab2KEJVv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Nov 2012 04:21:51 -0500
Content-Disposition: inline
In-Reply-To: <CACRpkdb0jmiBBi+W0U7h5PfVF-kYP+Ui-nOzWxBazMHxupruwA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, broonie@opensource.wolfsonmicro.com, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, mathias.nyman@linux.intel.com, linux-acpi@vger.kernel.org

On Sun, Nov 04, 2012 at 07:29:10PM +0100, Linus Walleij wrote:
> On Sat, Nov 3, 2012 at 8:46 AM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> 
> > With ACPI 5 we can now describe how devices are connected to their bus
> > using new resources: SPISerialBus and I2CSerialBus. Also it is now possible
> > to add GPIO connections for the devices with the help of GpioIO and GpioInt
> > resources.
> >
> > This series adds support for these new resources.
> 
> I would very much like Grant to review and merge these patches, since he
> is way more familiar with these concepts than me, but I'll have a quick
> glance for syntax and semantics...

That sounds good, thanks!
