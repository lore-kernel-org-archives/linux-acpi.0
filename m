From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Thu, 6 Oct 2016 19:02:21 +0200
Message-ID: <CAJZ5v0hdewtK0_xvRFBMMUPrgaFCHR=uXrdWh9+mbw+adqG06A@mail.gmail.com>
References: <20161005150641.GA22282@red-moon> <20161005153229.GO1765@lahna.fi.intel.com>
 <20161005161800.GA22433@red-moon> <CAJZ5v0jNSEQ6Uk4T-19jA=RV9pmRzojB4FBd=SFAo6VOj-SLLg@mail.gmail.com>
 <20161006085703.GA22776@red-moon> <20161006091133.GF30800@lahna.fi.intel.com>
 <20161006095739.GA22984@red-moon> <20161006111922.GI30800@lahna.fi.intel.com>
 <20161006153129.x6fosp725slgapjk@sirena.org.uk> <CAJZ5v0izHFuZbW84arDnZvht=jigstD1F9m6GLSe=K0gOGmYfQ@mail.gmail.com>
 <20161006161452.ubltgnviyswk6qsw@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36069 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942018AbcJFRCY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Oct 2016 13:02:24 -0400
Received: by mail-wm0-f68.google.com with SMTP id 123so4396003wmb.3
        for <linux-acpi@vger.kernel.org>; Thu, 06 Oct 2016 10:02:23 -0700 (PDT)
In-Reply-To: <20161006161452.ubltgnviyswk6qsw@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>

On Thu, Oct 6, 2016 at 6:14 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Oct 06, 2016 at 06:00:39PM +0200, Rafael J. Wysocki wrote:
>> On Thu, Oct 6, 2016 at 5:31 PM, Mark Brown <broonie@kernel.org> wrote:
>> > On Thu, Oct 06, 2016 at 02:19:22PM +0300, Mika Westerberg wrote:
>
>> >> I don't need a DT, I need that my existing firmware (in this case BIOS)
>> >> can describe camera device(s) and the OS can take advantage of this,
>> >> preferably with minimal changes to the drivers.
>
>> >> Currently there is no way in ACPI specification to do that.
>
>> > That's not exactly true - the way Windows handles audio devices (which
>> > follow a similar pattern) is to register the control interfaces of the
>> > individual components of the system using existing bindings and then
>> > bind them together with a driver that matches the board level
>> > identification.  This isn't super awesome but it's definitely a thing
>> > you can do.
>
>> But that would mean writing new Linux code to support hardware that
>> already is supported by the Linux kernel.
>
>> That would be a bit like saying "We have a driver for this, but you
>> are not allowed to use it, because your platform is not a DT one".
>> That doesn't sound good to me, honestly.
>
> Well, no - it just means that you need a bit of translation code to glue
> things together.  There's no need to replace the entire driver.

Fair enough, but also depending on what is provided by the ACPI tables
and what isn't.

In some cases kernel frameworks expect information that - without _DSD
properties - is not available in the ACPI tables in any form, but can
be provided by DT, so the driver would need to contain some sort of a
static table mapping device IDs to the missing information which would
not be fantastic.

Thanks,
Rafael
