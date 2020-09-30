Return-Path: <SRS0=KsR7=DH=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86353C4727C
	for <linux-acpi@archiver.kernel.org>; Wed, 30 Sep 2020 16:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 433262072E
	for <linux-acpi@archiver.kernel.org>; Wed, 30 Sep 2020 16:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgI3Q1m (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 30 Sep 2020 12:27:42 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:36366 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727681AbgI3Q1m (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Sep 2020 12:27:42 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kNex1-00GvTY-5D; Wed, 30 Sep 2020 18:27:31 +0200
Date:   Wed, 30 Sep 2020 18:27:31 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Calvin Johnson <calvin.johnson@oss.nxp.com>
Cc:     Grant Likely <grant.likely@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Cristi Sovaiala <cristian.sovaiala@nxp.com>,
        Florin Laurentiu Chiculita <florinlaurentiu.chiculita@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Madalin Bucur <madalin.bucur@oss.nxp.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux.cj@gmail.com,
        netdev@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Diana Madalina Craciun <diana.craciun@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [net-next PATCH v1 7/7] net/fsl: Use _ADR ACPI object to
 register PHYs
Message-ID: <20200930162731.GP3996795@lunn.ch>
References: <20200930160430.7908-1-calvin.johnson@oss.nxp.com>
 <20200930160430.7908-8-calvin.johnson@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930160430.7908-8-calvin.johnson@oss.nxp.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Calvin

>  	priv->has_a011043 = device_property_read_bool(&pdev->dev,
>  						      "fsl,erratum-a011043");
> -
> -	ret = of_mdiobus_register(bus, np);
> -	if (ret) {
> -		dev_err(&pdev->dev, "cannot register MDIO bus\n");
> +	if (is_of_node(pdev->dev.fwnode)) {
> +		ret = of_mdiobus_register(bus, np);
> +		if (ret) {
> +			dev_err(&pdev->dev, "cannot register MDIO bus\n");
> +			goto err_registration;
> +		}
> +	} else if (is_acpi_node(pdev->dev.fwnode)) {
> +		priv->is_little_endian = true;
> +		/* Mask out all PHYs from auto probing. */
> +		bus->phy_mask = ~0;
> +		ret = mdiobus_register(bus);
> +		if (ret) {
> +			dev_err(&pdev->dev, "mdiobus register err(%d)\n", ret);
> +			return ret;
> +		}
> +
> +		fwnode = pdev->dev.fwnode;

> +	/* Loop over the child nodes and register a phy_device for each PHY */
> +		fwnode_for_each_child_node(fwnode, child) {
> +			status = acpi_evaluate_integer(ACPI_HANDLE_FWNODE(child),
> +						       "_ADR", NULL, &addr);
> +			if (ACPI_FAILURE(status)) {
> +				pr_debug("_ADR returned %d\n", status);
> +				continue;
> +			}
> +
> +			if (addr < 0 || addr >= PHY_MAX_ADDR)
> +				continue;
> +
> +			ret = fwnode_mdiobus_register_phy(bus, child, addr);
> +			if (ret == -ENODEV)
> +				dev_err(&bus->dev,
> +					"MDIO device at address %lld is missing.\n",
> +					addr);
> +		}

Hi Calvin

This looping over the properties should be in the core, in the same
way of_mdiobus_register() loops over the OF properties in the core.
We don't want MDIO drivers doing this in their own way, with their own
bugs.

    Andrew
