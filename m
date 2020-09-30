Return-Path: <SRS0=KsR7=DH=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02792C4363D
	for <linux-acpi@archiver.kernel.org>; Wed, 30 Sep 2020 22:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C78862076A
	for <linux-acpi@archiver.kernel.org>; Wed, 30 Sep 2020 22:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgI3WEU (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 30 Sep 2020 18:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729912AbgI3WEU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Sep 2020 18:04:20 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193B6C061755;
        Wed, 30 Sep 2020 15:04:20 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 91B6113C732AF;
        Wed, 30 Sep 2020 14:47:31 -0700 (PDT)
Date:   Wed, 30 Sep 2020 15:04:18 -0700 (PDT)
Message-Id: <20200930.150418.1891146291368222087.davem@davemloft.net>
To:     calvin.johnson@oss.nxp.com
Cc:     grant.likely@arm.com, rafael@kernel.org, jeremy.linton@arm.com,
        andrew@lunn.ch, andy.shevchenko@gmail.com, f.fainelli@gmail.com,
        linux@armlinux.org.uk, cristian.sovaiala@nxp.com,
        florinlaurentiu.chiculita@nxp.com, ioana.ciornei@nxp.com,
        madalin.bucur@oss.nxp.com, heikki.krogerus@linux.intel.com,
        linux-kernel@vger.kernel.org, linux.cj@gmail.com,
        netdev@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, diana.craciun@nxp.com,
        laurentiu.tudor@nxp.com, hkallweit1@gmail.com, kuba@kernel.org
Subject: Re: [net-next PATCH v1 4/7] net: mdiobus: Introduce
 fwnode_mdiobus_register_phy()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200930160430.7908-5-calvin.johnson@oss.nxp.com>
References: <20200930160430.7908-1-calvin.johnson@oss.nxp.com>
        <20200930160430.7908-5-calvin.johnson@oss.nxp.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Wed, 30 Sep 2020 14:47:32 -0700 (PDT)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Calvin Johnson <calvin.johnson@oss.nxp.com>
Date: Wed, 30 Sep 2020 21:34:27 +0530

> --- a/drivers/net/phy/mdio_bus.c
> +++ b/drivers/net/phy/mdio_bus.c
> @@ -106,6 +106,46 @@ int mdiobus_unregister_device(struct mdio_device *mdiodev)
>  }
>  EXPORT_SYMBOL(mdiobus_unregister_device);
>  
> +int fwnode_mdiobus_register_phy(struct mii_bus *bus,
> +				struct fwnode_handle *child, u32 addr)
> +{
> +	struct phy_device *phy;
> +	bool is_c45;
> +	const char *cp;
> +	u32 phy_id;
> +	int rc;

Reverse christmas tree here please.
