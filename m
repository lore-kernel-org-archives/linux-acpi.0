From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v10 5/6] arm64: select ACPI PCI code only both features
 are enabled
Date: Mon, 17 Dec 2018 15:52:53 +0000
Message-ID: <20181217155252.5ix7m4vz2zeok4xf@mbp>
References: <20181215010247.26101-1-okaya@kernel.org>
 <20181215010247.26101-6-okaya@kernel.org>
 <2376424.2qzz6yc3ay@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2376424.2qzz6yc3ay@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sinan Kaya <okaya@kernel.org>, linux-acpi@vger.kernel.org, Will Deacon <will.deacon@arm.com>, open list <linux-kernel@vger.kernel.org>, "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Dec 17, 2018 at 11:04:42AM +0100, Rafael J. Wysocki wrote:
> On Saturday, December 15, 2018 2:02:46 AM CET Sinan Kaya wrote:
> > ACPI and PCI are no longer coupled to each other. Specify requirements
> > for both when pulling in code.
> > 
> > Signed-off-by: Sinan Kaya <okaya@kernel.org>
> > ---
> >  arch/arm64/Kconfig | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index ea2ab0330e3a..bcb6262044d8 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -5,7 +5,7 @@ config ARM64
> >  	select ACPI_GTDT if ACPI
> >  	select ACPI_IORT if ACPI
> >  	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> > -	select ACPI_MCFG if ACPI
> > +	select ACPI_MCFG if (ACPI && PCI)
> >  	select ACPI_SPCR_TABLE if ACPI
> >  	select ACPI_PPTT if ACPI
> >  	select ARCH_CLOCKSOURCE_DATA
> > @@ -163,7 +163,7 @@ config ARM64
> >  	select OF
> >  	select OF_EARLY_FLATTREE
> >  	select OF_RESERVED_MEM
> > -	select PCI_ECAM if ACPI
> > +	select PCI_ECAM if (ACPI && PCI)
> >  	select POWER_RESET
> >  	select POWER_SUPPLY
> >  	select REFCOUNT_FULL
> > 
> 
> I need a maintainer ACK here.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
