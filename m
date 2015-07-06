From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 4/5] x86: pmc_atom: Add Cherrytrail PMC interface
Date: Mon, 6 Jul 2015 17:47:40 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1507061747100.3916@nanos>
References: <1436192944-56496-1-git-send-email-andriy.shevchenko@linux.intel.com> <1436192944-56496-5-git-send-email-andriy.shevchenko@linux.intel.com> <20150706154425.GA19665@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150706154425.GA19665@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, x86@kernel.org, Aubrey Li <aubrey.li@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Kumar P, Mahesh" <mahesh.kumar.p@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 6 Jul 2015, Ingo Molnar wrote:
 
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > The patch adds CHT PMC interface. This exposes all the South IP device power
> > states and S0ix states for CHT. The bit map of FUNC_DIS and D3_STS_0 registers
> > for SoCs are consistent. The D3_STS_1 and FUNC_DIS_2 registers, however, are
> > not aligned. This is fixed by splitting a common mapping on per register basis.
> > 
> > Signed-off-by: Kumar P Mahesh <mahesh.kumar.p@intel.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> That's a weird signoff sequence. I changed it to:
> 
>  Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>  Acked-by: Kumar P Mahesh <mahesh.kumar.p@intel.com>

It might lack a From: Kumar ... 
