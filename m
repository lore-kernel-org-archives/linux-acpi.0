From: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Subject: Re: [PATCH v5 03/14] ACPI: ARM64: IORT: add missing comment for
 iort_dev_find_its_id()
Date: Fri, 30 Dec 2016 16:56:56 +0800
Message-ID: <58662158.2050007@hisilicon.com>
References: <1482384922-21507-1-git-send-email-guohanjun@huawei.com>
 <1482384922-21507-4-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482384922-21507-4-git-send-email-guohanjun@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Charles Garcia-Tobin <charles.garcia-tobin@arm.com>, jcm@redhat.com, yimin@huawei.com, Tomasz Nowicki <tn@semihalf.com>, linux-kernel@vger.kernel.org, linuxarm@huawei.com, Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Agustin Vega-Frias <agustinv@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On 2016/12/22 13:35, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
>
> We are missing req_id's comment for iort_dev_find_its_id(),
> add it back.
>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> ---
>   drivers/acpi/arm64/iort.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 46e2d82..174e983 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -446,6 +446,7 @@ u32 iort_msi_map_rid(struct device *dev, u32 req_id)
>   /**
>    * iort_dev_find_its_id() - Find the ITS identifier for a device
>    * @dev: The device.
> + * @req_id: Device's Requster ID
>    * @idx: Index of the ITS identifier list.
>    * @its_id: ITS identifier.
>    *
Tested-by:  Xinwei Kong <kong.kongxinwei@hisilicon.com>
