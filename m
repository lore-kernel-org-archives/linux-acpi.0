From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 2/5] ACPI / processor_idle: Add support for Low Power Idle(LPI) states
Date: Mon, 13 Jun 2016 23:05:01 +0200
Message-ID: <6013371.oAQ1sZvyYq@vostro.rjw.lan>
References: <1462981062-24909-1-git-send-email-sudeep.holla@arm.com> <1462981062-24909-3-git-send-email-sudeep.holla@arm.com> <575AFAF9.3020606@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <575AFAF9.3020606@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Vikas Sajjan <vikas.cha.sajjan@hpe.com>, Sunil <sunil.vl@hpe.com>, Prashanth Prakash <pprakash@codeaurora.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Al Stone <al.stone@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-acpi@vger.kernel.org

On Friday, June 10, 2016 06:38:01 PM Sudeep Holla wrote:
> Hi Rafael,

Hi,
 
> On 11/05/16 16:37, Sudeep Holla wrote:
> > ACPI 6.0 introduced an optional object _LPI that provides an alternate
> > method to describe Low Power Idle states. It defines the local power
> > states for each node in a hierarchical processor topology. The OSPM can
> > use _LPI object to select a local power state for each level of processor
> > hierarchy in the system. They used to produce a composite power state
> > request that is presented to the platform by the OSPM.
> >
> > Since multiple processors affect the idle state for any non-leaf hierarchy
> > node, coordination of idle state requests between the processors is
> > required. ACPI supports two different coordination schemes: Platform
> > coordinated and  OS initiated.
> >
> > This patch adds initial support for Platform coordination scheme of LPI.
> >
> 
> I have added support for autopromote states(basically skip flattening or
> creating composite state). I have also fixed the bug discussed in this
> thread with Prashant. Do you have any other feedback on this version
> that I incorporate before posting next version.

I'd really preferred it if you posted the next version without waiting for
my feedback to the previous one (as the feedback may not be relevant any
more among other things).

Thanks,
Rafael
