From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 1/3] mfd: Add new mfd device TPS68470
Date: Tue, 6 Jun 2017 15:48:48 +0300
Message-ID: <20170606124848.GA10936@kuha.fi.intel.com>
References: <1496750118-5570-1-git-send-email-rajmohan.mani@intel.com>
 <1496750118-5570-2-git-send-email-rajmohan.mani@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:40235 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751415AbdFFMvZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Jun 2017 08:51:25 -0400
Content-Disposition: inline
In-Reply-To: <1496750118-5570-2-git-send-email-rajmohan.mani@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rajmohan Mani <rajmohan.mani@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

Hi Rajmohan,

On Tue, Jun 06, 2017 at 04:55:16AM -0700, Rajmohan Mani wrote:
> +/*
> + * tps68470_reg_read: Read a single tps68470 register.
> + *
> + * @tps: Device to read from.
> + * @reg: Register to read.
> + * @val: Contains the value
> + */
> +int tps68470_reg_read(struct tps68470 *tps, unsigned int reg,
> +			unsigned int *val)
> +{
> +	int ret;
> +
> +	mutex_lock(&tps->lock);
> +	ret = regmap_read(tps->regmap, reg, val);
> +	mutex_unlock(&tps->lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(tps68470_reg_read);
> +
> +/*
> + * tps68470_reg_write: Write a single tps68470 register.
> + *
> + * @tps68470: Device to write to.
> + * @reg: Register to write to.
> + * @val: Value to write.
> + */
> +int tps68470_reg_write(struct tps68470 *tps, unsigned int reg,
> +			unsigned int val)
> +{
> +	int ret;
> +
> +	mutex_lock(&tps->lock);
> +	ret = regmap_write(tps->regmap, reg, val);
> +	mutex_unlock(&tps->lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(tps68470_reg_write);
> +
> +/*
> + * tps68470_update_bits: Modify bits w.r.t mask and val.
> + *
> + * @tps68470: Device to write to.
> + * @reg: Register to read-write to.
> + * @mask: Mask.
> + * @val: Value to write.
> + */
> +int tps68470_update_bits(struct tps68470 *tps, unsigned int reg,
> +				unsigned int mask, unsigned int val)
> +{
> +	int ret;
> +
> +	mutex_lock(&tps->lock);
> +	ret = regmap_update_bits(tps->regmap, reg, mask, val);
> +	mutex_unlock(&tps->lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(tps68470_update_bits);

I'm not sure you need those above wrappers at all, regmap is handling
locking in any case.

> +static const struct regmap_config tps68470_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = TPS68470_REG_MAX,
> +};
> +
> +static int tps68470_chip_init(struct tps68470 *tps)
> +{
> +	unsigned int version;
> +	int ret;
> +
> +	ret = tps68470_reg_read(tps, TPS68470_REG_REVID, &version);
> +	if (ret < 0) {
> +		dev_err(tps->dev,
> +			"Failed to read revision register: %d\n", ret);
> +		return ret;
> +	}
> +
> +	dev_info(tps->dev, "TPS68470 REVID: 0x%x\n", version);
> +
> +	ret = tps68470_reg_write(tps, TPS68470_REG_RESET, 0xff);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* FIXME: configure these dynamically */
> +	/* Enable Daisy Chain LDO and configure relevant GPIOs as output */
> +	ret = tps68470_reg_write(tps, TPS68470_REG_S_I2C_CTL, 2);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = tps68470_reg_write(tps, TPS68470_REG_GPCTL4A, 2);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = tps68470_reg_write(tps, TPS68470_REG_GPCTL5A, 2);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = tps68470_reg_write(tps, TPS68470_REG_GPCTL6A, 2);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * When SDA and SCL are routed to GPIO1 and GPIO2, the mode
> +	 * for these GPIOs must be configured using their respective
> +	 * GPCTLxA registers as inputs with no pull-ups.
> +	 */
> +	ret = tps68470_reg_write(tps, TPS68470_REG_GPCTL1A, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = tps68470_reg_write(tps, TPS68470_REG_GPCTL2A, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Enable daisy chain */
> +	ret = tps68470_update_bits(tps, TPS68470_REG_S_I2C_CTL, 1, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	usleep_range(TPS68470_DAISY_CHAIN_DELAY_US,
> +			TPS68470_DAISY_CHAIN_DELAY_US + 10);
> +	return 0;
> +}
> +
> +static int tps68470_probe(struct i2c_client *client)
> +{
> +	struct tps68470 *tps;
> +	int ret;
> +
> +	tps = devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
> +	if (!tps)
> +		return -ENOMEM;
> +
> +	mutex_init(&tps->lock);
> +	i2c_set_clientdata(client, tps);
> +	tps->dev = &client->dev;
> +
> +	tps->regmap = devm_regmap_init_i2c(client, &tps68470_regmap_config);
> +	if (IS_ERR(tps->regmap)) {
> +		dev_err(tps->dev, "devm_regmap_init_i2c Error %d\n", ret);
> +		return PTR_ERR(tps->regmap);
> +	}
> +
> +	ret = mfd_add_devices(tps->dev, -1, tps68470s,
> +			      ARRAY_SIZE(tps68470s), NULL, 0, NULL);
> +	if (ret < 0) {
> +		dev_err(tps->dev, "mfd_add_devices failed: %d\n", ret);
> +		return ret;
> +	}

devm_mfd_add_devices()?

> +	ret = tps68470_chip_init(tps);
> +	if (ret < 0) {
> +		dev_err(tps->dev, "TPS68470 Init Error %d\n", ret);
> +		goto fail;
> +	}
> +
> +	return 0;
> +fail:
> +	mutex_lock(&tps->lock);

Why do you need to lock here?

> +	mfd_remove_devices(tps->dev);
> +	mutex_unlock(&tps->lock);
> +
> +	return ret;
> +}
> +
> +static int tps68470_remove(struct i2c_client *client)
> +{
> +	struct tps68470 *tps = i2c_get_clientdata(client);
> +
> +	mutex_lock(&tps->lock);
> +	mfd_remove_devices(tps->dev);
> +	mutex_unlock(&tps->lock);
> +
> +	return 0;
> +}
> +
> +static const struct acpi_device_id tps68470_acpi_ids[] = {
> +	{"INT3472"},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(acpi, tps68470_acpi_ids);
> +
> +static struct i2c_driver tps68470_driver = {
> +	.driver = {
> +		   .name = "tps68470",
> +		   .acpi_match_table = ACPI_PTR(tps68470_acpi_ids),
> +	},
> +	.probe_new = tps68470_probe,
> +	.remove = tps68470_remove,
> +};

<snip>

> +/**
> + * struct tps68470 - tps68470 sub-driver chip access routines
> + *
> + * Device data may be used to access the TPS68470 chip
> + */
> +
> +struct tps68470 {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	/*
> +	 * Used to synchronize access to tps68470_ operations
> +	 * and addition and removal of mfd devices
> +	 */
> +	struct mutex lock;

Is this lock really necessary at all? Actually, you probable don't
even need this structure at all if you just rely on regmap functions
in the drivers.


Thanks,

-- 
heikki
