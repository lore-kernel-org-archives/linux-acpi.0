From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Tue, 11 Oct 2016 13:56:37 +0100
Message-ID: <20161011125637.GE24347@remoulade>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon>
 <20161005114129.GI1765@lahna.fi.intel.com>
 <20161005150641.GA22282@red-moon>
 <20161005153229.GO1765@lahna.fi.intel.com>
 <20161005161800.GA22433@red-moon>
 <CAJZ5v0jNSEQ6Uk4T-19jA=RV9pmRzojB4FBd=SFAo6VOj-SLLg@mail.gmail.com>
 <20161006085703.GA22776@red-moon>
 <CAJZ5v0ixapEyg6dhhH=9xQbQ+yxr30pCxaJdK9LQg1jEyNUvkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33548 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753733AbcJKNGw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Oct 2016 09:06:52 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ixapEyg6dhhH=9xQbQ+yxr30pCxaJdK9LQg1jEyNUvkw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>

On Thu, Oct 06, 2016 at 02:26:50PM +0200, Rafael J. Wysocki wrote:
> On Thu, Oct 6, 2016 at 10:57 AM, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
 
> > As you said this can only happen once the fwnode API usage trickles
> > into the respective subsystems. Can we prevent it ? I hope so and
> > we are keeping an eye on that too (that's the reason why I asked
> > Mika to widen the audience, BTW), but that's the *only* way to
> > prevent this FW bindings mix-up and it is almost impossible to
> > vet all code getting into subsystems IMHO.
> >
> > I am trying to understand why x86 wants to do this, please understand
> > our point of view too, we do not want to block progress we want to
> > prevent a mess.
> 
> It is not "x86" who wants to do that.
> 
> It is people who work on support for boards with ACPI firmware and
> containing devices that in Linux are handled by DT-centric code.
> 
> Of course, the reason why that code is DT-centric is because it was
> developed on systems using DT and there were no uses on ACPI-based
> systems for it back then.  Still, it is DT-centric as a matter of fact
> and *something* has to be done in order to make it work with ACPI.

We often create DT bindings for devices whose drivers were previously
ACPI-centric. If necessary, we expect that the driver or subsystem is
refactored in order to accomadate this.

I fail to see why the same cannot apply the other way around.

Mindlessly appying an s/of_/device_/ regex just adds to the mess.

Thanks,
Mark.
