From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6 0/5] ACPI / processor_idle: Add ACPI v6.0 LPI support
Date: Sat, 25 Jun 2016 02:23:16 +0200
Message-ID: <3343139.ZdTdDuDUJH@vostro.rjw.lan>
References: <1465915719-8409-1-git-send-email-sudeep.holla@arm.com> <576ACEAB.6050306@arm.com> <5423670.OFG561guF2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5423670.OFG561guF2@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-acpi@vger.kernel.org, Vikas Sajjan <vikas.cha.sajjan@hpe.com>, Sunil <sunil.vl@hpe.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Prashanth Prakash <pprakash@codeaurora.org>, Al Stone <al.stone@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thursday, June 23, 2016 02:42:57 AM Rafael J. Wysocki wrote:
> On Wednesday, June 22, 2016 06:45:15 PM Sudeep Holla wrote:
> > Hi Rafael,
> > 
> > On 14/06/16 15:48, Sudeep Holla wrote:
> > > ACPI 6.0 introduced LPI(Low Power Idle) states that provides an alternate
> > > method to describe processor idle states. It extends the specification
> > > to allow the expression of idle states like C-states selectable by the
> > > OSPM when a processor goes idle, but may affect more than one processor,
> > > and may affect other system components.
> > >
> > > LPI extensions leverages the processor container device(again introduced
> > > in ACPI 6.0) allowing to express which parts of the system are affected
> > > by a given LPI state. It defines the local power states for each node
> > > in a hierarchical processor topology. The OSPM can use _LPI object to
> > > select a local power state for each level of processor hierarchy in the
> > > system. They used to produce a composite power state request that is
> > > presented to the platform by the OSPM.
> > >
> > > Since multiple processors affect the idle state for any non-leaf hierarchy
> > > node, coordination of idle state requests between the processors is
> > > required. ACPI supports two different coordination schemes: Platform
> > > coordinated and  OS initiated.
> > >
> > > This series aims at providing basic and initial support for platform
> > > coordinated LPI states.
> > >
> > 
> > Gentle ping, was hoping to target this series for v4.8
> 
> On my list of things to take care of this week.  But this is a long list ...

Well, there are comments from Lorenzo and Daniel that need addressing,
so can you please do that and resend?

Thanks,
Rafael
