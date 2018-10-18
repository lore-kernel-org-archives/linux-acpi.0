From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH 0/5] device property: Introducing software nodes
Date: Wed, 17 Oct 2018 18:06:43 -0700
Message-ID: <20181018010643.GB205061@dtor-ws>
References: <20181012113934.29942-1-heikki.krogerus@linux.intel.com>
 <20181016173244.GB230131@dtor-ws>
 <20181017133612.GK24771@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181017133612.GK24771@kuha.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Heikki,

On Wed, Oct 17, 2018 at 04:36:12PM +0300, Heikki Krogerus wrote:
> @@ -189,7 +210,7 @@ static int cht_int33fe_probe(struct i2c_client *client)
>  	memset(&board_info, 0, sizeof(board_info));
>  	strlcpy(board_info.type, "typec_fusb302", I2C_NAME_SIZE);
>  	board_info.dev_name = "fusb302";
> -	board_info.properties = fusb302_props;
> +	board_info.fwnode = data->fusb302_node;
>  	board_info.irq = fusb302_irq;
>  
>  	data->fusb302 = i2c_acpi_new_device(dev, 2, &board_info);

OK, this totally explains it. I forgot how we can supply the properties
in board info for I2C/SPI devices and they would get attached to a
device later, and this obviously does not work if one wants to attach a
sub-tree.

Thank you for providing this example.

-- 
Dmitry
