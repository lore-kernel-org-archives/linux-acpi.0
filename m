From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 01/35] ACPI/acpi_pad: Remove the local apic nonsense
Date: Wed, 18 Feb 2015 07:16:58 +0100
Message-ID: <1505923.WBzzAyg8Mf@vostro.rjw.lan>
References: <20150216121435.203983131@infradead.org> <20150216122412.023909722@infradead.org> <1621111.kx7SauspkE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1621111.kx7SauspkE@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Monday, February 16, 2015 07:54:12 PM Rafael J. Wysocki wrote:
> On Monday, February 16, 2015 01:14:36 PM Peter Zijlstra wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> > While looking through the (ab)use of the clockevents_notify() function
> > I stumbled over the following gem in the acpi_pad code:
> > 
> >   if (lapic_detected_unstable && !lapic_marked_unstable) {
> >      /* LAPIC could halt in idle, so notify users */
> >      for_each_online_cpu(i)
> >        clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &i);
> >      lapic_marked_unstable = 1;
> >   }
> > 
> > This code calls on the cpu which detects the lapic unstable condition
> > first clockevents_notify() to tell the core code that the broadcast
> > should be enabled on all online cpus. Brilliant stuff that as it
> > notifies the core code a num_online_cpus() times that the broadcast
> > should be enabled on the current cpu.
> > 
> > This probably has never been noticed because that code got never
> > tested with NOHZ=n and HIGHRES_TIMER=n or it just worked by chance
> > because one of the other mechanisms told the core in the right way
> > that the local apic timer is wreckaged.
> > 
> > Sigh, this is:
> > 
> >  - The 4th incarnation of idle drivers which has their own mechanism
> >    to detect and deal with X86_FEATURE_ARAT.
> > 
> >  - The 2nd incarnation of fake idle mechanisms with a different set of
> >    brainmelting bugs.
> > 
> >  - Has been merged against an explicit NAK of the scheduler
> >    maintainer with the promise to improve it over time.
> > 
> >  - Another example of featuritis driven trainwreck engineering.
> > 
> >  - Another pointless waste of my time.
> > 
> > Fix this nonsense by removing that lapic detection and notification
> > logic and simply call into the clockevents code unconditonally. The
> > ARAT feature is marked in the lapic clockevent already so the core
> > code will just ignore the requests and return.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Or I can apply it right away if you want me to.

Rafael
