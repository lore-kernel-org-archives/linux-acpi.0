From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v8 0/6] ACPI / processor_idle: Add ACPI v6.0 LPI support
Date: Fri, 8 Jul 2016 15:43:07 +0100
Message-ID: <20160708144307.GH3784@red-moon>
References: <1467911451-24731-1-git-send-email-sudeep.holla@arm.com>
 <CAJZ5v0jhhXHVJi3Se0udcpfgQaqSANZgkKrM9REBxRT7p-3ggA@mail.gmail.com>
 <577F88C8.8010209@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43349 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754847AbcGHOmQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Jul 2016 10:42:16 -0400
Content-Disposition: inline
In-Reply-To: <577F88C8.8010209@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI List <linux-acpi@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Vikas Sajjan <vikas.cha.sajjan@hpe.com>, Sunil <sunil.vl@hpe.com>, PrashanthPrakash <pprakash@codeaurora.org>, Al Stone <al.stone@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, LKML <linux-kernel@vger.kernel.org>, ALKML <linux-arm-kernel@lists.infradead.org>

On Fri, Jul 08, 2016 at 12:04:40PM +0100, Sudeep Holla wrote:
> 
> 
> On 07/07/16 22:02, Rafael J. Wysocki wrote:
> >On Thu, Jul 7, 2016 at 7:10 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >>ACPI 6.0 introduced LPI(Low Power Idle) states that provides an alternate
> >>method to describe processor idle states. It extends the specification
> >>to allow the expression of idle states like C-states selectable by the
> >>OSPM when a processor goes idle, but may affect more than one processor,
> >>and may affect other system components.
> >>
> >>LPI extensions leverages the processor container device(again introduced
> >>in ACPI 6.0) allowing to express which parts of the system are affected
> >>by a given LPI state. It defines the local power states for each node
> >>in a hierarchical processor topology. The OSPM can use _LPI object to
> >>select a local power state for each level of processor hierarchy in the
> >>system. They used to produce a composite power state request that is
> >>presented to the platform by the OSPM.
> >>
> >>Since multiple processors affect the idle state for any non-leaf hierarchy
> >>node, coordination of idle state requests between the processors is
> >>required. ACPI supports two different coordination schemes: Platform
> >>coordinated and  OS initiated.
> >>
> >>This series aims at providing basic and initial support for platform
> >>coordinated LPI states.
> >>
> >>v7[7]->v8:
> >>         - Replaced HAVE_GENERIC_CPUIDLE_ENTER with CPU_IDLE_ENTER_WRAPPED
> >>           macro, which is more cleaner and definately less confusing :)
> >>           (Thanks to Rafael for the suggestion)
> >
> >Patches [3-6/6] definitely look a lot cleaner to me now. :-)
> >
> >That said, the name of the macro I suggested was just an example, so
> >if people don't like this one, it'd be fine to change it as far as I'm
> >concerned.
> >
> 
> I can think of addition to indicate it's pm notifiers wrapper.
> i.e. CPU_IDLE_ENTER_PM_NOTIFIERS_WRAPPED. Is it too long ? I am happy
> with the way it is too.

CPU_PM_CPU_IDLE_ENTER() ? Anyway, that's really not a problem IMO,
it makes sense to at least mention CPU PM in it given that's what
the CPUIDLE enter function is wrapped within.

Lorenzo
