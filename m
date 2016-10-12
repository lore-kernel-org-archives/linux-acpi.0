From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Wed, 12 Oct 2016 02:19:12 +0200
Message-ID: <23443005.JZJ5hoblVr@vostro.rjw.lan>
References: <20161005150641.GA22282@red-moon> <CAJZ5v0izHFuZbW84arDnZvht=jigstD1F9m6GLSe=K0gOGmYfQ@mail.gmail.com> <20161011124420.GD24347@remoulade>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:65243 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1751147AbcJLANN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Oct 2016 20:13:13 -0400
In-Reply-To: <20161011124420.GD24347@remoulade>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Mark Brown <broonie@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>

On Tuesday, October 11, 2016 01:44:20 PM Mark Rutland wrote:
> On Thu, Oct 06, 2016 at 06:00:39PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Oct 6, 2016 at 5:31 PM, Mark Brown <broonie@kernel.org> wrote:
> > > On Thu, Oct 06, 2016 at 02:19:22PM +0300, Mika Westerberg wrote:
> > >
> > >> I don't need a DT, I need that my existing firmware (in this case BIOS)
> > >> can describe camera device(s) and the OS can take advantage of this,
> > >> preferably with minimal changes to the drivers.
> > >
> > >> Currently there is no way in ACPI specification to do that.
> > >
> > > That's not exactly true - the way Windows handles audio devices (which
> > > follow a similar pattern) is to register the control interfaces of the
> > > individual components of the system using existing bindings and then
> > > bind them together with a driver that matches the board level
> > > identification.  This isn't super awesome but it's definitely a thing
> > > you can do.
> 
> ... so at least one OS *already* has an OS-specific bodge around what is a
> clear ACPI deficiency...
> 
> > But that would mean writing new Linux code to support hardware that
> > already is supported by the Linux kernel.
> > 
> > That would be a bit like saying "We have a driver for this, but you
> > are not allowed to use it, because your platform is not a DT one".
> > That doesn't sound good to me, honestly.
> 
> ... and none of us like any of the proposed OS-specific bodges.

I'm taking this as your personal opinion.

> So why is no-one trying to solve the issue? Why has this not been raised as an
> issue to be solved by the ACPI spec?

How exactly do you think it could be solved there?

Thanks,
Rafael

