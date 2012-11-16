From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH v2 3/3 UPDATED] i2c / ACPI: add ACPI enumeration support
Date: Fri, 16 Nov 2012 19:12:47 +0100
Message-ID: <20121116191247.356c23a0@endymion.delvare>
References: <1352977397-2280-1-git-send-email-mika.westerberg@linux.intel.com>
	<2439178.tCj2rUMYJS@vostro.rjw.lan>
	<20121116140357.5e0a6d6b@endymion.delvare>
	<1499062.QDd9DGofy9@vostro.rjw.lan>
	<20121116144256.55b49cae@endymion.delvare>
	<20121116141729.GS17774@intel.com>
	<20121116152332.GV17774@intel.com>
	<20121116174753.67d71043@endymion.delvare>
	<20121116172828.GY17774@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:27446 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437Ab2KPSNL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Nov 2012 13:13:11 -0500
In-Reply-To: <20121116172828.GY17774@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ben-linux@fluff.org, w.sang@pengutronix.de, linux-kernel@vger.kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, bhelgaas@google.com, mathias.nyman@linux.intel.com, linux-acpi@vger.kernel.org

On Fri, 16 Nov 2012 19:28:28 +0200, Mika Westerberg wrote:
> On Fri, Nov 16, 2012 at 05:47:53PM +0100, Jean Delvare wrote:
> > Hi Mika,
> > 
> > On Fri, 16 Nov 2012 17:23:32 +0200, Mika Westerberg wrote:
> > > Here's the updated version where we handle 10-bit addresses properly
> > > (hopefully).
> > > (...)
> > > +static int acpi_i2c_find_device(struct device *dev, acpi_handle *handle)
> > > +{
> > > (...)
> > > +	memset(&i2c_find, 0, sizeof(i2c_find));
> > > +	i2c_find.addr = client->addr;
> > > +	if (client->flags & I2C_CLIENT_TEN)
> > > +		i2c_find.access_mode = ACPI_I2C_10BIT_MODE;
> > 
> > This works because you are lucky and ACPI_I2C_7BIT_MODE has value 0,
> > but for correctness I'd rather add:
> > 
> > 	else
> > 		i2c_find.access_mode = ACPI_I2C_7BIT_MODE;
> 
> Right, sorry about that. The patch below should address this as well.
> (...)

Yes, looks good.

-- 
Jean Delvare
