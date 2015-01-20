From: Leif Lindholm <leif.lindholm@linaro.org>
Subject: Re: [PATCH v7 04/17] ARM64 / ACPI: Introduce early_param for "acpi"
 and pass acpi=force to enable ACPI
Date: Tue, 20 Jan 2015 12:31:13 +0000
Message-ID: <20150120123113.GP3827@bivouac.eciton.net>
References: <1421247905-3749-5-git-send-email-hanjun.guo@linaro.org>
 <20150119114255.GF11835@e104818-lin.cambridge.arm.com>
 <CAKv+Gu8vPKAdsNg7QC7xW+i8_BemWEx4mvBx6NrnAHi8Y+bNtw@mail.gmail.com>
 <20150119135144.GI11835@e104818-lin.cambridge.arm.com>
 <20150119151350.21B65C40948@trevor.secretlab.ca>
 <54BD3803.6020307@redhat.com>
 <20150119175233.GK11835@e104818-lin.cambridge.arm.com>
 <20150119180122.GJ21553@leverpostej>
 <54BE1FEA.5040109@linaro.org>
 <20150120111032.GB15924@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150120111032.GB15924@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Will Deacon <Will.Deacon@arm.com>, "wangyijing@huawei.com" <wangyijing@huawei.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Al Stone <al.stone@linaro.org>, Timur Tabi <timur@codeaurora.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 20, 2015 at 11:10:32AM +0000, Mark Rutland wrote:
> > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > index 54e39e3..8268c7b 100644
> > --- a/arch/arm64/kernel/setup.c
> > +++ b/arch/arm64/kernel/setup.c
> > @@ -371,6 +371,31 @@ static void __init request_standard_resources(void)
> >   	}
> >   }
> > 
> > +int __init dt_scan_chosen(unsigned long node, const char *uname,
> > +			int depth, void *data)
> > +{
> > +	const char *p;
> > +	
> > +	if (depth != 1 || !data ||
> > +	    (strcmp(uname, "chosen") != 0 && strcmp(uname, "chosen@0") != 0))
> > +		return 0;
> 
> Do we ever generate chosen@0, and do we even accept that?

This probably originates from some stupid cargo-culting on my side,
based on some of the PPC-specific workarounds for old machines
remaining in drivers/of/*. It should go.

/
    Leif
