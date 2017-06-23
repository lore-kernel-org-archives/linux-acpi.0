From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH] iommu/arm-smmu-v3: Enable ACPI based HiSilicon
 CMD_PREFETCH quirk(erratum 161010701)
Date: Fri, 23 Jun 2017 12:49:34 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83838930B@FRAEML521-MBS.china.huawei.com>
References: <20170517091205.7752-1-shameerali.kolothum.thodi@huawei.com>
 <5FC3163CFD30C246ABAA99954A238FA838388F08@FRAEML521-MBS.china.huawei.com>
 <20170623120207.GA2310@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([45.249.212.187]:8784 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751620AbdFWMtw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Jun 2017 08:49:52 -0400
In-Reply-To: <20170623120207.GA2310@arm.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "robin.murphy@arm.com" <robin.murphy@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, John Garry <john.garry@huawei.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>, "xuwei (O)" <xuwei5@hisilicon.com>, Linuxarm <linuxarm@huawei.com>, "devel@acpica.org" <devel@acpica.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>



> -----Original Message-----
> From: Will Deacon [mailto:will.deacon@arm.com]
> Sent: Friday, June 23, 2017 1:02 PM
> To: Shameerali Kolothum Thodi
> Cc: robin.murphy@arm.com; mark.rutland@arm.com;
> lorenzo.pieralisi@arm.com; John Garry; Gabriele Paoloni; Guohanjun
> (Hanjun Guo); xuwei (O); Linuxarm; devel@acpica.org; linux-
> acpi@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org
> Subject: Re: [PATCH] iommu/arm-smmu-v3: Enable ACPI based HiSilicon
> CMD_PREFETCH quirk(erratum 161010701)
> 
> On Fri, Jun 23, 2017 at 08:29:28AM +0000, Shameerali Kolothum Thodi wrote:
> > > -----Original Message-----
> > > From: Shameerali Kolothum Thodi
> > > Sent: Wednesday, May 17, 2017 10:12 AM
> > > To: robin.murphy@arm.com; will.deacon@arm.com;
> mark.rutland@arm.com;
> > > lorenzo.pieralisi@arm.com
> > > Cc: John Garry; Gabriele Paoloni; Guohanjun (Hanjun Guo); xuwei (O);
> > > Linuxarm; devel@acpica.org; linux-acpi@vger.kernel.org; linux-arm-
> > > kernel@lists.infradead.org; devicetree@vger.kernel.org; Shameerali
> > > Kolothum Thodi
> > > Subject: [PATCH] iommu/arm-smmu-v3: Enable ACPI based HiSilicon
> > > CMD_PREFETCH quirk(erratum 161010701)
> > >
> > > HiSilicon SMMUv3 on Hip06/Hip07 platforms doesn't support
> > > CMD_PREFETCH command. The dt based support for this quirk is already
> > > present in the driver(hisilicon,broken-prefetch-cmd). This adds ACPI
> > > support for the quirk using the IORT smmu model number.
> >
> > This also  has dependency on acpica header update and it looks like
> > it's going to take a while to appear on Linux mainline. I have seen
> > patches where a temp local definition for SMMU v3 model number is
> suggested instead.
> >
> > Could you please let me know the plan so that I can base this patch
> > similar to or on top of Caviums "[PATCH] iommu/arm-smmu-v3, acpi: Add
> > temporary Cavium SMMU-V3 IORT model number definitions"
> 
> I think I've got this in hand, but I'll shout if I run into any issues.

Ok. Thanks Will. Sure.

Shameer
