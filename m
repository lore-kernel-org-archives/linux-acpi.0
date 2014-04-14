From: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v3 1/5] x86: initialize secondary CPU only if master CPU
 will wait for it
Date: Mon, 14 Apr 2014 14:50:48 +0200
Message-ID: <20140414145048.3d7cf907@nial.usersys.redhat.com>
References: <1397150061-29735-1-git-send-email-imammedo@redhat.com>
	<1397150061-29735-2-git-send-email-imammedo@redhat.com>
	<20140414091600.GA19771@gmail.com>
	<20140414115210.51193098@thinkpad>
	<20140414100335.GC731@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140414100335.GC731@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, bp@suse.de, paul.gortmaker@windriver.com, JBeulich@suse.com, prarit@redhat.com, drjones@redhat.com, toshi.kani@hp.com, riel@redhat.com, gong.chen@linux.intel.com, andi@firstfloor.org, lenb@kernel.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 14 Apr 2014 12:03:35 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Mon, 14 Apr 2014 11:16:00 +0200
> > Ingo Molnar <mingo@kernel.org> wrote:
> > 
> > > 
> > > * Igor Mammedov <imammedo@redhat.com> wrote:
> > > 
> > > >  	/*
> > > > +	 * wait for ACK from master CPU before continuing
> > > > +	 * with AP initialization
> > > > +	 */
> > > > +	cpumask_set_cpu(cpu, cpu_initialized_mask);
> > > > +	while (!cpumask_test_cpu(cpu, cpu_callout_mask))
> > > > +		cpu_relax();
> > > 
> > > > +	/*
> > > > +	 * wait for ACK from master CPU before continuing
> > > > +	 * with AP initialization
> > > > +	 */
> > > > +	cpumask_set_cpu(cpu, cpu_initialized_mask);
> > > > +	while (!cpumask_test_cpu(cpu, cpu_callout_mask))
> > > > +		cpu_relax();
> > > 
> > > That repetitive pattern could be stuck into a properly named helper 
> > > inline function.
> > sure
> > 
> > > (Also, before the cpumask_set_cpu() we should probably do a WARN_ON() 
> > > if the bit is already set.)
WARN_ON will never be triggered here since bit is always cleared by master
CPU before AP gets here. There is no harm keeping WARN_ON though,
do you still want it be here?

It could be useful to put WARN_ON in do_boot_cpu() before bit is cleared,
so that user would see that he tries to online AP which has failed
previous time. It's not really necessary since failed to online attempt
reported in logs at ERR level now, see patch 2/5.

Thanks,
   Igor
