From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 1/3] mfd: Add new mfd device TPS68470
Date: Wed, 26 Jul 2017 09:20:39 +0100
Message-ID: <20170726082039.tcxbd7ogkmguufqo@dell>
References: <1500506426-3047-1-git-send-email-rajmohan.mani@intel.com>
 <1500506426-3047-2-git-send-email-rajmohan.mani@intel.com>
 <20170720090300.ayx5pz5l4yntefpt@dell>
 <6F87890CF0F5204F892DEA1EF0D77A59725DD60A@FMSMSX114.amr.corp.intel.com>
 <20170725091012.3hpxihekht2j35xb@dell>
 <6F87890CF0F5204F892DEA1EF0D77A59725DE951@FMSMSX114.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6F87890CF0F5204F892DEA1EF0D77A59725DE951@FMSMSX114.amr.corp.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: "Mani, Rajmohan" <rajmohan.mani@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, 25 Jul 2017, Mani, Rajmohan wrote:

> Hi Lee,
> 
> > Subject: Re: [PATCH v4 1/3] mfd: Add new mfd device TPS68470
> > 
> > On Fri, 21 Jul 2017, Mani, Rajmohan wrote:
> > > > On Wed, 19 Jul 2017, Rajmohan Mani wrote:
> > > >
> > > > > The TPS68470 device is an advanced power management unit that
> > > > > powers
> > > > a
> > > > > Compact Camera Module (CCM), generates clocks for image sensors,
> > > > > drives a dual LED for Flash and incorporates two LED drivers for
> > > > > general purpose indicators.
> > > > >
> > > > > This patch adds support for TPS68470 mfd device.
> > > > >
> > > > > Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
> > > > > ---
> > > > >  drivers/mfd/Kconfig          |  18 +++++++
> > > > >  drivers/mfd/Makefile         |   1 +
> > > > >  drivers/mfd/tps68470.c       | 110
> > > > +++++++++++++++++++++++++++++++++++++++++++
> > > > >  include/linux/mfd/tps68470.h |  97
> > > > > ++++++++++++++++++++++++++++++++++++++
> > > > >  4 files changed, 226 insertions(+)  create mode 100644
> > > > > drivers/mfd/tps68470.c  create mode 100644
> > > > > include/linux/mfd/tps68470.h
> > 
> > [...]
> > 
> > > > > +static const struct regmap_config tps68470_regmap_config = {
> > > > > +	.reg_bits = 8,
> > > > > +	.val_bits = 8,
> > > > > +	.max_register = TPS68470_REG_MAX, };
> > > > > +
> > > > > +static int tps68470_chip_init(struct device *dev, struct regmap
> > > > > +*regmap) {
> > > > > +	unsigned int version;
> > > > > +	int ret;
> > > > > +
> > > > > +	/* Force software reset */
> > > > > +	ret = regmap_write(regmap, TPS68470_REG_RESET,
> > > > TPS68470_REG_RESET_MASK);
> > > > > +	if (ret < 0)
> > > >
> > > > Will 'if (!ret)' do?
> > > >
> > >
> > > We intend to check error conditions and bail out. So, if (ret < 0) works for
> > this.
> > 
> > Yes, 'if (!ret)' does that too.
> > 
> 
> regmap_write() and regmap_read() functions return 0 on success. Hence we can not use 'if (!ret)' here, since we check for error conditions.

Sorry, this was a typo.

It should be 'if (ret)'.

What I'm trying to get at is the " < 0" is not required.

> > > > > +		return ret;
> > > > > +
> > > > > +	ret = regmap_read(regmap, TPS68470_REG_REVID, &version);
> > > > > +	if (ret < 0) {
> > > >
> > > > Same
> > > >
> > >
> > > We intend to check error conditions and bail out. So, if (ret < 0) works for
> > this.
> > 
> > As above.
> > 
> 
> Same as above
> 
> > > > > +		dev_err(dev, "Failed to read revision register: %d\n", ret);
> > > > > +		return ret;
> > > > > +	}
> > > > > +
> > > > > +	dev_info(dev, "TPS68470 REVID: 0x%x\n", version);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int tps68470_probe(struct i2c_client *client) {
> > > > > +	struct device *dev = &client->dev;
> > > > > +	struct regmap *regmap;
> > > > > +	int ret;
> > > > > +
> > > > > +	regmap = devm_regmap_init_i2c(client, &tps68470_regmap_config);
> > > > > +	if (IS_ERR(regmap)) {
> > > > > +		dev_err(dev, "devm_regmap_init_i2c Error %ld\n",
> > > > > +			PTR_ERR(regmap));
> > > > > +		return PTR_ERR(regmap);
> > > > > +	}
> > > > > +
> > > > > +	i2c_set_clientdata(client, regmap);
> > > > > +
> > > > > +	ret = tps68470_chip_init(dev, regmap);
> > > > > +	if (ret < 0) {
> > > >
> > > > Same
> > > >
> > >
> > > We intend to check error conditions and bail out. So, if (ret < 0) works for
> > this.
> > 
> > As above.
> > 
> 
> Same as above

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
