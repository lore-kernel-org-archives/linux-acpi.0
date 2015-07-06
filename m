From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 4/5] x86: pmc_atom: Add Cherrytrail PMC interface
Date: Mon, 6 Jul 2015 17:50:08 +0200
Message-ID: <20150706155008.GA3095@gmail.com>
References: <1436192944-56496-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1436192944-56496-5-git-send-email-andriy.shevchenko@linux.intel.com>
 <20150706154425.GA19665@gmail.com>
 <alpine.DEB.2.11.1507061747100.3916@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1507061747100.3916@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, x86@kernel.org, Aubrey Li <aubrey.li@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Kumar P, Mahesh" <mahesh.kumar.p@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Mon, 6 Jul 2015, Ingo Molnar wrote:
>  
> > * Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > > The patch adds CHT PMC interface. This exposes all the South IP device power
> > > states and S0ix states for CHT. The bit map of FUNC_DIS and D3_STS_0 registers
> > > for SoCs are consistent. The D3_STS_1 and FUNC_DIS_2 registers, however, are
> > > not aligned. This is fixed by splitting a common mapping on per register basis.
> > > 
> > > Signed-off-by: Kumar P Mahesh <mahesh.kumar.p@intel.com>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > That's a weird signoff sequence. I changed it to:
> > 
> >  Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >  Acked-by: Kumar P Mahesh <mahesh.kumar.p@intel.com>
> 
> It might lack a From: Kumar ... 

Yeah, and got lost due to a rebase. Will change it to that, to preserve 
authorship. Won't push it out before I hear back from Andy though.

Thanks,

	Ingo
