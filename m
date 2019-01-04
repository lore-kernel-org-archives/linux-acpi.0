From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH -next] ACPI/IORT: fix build when CONFIG_IOMMU_API=n
Date: Fri, 4 Jan 2019 16:16:53 +0000
Message-ID: <20190104161653.GA18795@e107981-ln.cambridge.arm.com>
References: <20181224172058.56206-1-cai@lca.pw>
 <31c013ad-1261-7ca4-2434-69911d5d2cb8@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <31c013ad-1261-7ca4-2434-69911d5d2cb8@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: Qian Cai <cai@lca.pw>, sfr@canb.auug.org.au, hanjun.guo@linaro.org, sudeep.holla@arm.com, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 25, 2018 at 10:44:38AM +0800, Hanjun Guo wrote:
> Hi Qian,
> 
> Good catch, minor comments below.
> 
> On 2018/12/25 1:20, Qian Cai wrote:
> > rivers/acpi/arm64/iort.c:880:1: error: expected identifier or '(' before '{' token
>   ^^
>   drivers
> 
> >  { return NULL; }
> >  ^
> > drivers/acpi/arm64/iort.c:879:39: warning: 'iort_fwspec_iommu_ops' used but never defined
> >  static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev);
> >                                        ^~~~~~~~~~~~~~~~~~~~~
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> >  drivers/acpi/arm64/iort.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index fdd90ffceb85..5d29783ee5bd 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> > @@ -876,7 +876,7 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
> >  	return (resv == its->its_count) ? resv : -ENODEV;
> >  }
> >  #else
> > -static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev);
> > +static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev)
> >  { return NULL; }
> >  static inline int iort_add_device_replay(const struct iommu_ops *ops,
> >  					 struct device *dev)
> 
> Acked-by: Hanjun Guo <hanjun.guo@linaro.org>
> 
> Lorenzo, I think this is 4.21-rc1 material if it's OK for you.

It is a bit late for -rc1 but I will send it asap, with a proper Fixes:
tag that points at the commit that introduced the typo.

Lorenzo
