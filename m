From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH v6 1/4] acpi: arm64: add iort support for PMCG
Date: Mon, 18 Feb 2019 09:57:44 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8392C2FA3@lhreml524-mbb.china.huawei.com>
References: <20190204121324.11460-1-shameerali.kolothum.thodi@huawei.com>
 <20190204121324.11460-2-shameerali.kolothum.thodi@huawei.com>
 <20190215113933.GB27700@e107981-ln.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215113933.GB27700@e107981-ln.cambridge.arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "robin.murphy@arm.com" <robin.murphy@arm.com>, "andrew.murray@arm.com" <andrew.murray@arm.com>, "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>, John Garry <john.garry@huawei.com>, "pabba@codeaurora.org" <pabba@codeaurora.org>, "vkilari@codeaurora.org" <vkilari@codeaurora.org>, "rruigrok@codeaurora.org" <rruigrok@codeaurora.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linuxarm <linuxarm@huawei.com>, "neil.m.leeder@gmail.com" <neil.m.leeder@gmail.com>
List-Id: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@arm.com]
> Sent: 15 February 2019 11:40
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: robin.murphy@arm.com; andrew.murray@arm.com;
> jean-philippe.brucker@arm.com; will.deacon@arm.com;
> mark.rutland@arm.com; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
> John Garry <john.garry@huawei.com>; pabba@codeaurora.org;
> vkilari@codeaurora.org; rruigrok@codeaurora.org; linux-acpi@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Linuxarm
> <linuxarm@huawei.com>; neil.m.leeder@gmail.com
> Subject: Re: [PATCH v6 1/4] acpi: arm64: add iort support for PMCG
> 
[...]

> > +/*
> > + * PMCG model identifiers for use in smmu pmu driver. Please note
> > + * that, this is not part of the IORT specification.
> 
> And it is a Linux internal tag that has nothing to do with HW, it is just fabricated
> for matching a driver, I would like to have this clarified in the comment please.
> 
> I would have avoided adding another hook to differentiate platform data but
> given that it is self-contained in IORT code that should be fine for the sake of
> making progress:
> 
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Thanks. I will wait for review of main driver patches and then will sent out a
revised one incorporating your comments on this.

Thanks,
Shameer

> > + */
> > +#define IORT_SMMU_V3_PMCG_GENERIC        0x00000000 /* Generic
> SMMUv3 PMCG */
> > +
> >  int iort_register_domain_token(int trans_id, phys_addr_t base,
> >  			       struct fwnode_handle *fw_node);  void
> > iort_deregister_domain_token(int trans_id);
> > --
> > 2.7.4
> >
> >
