From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v8 0/6] ACPI / processor_idle: Add ACPI v6.0 LPI support
Date: Thu, 7 Jul 2016 23:02:48 +0200
Message-ID: <CAJZ5v0jhhXHVJi3Se0udcpfgQaqSANZgkKrM9REBxRT7p-3ggA@mail.gmail.com>
References: <1467911451-24731-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467911451-24731-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: ACPI List <linux-acpi@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Vikas Sajjan <vikas.cha.sajjan@hpe.com>, Sunil <sunil.vl@hpe.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, PrashanthPrakash <pprakash@codeaurora.org>, Al Stone <al.stone@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, LKML <linux-kernel@vger.kernel.org>, ALKML <linux-arm-kernel@lists.infradead.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jul 7, 2016 at 7:10 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> ACPI 6.0 introduced LPI(Low Power Idle) states that provides an alternate
> method to describe processor idle states. It extends the specification
> to allow the expression of idle states like C-states selectable by the
> OSPM when a processor goes idle, but may affect more than one processor,
> and may affect other system components.
>
> LPI extensions leverages the processor container device(again introduced
> in ACPI 6.0) allowing to express which parts of the system are affected
> by a given LPI state. It defines the local power states for each node
> in a hierarchical processor topology. The OSPM can use _LPI object to
> select a local power state for each level of processor hierarchy in the
> system. They used to produce a composite power state request that is
> presented to the platform by the OSPM.
>
> Since multiple processors affect the idle state for any non-leaf hierarchy
> node, coordination of idle state requests between the processors is
> required. ACPI supports two different coordination schemes: Platform
> coordinated and  OS initiated.
>
> This series aims at providing basic and initial support for platform
> coordinated LPI states.
>
> v7[7]->v8:
>         - Replaced HAVE_GENERIC_CPUIDLE_ENTER with CPU_IDLE_ENTER_WRAPPED
>           macro, which is more cleaner and definately less confusing :)
>           (Thanks to Rafael for the suggestion)

Patches [3-6/6] definitely look a lot cleaner to me now. :-)

That said, the name of the macro I suggested was just an example, so
if people don't like this one, it'd be fine to change it as far as I'm
concerned.

Thanks,
Rafael
