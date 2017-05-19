From: Robert Richter <robert.richter@cavium.com>
Subject: Re: [PATCH 1/2] acpica: iort: Update SMMU models for IORT rev. C
Date: Fri, 19 May 2017 13:32:37 +0200
Message-ID: <20170519113237.GN658@rric.localdomain>
References: <0bb462748c0a08dbf1db103d2a96b80c71412817.1494585645.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-cys01nam02on0061.outbound.protection.outlook.com ([104.47.37.61]:14752
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750818AbdESLcx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 19 May 2017 07:32:53 -0400
Content-Disposition: inline
In-Reply-To: <0bb462748c0a08dbf1db103d2a96b80c71412817.1494585645.git.robin.murphy@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: will.deacon@arm.com, rjw@rjwysocki.net, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org, gakula@caviumnetworks.com, linu.cherian@cavium.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, john.garry@huawei.com, shameerali.kolothum.thodi@huawei.com, gabriele.paoloni@huawei.com, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

On 12.05.17 11:41:41, Robin Murphy wrote:
> IORT revision C has been published with a number of new SMMU
> implementation identifiers; define them.
> 
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Robert Moore <robert.moore@intel.com>
> CC: Lv Zheng <lv.zheng@intel.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

As an additional note, could these both patches being marked stable?
If we are going to deploy fw with the new model number, older kernels
become unusable as the smmu is not detected any longer.

Thanks,

-Robert
