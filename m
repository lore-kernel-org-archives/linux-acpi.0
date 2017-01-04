From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v6 03/14] ACPI: ARM64: IORT: add missing comment for
 iort_dev_find_its_id()
Date: Wed, 4 Jan 2017 14:34:42 +0000
Message-ID: <20170104143442.GA8604@red-moon>
References: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org>
 <1483363905-2806-4-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936389AbdADOdn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 4 Jan 2017 09:33:43 -0500
Content-Disposition: inline
In-Reply-To: <1483363905-2806-4-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Tomasz Nowicki <tn@semihalf.com>, Ma Jun <majun258@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Agustin Vega-Frias <agustinv@codeaurora.org>, Sinan Kaya <okaya@codeaurora.org>, charles.garcia-tobin@arm.com, huxinwei@huawei.com, yimin@huawei.com, Jon Masters <jcm@redhat.com>

On Mon, Jan 02, 2017 at 09:31:34PM +0800, Hanjun Guo wrote:
> We are missing req_id's comment for iort_dev_find_its_id(),
> add it back.

"Add missing req_id parameter to the iort_dev_find_its_id() function
kernel-doc comment."

> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Majun <majun258@huawei.com>
> Tested-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> ---
>  drivers/acpi/arm64/iort.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 46e2d82..174e983 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -446,6 +446,7 @@ u32 iort_msi_map_rid(struct device *dev, u32 req_id)
>  /**
>   * iort_dev_find_its_id() - Find the ITS identifier for a device
>   * @dev: The device.
> + * @req_id: Device's Requster ID

s/Requster/Requester

We can send it upstream independently along with some other patches
in this series but I will have a look at the whole series first.

Lorenzo

>   * @idx: Index of the ITS identifier list.
>   * @its_id: ITS identifier.
>   *
> -- 
> 1.9.1
> 
