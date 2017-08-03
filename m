From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3 0/5] ACPI: DMA ranges management
Date: Thu, 3 Aug 2017 16:16:48 +0100
Message-ID: <20170803151647.GA20783@arm.com>
References: <20170803123239.11359-1-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41804 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751208AbdHCPQs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Aug 2017 11:16:48 -0400
Content-Disposition: inline
In-Reply-To: <20170803123239.11359-1-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Feng Kan <fkan@apm.com>, Jon Masters <jcm@redhat.com>, Robert Moore <robert.moore@intel.com>, Robin Murphy <robin.murphy@arm.com>, Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nate Watterson <nwatters@codeaurora.org>

On Thu, Aug 03, 2017 at 01:32:34PM +0100, Lorenzo Pieralisi wrote:
> This patch series is v3 of a previous posting:
> 
> v2->v3:
> 	- Fixed DMA masks computation
>         - Fixed size computation overflow in acpi_dma_get_range()
> 
> v1->v2:
> 	- Reworked acpi_dma_get_range() flow and logs
> 	- Added IORT named component address limits
> 	- Renamed acpi_dev_get_resources() helper function
> 	- Rebased against v4.13-rc3
> 
> v2: http://lkml.kernel.org/r/20170731152323.32488-1-lorenzo.pieralisi@arm.com
> v1: http://lkml.kernel.org/r/20170720144517.32529-1-lorenzo.pieralisi@arm.com

For the arm64 bits:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
