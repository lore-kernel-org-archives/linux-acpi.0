From: David Miller <davem@davemloft.net>
Subject: Re: [net-next: PATCH v4 0/7] Armada 7k/8k PP2 ACPI support
Date: Mon, 22 Jan 2018 09:35:25 -0500 (EST)
Message-ID: <20180122.093525.1549534484738907077.davem@davemloft.net>
References: <1516278704-17141-1-git-send-email-mw@semihalf.com>
        <20180118132322.GE2690@kwain>
        <CAPv3WKeqEd6Hcy0NdPpiVVA1ioUYY4zs_0zai2gwkCPtM1yaJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:34632 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbeAVOf2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jan 2018 09:35:28 -0500
In-Reply-To: <CAPv3WKeqEd6Hcy0NdPpiVVA1ioUYY4zs_0zai2gwkCPtM1yaJg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mw@semihalf.com
Cc: linux-kernel@vger.kernel.org, antoine.tenart@free-electrons.com, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, linux-acpi@vger.kernel.org, graeme.gregory@linaro.org, linux@armlinux.org.uk, rafael.j.wysocki@intel.com, andrew@lunn.ch, f.fainelli@gmail.com, thomas.petazzoni@free-electrons.com, gregory.clement@free-electrons.com, stefanc@marvell.com, nadavh@marvell.com, neta@marvell.com, ard.biesheuvel@linaro.org, jaz@semihalf.com, tn@semihalf.com

From: Marcin Wojtas <mw@semihalf.com>
Date: Mon, 22 Jan 2018 14:00:37 +0100

> There's a discussion about the ACPI vs generic MDIO/PHY change under
> initial version of the patchset, however the patches in question were
> for now abandoned from further re-sends.

But doesn't the results of that discussion determine whether the way ACPI
is being used in this patch series is what we want to do or not?
