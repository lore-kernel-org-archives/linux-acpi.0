From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[3/6]-Mapping lsapic to cpu
Date: Wed, 22 Sep 2004 10:54:46 -0700
Sender: linux-ia64-owner@vger.kernel.org
Message-ID: <20040922105446.A3088@unix-os.sc.intel.com>
References: <20040920092520.A14208@unix-os.sc.intel.com> <20040920093819.E14208@unix-os.sc.intel.com> <20040922221538.650986f2.tokunaga.keiich@jp.fujitsu.com> <1095864779.6105.3.camel@tdi> <20040923021031.00007001.tokunaga.keiich@jp.fujitsu.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ia64-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20040923021031.00007001.tokunaga.keiich@jp.fujitsu.com>; from tokunaga.keiich@jp.fujitsu.com on Thu, Sep 23, 2004 at 02:10:31AM +0900
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Cc: Alex Williamson <alex.williamson@hp.com>, anil.s.keshavamurthy@intel.com, len.brown@intel.com, acpi-devel@lists.sourceforge.net, lhns-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Sep 23, 2004 at 02:10:31AM +0900, Keiichiro Tokunaga wrote:
> On Wed, 22 Sep 2004 08:52:59 -0600, Alex Williamson wrote:
> > On Wed, 2004-09-22 at 22:15 +0900, Keiichiro Tokunaga wrote:
> > > 
> > > I would like to suggest introducing a new function 'acpi_get_pxm()'
> > > since other drivers might need it in the future.  Acutally, ACPI container
> > > hotplug will be using it soon.
> > > 
> > > Here is a patch creating the function.
> > > 
> > 
> >    Nice, I have a couple I/O locality patches that could be simplified
> > with this function.
> > 
> > > +#ifdef CONFIG_ACPI_NUMA
> > > +int acpi_get_pxm(acpi_handle handle);
> > > +#else
> > > +static inline int acpi_get_pxm(acpi_handle hanle)
> > Trivial typo here --->                        ^^^^^ handle
> 
> Oh, good catch:)
Merged your changes, thanks again.

-Anil
