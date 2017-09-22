From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH v2 0/4] IORT SMMUv3 MSI support
Date: Fri, 22 Sep 2017 12:22:09 +0100
Message-ID: <20170922112209.GA3475@red-moon>
References: <1505999838-52530-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56374 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751933AbdIVLTl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Sep 2017 07:19:41 -0400
Content-Disposition: inline
In-Reply-To: <1505999838-52530-1-git-send-email-guohanjun@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, Hanjun Guo <hanjun.guo@linaro.org>

On Thu, Sep 21, 2017 at 09:17:14PM +0800, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> IORT revision C introduced SMMUv3 MSI support for control interrupts,
> which introduced a device ID mapping index to retrieve the dev ID
> and ITS parent, adding its support in this patch set, please refer
> to each patch for detail commit message.
> 
> RFC v1 -> RFC v2:
>  - Introduce a new API iort_set_device_domain() to find the MSI domain
>    for an SMMUv3 (or any other IORT table node) to reduce the complex
>    of doing that via acpi_configure_pmsi_domain().
> 
> Hanjun Guo (3):
>   ACPICA: Add SMMUv3 device ID mapping index support
>   ACPI: IORT: lookup iort node via fwnode
>   ACPI: IORT: Skip SMMUv3 device ID map for two steps mappings
> 
> Lorenzo Pieralisi (1):
>   ACPI: IORT: SMMUv3 nodes MSI support
> 
>  drivers/acpi/arm64/iort.c | 157 ++++++++++++++++++++++++++++++++++++++++++++--
>  include/acpi/actbl2.h     |   1 +
>  2 files changed, 152 insertions(+), 6 deletions(-)

Please drop RFC tag from this series, comments on respective patches.

Lorenzo
