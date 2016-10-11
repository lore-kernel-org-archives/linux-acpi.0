From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Tue, 11 Oct 2016 13:44:20 +0100
Message-ID: <20161011124420.GD24347@remoulade>
References: <20161005150641.GA22282@red-moon>
 <20161005153229.GO1765@lahna.fi.intel.com>
 <20161005161800.GA22433@red-moon>
 <CAJZ5v0jNSEQ6Uk4T-19jA=RV9pmRzojB4FBd=SFAo6VOj-SLLg@mail.gmail.com>
 <20161006085703.GA22776@red-moon>
 <20161006091133.GF30800@lahna.fi.intel.com>
 <20161006095739.GA22984@red-moon>
 <20161006111922.GI30800@lahna.fi.intel.com>
 <20161006153129.x6fosp725slgapjk@sirena.org.uk>
 <CAJZ5v0izHFuZbW84arDnZvht=jigstD1F9m6GLSe=K0gOGmYfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751672AbcJKMqB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Oct 2016 08:46:01 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0izHFuZbW84arDnZvht=jigstD1F9m6GLSe=K0gOGmYfQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>

On Thu, Oct 06, 2016 at 06:00:39PM +0200, Rafael J. Wysocki wrote:
> On Thu, Oct 6, 2016 at 5:31 PM, Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Oct 06, 2016 at 02:19:22PM +0300, Mika Westerberg wrote:
> >
> >> I don't need a DT, I need that my existing firmware (in this case BIOS)
> >> can describe camera device(s) and the OS can take advantage of this,
> >> preferably with minimal changes to the drivers.
> >
> >> Currently there is no way in ACPI specification to do that.
> >
> > That's not exactly true - the way Windows handles audio devices (which
> > follow a similar pattern) is to register the control interfaces of the
> > individual components of the system using existing bindings and then
> > bind them together with a driver that matches the board level
> > identification.  This isn't super awesome but it's definitely a thing
> > you can do.

... so at least one OS *already* has an OS-specific bodge around what is a
clear ACPI deficiency...

> But that would mean writing new Linux code to support hardware that
> already is supported by the Linux kernel.
> 
> That would be a bit like saying "We have a driver for this, but you
> are not allowed to use it, because your platform is not a DT one".
> That doesn't sound good to me, honestly.

... and none of us like any of the proposed OS-specific bodges.

So why is no-one trying to solve the issue? Why has this not been raised as an
issue to be solved by the ACPI spec?

Thanks,
Mark.
