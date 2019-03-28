From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] drivers/acpi: Clear status of an event before enabling it
Date: Thu, 28 Mar 2019 09:57:18 +0100
Message-ID: <CAJZ5v0jPJYM6n0OWBM17d3MF5h5B+an+LSRiXTHqboXZuXkcvw@mail.gmail.com>
References: <20190320222844.134765-1-furquan@google.com> <CAJZ5v0h7dYEFHSOHengJ3OFyXBW+XZVbjCAegpzqg1VxeeaXog@mail.gmail.com>
 <CAEGmHFEqhh_xYaTXsVHqSgNW-1Ao6-mtk0BPhgu3-8ua6cCZ-Q@mail.gmail.com>
 <CAJZ5v0hxNA_KHjcqSL4XPpQpB1M4UuWJcYOknex=NOGavoooHA@mail.gmail.com> <CAEGmHFHaFk6v=vcciU3QNaQfLriWSJtQ5QUjciY+O8dLh3DhJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEGmHFHaFk6v=vcciU3QNaQfLriWSJtQ5QUjciY+O8dLh3DhJA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Furquan Shaikh <furquan@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, "Schmauss, Erik" <erik.schmauss@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rajat Jain <rajatja@google.com>, Evan Green <evgreen@google.com>, Duncan Laurie <dlaurie@google.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 28, 2019 at 1:46 AM Furquan Shaikh <furquan@google.com> wrote:
>
> On Wed, Mar 27, 2019 at 5:24 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Mar 21, 2019 at 3:16 AM Furquan Shaikh <furquan@google.com> wrote:
> > >
> > > On Wed, Mar 20, 2019 at 5:11 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Wed, Mar 20, 2019 at 11:34 PM Furquan Shaikh <furquan@google.com> wrote:
> > > > >
> > > > > Commit 18996f2db918 ("ACPICA: Events: Stop unconditionally
> > > > > clearing ACPI IRQs during suspend/resume") was added to stop clearing
> > > > > of event status bits unconditionally on suspend and resume paths. This
> > > > > was done because of an issue
> > > > > reported (https://bugzilla.kernel.org/show_bug.cgi?id=196249) where
> > > > > lid status stays closed even on resume (which happens because event
> > > > > status bits are cleared unconditionally on resume). Though this change
> > > > > fixed the issue on suspend path, it introduced regressions on several
> > > > > resume paths.
> > > > >
> > > > > First regression was reported and fixed on S5 path by the following
> > > > > change: commit fa85015c0d95 ("ACPICA: Clear status of all events when
> > > > > entering S5"). Next regression was reported and fixed on all legacy
> > > > > sleep paths by the commit f317c7dc12b7 ("ACPICA: Clear status of all
> > > > > events when entering sleep states"). However, regression still exists
> > > > > on S0ix sleep path since it does not follow the legacy sleep path.
> > > >
> > > > What exactly is failing?
> > >
> > > Here is the failure scenario:
> > >
> > > 1. Consider the case of trackpad which acts as a wake source.
> > > 2. Since the pad is configured for SCI, GPE_STS gets set for that pad
> > > during normal interrupts as well (i.e. during probe at boot or when
> > > using the trackpad)
> >
> > I don't quite understand this.
> >
> > Is the same GPE used for signaling trackpad events in the system
> > working state and for wakeup?
>
> Yes. The same pad is being configured for interrupts (i.e. routed to
> APIC) during S0 as well as configured for GPE (i.e. routed for SCI) to
> cause wakes when in S0ix/S3. This pad is externally connected to
> trackpad interrupt line.

And the way the system is wired up causes the GPE status to be set
when it is enabled, I suppose?

So effectively, you need to disable the active-state IRQ, then clear
the GPE status and enable it for wakeup.

OK, I'll queue up the patch (and talk to the upstream ACPICA people
about taking it in there).

Thanks!
