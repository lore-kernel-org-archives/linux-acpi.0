From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH v4 1/2] ACPICA: ACPI 6.2: Add support for new SRAT
 subtable
Date: Thu, 22 Jun 2017 14:13:18 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E5C3067@ORSMSX110.amr.corp.intel.com>
References: <1498111812-17053-1-git-send-email-ganapatrao.kulkarni@cavium.com>
 <1498111812-17053-2-git-send-email-ganapatrao.kulkarni@cavium.com>
 <20170622134303.GA9732@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:23421 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751458AbdFVON0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Jun 2017 10:13:26 -0400
In-Reply-To: <20170622134303.GA9732@red-moon>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "jason@lakedaemon.net" <jason@lakedaemon.net>, "jnair@caviumnetworks.com" <jnair@caviumnetworks.com>, "gpkulkarni@gmail.com" <gpkulkarni@gmail.com>

This support is already in the ACPICA code base, but I can't speak to when it will be upstreamed to Linux. Lv would know this.
Bob


> -----Original Message-----
> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi@arm.com]
> Sent: Thursday, June 22, 2017 6:43 AM
> To: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>; Zheng, Lv
> <lv.zheng@intel.com>; Moore, Robert <robert.moore@intel.com>; Rafael J.
> Wysocki <rjw@rjwysocki.net>
> Cc: linux-acpi@vger.kernel.org; devel@acpica.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> marc.zyngier@arm.com; catalin.marinas@arm.com; will.deacon@arm.com;
> hanjun.guo@linaro.org; tglx@linutronix.de; jason@lakedaemon.net;
> jnair@caviumnetworks.com; gpkulkarni@gmail.com
> Subject: Re: [PATCH v4 1/2] ACPICA: ACPI 6.2: Add support for new SRAT
> subtable
> 
> Hi Rafael, Lv, Robert,
> 
> On Thu, Jun 22, 2017 at 11:40:11AM +0530, Ganapatrao Kulkarni wrote:
> > Add GIC ITS Affinity (ACPI 6.2) subtable to SRAT table.
> >
> > ACPICA commit 5bc67f63918da249bfe279ee461d152bb3e6f55b
> > Link: https://github.com/acpica/acpica/commit/5bc67f6
> >
> > Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> > ---
> >  include/acpi/actbl1.h | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> This patch is fine to me but it is up to you or who sends the ACPICA
> pull request to send it upstream or give us an ACK so that it can go via
> irqchip.
> 
> We need to know how this commit (and other ACPICA changes) will be sent
> upstream to handle trees dependencies, please advise it is a bit urgent,
> thank you.
> 
> Lorenzo
> 
> > diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h index
> > b4ce55c..253c9db 100644
> > --- a/include/acpi/actbl1.h
> > +++ b/include/acpi/actbl1.h
> > @@ -1192,7 +1192,8 @@ enum acpi_srat_type {
> >  	ACPI_SRAT_TYPE_MEMORY_AFFINITY = 1,
> >  	ACPI_SRAT_TYPE_X2APIC_CPU_AFFINITY = 2,
> >  	ACPI_SRAT_TYPE_GICC_AFFINITY = 3,
> > -	ACPI_SRAT_TYPE_RESERVED = 4	/* 4 and greater are reserved */
> > +	ACPI_SRAT_TYPE_GIC_ITS_AFFINITY = 4,	/* ACPI 6.2 */
> > +	ACPI_SRAT_TYPE_RESERVED = 5	/* 5 and greater are reserved */
> >  };
> >
> >  /*
> > @@ -1260,6 +1261,15 @@ struct acpi_srat_gicc_affinity {
> >  	u32 clock_domain;
> >  };
> >
> > +/* 4: GIC ITS Affinity (ACPI 6.2) */
> > +
> > +struct acpi_srat_its_affinity {
> > +	struct acpi_subtable_header header;
> > +	u32 proximity_domain;
> > +	u16 reserved;
> > +	u32 its_id;
> > +};
> > +
> >  /* Flags for struct acpi_srat_gicc_affinity */
> >
> >  #define ACPI_SRAT_GICC_ENABLED     (1)	/* 00: Use affinity structure
> */
> > --
> > 1.8.1.4
> >
