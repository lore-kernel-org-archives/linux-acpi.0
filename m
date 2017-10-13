From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 3/4] ACPI/IORT: Add SMMUv3 specific special index mapping handling
Date: Fri, 13 Oct 2017 14:59:30 +0200
Message-ID: <1751061.R5V0ggIEsy@aspire.rjw.lan>
References: <1507878590-51066-1-git-send-email-guohanjun@huawei.com> <1507878590-51066-4-git-send-email-guohanjun@huawei.com> <20171013130445.GA27895@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48084 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753258AbdJMNJC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 13 Oct 2017 09:09:02 -0400
In-Reply-To: <20171013130445.GA27895@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, Hanjun Guo <hanjun.guo@linaro.org>, will.deacon@arm.com

On Friday, October 13, 2017 3:04:45 PM CEST Lorenzo Pieralisi wrote:
> [+Robert, Will]
> 
> Rafael, Robert,
> 
> On Fri, Oct 13, 2017 at 03:09:49PM +0800, Hanjun Guo wrote:
> 
> [...]
> 
> > +#if (ACPI_CA_VERSION > 0x20170929)
> 
> Any objection to handling 4.15 trees dependency by using ACPICA
> version as a temporary guard (that I will promptly remove at -rc1) ?

Well, fine by me, as long as you take care of dropping this going forward.

Thanks,
Rafael

