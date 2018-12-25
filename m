From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH -next] ACPI/IORT: fix build when CONFIG_IOMMU_API=n
Date: Tue, 25 Dec 2018 10:44:38 +0800
Message-ID: <31c013ad-1261-7ca4-2434-69911d5d2cb8@huawei.com>
References: <20181224172058.56206-1-cai@lca.pw>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181224172058.56206-1-cai@lca.pw>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Qian Cai <cai@lca.pw>, sfr@canb.auug.org.au, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com
Cc: linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Qian,

Good catch, minor comments below.

On 2018/12/25 1:20, Qian Cai wrote:
> rivers/acpi/arm64/iort.c:880:1: error: expected identifier or '(' before '{' token
  ^^
  drivers

>  { return NULL; }
>  ^
> drivers/acpi/arm64/iort.c:879:39: warning: 'iort_fwspec_iommu_ops' used but never defined
>  static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev);
>                                        ^~~~~~~~~~~~~~~~~~~~~
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  drivers/acpi/arm64/iort.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index fdd90ffceb85..5d29783ee5bd 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -876,7 +876,7 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>  	return (resv == its->its_count) ? resv : -ENODEV;
>  }
>  #else
> -static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev);
> +static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev)
>  { return NULL; }
>  static inline int iort_add_device_replay(const struct iommu_ops *ops,
>  					 struct device *dev)

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Lorenzo, I think this is 4.21-rc1 material if it's OK for you.

Thanks
Hanjun
