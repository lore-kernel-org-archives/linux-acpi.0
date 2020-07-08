Return-Path: <SRS0=HTVb=AT=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F33C433E0
	for <linux-acpi@archiver.kernel.org>; Wed,  8 Jul 2020 18:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 574F2206A1
	for <linux-acpi@archiver.kernel.org>; Wed,  8 Jul 2020 18:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgGHS6o (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:58:44 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:53946 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgGHS6n (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 8 Jul 2020 14:58:43 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1jtFHB-004DwY-UJ; Wed, 08 Jul 2020 20:58:37 +0200
Date:   Wed, 8 Jul 2020 20:58:37 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Calvin Johnson <calvin.johnson@oss.nxp.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Jon <jon@solid-run.com>,
        Cristi Sovaiala <cristian.sovaiala@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Madalin Bucur <madalin.bucur@oss.nxp.com>, linux.cj@gmail.com,
        linux-acpi@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [net-next PATCH v3 3/5] net: phy: introduce phy_find_by_fwnode()
Message-ID: <20200708185837.GJ928075@lunn.ch>
References: <20200708173435.16256-1-calvin.johnson@oss.nxp.com>
 <20200708173435.16256-4-calvin.johnson@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708173435.16256-4-calvin.johnson@oss.nxp.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> +/**
> + * fwnode_mdio_find_bus - Given an mii_bus fwnode, find the mii_bus.
> + * @mdio_bus_fwnode: fwnode of the mii_bus.
> + *
> + * Returns a reference to the mii_bus, or NULL if none found.  The
> + * embedded struct device will have its reference count incremented,
> + * and this must be put once the bus is finished with.

> +struct phy_device *phy_find_by_fwnode(struct fwnode_handle *fwnode)
> +{
> +	struct fwnode_handle *fwnode_mdio;
> +	struct mii_bus *mdio;
> +	int addr;
> +	int err;
> +
> +	fwnode_mdio = fwnode_find_reference(fwnode, "mdio-handle", 0);
> +	mdio = fwnode_mdio_find_bus(fwnode_mdio);

You don't seem to release the reference on the device anywhere. Is
that a problem?

     Andrew
